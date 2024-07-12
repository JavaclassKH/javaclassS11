package com.spring.javaclassS11.controller;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
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
import com.spring.javaclassS11.vo.MemberVO;

@Controller
public class AdminController {
	
	@Autowired
	AdminService adminService;
	
	@RequestMapping(value = "/admin/adminLobby" , method = RequestMethod.GET)
	public String adminLobbyGet(Model model, HttpSession session) {
		ArrayList<MemberVO> vos = adminService.getAdminList();
		session.setAttribute("sAdminSession", "on");
		
		model.addAttribute("vos", vos);
		return "admin/adminLobby";
	}
	
	@RequestMapping(value = "/admin/adminMemberList" , method = RequestMethod.GET)
	public String adminMemberListGet(Model model,
			@RequestParam(name = "level", defaultValue = "100", required = false) int level,
			@RequestParam(name = "memberSearch", defaultValue = "0", required = false) String memberSearch,
			@RequestParam(name = "flag", defaultValue = "0", required = false) String flag			
			) {
		
		if(flag.trim().equals("midPart") || flag.trim().equals("nickNamePart")) {
			ArrayList<MemberVO> vos = adminService.getAdminMemberSearchList(memberSearch, flag);			
			
			if(vos == null) return "redirect:/message/adminMemberSearchNo";		
			
			model.addAttribute("vos", vos);
			model.addAttribute("level", level);
			model.addAttribute("flag", flag);
		}
		else if(flag.trim().equals("midAll")|| flag.trim().equals("nickNameAll")) {
			MemberVO vo = adminService.getAdminMemberSearch(memberSearch, flag);			
			if(vo == null) return "redirect:/message/adminMemberSearchNo";
			
			model.addAttribute("vo", vo);
			model.addAttribute("level", level);
			model.addAttribute("flag", flag);
		}
		else if(level != 0 && level != 100) {
			ArrayList<MemberVO> vos = adminService.getAdminMemberLevelList(level);		
			
			model.addAttribute("vos", vos);
			model.addAttribute("level", level);
		}
		else if(level == 100){
			ArrayList<MemberVO> vos = adminService.getAdminMemberList();		
			
			model.addAttribute("vos", vos);
			model.addAttribute("level", level);
		}
		
		return "admin/adminMemberList";
	}
	
	@ResponseBody
	@RequestMapping(value = "/admin/adminMemberLevelChange" , method = RequestMethod.POST)
	public String adminMemberLevelChangePost(int level, String idxArr) {
		int res = 0;
		
		String[] arrayIdx = null;
    
    if (!idxArr.equals("")) {
      arrayIdx = idxArr.split("/");
      for (String idx : arrayIdx) {
        res = adminService.setAdminMemberLevelChange(Integer.parseInt(idx), level);
      }
      return res+"";
    }
    else return res+"";
	}
	
	@RequestMapping(value = "/admin/adminMemberInfoWatch" , method = RequestMethod.GET)
	public String adminMemberInfoWatchGet(Model model, @RequestParam int idx, 
		@RequestParam(name = "flag", defaultValue = "1", required = false) int flag) {
		MemberVO vo = adminService.getAdminMemberInfo(idx);
		
		model.addAttribute("vo", vo);
		model.addAttribute("flag", flag);
		return "admin/adminMemberInfoWatch";
	}
	
	@RequestMapping(value = "/admin/adminMemberMidNickNameChange" , method = RequestMethod.GET)
	public String adminMemberMidNickNameChangeGet(String mid, String nickName, int idx) {
		int res = adminService.adminMemberMidNickNameChange(mid, nickName, idx);
		
		if(res != 0) return "redirect:/message/adminMemberMidNickNameChangeOk";
		else return "redirect:/message/adminMemberMidNickNameChangeNo";
	}
	
	@RequestMapping(value = "/admin/adminMemberBlockManagement" , method = RequestMethod.GET)
	public String adminMemberBlockManagementGet(String str, String blockEndDate, int idx) {
		
		LocalDateTime now = LocalDateTime.now();       
		String formatedNow = now.format(DateTimeFormatter.ofPattern("yyyy-MM-dd"));  
		int res = adminService.setAdminMemberBlockManagement(str, blockEndDate, formatedNow, idx);
		
		if(res != 0) return "redirect:/message/adminMemberBlockManagementOk";
		else return "redirect:/message/adminMemberBlockManagementNo";
	}

	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
}
