package com.spring.javaclassS11.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.spring.javaclassS11.service.MemberService;
import com.spring.javaclassS11.vo.MemberVO;

@Controller
public class MemberController {
	
	@Autowired 
	MemberService memberService;
	
	@Autowired
	BCryptPasswordEncoder passwordEncoder;

	@RequestMapping(value = "/member/memberLogin" , method = RequestMethod.GET)
	public String memberLoginGet() { return "member/memberLogin"; }
	
	@RequestMapping(value = "/member/myPage" , method = RequestMethod.GET)
	public String myPageGet(Model model, HttpServletRequest request) { 
		HttpSession session = request.getSession();
		String mid = (String)session.getAttribute("sMid");
		if(mid == null || mid.equals("")) return "redirect:/message/sessionOff"; 		
		MemberVO vo = memberService.getMemberIdCheck(mid);		
		
		String joinDate = vo.getJoinDate();
		String showJoinDate = "";
		
		model.addAttribute("vo", vo);
		return "member/myPage"; 
	}
	
	@RequestMapping(value = "/member/memberLogin" , method = RequestMethod.POST)
	public String memberLoginPost(String mid, String pwd, HttpServletRequest request) { 
		
		MemberVO vo = memberService.getMemberIdCheck(mid);
		if(vo != null && passwordEncoder.matches(pwd, vo.getPwd())) {
			// 휴면회원&제제회원 로그인 방지
			if(vo.getMemLevel() == 1) { return "redirect:/message/memberLoginRestMember"; }
			else if(vo.getMemLevel() == 99) {	
				int blockDate = vo.getBlockDate();
				return "redirect:/message/memberLoginBlockMember?blockDate="+blockDate; 
			}
			
			// 로그인 성공 시 세션처리 
			HttpSession session = request.getSession();
			String strLevel = "";
			if(vo.getMemLevel() == 1) strLevel = "휴면회원";
			else if(vo.getMemLevel() == 2) strLevel = "준회원";
			else if(vo.getMemLevel() == 3) strLevel = "정회원";
			else if(vo.getMemLevel() == 4) strLevel = "우수회원";
			else if(vo.getMemLevel() == 5) strLevel = "아이브 멤버";
			else if(vo.getMemLevel() == 99) strLevel = "제제회원";
			else if(vo.getMemLevel() == 111) strLevel = "운영자";
			else if(vo.getMemLevel() == 112) strLevel = "관리자";
			else if(vo.getMemLevel() == 113) strLevel = "전체관리자";
			else if(vo.getMemLevel() == 114) strLevel = "대표운영자";
			
			
			session.setAttribute("sMid", vo.getMid());
			session.setAttribute("sNickName", vo.getNickName());
			session.setAttribute("sLevel", vo.getMemLevel());
			session.setAttribute("strLevel", strLevel);
			if(!vo.getPart().equals("emp")) session.setAttribute("sPart", vo.getPart());
			
			return "redirect:/message/memberLoginOk?mid="+mid; 
		}
		else return "redirect:/message/memberLoginNo"; 
	}
	
	@RequestMapping(value = "/member/memberLogout" , method = RequestMethod.GET)
	public String memberLogoutGet(@RequestParam String mid, HttpServletRequest request) { 
		HttpSession session = request.getSession();
		session.invalidate();
		return "redirect:/message/memberLogoutOk?mid="+mid; 
	}
	
	@RequestMapping(value = "/member/memberJoin" , method = RequestMethod.GET)
	public String memberJoinGet() { return "member/memberJoin"; }
	
	@ResponseBody
	@RequestMapping(value = "/member/memberIdCheck" , method = RequestMethod.POST)
	public String memberIdCheckPost(String mid) {
		int res = 0;		
		MemberVO vo = memberService.getMemberIdCheck(mid);
		if(vo != null) {
			if(vo.getMid().equals(mid)) {
				res = 1;
				return res+"";
			}
		}
		return res+"";	
	}	
	
	@ResponseBody
	@RequestMapping(value = "/member/memberNickCheck" , method = RequestMethod.POST)
	public String memberNickCheckPost(String nickName) {
		int res = 0;		
		MemberVO vo = memberService.getMemberNickCheck(nickName);
		if(vo != null) {
			if(vo.getNickName().equals(nickName)) {
				res = 1;
				return res+"";
			}
		}
		return res+"";	
	}	
	
	@RequestMapping(value = "/member/memberJoin" , method = RequestMethod.POST)
	public String memberJoinPost(MemberVO vo) { 
		int res = 0;
		
		if(vo.getMemberImage().equals("") || vo.getMemberImage() == null) vo.setMemberImage("eImg.jpg");
		
		vo.setPwd(passwordEncoder.encode(vo.getPwd()));
		System.out.println("tel : " + vo.getTel());
		// 회원사진저장(서비스 객체에서 처리후 저장)		
		res = memberService.setMemberJoin(vo);
		
		if(res != 0) return "redirect:/message/memberJoinOk"; 
		else return "redirect:/message/memberJoinNo"; 
	}
	
	
	
	
}









