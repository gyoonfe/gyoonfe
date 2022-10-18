package com.gyoontar.controller;

import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.gyoontar.domain.BoardVO;
import com.gyoontar.domain.ProductVO;
import com.gyoontar.service.ProductService;
import com.gyoontar.utility.Criteria;
import com.gyoontar.utility.PageVO;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Controller
@RequestMapping("/product/*")
@AllArgsConstructor
@Log4j
public class ProductController {

	private ProductService service;
	
	@RequestMapping(value = "/productSearch.do", method = {RequestMethod.GET, RequestMethod.POST}) 
	public void toProductSearch(Model model, Criteria cri) { 
		if(cri.getAmount() == 10) {
			cri.setAmount(12);
		}
		int count = service.selectCount(cri);
		model.addAttribute("best_list", service.selectBest());
		model.addAttribute("product_list", service.selectAll(cri));
		model.addAttribute("pageVO", new PageVO(cri, count));
	}
	
	@RequestMapping(value = "/productSale.do", method = {RequestMethod.GET, RequestMethod.POST})
	public void toProductSale(Model model, Criteria cri) { 
		if(cri.getAmount() == 10) {
			cri.setAmount(12);
		}
		int count = service.selectSaleCount(cri);
		model.addAttribute("best_list", service.selectBest());
		model.addAttribute("sale_list", service.selectSale(cri));
		model.addAttribute("pageVO", new PageVO(cri, count));
	}

	@RequestMapping(value = "/productCategory.do", method = {RequestMethod.GET, RequestMethod.POST})
	public void toProductCategory(Model model, Criteria cri) { //URL의 category 값은 Criteria에 바인딩.
		if(cri.getAmount() == 10) {
			cri.setAmount(12);
		}
		int count = service.selectKindCount(cri);
		model.addAttribute("best_list", service.selectBest());
		model.addAttribute("product_list", service.selectKind(cri));
		model.addAttribute("pageVO", new PageVO(cri, count));
	}
	
	@GetMapping("/productView.do") 
	public void toProductView(Model model, @RequestParam("pseq") int pseq) { 
		model.addAttribute("wish_list", service.selectWish(pseq));
		model.addAttribute("wishCount", service.selectWishCount(pseq));
		model.addAttribute("pVO", service.view(pseq));
		model.addAttribute("review_list", service.selectReview(pseq));
		model.addAttribute("comment_list", service.selectComment(pseq));
	}
	@GetMapping("/addWish.do") 
	@ResponseBody
	public String addWish(ProductVO pVO) { 
		int data = -1;
		if( service.insertWish(pVO) == 1 ) {
			data = service.selectWishCount(pVO.getPseq());
		}
		return Integer.toString(data);
	}
	@GetMapping("/deleteWish.do") 
	@ResponseBody
	public String deleteWish(ProductVO pVO) { 
		int data = -1;
		if( service.deleteWish(pVO) == 1 ) {
			data = service.selectWishCount(pVO.getPseq());
		}
		return Integer.toString(data);
	}
	@PostMapping("/revWrite.do")
	@PreAuthorize("isAuthenticated()")
	public String revWrite(ProductVO pVO, RedirectAttributes rttr) {
		int reviewIN_result = service.insertReview(pVO);
		rttr.addFlashAttribute("reviewIN_result", reviewIN_result);
		rttr.addAttribute("pseq", pVO.getPseq());
		return "redirect:/product/productView.do";
	}
	@GetMapping("/revUpdate.do")
	@ResponseBody
	public ProductVO revUpdate(@RequestParam("revno") int revno) {
		return service.selectOneReview(revno);
	}
	@PostMapping("/revUpdatePost.do")
	@ResponseBody
	public String revUpdatePost(ProductVO pVO) {
		System.out.println("revcontent : " + pVO.getRevcontent());
		return Integer.toString(service.updateReview(pVO));
	}
	@GetMapping("/revDelete.do")
	@PreAuthorize("principal.username == #pVO.userid")
	public String revDelete(ProductVO pVO, RedirectAttributes rttr) {
		int reviewDel_result = service.deleteReview(pVO);
		rttr.addFlashAttribute("reviewDel_result", reviewDel_result);
		rttr.addAttribute("pseq", pVO.getPseq());
		return "redirect:/product/productView.do";
	}
	@PostMapping("/comWrite.do")
	@PreAuthorize("isAuthenticated()")
	public String comWrite(ProductVO pVO, RedirectAttributes rttr) {
		int commentIN_result = service.insertComment(pVO);
		rttr.addFlashAttribute("commentIN_result", commentIN_result);
		rttr.addAttribute("pseq", pVO.getPseq());
		return "redirect:/product/productView.do";
	}
	@GetMapping("/comUpdate.do")
	@ResponseBody
	public ProductVO comUpdate(@RequestParam("comno") int comno) {
		return service.selectOneComment(comno);
	}
	@PostMapping("/comUpdatePost.do")
	@ResponseBody
	public String comUpdatePost(ProductVO pVO) {
		System.out.println("comcontent : " + pVO.getComcontent());
		return Integer.toString(service.updateComment(pVO));
	}
	@GetMapping("/comDelete.do")
	@PreAuthorize("principal.username == #pVO.userid")
	public String comDelete(ProductVO pVO, RedirectAttributes rttr) {
		int commentDel_result = service.deleteComment(pVO);
		rttr.addFlashAttribute("commentDel_result", commentDel_result);
		rttr.addAttribute("pseq", pVO.getPseq());
		return "redirect:/product/productView.do";
	}	
	
	
	
}
