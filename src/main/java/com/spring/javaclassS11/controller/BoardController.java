package com.spring.javaclassS11.controller;

import java.util.ArrayList;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.spring.javaclassS11.common.PageProcess;
import com.spring.javaclassS11.service.BoardService;
import com.spring.javaclassS11.vo.FreeBoardVO;
import com.spring.javaclassS11.vo.PagVO;

@Controller
public class BoardController {
	
	@Autowired 
	BoardService boardService;
	
	@Autowired
	BCryptPasswordEncoder passwordEncoder;
	
	@Autowired
	PageProcess pageProcess;

	@RequestMapping(value = "/board/freeBoard" , method = RequestMethod.GET)
	public String freeBoardGet(Model model,
			@RequestParam(name="pag", defaultValue = "1", required = false) int pag,
			@RequestParam(name="pageSize", defaultValue = "10", required = false) int pageSize) {
		
		PagVO pageVo = pageProcess.getTotRecCnt(pag, pageSize, "freeBoard", "", "");
		
		ArrayList<FreeBoardVO> vos = boardService.getFreeBoardList();
		model.addAttribute("vos", vos);
		model.addAttribute("pageVo", pageVo);
		return "board/freeBoard";
	}	
	
	@RequestMapping(value = "/board/freeBoardContent" , method = RequestMethod.GET)
	public String freeBoardContentGet(Model model, int idx,
			@RequestParam(name="pag", defaultValue = "1", required = false) int pag,
			@RequestParam(name="pageSize", defaultValue = "10", required = false) int pageSize) {
		System.out.println(idx);
		
		PagVO pageVo = pageProcess.getTotRecCnt(pag, pageSize, "freeBoard", "", "");
		FreeBoardVO vo = boardService.getFreeBoardContent(idx);
		System.out.println(pageVo);
		System.out.println(vo);
		
		model.addAttribute("pageVo", pageVo);
		model.addAttribute("vo", vo);
		return "board/freeBoardContent";
	}	
	
	
}









