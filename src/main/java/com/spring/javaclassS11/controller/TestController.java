package com.spring.javaclassS11.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller
public class TestController {

	// 타이머 테스트
	@RequestMapping(value = "/test/timerTest" , method = RequestMethod.GET)
	public String timerTestGet() { return "test/timerTest";	}
	
	// 원영적사고 페이지 iframe 테스트
	@RequestMapping(value = "/test/luckyvicky" , method = RequestMethod.GET)
	public String luckyvickyGet() { return "test/luckyvicky"; }

	@RequestMapping(value = "/message/{mid}/{pwd}", method = RequestMethod.GET)
	public String getMessage(@PathVariable String mid, @PathVariable String pwd) {
		return mid + " " + pwd;   
	}
	
	
}
