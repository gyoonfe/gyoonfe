package com.gyoontar.controller;

import java.io.File;
import java.io.UnsupportedEncodingException;
import java.net.URLDecoder;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.UUID;

import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.gyoontar.domain.CartVO;
import com.gyoontar.domain.MemberVO;
import com.gyoontar.domain.OrderVO;
import com.gyoontar.domain.QnaVO;
import com.gyoontar.service.BoardService;
import com.gyoontar.service.MemberService;
import com.gyoontar.service.MypageService;
import com.gyoontar.service.ProductService;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Controller
@RequestMapping("/mypage/*")
@AllArgsConstructor
@Log4j
public class MypageController {

	private MypageService mypage_service;
	private MemberService member_service;
	private ProductService product_service;
	private BoardService board_service;
	private BCryptPasswordEncoder bcrypt; // Profile Update
	
	//날짜 폴더 만들기
	public String getFolder() {
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		Date date = new Date();
		String str = sdf.format(date);
		return str.replace("-", File.separator);
	}
	
	@PostMapping("/order.do") // produtcView -> Order Confirmation(order.jsp)
	public void order(Model model, OrderVO oVO) {
		model.addAttribute("mVO", member_service.read(oVO.getUserid()));
		model.addAttribute("oVO", oVO);
		model.addAttribute("pVO", product_service.view(oVO.getPseq()));
	}
	@PostMapping("/orderRegister.do") // Order Confirmation(order.jsp) -> DB insert -> myOrderIng
	public String orderPost(OrderVO oVO, RedirectAttributes rttr) {
		oVO.setOseq( mypage_service.selectOrderSeq() );
		int order_result = mypage_service.insertOrder(oVO);
		int detail_result = 0;
		if( order_result == 1 ) {
			detail_result = mypage_service.insertDetail(oVO);
		}
		rttr.addFlashAttribute("detail_result", detail_result);
		rttr.addAttribute("userid", oVO.getUserid());
		return "redirect:/mypage/myOrderIng.do";
	}
	
	@GetMapping("/myProfile.do")
	@PreAuthorize("principal.username == #userid")
	public void toProfile(Model model, String userid) { 

		model.addAttribute("mVO", member_service.read(userid));
	}
	
	@GetMapping("/myProfileUpdate.do")
	@PreAuthorize("principal.username == #userid")
	public void toProfileUpdate(Model model, String userid) { 
		
		model.addAttribute("mVO", member_service.read(userid));
	}
	
