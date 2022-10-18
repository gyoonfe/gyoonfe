package com.gyoontar.controller;

import java.io.File;
import java.io.UnsupportedEncodingException;
import java.net.URLDecoder;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.UUID;

import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.gyoontar.domain.BoardVO;
import com.gyoontar.service.BoardService;
import com.gyoontar.service.ProductService;
import com.gyoontar.utility.Criteria;
import com.gyoontar.utility.PageVO;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Controller
@RequestMapping("/board/*")
@AllArgsConstructor
@Log4j
public class BoardController {

	private BoardService service;
	
	@GetMapping("/board.do") 
	public void toBoard(Model model, Criteria cri) { 
		int count = service.selectCount(cri);
		model.addAttribute("board_list", service.select(cri));
		model.addAttribute("notice_list", service.selectNotice(cri));
		model.addAttribute("pageVO" , new PageVO(cri, count));
	}
	
	@GetMapping("/boardView.do") 
	public void toBoardView(Model model, @RequestParam("bno") int bno, @ModelAttribute("cri") Criteria cri) { //필요한 메서드 = 조회수 올리기, 최대BNO, 최소BNO, nextBVO, prevBVO
		log.info("Page to -> boardView.do ... ");
		service.plusHits(bno);
		model.addAttribute("bVO", service.view(bno));
		model.addAttribute("cri", cri);
		model.addAttribute("reply_list", service.selectReply(bno)); // 해당 bno의 모든 댓글
		model.addAttribute("like_count", service.selectLikeCount(bno)); // 좋아요 개수
		model.addAttribute("like_list", service.selectLike(bno)); // bno에 해당하는 좋아요를 누른 userid의 목록
		if(bno < service.maxBno()) {
			model.addAttribute("nextBvo", service.nextBvo(bno));
		}
		if(bno > service.minBno()) {
			model.addAttribute("prevBvo", service.prevBvo(bno));
		}
	}
	@GetMapping("/addLike.do") 
	@ResponseBody
	public String addLike(BoardVO bVO) { 
		service.addLike(bVO);
		int result = service.selectLikeCount(bVO.getBno());
		return Integer.toString(result);
	}
	@GetMapping("/deleteLike.do") 
	@ResponseBody
	public String deleteLike(BoardVO bVO) { 
		service.deleteLike(bVO);
		int result = service.selectLikeCount(bVO.getBno());
		return Integer.toString(result);
	}
	@PostMapping("/boardRepWrite.do")
	@PreAuthorize("principal.username == #boardVO.userid")
	public String repWrite(BoardVO boardVO, Criteria cri, RedirectAttributes rttr) {
		int result = service.insertReply(boardVO);
		rttr.addFlashAttribute("insertReply_result", result);
		rttr.addAttribute("bno", boardVO.getBno());
		rttr.addAttribute("pageNum", cri.getPageNum());
		rttr.addAttribute("amount", cri.getAmount());
		return "redirect:/board/boardView.do";
	}
	@GetMapping("/boardRepUpdate.do")
	@ResponseBody
	public BoardVO boardRepUpdate(@RequestParam("repno") int repno) {
		return service.selectOneReply(repno);
	}
	@PostMapping("/boardRepUpdatePost.do")
	@ResponseBody
	public String boardRepUpdatePost(BoardVO bVO) {
		System.out.println("repcontent : " + bVO.getRepcontent());
		return Integer.toString(service.updateReply(bVO));
	}
	@GetMapping("/boardRepDelete.do")
	@PreAuthorize("principal.username == #boardVO.userid")
	public String boardRepDelete(BoardVO boardVO, Criteria cri, RedirectAttributes rttr) {
		int result = service.deleteReply(boardVO);
		rttr.addFlashAttribute("deleteReply_result", result);
		rttr.addAttribute("bno", boardVO.getBno());
		rttr.addAttribute("pageNum", cri.getPageNum());
		rttr.addAttribute("amount", cri.getAmount());
		return "redirect:/board/boardView.do";
	}
	
	@GetMapping("/boardWrite.do")
	public void toBoardWrite() { 
		log.info("Page to -> boardWrite.do ... ");
	}
	//날짜 폴더 만들기
	public String getFolder() {
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		Date date = new Date();
		String str = sdf.format(date);
		return str.replace("-", File.separator);
	}
	@PostMapping("/boardWrite.do")
	@PreAuthorize("isAuthenticated()")
	public String BoardWrite(BoardVO boardVO, RedirectAttributes rttr) { 

		int insert_result =  service.insert(boardVO);
		rttr.addFlashAttribute("insert_result", insert_result);
		return "redirect:/board/board.do";
	}
	
	@GetMapping("/boardUpdate.do") 
	@PreAuthorize("principal.username == #userid")
	public void toBoardUpdate(Model model, @RequestParam("bno") int bno, @RequestParam("userid") String userid, Criteria cri, RedirectAttributes rttr) { 
		model.addAttribute("boardVO", service.view(bno));
		model.addAttribute("cri", cri); 
	}
	
	@PostMapping("/boardUpdate.do")
	@PreAuthorize("principal.username == #boardVO.userid")
	public String boardUpdate(BoardVO boardVO, Criteria cri, RedirectAttributes rttr) {
		
		int result = service.update(boardVO);
		rttr.addFlashAttribute("update_result", result);
		rttr.addAttribute("pageNum", cri.getPageNum());
		rttr.addAttribute("amount", cri.getAmount());
		return "redirect:/board/board.do";
	}
	
	@GetMapping("/boardDelete.do")
	@PreAuthorize("principal.username == #userid")
	public String boardDelete(@RequestParam ("bno") int bno, @RequestParam ("userid") String userid, Criteria cri, RedirectAttributes rttr) {

		int delete_result = service.delete(bno);
		rttr.addFlashAttribute("delete_result", delete_result);
    	rttr.addAttribute("pageNum",cri.getPageNum());
    	rttr.addAttribute("amount",cri.getAmount());
		return "redirect:/board/board.do";
	}
	
	
}