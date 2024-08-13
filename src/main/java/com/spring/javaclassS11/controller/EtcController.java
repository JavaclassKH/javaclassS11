package com.spring.javaclassS11.controller;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import org.jsoup.Connection;
import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.jsoup.nodes.Element;
import org.jsoup.select.Elements;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.spring.javaclassS11.vo.IVEOfficialArticleVO;

@Controller
public class EtcController {

	//공식기사 메인
	@RequestMapping(value = "/etc/newArticle" , method = RequestMethod.GET)
	public String officialArticleGet(Model model) throws IOException { 
		Connection conn = Jsoup.connect("https://entertain.naver.com/home");
		
		Document document = conn.get();
		
		Elements selects = null;
		
		List<String> titleVos = new ArrayList<String>();
		selects = document.select("div.lst_item._page_no_1 div.title_area");
		for(Element select : selects) {
			titleVos.add(select.html());
		}
		
		List<String> imageVos = new ArrayList<String>();
		selects = document.select("div.lst_item._page_no_1 a.thumb_area ");
		for(Element select : selects) {
			imageVos.add(select.html());
		}
		
		List<String> contentVos = new ArrayList<String>();
		selects = document.select("div.lst_item._page_no_1 a.summary");
		for(Element select : selects) {
			contentVos.add(select.html());
		}
		
		List<IVEOfficialArticleVO> vos = new ArrayList<IVEOfficialArticleVO>();
		
		IVEOfficialArticleVO vo = null;
		for(int i=0; i<contentVos.size() - 1; i++) {
			vo = new IVEOfficialArticleVO();
			vo.setItem1Title(titleVos.get(i).substring(titleVos.get(i).indexOf("<a href="), titleVos.get(i).indexOf("</a>")));
			String i1 = vo.getItem1Title();
			i1 = i1.replace(";\"", ";\" target=\"_blank\"");
			vo.setItem1Title(i1);
			vo.setItem2Image(imageVos.get(i).replace("data-src", "src"));
			vo.setItem3Content(contentVos.get(i));
			
			vos.add(vo);
		}
		
		
		
		model.addAttribute("vos", vos);
		return "etc/newArticle";
	}
	
	
	
}
