package com.spring.javaclassS11.controller;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.jsoup.Connection;
import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.jsoup.nodes.Element;
import org.jsoup.select.Elements;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.spring.javaclassS11.common.PageProcess;
import com.spring.javaclassS11.service.NoticeService;
import com.spring.javaclassS11.vo.IVEOfficialArticleVO;
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
	
	// 전체공지 수정
	@RequestMapping(value = "/notice/noticeUpdate" , method = RequestMethod.POST)
	public String noticeContentUpdatePost(NoticeVO vo) { 
		int res = noticeService.setNoticeUpdate(vo);
		
		if(res != 0) return "redirect:/message/noticeUpdateOk"; 
		else return "redirect:/message/noticeUpdateNo"; 
	}
	
	// 공식기사 메인
	@RequestMapping(value = "/notice/officialArticle" , method = RequestMethod.GET)
	public String officialArticleGet(Model model) throws IOException { 
		Connection conn = Jsoup.connect("https://entertain.naver.com/home");
		
		Document document = conn.get();
		
		Elements selects = null;
		
		//div.home_airs_grid_airs_top 
		List<String> titleVos = new ArrayList<String>();
		selects = document.select("div.lst_item._page_no_1 div.title_area a.title");
		for(Element select : selects) {
			System.out.println("제목: " + select.html() + "\n");
			titleVos.add(select.html());
		}
		
		List<String> imageVos = new ArrayList<String>();
		selects = document.select("div.lst_item._page_no_1 a.thumb_area");
		for(Element select : selects) {
			System.out.println("이미지: " + select.html() + "\n");
			imageVos.add(select.html());
		}
		
		List<String> contentVos = new ArrayList<String>();
		selects = document.select("div.lst_item._page_no_1 a.summary");
		for(Element select : selects) {
			System.out.println("내용: " + select.html() + "\n");
			imageVos.add(select.html());
		}
		
		List<IVEOfficialArticleVO> vos = new ArrayList<IVEOfficialArticleVO>();
		
		IVEOfficialArticleVO vo = null;
		for(int i=0; i<contentVos.size() - 1; i++) {
			vo = new IVEOfficialArticleVO();
			vo.setItem1Title(titleVos.get(i));
			vo.setItem2Image(imageVos.get(i));
			vo.setItem3Content(contentVos.get(i));
			vos.add(vo);
		}
		
		for(IVEOfficialArticleVO vo2 : vos) {
			System.out.println(vo2);
		}
		
		model.addAttribute("vos", vos);
		
		return "notice/officialArticle";
	}
	
	
	
	
	
}









