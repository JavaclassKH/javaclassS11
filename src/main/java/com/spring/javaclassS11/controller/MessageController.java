package com.spring.javaclassS11.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
public class MessageController {

	@RequestMapping(value = "/message/{msgFlag}", method = RequestMethod.GET)
	public String getMessage(Model model, HttpServletRequest request,
			@PathVariable String msgFlag,
			@RequestParam(name="mid", defaultValue = "", required = false) String mid,
			@RequestParam(name="idx", defaultValue = "0", required = false) int idx,
			@RequestParam(name="pag", defaultValue = "1", required = false) int pag,
			@RequestParam(name="pageSize", defaultValue = "5", required = false) int pageSize,
			@RequestParam(name="blockDate", defaultValue = "30", required = false) int blockDate 
			) {
		
		HttpSession session = request.getSession();
		
		if(msgFlag.equals("sessionOff")) {
			session.invalidate();
			model.addAttribute("msg", "비정상적인 접근으로 로그인 세션이 중지되었습니다\\n다시 로그인 후 이용해주시길 바랍니다");
			model.addAttribute("url", "member/memberLogin");
		}		
		else if(msgFlag.equals("memberJoinOk")) {
			model.addAttribute("msg", "Second DIVE에 가입하신 것을 환영합니다!\\n로그인 후 즐거운 팬활동을 즐겨주시기 바랍니다");
			model.addAttribute("url", "member/memberLogin");
		}		
		else if(msgFlag.equals("memberJoinNo")) {
			model.addAttribute("msg", "회원가입에 실패하였습니다\\n다시 가입을 시도해주세요");
			model.addAttribute("url", "member/memberJoin");
		}
		else if(msgFlag.equals("memberLoginOk")) {
			model.addAttribute("msg", mid + "님 로그인되었습니다");
			model.addAttribute("url", "");
		}
		else if(msgFlag.equals("memberLoginNo")) {
			model.addAttribute("msg", "로그인에 실패하였습니다");
			model.addAttribute("url", "member/memberLogin");
		}
		else if(msgFlag.equals("memberLoginRestMember")) {
			model.addAttribute("msg", "현재 해당 계정은 휴면상태입니다\\n가입시 작성하신 이메일로 인증코드를 발송하였으니\\n코드를 통해 휴면상태를 해지하실 수 있습니다");
			model.addAttribute("url", "member/memberLogin");
		}
		else if(msgFlag.equals("memberLoginBlockMember")) {
			model.addAttribute("msg", "현재 해당 계정은 제재상태입니다\\n"+blockDate+"일 후 로그인이 가능합니다");
			model.addAttribute("url", "");
		}
		else if(msgFlag.equals("memberLogoutOk")) {
			model.addAttribute("msg", mid + "님 로그아웃 되었습니다");
			model.addAttribute("url", "");
		}
		else if(msgFlag.equals("noticeInputOk")) {
			model.addAttribute("msg", "전체공지가 등록되었습니다");
			model.addAttribute("url", "notice/noticeBoard");
		}
		else if(msgFlag.equals("noticeInputNo")) {
			model.addAttribute("msg", "전체공지 등록에 실패했습니다");
			model.addAttribute("url", "notice/noticeInput");
		}
		else if(msgFlag.equals("noticeUpdateOk")) {
			model.addAttribute("msg", "전체공지가 수정되었습니다");
			model.addAttribute("url", "notice/noticeBoard");
		}
		else if(msgFlag.equals("noticeUpdateNo")) {
			model.addAttribute("msg", "전체공지 수정에 실패했습니다");
			model.addAttribute("url", "notice/noticeBoard");
		}
		
		
		
		return "include/message";
	}
	
}
