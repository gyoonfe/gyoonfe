package com.gyoontar.controller;

import java.io.File;

import java.io.UnsupportedEncodingException;
import java.net.URLDecoder;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Random;
import java.util.UUID;

import javax.mail.internet.MimeMessage;

import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.gyoontar.domain.BoardVO;
import com.gyoontar.domain.MapVO;
import com.gyoontar.domain.MemberVO;
import com.gyoontar.domain.ProductVO;
import com.gyoontar.domain.QnaVO;
import com.gyoontar.domain.StatisticsVO;
import com.gyoontar.service.BoardService;
import com.gyoontar.service.MapService;
import com.gyoontar.service.MemberService;
import com.gyoontar.service.MypageService;
import com.gyoontar.service.ProductService;
import com.gyoontar.utility.Criteria;
import com.gyoontar.utility.PageVO;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Controller
@RequestMapping("/admin/*")
@AllArgsConstructor
@Log4j
public class AdminController {

	private MypageService mypage_service;
	private BoardService board_service;
	private ProductService product_service;
	private MemberService member_service;
	private MapService map_service;
	private JavaMailSender mailSender;
	private PasswordEncoder pwencoder;
	
	//날짜 폴더 만들기
	public String getFolder() {
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		Date date = new Date();
		String str = sdf.format(date);
		return str.replace("-", File.separator);
	}	
	
	/* ---------------------- Offline Store Map ---------------------- */
	
