package com.spring.javaclassS11.controller;

import java.util.ArrayList;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.spring.javaclassS11.service.AdminService;
import com.spring.javaclassS11.vo.MemberVO;

@Controller
public class AdminController {
	
	@Autowired
	AdminService adminService;
	
	@RequestMapping(value = "/admin/adminLobby" , method = RequestMethod.GET)
	public String adminLobbyGet(Model model) {
		ArrayList<MemberVO> vos = adminService.getAdminList();
		
		model.addAttribute("vos", vos);
		return "admin/adminLobby";
	}
	

	

	
}
