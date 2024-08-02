package com.spring.javaclassS11.controller;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.spring.javaclassS11.common.LevelBlocker;
import com.spring.javaclassS11.common.PageProcess;
import com.spring.javaclassS11.service.BoardService;
import com.spring.javaclassS11.vo.FreeBoardReplyVO;
import com.spring.javaclassS11.vo.FreeBoardVO;
import com.spring.javaclassS11.vo.FromIVEVO;
import com.spring.javaclassS11.vo.MemberVO;
import com.spring.javaclassS11.vo.PagVO;
import com.spring.javaclassS11.vo.ToIVEVO;

@Controller
public class BoardController {
	
	@Autowired 
	BoardService boardService;
	
	@Autowired
	PageProcess pageProcess;
	
	@Autowired
	LevelBlocker levelBlocker;

	@RequestMapping(value = "/board/freeBoard" , method = RequestMethod.GET)
	public String freeBoardGet(Model model,
		@RequestParam(name="pag", defaultValue = "1", required = false) int pag,
		@RequestParam(name="pageSize", defaultValue = "10", required = false) int pageSize) {
		
		PagVO pageVo = pageProcess.getTotRecCnt(pag, pageSize, "freeBoard", "", "");
		
		ArrayList<FreeBoardVO> vos = boardService.getFreeBoardList(pageVo.getStartIndexNo(),pageVo.getPageSize());
		model.addAttribute("vos", vos);
		model.addAttribute("pageVo", pageVo);
		return "board/freeBoard";
	}	
	
	/** 자유게시판 게시글 보기 */
	@RequestMapping(value = "/board/freeBoardContent" , method = RequestMethod.GET)
	public String freeBoardContentGet(Model model, int idx,
		@RequestParam(name="pag", defaultValue = "1", required = false) int pag,
		@RequestParam(name="pageSize", defaultValue = "10", required = false) int pageSize) {
		
		PagVO pageVo = pageProcess.getTotRecCnt(pag, pageSize, "freeBoard", "", "");
		FreeBoardVO vo = boardService.getFreeBoardContent(idx);
		
		model.addAttribute("pageVo", pageVo);
		model.addAttribute("vo", vo);
		
		ArrayList<FreeBoardReplyVO> replyVos = boardService.getBoardReplyList(idx);
		model.addAttribute("replyVos", replyVos);
		
		return "board/freeBoardContent";
	}	
	
	/** 자유게시판 게시글에 댓글 작성하기 */
	@ResponseBody
	@RequestMapping(value = "/board/freeBoardReplyInput" , method = RequestMethod.POST)
	public String freeBoardReplyInputPost(FreeBoardReplyVO vo) {
		int res = boardService.setFreeBoardReplyInput(vo);
		return res + "";
	}	
	
	/** 자유게시판 게시글에 댓글 작성하기 */
	@ResponseBody
	@RequestMapping(value = "/board/freeBoardReplyDelete" , method = RequestMethod.POST)
	public String freeBoardReplyDeletePost(int idx) {
		int res = boardService.setFreeBoardReplyDelete(idx);
		return res + "";
	}	
	
	// 자유게시판 글쓰기 화면
	@RequestMapping(value = "/board/freeBoardInput" , method = RequestMethod.GET)
	public String noticeInputGet(Model model, HttpSession session,
		@RequestParam(name="pag", defaultValue = "1", required = false) int pag,
		@RequestParam(name="pageSize", defaultValue = "10", required = false) int pageSize
		) { 
		int level = 0;
		if((String) session.getAttribute("sMid") != null)	level = (int)session.getAttribute("sLevel");			
		else level = 0;
		
		String result = levelBlocker.levelBlocker("freeBoardInput", level);
		
		
		if(result.equals("level0Cut")) return "redirect:/message/level0Cut";
		else if(result.equals("freeBoardInputLevel2")) return "redirect:/message/freeBoardInputLevel2";
		else if(result.equals("Ok")) {
			PagVO pageVo = pageProcess.getTotRecCnt(pag, pageSize, "freeBoard", "", "");
			model.addAttribute("pageVo", pageVo);
		}
		return "/board/freeBoardInput"; 			
	}	
	
	// 자유게시판 글 등록
	@RequestMapping(value = "/board/freeBoardInput" , method = RequestMethod.POST)
	public String freeBoardInputPost(FreeBoardVO vo,
			@RequestParam(name="pag", defaultValue = "1", required = false) int pag,
			@RequestParam(name="pageSize", defaultValue = "10", required = false) int pageSize
			) { 
		int res = boardService.setFreeBoardInput(vo);
		
		if(res != 0) return "redirect:/message/freeBoardInputOk?pag="+pag+"&pageSize="+pageSize; 
		else return "redirect:/message/freeBoardInputNo?pag="+pag+"&pageSize="+pageSize; 
	}
	
