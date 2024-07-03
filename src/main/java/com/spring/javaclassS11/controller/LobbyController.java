package com.spring.javaclassS11.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
public class LobbyController {
	
	
	@RequestMapping(value = "/" , method = RequestMethod.GET)
	public String LobbyGet(Model model) {
		
		model.addAttribute("c", 0);
		return "lobby";
	}
	
	
	@RequestMapping(value = "/cursorMode" , method = RequestMethod.GET) public
	String cursorModeGet(Model model, @RequestParam(name = "c", defaultValue = "0", required = false) int c) {		
		model.addAttribute("c", c);
		return "lobby"; 
	}
	

	
}
