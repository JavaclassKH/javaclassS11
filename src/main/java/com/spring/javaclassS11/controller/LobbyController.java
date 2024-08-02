package com.spring.javaclassS11.controller;

import java.util.ArrayList;

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
import com.spring.javaclassS11.service.MemberService;
import com.spring.javaclassS11.service.PlayService;
import com.spring.javaclassS11.vo.LobbyPostVO;
import com.spring.javaclassS11.vo.MemberVO;

@Controller
public class LobbyController {
	
	// LobbyController는 작업 수가 적으므로 adminService를 빌려서 사용
	@Autowired
	AdminService adminService;
	
	@Autowired
	MemberService memberService;
	
	@Autowired
	PlayService playService;

	@RequestMapping(value = "/" , method = RequestMethod.GET)
	public String LobbyGet(Model model, HttpServletRequest request) {
		
		HttpSession session = request.getSession();
		String master = adminService.getMasterNickName();
		int cafeMemberCount = adminService.getCafeMemberCount();
		int cafeVisitCount = adminService.getCafeVisitCount();
		
		session.setAttribute("sMaster", master);
		session.setAttribute("sCafeMemberCount", cafeMemberCount);
		session.setAttribute("sCafeVisitCount", cafeVisitCount);		
		
		ArrayList<LobbyPostVO> vos = adminService.getLobbyPost();
		model.addAttribute("vos", vos);
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
	
	// 로비전용 포스트 작성
	@ResponseBody
	@RequestMapping(value = "/lobbyPostInsert" , method = RequestMethod.POST) 
	public String curssdorModeGet(String mid, String post) {	
		MemberVO vo = memberService.getMemberIdCheck(mid);
		int res = adminService.setLobbyPostInsert(vo.getNickName(), post);
		return res + "";
	}
	

	
}