	// fromIVE 게시판 메인화면
	@RequestMapping(value = "/board/fromIVE" , method = RequestMethod.GET)
	public String fromIVEGet(Model model, HttpSession session,
		@RequestParam(name="pag", defaultValue = "1", required = false) int pag,
		@RequestParam(name="pageSize", defaultValue = "10", required = false) int pageSize) {
		
		int level = 0;
		if((String) session.getAttribute("sMid") != null)	level = (int)session.getAttribute("sLevel");			
		else level = 0;
		String result = levelBlocker.levelBlocker("fromIVEList", level);
		
		if(result.equals("level0Cut")) return "redirect:/message/level0Cut";
		else if(result.equals("fromIVEListLevel2")) return "redirect:/message/fromIVEListLevel2";
		else if(result.equals("Ok")) {
			PagVO pageVo = pageProcess.getTotRecCnt(pag, pageSize, "fromIVE", "", "");
			model.addAttribute("pageVo", pageVo);
			ArrayList<FromIVEVO> vos = boardService.getFromIVEList(pageVo.getStartIndexNo(),pageVo.getPageSize());
			model.addAttribute("vos", vos);
		}
		
		return "board/fromIVE";
	}	
	
	@RequestMapping(value = "/board/fromIVEContent" , method = RequestMethod.GET)
	public String fromIVEContentGet(Model model, int idx,
			@RequestParam(name="pag", defaultValue = "1", required = false) int pag,
			@RequestParam(name="pageSize", defaultValue = "10", required = false) int pageSize) {
		
		PagVO pageVo = pageProcess.getTotRecCnt(pag, pageSize, "fromIVE", "", "");
		
		FromIVEVO vo = boardService.getFromIVEContent(idx);
		model.addAttribute("vo", vo);
		model.addAttribute("pageVo", pageVo);
		
		return "board/fromIVEContent";
	}	
	
	// fromIVE 게시판 글쓰기
	@RequestMapping(value = "/board/fromIVEInput" , method = RequestMethod.GET)
	public String fromIVEInputGet(FromIVEVO vo,
			@RequestParam(name="pag", defaultValue = "1", required = false) int pag,
			@RequestParam(name="pageSize", defaultValue = "10", required = false) int pageSize
			) { 
		return "board/fromIVEInput"; 
	}
	
	// fromIVE 게시판 글쓰기
	@RequestMapping(value = "/board/fromIVEInput" , method = RequestMethod.POST)
	public String fromIVEInputPost(FromIVEVO vo,
			@RequestParam(name="pag", defaultValue = "1", required = false) int pag,
			@RequestParam(name="pageSize", defaultValue = "10", required = false) int pageSize
			) { 
		int res = boardService.setFromIVEInput(vo);
		
		if(res != 0) return "redirect:/message/fromIVEInputOk?pag="+pag+"&pageSize="+pageSize; 
		else return "redirect:/message/fromIVEInputNo?pag="+pag+"&pageSize="+pageSize; 
	}
	
	
	// toIVE 게시판 메인화면
	@RequestMapping(value = "/board/toIVE" , method = RequestMethod.GET)
	public String toIVEGet(Model model, HttpSession session,
		@RequestParam(name="pag", defaultValue = "1", required = false) int pag,
		@RequestParam(name="pageSize", defaultValue = "10", required = false) int pageSize) {
		
		int level = 0;
		if((String) session.getAttribute("sMid") != null)	level = (int)session.getAttribute("sLevel");			
		else level = 0;
		String result = levelBlocker.levelBlocker("toIVEList", level);
		
		if(result.equals("level0Cut")) return "redirect:/message/level0Cut";
		else if(result.equals("toIVEListLevel2")) return "redirect:/message/toIVEListLevel2";
		else if(result.equals("Ok")) {
			PagVO pageVo = pageProcess.getTotRecCnt(pag, pageSize, "toIVE", "", "");
			model.addAttribute("pageVo", pageVo);
			ArrayList<ToIVEVO> vos = boardService.getToIVEList(pageVo.getStartIndexNo(),pageVo.getPageSize());
			model.addAttribute("vos", vos);
		}
		
		return "board/toIVE";
	}	
	
	// toIVE 게시글보기
	@RequestMapping(value = "/board/toIVEContent" , method = RequestMethod.GET)
	public String toIVEContentGet(Model model, int idx,
			@RequestParam(name="pag", defaultValue = "1", required = false) int pag,
			@RequestParam(name="pageSize", defaultValue = "10", required = false) int pageSize) {
		
		PagVO pageVo = pageProcess.getTotRecCnt(pag, pageSize, "toIVE", "", "");
		
		ToIVEVO vo = boardService.getToIVEContent(idx);
		model.addAttribute("vo", vo);
		model.addAttribute("pageVo", pageVo);
		return "board/toIVEContent";
	}	
	
	
	
	
	
	
	
	
	
	
	
}