	@GetMapping("/map.do") 
	public void map(Model model) {
		model.addAttribute("map_list", map_service.selectAllMap());
	}
	@PostMapping("/regMap.do")
	public String regMap(Model model, MapVO mapVO, @RequestParam(value="uploadfile") MultipartFile uploadfile, RedirectAttributes rttr) {
		
		String uploadFileName = uploadfile.getOriginalFilename();
		uploadFileName = uploadFileName.substring(uploadFileName.lastIndexOf("\\")+1); //explorer 브라우저 같은 경우는 경로까지 파일 이름에 포함되기 때문에, 마지막 \\ 뒤의 있는 문자열만 잘라냄.
		log.info("uploadFileName : " + uploadFileName);
		//중복파일 처리
		UUID uuid = UUID.randomUUID();
		uploadFileName = uuid.toString() + "_" + uploadFileName;
		log.info("UUID File Name : " + uploadFileName);
		//업로드 패스 구하기
		String uploadFolder = "c:\\upload_gyoontar"; // c:/upload_gyoontar
		uploadFolder = uploadFolder + File.separator + "map"; // c:/upload_gyoontar/map
		//업로드하는 경로와 파일 객체 생성
		File uploadSaveFile = new File(uploadFolder, uploadFileName); // c:/upload_gyoontar/map/image.jpg
		log.info("uploadSaveFile : " + uploadSaveFile);
		// 년/월/일/파일이름만 구하기.
		String uploadURL = uploadSaveFile.toString().substring(23); // image.jpg
		log.info("REAL UPLOAD URL : " + uploadURL);
		// 첨부파일 업로드 폴더에 저장하기
		try {
			uploadfile.transferTo(uploadSaveFile); // 파일 실제로 전송
			mapVO.setImage(uploadURL); // 테이블에 저장하기 위한 경로
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		int reg_result = map_service.insertMap(mapVO);
		rttr.addFlashAttribute("reg_result", reg_result);
		return "redirect:/admin/map.do";
	}
	@PostMapping("/deleteMap.do")
	public String deleteMap(@RequestParam("idx") int[] idxArr, RedirectAttributes rttr) {
		int len = idxArr.length;
		int total = 0;
		for( int idx : idxArr ) {
			if( map_service.deleteMap(idx) == 1 ) {
				total++;
			}
		}
		if( len == total ) {
			rttr.addFlashAttribute("delete_result", len);
		}else {
			rttr.addFlashAttribute("delete_result", 0);
		}
		return "redirect:/admin/map.do";
	}
	
	/* ---------------------- Statistics ---------------------- */
	
	@GetMapping("/statistics.do")
	public void statistics(Model model, StatisticsVO statVO) {
		
		String[] monthArr = {"01","02","03","04","05","06","07","08","09","10","11","12"};
		//Long[] list = new Long[12];
		List<StatisticsVO> list = new ArrayList<StatisticsVO>();

		if( statVO.getPseq() == 0 ) {
			for( String m : monthArr ) {
				statVO.setMm(m);
				StatisticsVO sVO = mypage_service.allMonthly(statVO);
				list.add(sVO);
				System.out.println("Price: " + sVO.getPrice() + " Count: " + sVO.getCount());
			}
		}else {
			for( String m : monthArr ) {
				statVO.setMm(m);
				StatisticsVO sVO = mypage_service.pseqMonthly(statVO);
				list.add(sVO);
				System.out.println("Price: " + sVO.getPrice() + " Count: " + sVO.getCount());
			}
		}
		ProductVO pVO = product_service.view(statVO.getPseq());
		if( pVO != null ) {
			model.addAttribute("pVO", pVO);
		}
		model.addAttribute("year", statVO.getYyyy());
		model.addAttribute("list", list);
		model.addAttribute("product_list", product_service.selectAll(new Criteria(1,9999999)));
	}
	
	/* ---------------------- Order ---------------------- */
	
	@GetMapping("/order.do") 
	public void adminOrder(Model model, Criteria cri) {
		int count = mypage_service.selectOrderCount(cri);
		model.addAttribute("order_list", mypage_service.selectAllOrder(cri));
		model.addAttribute("pageVO" , new PageVO(cri, count));
	}
	
	@GetMapping("/orderCheck.do") // Making orders processed.
	public String adminOrderCheck(Model model, @RequestParam("odseq") int[] odseqArr, Criteria cri, RedirectAttributes rttr) {
		int len_result = odseqArr.length;
		int count_result = 0;
		for( int odseq : odseqArr ) {
			int result = mypage_service.updateOdresult(odseq);
			if( result != 1 ) {
				break;
			}
			count_result ++;
		}
		rttr.addFlashAttribute("len_result", len_result);
		rttr.addFlashAttribute("count_result", count_result);
		model.addAttribute("cri", cri);
		return "redirect:/admin/order.do";
	}
	
	/* ---------------------- Board ---------------------- */
	
	@GetMapping("/board.do") 
	public void adminBoard(Model model, Criteria cri) {
		int count = board_service.selectCount(cri);
		model.addAttribute("board_list", board_service.select(cri));
		model.addAttribute("notice_list", board_service.selectNotice(cri));
		model.addAttribute("pageVO" , new PageVO(cri, count));
	}
	
	@GetMapping("/boardView.do")
	public void adminBoardView(Model model, @RequestParam("bno") int bno, @ModelAttribute("cri") Criteria cri) {
		board_service.plusHits(bno);
		model.addAttribute("bVO", board_service.view(bno));
		model.addAttribute("cri", cri);
		model.addAttribute("reply_list", board_service.selectReply(bno)); // 해당 bno의 모든 댓글
		model.addAttribute("like_count", board_service.selectLikeCount(bno)); // 좋아요 개수
		model.addAttribute("like_list", board_service.selectLike(bno)); // bno에 해당하는 좋아요를 누른 userid의 목록
		if(bno < board_service.maxBno()) {
			model.addAttribute("nextBvo", board_service.nextBvo(bno));
		}
		if(bno > board_service.minBno()) {
			model.addAttribute("prevBvo", board_service.prevBvo(bno));
		}
	}
	@PostMapping("/boardRepWrite.do")
	public String repWrite(BoardVO boardVO, Criteria cri, RedirectAttributes rttr) {
		int result = board_service.insertReply(boardVO);
		rttr.addFlashAttribute("insertReply_result", result);
		rttr.addAttribute("bno", boardVO.getBno());
		rttr.addAttribute("pageNum", cri.getPageNum());
		rttr.addAttribute("amount", cri.getAmount());
		return "redirect:/admin/boardView.do";
	}
	@GetMapping("/boardRepDelete.do")
	public String boardRepDelete(BoardVO boardVO, Criteria cri, RedirectAttributes rttr) {
		int result = board_service.deleteReply(boardVO);
		rttr.addFlashAttribute("deleteReply_result", result);
		rttr.addAttribute("bno", boardVO.getBno());
		rttr.addAttribute("pageNum", cri.getPageNum());
		rttr.addAttribute("amount", cri.getAmount());
		return "redirect:/admin/boardView.do";
	}
	
	@GetMapping("/boardWrite.do") 
	public void adminBoardWrite() {

	}
	@PostMapping("/boardWrite.do")
	public String BoardWrite(BoardVO boardVO, RedirectAttributes rttr) { 

		int insert_result =  board_service.insert(boardVO);
		rttr.addFlashAttribute("insert_result", insert_result);
		return "redirect:/admin/board.do";
	}	
	
	@GetMapping("/boardUpdate.do") 
	@PreAuthorize("principal.username == #userid")
	public void toBoardUpdate(Model model, @RequestParam("bno") int bno, @RequestParam("userid") String userid, Criteria cri) { 
		model.addAttribute("boardVO", board_service.view(bno));
		model.addAttribute("cri", cri); // boardUpdate.jsp 에서 POST 방식으로 cri 내용을 넘길 것이므로 model로 보내줘야 하는 듯?
	}
	
	@PostMapping("/boardUpdate.do")
	@PreAuthorize("principal.username == #boardVO.userid")
	public String boardUpdate(BoardVO boardVO, Criteria cri, RedirectAttributes rttr) {

		int result = board_service.update(boardVO);
		rttr.addFlashAttribute("update_result", result);
		rttr.addAttribute("pageNum", cri.getPageNum());
		rttr.addAttribute("amount", cri.getAmount());
		return "redirect:/admin/board.do";
	}
	
	@GetMapping("/boardDelete.do") 
	public String boardDelete(@RequestParam ("bno") int[] bnoArr, Criteria cri, RedirectAttributes rttr) {
		int cnt = 0;
		for( int bno : bnoArr ) {
            int result = board_service.delete(bno);
            if( result != 1 ) {
        		rttr.addFlashAttribute("delete_result", 0);
            	rttr.addAttribute("pageNum",cri.getPageNum());
            	rttr.addAttribute("amount",cri.getAmount());
        		return "redirect:/admin/board.do";
            }
            cnt++;
		}
		rttr.addFlashAttribute("delete_result", cnt);
    	rttr.addAttribute("pageNum",cri.getPageNum());
    	rttr.addAttribute("amount",cri.getAmount());
		return "redirect:/admin/board.do";
	}
	
	/* ---------------------- Product ---------------------- */

	@RequestMapping(value = "/product.do", method = {RequestMethod.GET, RequestMethod.POST}) 
	public void adminProduct(Model model, Criteria cri, @RequestParam(value="onKind", required=false) String onKind) {
		if( onKind != null && onKind.equals("y") ) {
			int count = product_service.selectKindCount(cri);
			List<ProductVO> product_list = product_service.selectKind(cri);
			for( ProductVO pVO : product_list ) { // setting Count of Comment that has no relpy.
				int noRepComCount = product_service.selectNoRepComCount(pVO.getPseq());
				pVO.setNoRepComCount(noRepComCount);
			}
			model.addAttribute("onKind", "y");
			model.addAttribute("kind", cri.getCategory());
			model.addAttribute("product_list", product_list);
			model.addAttribute("pageVO", new PageVO(cri, count));	
		}else {
			List<ProductVO> product_list = product_service.selectAll(cri);
			for( ProductVO pVO : product_list ) { // setting Count of Comment that has no relpy.
				int noRepComCount = product_service.selectNoRepComCount(pVO.getPseq());
				pVO.setNoRepComCount(noRepComCount);
			}
			int count = product_service.selectCount(cri);
			model.addAttribute("product_list", product_list);
			model.addAttribute("pageVO", new PageVO(cri, count));	
		}
	}
	
	@GetMapping("/productView.do")
	public void adminProductView(Model model, @RequestParam("pseq") int pseq) {
		model.addAttribute("pVO", product_service.view(pseq));
		model.addAttribute("review_list", product_service.selectReview(pseq));
		model.addAttribute("comment_list", product_service.selectComment(pseq));
	}
	@PostMapping("/revWrite.do")
	@PreAuthorize("isAuthenticated()")
	public String revWrite(ProductVO pVO, RedirectAttributes rttr) {
		int reviewIN_result = product_service.insertReview(pVO);
		rttr.addFlashAttribute("reviewIN_result", reviewIN_result);
		rttr.addAttribute("pseq", pVO.getPseq());
		return "redirect:/admin/productView.do";
	}
	@GetMapping("/revDelete.do")
	public String revDelete(ProductVO pVO, RedirectAttributes rttr) {
		int reviewDel_result = product_service.deleteReview(pVO);
		rttr.addFlashAttribute("reviewDel_result", reviewDel_result);
		rttr.addAttribute("pseq", pVO.getPseq());
		return "redirect:/admin/productView.do";
	}
	@PostMapping("/comWrite.do")
	@PreAuthorize("isAuthenticated()")
	public String comWrite(ProductVO pVO, RedirectAttributes rttr) {
		int commentIN_result = product_service.insertComment(pVO);
		rttr.addFlashAttribute("commentIN_result", commentIN_result);
		rttr.addAttribute("pseq", pVO.getPseq());
		return "redirect:/admin/productView.do";
	}
	@GetMapping("/comDelete.do")
	public String comDelete(ProductVO pVO, RedirectAttributes rttr) {
		int commentDel_result = product_service.deleteComment(pVO);
		rttr.addFlashAttribute("commentDel_result", commentDel_result);
		rttr.addAttribute("pseq", pVO.getPseq());
		return "redirect:/admin/productView.do";
	}	
	@PostMapping("/comReplyUpdate.do")
	@ResponseBody
	public String comUpdatePost(ProductVO pVO) {
		System.out.println("comreply : " + pVO.getComreply());
		return Integer.toString(product_service.updateComReply(pVO));
	}
	
	
	@GetMapping("/productWrite.do")
	public void adminProductWrite() {
		
	}
	@PostMapping("/productWrite.do")
	public String adminProductWritePost(ProductVO pVO, @RequestParam(value="uploadfile") MultipartFile uploadfile, RedirectAttributes rttr) {

		if( uploadfile.isEmpty() ) {
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
			String uploadFolder = "c:\\upload_gyoontar" + File.separator + "product";
			File uploadPath = new File(uploadFolder, getFolder()); // c:/upload_gyoontar/product/2022/06/02
			log.info("uploadPath : " + uploadPath);
			//날짜 폴더 만들기
			if(uploadPath.exists()==false) {
				uploadPath.mkdirs();
			}
			//업로드하는 경로와 파일 객체 생성
			File uploadSaveFile = new File(uploadPath, uploadFileName); // c:/upload_gyoontar/product/2022/06/02/image.jpg
			log.info("uploadSaveFile : " + uploadSaveFile);
			// 년/월/일/파일이름만 구하기.
			String uploadURL = uploadSaveFile.toString().substring(27); // 2022/06/02/image.jpg
			log.info("REAL UPLOAD URL : " + uploadURL);
			// 첨부파일 업로드 폴더에 저장하기
			try {
				uploadfile.transferTo(uploadSaveFile); // 파일 실제로 전송
				pVO.setPimage(uploadURL); // 테이블에 저장하기 위한 경로
			} catch (Exception e) {
				e.printStackTrace();
			}
		}

		int result = product_service.insert(pVO);
			System.out.println("Product Insert Result : " + result);
		rttr.addFlashAttribute("insert_result", result);
		
		return "redirect:/admin/product.do";
	}
	
	@PostMapping("/productUpdate.do")
	public String adminProductUpdate(ProductVO pVO, @RequestParam(value="uploadfile", required = false) MultipartFile uploadfile, RedirectAttributes rttr) {
		
		if( uploadfile.isEmpty() ) {
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
			String uploadFolder = "c:\\upload_gyoontar" + File.separator + "product";
			File uploadPath = new File(uploadFolder, getFolder()); // c:/upload_gyoontar/product/2022/06/02
			log.info("uploadPath : " + uploadPath);
			//날짜 폴더 만들기
			if(uploadPath.exists()==false) {
				uploadPath.mkdirs();
			}
			//업로드하는 경로와 파일 객체 생성
			File uploadSaveFile = new File(uploadPath, uploadFileName); // c:/upload_gyoontar/product/2022/06/02/image.jpg
			log.info("uploadSaveFile : " + uploadSaveFile);
			// 년/월/일/파일이름만 구하기.
			String uploadURL = uploadSaveFile.toString().substring(27); // 2022/06/02/image.jpg
			log.info("REAL UPLOAD URL : " + uploadURL);
	        //기존의 첨부파일 이미지 삭제하기.
			if(pVO.getPimage() != null && pVO.getPimage() != "") {
		        String srcFileName = null; String uploadPath2 = "c:\\upload_gyoontar" + File.separator + "product";        
		        try{
		            srcFileName = URLDecoder.decode(pVO.getPimage(),"UTF-8"); // UUID가 포함된 파일이름을 디코딩해줍니다.
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
				pVO.setPimage(uploadURL); // 테이블에 저장하기 위한 경로
			} catch (Exception e) {
				e.printStackTrace();
			}
		}

		int result = product_service.update(pVO);
			System.out.println("Product Update Result : " + result);
		rttr.addFlashAttribute("update_result", result);
		return "redirect:/admin/product.do";
	}
	
	@RequestMapping(value = "/productDelete.do", method = {RequestMethod.GET, RequestMethod.POST}) 
	public String productDelete(@RequestParam("pseq") int[] pseq, RedirectAttributes rttr) {
		
		for( int pq : pseq) {
			ProductVO pVO =	product_service.view(pq);
		    String srcFileName = null; String uploadPath = "c:\\upload_gyoontar" + File.separator + "product" ;
	        try{
	            srcFileName = URLDecoder.decode(pVO.getPimage(),"UTF-8"); // UUID가 포함된 파일이름을 디코딩해줍니다.
	            File file = new File(uploadPath + File.separator + srcFileName);
	            boolean result = file.delete();
	            System.out.println("Delete uploadFile Result : " + result);
	            if( !result ) { // result가 false일 때, 파일 삭제 실패로 간주하여 boardView로 돌아감.
	            	rttr.addAttribute("delete_result", "Delete Fail");
	            	return "redirect:/admin/product.do";
	            }
	            int real_delete_result = product_service.delete(pq);
	            System.out.println("Delete Product In DB Result : " + real_delete_result);
	        }catch (UnsupportedEncodingException e){
	            e.printStackTrace();
	        }
		}

    	rttr.addFlashAttribute("delete_result", "Delete Success !");
		return "redirect:/admin/product.do";
	}
	
	/* ---------------------- Member ---------------------- */
	
	@RequestMapping(value = "/member.do", method = {RequestMethod.GET, RequestMethod.POST}) 
	public void member(Model model, Criteria cri) {
		
		int count = member_service.selectCount(cri);
		model.addAttribute("member_list", member_service.selectAll(cri));
		model.addAttribute("pageVO", new PageVO(cri,count));
	}
	@PostMapping("/toDormant.do")
	public String toDormant(@RequestParam("userid") String[] useridArr, RedirectAttributes rttr) {
		for(String userid : useridArr) {
			if( member_service.toDormant(userid) != 1 ) {
				rttr.addFlashAttribute("y_result", 0);
				return "redirect:/admin/member.do";
			}
		}
		rttr.addFlashAttribute("y_result", 1);
		return "redirect:/admin/member.do";
	}
	@PostMapping("/notDormant.do")
	public String notDormant(@RequestParam("userid") String[] useridArr, RedirectAttributes rttr) {
		for(String userid : useridArr) {
			if( member_service.notDormant(userid) != 1 ) {
				rttr.addFlashAttribute("n_result", 0);
				return "redirect:/admin/member.do";
			}
		}
		rttr.addFlashAttribute("n_result", 1);
		return "redirect:/admin/member.do";
	}
	
	/* ---------------------- Admin ---------------------- */
	@GetMapping("/admin.do")
	public void admin(Model model, Criteria cri) {
		
		model.addAttribute("admin_list", member_service.selectAdmin());
		model.addAttribute("count", member_service.selectCountAdmin());
	}
	
	@GetMapping("/adminWrite.do")
	public void getAdminWrite() {
		
	}
	
	@PostMapping("/adminWrite.do")
	public String postAdminWrite(MemberVO mVO, @RequestParam(value="uploadfile") MultipartFile uploadfile, RedirectAttributes rttr) {
		
		if( uploadfile.isEmpty() ) {
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
			// 첨부파일 업로드 폴더에 저장하기
			try {
				uploadfile.transferTo(uploadSaveFile); // 파일 실제로 전송
				mVO.setMprofile(uploadURL); // 테이블에 저장하기 위한 경로
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		
		//password encoder
		String pass = pwencoder.encode(mVO.getPass());
		mVO.setPass(pass);
		
		int result = member_service.insertAdmin(mVO);
		if( result == 1) {
			MemberVO mVO1 = new MemberVO(); mVO1.setUserid(mVO.getUserid()); mVO1.setAuth("ROLE_MEMBER");
			MemberVO mVO2 = new MemberVO(); mVO2.setUserid(mVO.getUserid()); mVO2.setAuth("ROLE_ADMIN");
			member_service.insertAuth(mVO1); member_service.insertAuth(mVO2); 
		}
		rttr.addFlashAttribute("insert_result", result); System.out.println("insert_result : " + result);
		return "redirect:/admin/admin.do";
	}
	@GetMapping("/checkUserId.do")
	public @ResponseBody String checkAdminId(@RequestParam("userid") String userid) {
		int result = member_service.checkUserid(userid);
		return Integer.toString(result);
	}
	@GetMapping("/checkNickname.do")
	public @ResponseBody String checknickname(@RequestParam("nickname") String nickname) {
		int result = member_service.checkNickname(nickname);
		return Integer.toString(result);
	}
	@GetMapping("/checkUpdateNickname.do")
	public @ResponseBody String checkUpdateNickname(MemberVO mVO) {
		int result = member_service.checkUpdateNickname(mVO);
		return Integer.toString(result);
	}
	@GetMapping("/mailCheck.do")
	public @ResponseBody String mailCheck(@RequestParam("email") String email) {
		//인증번호(난수) 생성
		Random random = new Random();
		int checkNum = random.nextInt(888888) + 111111;
		System.out.println("인증 번호 : " + checkNum);
		
		//이메일 보내기
		String setFrom = "gyoonproject@gmail.com";
		String toMail = email;
		String title = "Gyoontar's E-mail code.";
		String content = "<p>Thank you for visiting Gyoontar.</p>"
				+ "<p>Code : " + checkNum + " </p>"
				+ "<p>(Please copy and paste)</p>";
		try {
			MimeMessage message = mailSender.createMimeMessage(); //상단에 JavaMailSender 주입해줘야 함.
			MimeMessageHelper helper = new MimeMessageHelper(message, true, "utf-8");
			helper.setFrom(setFrom);
			helper.setTo(toMail);
			helper.setSubject(title);
			helper.setText(content, true);
			mailSender.send(message);
		} catch (Exception e) {
			e.printStackTrace();
		}
		String num = Integer.toString(checkNum);
		return num;
	}
	@PostMapping("/adminDelete.do")
	public String adminDelte(@RequestParam("userid") String[] useridArr, RedirectAttributes rttr) {
		for(String userid : useridArr) {
	        //기존의 첨부파일 이미지 삭제하기.
			MemberVO mVO = member_service.read(userid);
			if(mVO.getMprofile() != null && mVO.getMprofile() != "") {
		        String srcFileName = null; String uploadPath2 = "c:\\upload_gyoontar" + File.separator + "member";        
		        try{
		            srcFileName = URLDecoder.decode(mVO.getMprofile(),"UTF-8"); // UUID가 포함된 파일이름을 디코딩해줍니다.
		            File file = new File(uploadPath2 + File.separator + srcFileName);
		            boolean result = file.delete();
		            System.out.println("Delete uploadFile Result : " + result);
		        }catch (UnsupportedEncodingException e){
		            e.printStackTrace();
		        }
			}
			//계정 삭제하기
			if( member_service.adminDelete(userid) != 1 ) {
				rttr.addFlashAttribute("delete_result", 0);
				return "redirect:/admin/admin.do";
			}
		}
		rttr.addFlashAttribute("delete_result", 1);
		return "redirect:/admin/admin.do";
	}
	@GetMapping("/adminUpdate.do")
	public void adminUpdate(Model model, @RequestParam("userid") String userid) {
		model.addAttribute("mVO", member_service.read(userid));
	}
	@PostMapping("/adminUpdate.do")
	public String adminPostUpdate(Model model, @RequestParam(value="uploadfile") MultipartFile uploadfile, MemberVO mVO, RedirectAttributes rttr) {
		
		if( uploadfile.isEmpty() ) {
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
	        //기존의 첨부파일 이미지 삭제하기.
			if(mVO.getMprofile() != null && mVO.getMprofile() != "") {
		        String srcFileName = null; String uploadPath2 = "c:\\upload_gyoontar" + File.separator + "member";        
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
		
		//password encoder
		String pass = pwencoder.encode(mVO.getPass());
		mVO.setPass(pass);
		
		int result = member_service.updateAdmin(mVO);
		rttr.addFlashAttribute("update_result", result); System.out.println("update_result : " + result);
		return "redirect:/admin/admin.do";
	}
	
	/* ---------------------- QnA ---------------------- */
	@GetMapping("/qna.do")
	public void qna(Model model, Criteria cri) {
		int count = mypage_service.selectQnaCount(cri);
		model.addAttribute("qna_list", mypage_service.selectAllQna(cri));
		model.addAttribute("pageVO", new PageVO(cri, count));
	}
	@GetMapping("/qnaUpdate.do")
	public @ResponseBody QnaVO qnaUpdate(@RequestParam("qseq") int qseq) {
		
		return mypage_service.selectOneQna(qseq);
	}
	@PostMapping("/qnaUpdatePost.do")
	public @ResponseBody String qnaUpdatePost(QnaVO qVO) {
		
		return Integer.toString( mypage_service.updateQna(qVO) );
	}
	@GetMapping("/qnaCheck.do")
	public String qnaCheckY(Model model, @RequestParam("qseq") int[] qseqArr, @RequestParam("qresult") int qresult, Criteria cri, RedirectAttributes rttr ) {
		int check_result = 0;
		for( int qseq : qseqArr ) {
			QnaVO qVO = new QnaVO(qseq, qresult);
			if( mypage_service.updateQresult(qVO) != 1 ) {
				check_result = 0;
				break;
			}
			check_result++;
		}
		rttr.addFlashAttribute("check_result", check_result);
		model.addAttribute("cri", cri);
		return "redirect:/admin/qna.do";
	}
	@GetMapping("/qnaDelete.do")
	public String qnaDelete(Model model, @RequestParam("qseq") int[] qseqArr, Criteria cri, RedirectAttributes rttr ) {
		int delete_result = 0;
		for( int qseq : qseqArr ) {
			if( mypage_service.qnaDelete(qseq) != 1 ) {
				delete_result = 0;
				break;
			}
			delete_result++;
		}
		rttr.addFlashAttribute("delete_result", delete_result);
		model.addAttribute("cri", cri);
		return "redirect:/admin/qna.do";
	}
	
}
