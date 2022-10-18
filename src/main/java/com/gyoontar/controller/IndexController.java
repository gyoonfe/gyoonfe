package com.gyoontar.controller;

import java.util.Random;

import javax.mail.internet.MimeMessage;

import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.gyoontar.service.BoardService;
import com.gyoontar.service.MapService;
import com.gyoontar.service.ProductService;
import com.gyoontar.utility.Criteria;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Controller
@RequestMapping("/index/*")
@AllArgsConstructor
@Log4j
public class IndexController {

	private BoardService board_service;
	private ProductService product_service;
	private MapService map_service;
	private JavaMailSender mailSender;
	
	@GetMapping("/map.do") 
	public void map(Model model) {
		model.addAttribute("map_list", map_service.selectAllMap());
	}
	
	@GetMapping("/test.do")
	public void test() {
		
	}
	
	@GetMapping("/test2.do")
	public void test2() {
		
	}
	
	@GetMapping("/index.do") 
	public void toIndext(Model model) { 
		Criteria cri = new Criteria();
		model.addAttribute("cri", cri);
		model.addAttribute("notice_list", board_service.selectNotice(cri));
		model.addAttribute("board_list", board_service.select(cri));
		model.addAttribute("product_list", product_service.selectAll(cri));
		model.addAttribute("best_list", product_service.selectBest());
		model.addAttribute("sale_list", product_service.selectSale(cri));
	}
	
	@GetMapping("/faq.do") 
	public void toFaq() { 
		log.info("Page to -> FAQ ... ");

	}	
	
	@PostMapping("/contact.do")
	public @ResponseBody String mailCheck(@RequestParam("email") String email, @RequestParam("name") String name, @RequestParam("content") String content) {
		//이메일 보내기
		String result = "0";
		String setFrom = email;
		String toMail = "gyoonproject@gmail.com";
		String title = "Gyoontar's Contact Us Mail.";
		String contents = "<p>Name : " + name + " .</p>"
					+ "<p>E-mail : " + email + " .</p>"
					+ "<p>" + content + "</p>";
		try {
			MimeMessage message = mailSender.createMimeMessage(); //상단에 JavaMailSender 주입해줘야 함.
			MimeMessageHelper helper = new MimeMessageHelper(message, true, "utf-8");
			helper.setFrom(setFrom);
			helper.setTo(toMail);
			helper.setSubject(title);
			helper.setText(contents, true);
			mailSender.send(message);
			result = "1";
			System.out.println("result : 1 => Contact Us Maill sent successfully !!!");
		} catch (Exception e) {
			e.printStackTrace();
			result = "0";
		}
		return result;
	}
	
}
