package com.spring.javaclassS11.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.spring.javaclassS11.service.AdminService;

@Controller
public class LobbyController {
	
	@Autowired
	AdminService adminService;

	@RequestMapping(value = "/" , method = RequestMethod.GET)
	public String LobbyGet(Model model, HttpServletRequest request) {
		
		HttpSession session = request.getSession();
		String master = adminService.getMasterNickName();
		int cafeMemberCount = adminService.getCafeMemberCount();
		int cafeVisitCount = adminService.getCafeVisitCount();
			
		
			
		session.setAttribute("sMaster", master);
		session.setAttribute("sCafeMemberCount", cafeMemberCount);
		session.setAttribute("sCafeVisitCount", cafeVisitCount);		
		
		return "lobby";
	}
	
	@ResponseBody
	@RequestMapping(value = "/cursorMode" , method = RequestMethod.GET) 
	public void cursorModeGet(Model model, HttpServletRequest request, 
		@RequestParam(name = "c", defaultValue = "0", required = false) int c,
		@RequestParam(name = "nowPath", defaultValue = "/", required = false) String nowPath) {		
		
		HttpSession session = request.getSession();
		session.removeAttribute("c");
		session.setAttribute("c", c);
	}
	

	
}












