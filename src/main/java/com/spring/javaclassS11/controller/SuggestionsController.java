package com.spring.javaclassS11.controller;

import java.util.ArrayList;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import com.spring.javaclassS11.common.LevelBlocker;
import com.spring.javaclassS11.common.PageProcess;
import com.spring.javaclassS11.service.SuggestionsService;
import com.spring.javaclassS11.vo.PagVO;
import com.spring.javaclassS11.vo.SongSuggestionsVO;
import com.spring.javaclassS11.vo.ChoreographySuggestionsVO;

@Controller
public class SuggestionsController {
	
	@Autowired
	SuggestionsService suggestionsService;
	
	@Autowired
	PageProcess pageProcess;
	
	@Autowired
	LevelBlocker levelBlocker;
	
	// 노래제안 게시판 suggestions/songSuggestions
	@RequestMapping(value="/suggestions/songSuggestions", method = RequestMethod.GET)
	public String songSuggestionsGet(Model model, HttpSession session,
		@RequestParam(name="pag", defaultValue = "1", required = false) int pag,
		@RequestParam(name="pageSize", defaultValue = "10", required = false) int pageSize) {
		
		int level = 0;
		if((String) session.getAttribute("sMid") != null)	level = (int)session.getAttribute("sLevel");			
		else level = 0;
		
		String result = levelBlocker.levelBlocker("songSuggestions", level);
		
		
		if(result.equals("level0Cut")) return "redirect:/message/level0Cut";
		else if(result.equals("songSuggestionsLevel4")) return "redirect:/message/songSuggestionsLevel4";
		
		else if(result.equals("Ok")) {
			PagVO pageVo = pageProcess.getTotRecCnt(pag, pageSize, "songSuggestions", "", "");
			model.addAttribute("pageVo", pageVo);
			ArrayList<SongSuggestionsVO> vos = suggestionsService.getsongSuggestionsList(pageVo.getStartIndexNo(),pageVo.getPageSize());
			model.addAttribute("vos", vos);
		}
		 
		
		return "suggestions/songSuggestions";
	}
	
	// 노래제안 작성화면
	@RequestMapping(value="/suggestions/songSuggestionsInput", method = RequestMethod.GET)
	public String songSuggestionsInputGet(Model model,
		@RequestParam(name="pag", defaultValue = "1", required = false) int pag,
		@RequestParam(name="pageSize", defaultValue = "10", required = false) int pageSize) {
		return "suggestions/songSuggestionsInput";
	}
	
	// 노래제안 작성완료처리
	@RequestMapping(value="/suggestions/songSuggestionsInput", method = RequestMethod.POST)
	public String songSuggestionsInputPost(SongSuggestionsVO vo, MultipartFile fName) {
		int res = suggestionsService.setSongSuggestionsInput(vo, fName);
			
		if(res != 0) return "redirect:/message/songSuggestionsInputOk";
		else return "redirect:/message/songSuggestionsInputNo";
	}
	
	// 노래제안 게시글 보기
	@RequestMapping(value="/suggestions/songSuggestionsContent", method = RequestMethod.GET)
	public String songSuggestionsContentGet(Model model, int idx,
		@RequestParam(name="pag", defaultValue = "1", required = false) int pag,
		@RequestParam(name="pageSize", defaultValue = "10", required = false) int pageSize) {
		
		SongSuggestionsVO vo = suggestionsService.getSongSuggestionsContent(idx);
		String songFileOriginName = vo.getSongFileName();
		model.addAttribute("vo", vo);
		model.addAttribute("songFileOriginName", songFileOriginName);
		return "suggestions/songSuggestionsContent";
	}
	
	
	
	// 안무제안 게시판 suggestions/choreographySuggestions
	@RequestMapping(value="/suggestions/choreographySuggestions", method = RequestMethod.GET)
	public String choreographySuggestionsGet(Model model, HttpSession session,
		@RequestParam(name="pag", defaultValue = "1", required = false) int pag,
		@RequestParam(name="pageSize", defaultValue = "10", required = false) int pageSize) {
		
		int level = 0;
		if((String) session.getAttribute("sMid") != null)	level = (int)session.getAttribute("sLevel");			
		else level = 0;
		
		String result = levelBlocker.levelBlocker("choreographySuggestions", level);
		
		if(result.equals("level0Cut")) return "redirect:/message/level0Cut";
		else if(result.equals("choreographySuggestionsLevel4")) return "redirect:/message/choreographySuggestionsLevel4";
		
		else if(result.equals("Ok")) {
			PagVO pageVo = pageProcess.getTotRecCnt(pag, pageSize, "choreographySuggestions", "", "");
			model.addAttribute("pageVo", pageVo);
			ArrayList<ChoreographySuggestionsVO> vos = suggestionsService.getChoreographySuggestionsList(pageVo.getStartIndexNo(),pageVo.getPageSize());
			model.addAttribute("vos", vos);
		}
		 
		return "suggestions/choreographySuggestions";
	}
	
	// 노래제안 게시글 보기
	@RequestMapping(value="/suggestions/choreographySuggestionsContent", method = RequestMethod.GET)
	public String choreographySuggestionsListGet(Model model, int idx,
		@RequestParam(name="pag", defaultValue = "1", required = false) int pag,
		@RequestParam(name="pageSize", defaultValue = "10", required = false) int pageSize) {
		
		ChoreographySuggestionsVO vo = suggestionsService.getChoreographySuggestionsContent(idx);
		String choreographyFileOriginName = vo.getChoreographyFileName();
		model.addAttribute("vo", vo);
		model.addAttribute("choreographyFileOriginName", choreographyFileOriginName);
		return "suggestions/choreographySuggestionsContent";
	}
	
	// 안무제안 작성화면
	@RequestMapping(value="/suggestions/choreographySuggestionsInput", method = RequestMethod.GET)
	public String choreographySuggestionsInputGet(Model model,
		@RequestParam(name="pag", defaultValue = "1", required = false) int pag,
		@RequestParam(name="pageSize", defaultValue = "10", required = false) int pageSize) {
		return "suggestions/choreographySuggestionsInput";
	}
	
	// 안무제안 작성완료처리
	@RequestMapping(value="/suggestions/choreographySuggestionsInput", method = RequestMethod.POST)
	public String choreographySuggestionsInputPost(ChoreographySuggestionsVO vo, MultipartFile fName) {
		int res = suggestionsService.setChoreographySuggestionsInput(vo, fName);
			
		if(res != 0) return "redirect:/message/choreographySuggestionsInputOk";
		else return "redirect:/message/choreographySuggestionsInputNo";
	}
	
	
	
	
	
	
	
	
	
	
	
	
	
}










