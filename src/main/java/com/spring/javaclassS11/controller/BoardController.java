package com.spring.javaclassS11.controller;

import java.util.ArrayList;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.spring.javaclassS11.common.PageProcess;
import com.spring.javaclassS11.service.BoardService;
import com.spring.javaclassS11.vo.FreeBoardVO;
import com.spring.javaclassS11.vo.FromIVEVO;
import com.spring.javaclassS11.vo.NoticeVO;
import com.spring.javaclassS11.vo.PagVO;

@Controller
public class BoardController {
	
	@Autowired 
	BoardService boardService;
	
	@Autowired
	PageProcess pageProcess;

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
	
	@RequestMapping(value = "/board/freeBoardContent" , method = RequestMethod.GET)
	public String freeBoardContentGet(Model model, int idx,
		@RequestParam(name="pag", defaultValue = "1", required = false) int pag,
		@RequestParam(name="pageSize", defaultValue = "10", required = false) int pageSize) {
		
		PagVO pageVo = pageProcess.getTotRecCnt(pag, pageSize, "freeBoard", "", "");
		FreeBoardVO vo = boardService.getFreeBoardContent(idx);
		
		model.addAttribute("pageVo", pageVo);
		model.addAttribute("vo", vo);
		return "board/freeBoardContent";
	}	
	
	@RequestMapping(value = "/board/freeBoardInput" , method = RequestMethod.GET)
	public String noticeInputGet(Model model,
		@RequestParam(name="pag", defaultValue = "1", required = false) int pag,
		@RequestParam(name="pageSize", defaultValue = "10", required = false) int pageSize
		) { 
		PagVO pageVo = pageProcess.getTotRecCnt(pag, pageSize, "freeBoard", "", "");
		model.addAttribute("pageVo", pageVo);
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
	public String fromIVEGet(Model model,
		@RequestParam(name="pag", defaultValue = "1", required = false) int pag,
		@RequestParam(name="pageSize", defaultValue = "10", required = false) int pageSize) {
		
		PagVO pageVo = pageProcess.getTotRecCnt(pag, pageSize, "fromIVE", "", "");
		
		ArrayList<FromIVEVO> vos = boardService.getFromIVEList(pageVo.getStartIndexNo(),pageVo.getPageSize());
		model.addAttribute("vos", vos);
		model.addAttribute("pageVo", pageVo);
		return "board/fromIVE";
	}	
	
	// fromIVE 게시판 메인화면
	@RequestMapping(value = "/board/fromIVEInput" , method = RequestMethod.POST)
	public String fromIVEInputPost(FromIVEVO vo,
			@RequestParam(name="pag", defaultValue = "1", required = false) int pag,
			@RequestParam(name="pageSize", defaultValue = "10", required = false) int pageSize
			) { 
		int res = boardService.setFromIVEInput(vo);
		
		if(res != 0) return "redirect:/message/fromIVEInputOk?pag="+pag+"&pageSize="+pageSize; 
		else return "redirect:/message/fromIVEInputNo?pag="+pag+"&pageSize="+pageSize; 
	}
	
}








