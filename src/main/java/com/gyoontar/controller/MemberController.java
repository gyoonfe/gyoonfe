package com.gyoontar.controller;

import java.io.File;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Random;
import java.util.UUID;

import javax.mail.internet.MimeMessage;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.security.core.Authentication;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.gyoontar.domain.MemberVO;
import com.gyoontar.service.MemberService;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Controller
@RequestMapping("/member/*")
@AllArgsConstructor
@Log4j
public class MemberController {
	
	private MemberService service;
	private JavaMailSender mailSender;
	private PasswordEncoder pwencoder;
	
	//날짜 폴더 만들기
	public String getFolder() {
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		Date date = new Date();
		String str = sdf.format(date);
		return str.replace("-", File.separator);
	}
	
	@GetMapping("/login.do")
	public void loginInput(String error, String logout, Model model) {
		log.info("error : " + error); System.out.println("error : " + error);
		log.info("logout : " + logout); System.out.println("logout : " + logout);
		
		if(error != null) {
			model.addAttribute("errorMsg", "Check your Account !");
		}
		if(logout != null) {
			model.addAttribute("logoutMsg", "Logout !");
		}
	}
	
//	@RequestMapping("/logout.do") 
//	public String logout(RedirectAttributes rttr, HttpServletRequest request) { 
//		request.getSession().invalidate();
//		request.getSession(true);
//		System.out.println("LOG OUT ---------------------------------------------");
//		rttr.addFlashAttribute("logout_result", 1);
//		return "redirect:/member/login.do";
//	}	
	
	@GetMapping("/accessError.do")
	public void accessDenied(Authentication auth, Model model) {
		log.info("ACCESS DENIED ->" + auth );
		model.addAttribute("msg","Access Denied");
	}
	
	@GetMapping("/contract.do") 
	public void toContract() { 
		log.info("Page to -> Contract ... ");

	}	
	
	@GetMapping("/join.do")
	public void join() {
		
	}
	
	@PostMapping("/join.do") 
	public String toJoin(MemberVO mVO, @RequestParam(value="uploadfile") MultipartFile uploadfile, RedirectAttributes rttr) { 
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
		
		int result = service.insert(mVO);
		if( result == 1) {
			MemberVO mVO1 = new MemberVO(); 
			mVO1.setUserid(mVO.getUserid()); mVO1.setAuth("ROLE_MEMBER");
			service.insertAuth(mVO1);
		}
		rttr.addFlashAttribute("insert_result", result); System.out.println("insert_result : " + result);
		return "redirect:/member/login.do";
	}	
	
	@GetMapping("/checkUserId.do")
	public @ResponseBody String checkAdminId(@RequestParam("userid") String userid) {
		int result = service.checkUserid(userid);
		return Integer.toString(result);
	}
	@GetMapping("/checkNickname.do")
	public @ResponseBody String checknickname(@RequestParam("nickname") String nickname) {
		int result = service.checkNickname(nickname);
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
	
	
}
