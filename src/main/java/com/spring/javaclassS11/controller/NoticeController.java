package com.spring.javaclassS11.controller;

import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.spring.javaclassS11.common.PageProcess;
import com.spring.javaclassS11.service.NoticeService;
import com.spring.javaclassS11.vo.NoticeVO;
import com.spring.javaclassS11.vo.PagVO;

@Controller
public class NoticeController {
	
	@Autowired 
	NoticeService noticeService;
	
	@Autowired
	BCryptPasswordEncoder passwordEncoder;
	
	@Autowired
	PageProcess pageProcess;

	@RequestMapping(value = "/notice/noticeBoard" , method = RequestMethod.GET)
	public String noticeBoardGet(Model model,
			@RequestParam(name="pag", defaultValue = "1", required = false) int pag,
			@RequestParam(name="pageSize", defaultValue = "10", required = false) int pageSize
			) { 
		PagVO pageVo = pageProcess.getTotRecCnt(pag, pageSize, "noticeBoard", "", "");
		
		ArrayList<NoticeVO> vos = noticeService.getNoticeBoardList(pageVo);
		model.addAttribute("vos", vos);
		model.addAttribute("pageVo", pageVo);
		return "notice/noticeBoard"; 
	}
	
	@RequestMapping(value = "/notice/noticeContent" , method = RequestMethod.GET)
	public String noticeContentGet(Model model, int idx, HttpServletRequest request,
			@RequestParam(name="pag", defaultValue = "1", required = false) int pag,
			@RequestParam(name="pageSize", defaultValue = "10", required = false) int pageSize
			) { 
		NoticeVO vo = noticeService.getNoticeBoardContent(idx);
		
		HttpSession session = request.getSession();
		ArrayList<String> ContentReadNum = (ArrayList<String>)session.getAttribute("noticeBoardIdx"); 
		if(ContentReadNum == null) ContentReadNum = new ArrayList<String>();
		String imsiContentReadNum = "board" + idx;
		
		if(!ContentReadNum.contains(imsiContentReadNum)) {
			noticeService.setReadNumPlus(idx);
			ContentReadNum.add(imsiContentReadNum);
		}
		session.setAttribute("noticeBoardIdx", ContentReadNum);
		model.addAttribute("vo", vo);
		
		PagVO pageVo = pageProcess.getTotRecCnt(pag, pageSize, "noticeBoard", "", "");
		model.addAttribute("pageVo", pageVo);
		
		return "notice/noticeContent"; 
	}
	
	@RequestMapping(value = "/notice/noticeInput" , method = RequestMethod.GET)
	public String noticeInputGet(Model model,
			@RequestParam(name="pag", defaultValue = "1", required = false) int pag,
			@RequestParam(name="pageSize", defaultValue = "10", required = false) int pageSize
			) { 
		return "notice/noticeInput"; 
	}
	
	@RequestMapping(value = "/notice/noticeInput" , method = RequestMethod.POST)
	public String noticeInputPost(NoticeVO vo,
			@RequestParam(name="pag", defaultValue = "1", required = false) int pag,
			@RequestParam(name="pageSize", defaultValue = "10", required = false) int pageSize
			) { 
		int res = noticeService.setNoticeInput(vo);
		
		if(res != 0) return "redirect:/message/noticeInputOk?pag="+pag+"&pageSize="+pageSize; 
		else return "redirect:/message/noticeInputNo?pag="+pag+"&pageSize="+pageSize; 
	}
	
	@RequestMapping(value = "/notice/noticeUpdate" , method = RequestMethod.GET)
	public String noticeContentUpdateGet(Model model, int idx,
			@RequestParam(name="pag", defaultValue = "1", required = false) int pag,
			@RequestParam(name="pageSize", defaultValue = "10", required = false) int pageSize
			) { 
		NoticeVO vo = noticeService.getNoticeBoardContent(idx);
		
		
		
		model.addAttribute("vo", vo);
		return "notice/noticeUpdate"; 
	}
	
	@RequestMapping(value = "/notice/noticeUpdate" , method = RequestMethod.POST)
	public String noticeContentUpdatePost(NoticeVO vo) { 
		int res = noticeService.setNoticeUpdate(vo);
		
		if(res != 0) return "redirect:/message/noticeUpdateOk"; 
		else return "redirect:/message/noticeUpdateNo"; 
	}
	
	
	
}