	@PostMapping("/myProfileUpdate.do")
	@PreAuthorize("principal.username == #mVO.userid")
	public String editProfileUpdate(MemberVO mVO, RedirectAttributes rttr, 
									@RequestParam(value="uploadfile", required=false) MultipartFile uploadfile,
									@RequestParam(value="imageCheck", required=false) String imageCheck, @RequestParam("password") String password) {
		
		// 비밀번호 불일치시, 즉각 업데이트화면으로 돌아감.
		MemberVO memberVO = member_service.read(mVO.getUserid());
		if( !bcrypt.matches(password, memberVO.getPass()) ) {
			rttr.addFlashAttribute("password_result", "Please Check your password.");
			rttr.addAttribute("userid", mVO.getUserid());
			return "redirect:/mypage/myProfileUpdate.do";
		}
		
		if( uploadfile.isEmpty() || imageCheck != null ) {
			log.info("MultipartFile uploadfile isEmpty !!!!!");
		}else {
			String uploadFileName = uploadfile.getOriginalFilename();
			log.info("Original : " + uploadFileName);
			uploadFileName = uploadFileName.substring(uploadFileName.lastIndexOf("\\")+1); //익스플로러의 경우 순수 파일명만 구하기 위함.
			log.info("uploadFileName : " + uploadFileName);
			//중복파일 처리
			UUID uuid = UUID.randomUUID();
			uploadFileName = uuid.toString() + "_" + uploadFileName;
			log.info("UUID File Name : " + uploadFileName);
			//업로드 패스 구하기
			String uploadFolder = "c:\\upload_gyoontar" + File.separator + "member";
			File uploadPath = new File(uploadFolder, getFolder()); // c:/upload_gyoontar/member/2022/06/02
			log.info("uploadPath : " + uploadPath);
			//날짜 폴더 만들기
			if(uploadPath.exists()==false) {
				uploadPath.mkdirs();
			}
			//업로드하는 경로와 파일 객체 생성
			File uploadSaveFile = new File(uploadPath, uploadFileName); // c:/upload_gyoontar/member/2022/06/02/image.jpg
			log.info("uploadSaveFile : " + uploadSaveFile);
			// 년/월/일/파일이름만 구하기.
			String uploadURL = uploadSaveFile.toString().substring(26); // 2022/06/02/image.jpg
			log.info("REAL UPLOAD URL : " + uploadURL);
			//기존에 있던 이미지가 있다면 삭제하기.
			if( mVO.getMprofile() != null && !mVO.getMprofile().equals("") ) {
				String uploadPath2 = "c:\\upload_gyoontar" + File.separator + "member"; 
				String srcFileName = null;         
		        try{
		            srcFileName = URLDecoder.decode(mVO.getMprofile(),"UTF-8"); // UUID가 포함된 파일이름을 디코딩해줍니다.
		            File file = new File(uploadPath2 + File.separator + srcFileName);
		            boolean result = file.delete();
		            System.out.println("Delete uploadFile Result : " + result);
		        }catch (UnsupportedEncodingException e){
		            e.printStackTrace();
		        }
			}
			// 첨부파일 업로드 폴더에 저장하기
			try {
				uploadfile.transferTo(uploadSaveFile); // 파일 실제로 전송
				mVO.setMprofile(uploadURL); // 테이블에 저장하기 위한 경로
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		if( imageCheck != null && imageCheck.equals("y") ) { // imageCheck에 체크를 한 경우, mprofile를 null로 만듦.
			String uploadPath2 = "c:\\upload_gyoontar" + File.separator + "member"; 
			String srcFileName = null;         
	        try{
	            srcFileName = URLDecoder.decode(mVO.getMprofile(),"UTF-8"); // UUID가 포함된 파일이름을 디코딩해줍니다.
	            File file = new File(uploadPath2 + File.separator + srcFileName);
	            boolean result = file.delete();
	            System.out.println("Delete uploadFile Result : " + result);
	        }catch (UnsupportedEncodingException e){
	            e.printStackTrace();
	        }
			mVO.setMprofile(null);
		}
		int update_result = member_service.updateMember(mVO);
		rttr.addFlashAttribute("update_result", update_result);
		rttr.addAttribute("userid", mVO.getUserid());
		return "redirect:/mypage/myProfile.do";
	}
	@PostMapping("/changePW.do")
	public String changePW(String originPW, String newPW, String userid, RedirectAttributes rttr) {
		MemberVO mVO = member_service.read(userid);
		if( !bcrypt.matches(originPW, mVO.getPass()) ) {
			rttr.addFlashAttribute("password_result", "ERROR - Please Check your password."); // originPW 불일치시, 즉각 리턴
			rttr.addAttribute("userid", userid);
			return "redirect:/mypage/myProfile.do";
		}
		mVO.setPass(bcrypt.encode(newPW));
		int changePW_result = member_service.changePW(mVO);
		rttr.addFlashAttribute("changePW_result", changePW_result);
		rttr.addAttribute("userid", userid);
		return "redirect:/mypage/myProfile.do";
	}
	@GetMapping("/checkUpdateNickname.do")
	public @ResponseBody String checkUpdateNickname(MemberVO mVO) {
		int result = member_service.checkUpdateNickname(mVO);
		return Integer.toString(result);
	}
	
	@GetMapping("/myQna.do")
	@PreAuthorize("principal.username == #userid")
	public void toQna(Model model, @RequestParam("userid") String userid) { 
		
		model.addAttribute("qna_list", mypage_service.selectQna(userid));
	}
	@PostMapping("/myQna.do")
	@PreAuthorize("principal.username == #qVO.userid")
	public String writeQna(QnaVO qVO, RedirectAttributes rttr) { 
		
		int insert_result = mypage_service.insertQna(qVO);
		rttr.addFlashAttribute("insert_result", insert_result);
		rttr.addAttribute("userid", qVO.getUserid());
		return "redirect:/mypage/myQna.do";
	}

	@GetMapping("/myBoard.do")
	@PreAuthorize("principal.username == #userid")
	public void toMyBoard(Model model, String userid) { 
		
		model.addAttribute("board_list", board_service.selectByUserid(userid));
		model.addAttribute("reply_list", board_service.selectReplyByUserid(userid));
		model.addAttribute("like_list", board_service.selectLikeByUserid(userid));
	}
	@GetMapping("/deleteAllLike.do")
	@PreAuthorize("principal.username == #userid")
	public String deleteAllLike(String userid, RedirectAttributes rttr) { 
		
		int all_delete = board_service.deleteAllLike(userid);
		rttr.addFlashAttribute("all_delete", all_delete);
		rttr.addAttribute("userid", userid);
		return "redirect:/mypage/myBoard.do"; 
	}
		
	@GetMapping("/myReview.do")
	@PreAuthorize("principal.username == #userid")
	public void toMyComment(Model model, String userid) { 
		
		model.addAttribute("review_list", product_service.selectRevByUserid(userid));
		model.addAttribute("comment_list", product_service.selectComByUserid(userid));
	}
	
	@GetMapping("/myCart.do")
	@PreAuthorize("principal.username == #userid")
	public void toMyCart(Model model, String userid) { 
		List<CartVO> cart_list = mypage_service.selectCart(userid);
		int total_price = 0;
		for(CartVO cVO : cart_list) {
			total_price += ( cVO.getPrice2() * cVO.getCquantity() );
		}
		model.addAttribute("mVO", member_service.read(userid));
		model.addAttribute("cart_list", cart_list);
		model.addAttribute("total_price", total_price);
	}
	@PostMapping("/myCart.do") // productView -> DB insert -> productView & confirm(you want to go MyCart?)
	@PreAuthorize("principal.username == #cVO.userid")
	public String addCart(CartVO cVO, @RequestParam("odquantity") int cquantity, RedirectAttributes rttr) { 
		cVO.setCquantity(cquantity);
		int cart_result = mypage_service.insertCart(cVO);
		rttr.addFlashAttribute("cart_result", cart_result);
		return "redirect:/product/productView.do?pseq=" + cVO.getPseq();
	}
	@PostMapping("/cartDelete.do")
	@PreAuthorize("principal.username == #userid")
	public String cartDelete(@RequestParam("cseq") int[] cseqArr, String userid, RedirectAttributes rttr) { 
		int delete_result = 0;
		for( int cseq : cseqArr ) {
			int result = mypage_service.deleteCart(cseq);
			if(result == 0) {
				rttr.addFlashAttribute("delete_result", 0);
				return "redirect:/mypage/myCart.do?userid=" + userid;
			}
			delete_result ++;
		}
		rttr.addFlashAttribute("delete_result", delete_result);
		return "redirect:/mypage/myCart.do?userid=" + userid;
	}
	@PostMapping("/cartRegister.do") // myCart -> gt_order/gt_order_detail insert -> myCart || myOrderIng
	@PreAuthorize("principal.username == #oVO.userid")
	public String cartToOrder(OrderVO oVO, RedirectAttributes rttr) {
		List<CartVO> cart_list = mypage_service.selectCart(oVO.getUserid());
		if( cart_list.size()==0 || cart_list==null ) {
			rttr.addFlashAttribute("no_cart", "No items in Cart.");
			return "redirect:/mypage/myCart.do?userid=" + oVO.getUserid();
		}
		oVO.setOseq( mypage_service.selectOrderSeq() );
		int order_result = mypage_service.insertOrder(oVO);
		int len_result = cart_list.size();
		int cart_result = 0;
		if( order_result == 1 ) {
			for( CartVO cVO : cart_list ) {
				OrderVO odVO = new OrderVO(); odVO.setOseq(oVO.getOseq()); odVO.setPseq(cVO.getPseq()); odVO.setOdquantity(cVO.getCquantity());
				int result = mypage_service.insertDetail(odVO);
				if(result != 1) { // order_detail DB 삽입 실패 시, 즉시 myOrderIng.jsp로 이동
					rttr.addFlashAttribute("len_result", len_result);
					rttr.addFlashAttribute("cart_result", cart_result);
					return "redirect:/mypage/myOrderIng.do";
				}
				mypage_service.updateCartResult(cVO.getCseq());
				cart_result++;
			}
		}
		rttr.addFlashAttribute("len_result", len_result);
		rttr.addFlashAttribute("cart_result", cart_result);
		rttr.addAttribute("userid", oVO.getUserid());
		return "redirect:/mypage/myOrderIng.do";
	}
	
	@GetMapping("/myWish.do")
	@PreAuthorize("principal.username == #userid")
	public void toMyWish(Model model, String userid) { 
		
		model.addAttribute("wish_list", product_service.selectWishByUserid(userid));
	}
	@GetMapping("/deleteAllWish.do")
	@PreAuthorize("principal.username == #userid")
	public String deleteAllwish(String userid, RedirectAttributes rttr) {
		int all_delete = product_service.deleteAllWish(userid);
		rttr.addFlashAttribute("all_delete", all_delete);
		rttr.addAttribute("userid", userid);
		return "redirect:/mypage/myWish.do";
	}
	
	@GetMapping("/myOrderIng.do")
	@PreAuthorize("principal.username == #userid")
	public void toMyOrderIng(Model model, String userid) { 
		List<OrderVO> order_list = mypage_service.selectOrder(userid);
		int size = order_list.size();
		if( size > 0 ) { 
			for( int i =0; i<size; i++ ) {
				OrderVO oVO = order_list.get(i);
				int od_status = 0;
				int totalPrice = 0;
				List<OrderVO> detail_list = mypage_service.selectDetail( oVO.getOseq() );
				
				oVO.setPname( detail_list.get(0).getPname() );
				if( detail_list.size() > 1 ) { 
					oVO.setPname( oVO.getPname() + " & " + (detail_list.size()-1) ); 
				}
				for( OrderVO odVO : detail_list ) {
					if( odVO.getOdresult() == 0 ){ od_status++; }
					totalPrice += ( odVO.getPrice2() * odVO.getOdquantity() );
				}
				oVO.setPrice2(totalPrice);
				if( od_status == 0 ) { // oVO의 모든 odVO.odresult가 1이다. => order_list에서 제외시킨다.
					order_list.remove(oVO); 
					i--;
					size--;
				}
			}
		}
		model.addAttribute("order_list", order_list);
	}
	
	@GetMapping("/myOrderAll.do")
	@PreAuthorize("principal.username == #userid")
	public void toMyOrderAll(Model model, String userid) { 
		List<OrderVO> order_list = mypage_service.selectOrder(userid);
		if( order_list.size() > 0 ) { 
			for( OrderVO oVO : order_list ) {
				int totalPrice = 0;
				List<OrderVO> detail_list = mypage_service.selectDetail( oVO.getOseq() );
				oVO.setPname( detail_list.get(0).getPname() );
				if( detail_list.size() > 1 ) { 
					oVO.setPname( oVO.getPname() + " & " + (detail_list.size()-1) ); 
				}
				for( OrderVO odVO : detail_list ) {
					totalPrice += ( odVO.getPrice2() * odVO.getOdquantity() );
				}
				oVO.setPrice2(totalPrice);
			}
		}
		model.addAttribute("order_list", order_list);
	}
	
	@GetMapping("/myOrderDetail.do")
	@PreAuthorize("principal.username == #userid")
	public void toMyOrderDetail(Model model, String userid, int oseq) {
		int totalPrice = 0;
		OrderVO oVO = mypage_service.selectOneOrder(oseq);
		List<OrderVO> detail_list = mypage_service.selectDetail(oseq);
		for( OrderVO odVO : detail_list ) {
			totalPrice += ( odVO.getPrice2() * odVO.getOdquantity() );
		}
		oVO.setPrice2(totalPrice);
		
		model.addAttribute("oVO", oVO);
		model.addAttribute("detail_list", detail_list);
	}
	
	
}
