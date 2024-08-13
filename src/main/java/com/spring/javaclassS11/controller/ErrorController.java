package com.spring.javaclassS11.controller;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.spring.javaclassS11.vo.FreeBoardVO;

@Controller
@RequestMapping("/errorPage")
public class ErrorController {
	
	// 404 Page Not Found 
	@RequestMapping(value = "/error404", method = RequestMethod.GET)
	public String error404Get() {
		return "errorPage/error404";
	}
	
	// 405 Method Not Allowed
	@RequestMapping(value = "/error405", method = RequestMethod.GET)
	public String error405Get() {
		return "errorPage/error405";
	}
	
	// 500 Internal Server Error
	@RequestMapping(value = "/error500", method = RequestMethod.GET)
	public String error500Get() {
		return "errorPage/error500";
	}
	

	
	
	
}
























