package com.spring.javaclassS11.controller;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;

import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
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
import com.spring.javaclassS11.vo.BlockReasonDataVO;
import com.spring.javaclassS11.vo.MemberVO;
import com.spring.javaclassS11.vo.RandomSongRecommandVO;

@Controller
public class AdminController {
	
	@Autowired
	AdminService adminService;
	
	@Autowired
	MemberService memberService;
	
	// 관리자모드 메인화면(관리자 로비/관리자목록 보여주기)
	@RequestMapping(value = "/admin/adminLobby" , method = RequestMethod.GET)
	public String adminLobbyGet(Model model) {
		ArrayList<MemberVO> vos = adminService.getAdminList();
		
		model.addAttribute("vos", vos);
		return "admin/adminLobby";
	}
	
	// 조회를 원하는 목록별 회원정보 가져오기
	@RequestMapping(value = "/admin/adminMemberList" , method = RequestMethod.GET)
	public String adminMemberListGet(Model model,
			@RequestParam(name = "level", defaultValue = "100", required = false) int level,
			@RequestParam(name = "memberSearch", defaultValue = "0", required = false) String memberSearch,
			@RequestParam(name = "flag", defaultValue = "0", required = false) String flag			
			) {
		
		if(flag.trim().equals("midPart") || flag.trim().equals("nickNamePart")) {
			memberSearch = memberSearch.trim();
			memberSearch = memberSearch.replace(" ", "");
			ArrayList<MemberVO> vos = adminService.getAdminMemberSearchList(memberSearch, flag);			
			
			if(vos == null) return "redirect:/message/adminMemberSearchNo";		
			
			model.addAttribute("vos", vos);
			model.addAttribute("level", level);
			model.addAttribute("flag", flag);
		}
		else if(flag.trim().equals("midAll")|| flag.trim().equals("nickNameAll")) {
			memberSearch = memberSearch.trim();
			memberSearch = memberSearch.replace(" ", "");
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
	
	// 회원등급 조정
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
	
	// 선택회원 상세정보 보기
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
	
	// 회원 재제관리
	@RequestMapping(value = "/admin/adminMemberBlockManagement" , method = RequestMethod.GET)
	public String adminMemberBlockManagementGet(BlockReasonDataVO vo, String str, HttpServletRequest request) {
		
		LocalDateTime now = LocalDateTime.now();       
		String formatedNow = now.format(DateTimeFormatter.ofPattern("yyyy-MM-dd"));  
		vo.setBlockStartDate(formatedNow);
		
		MemberVO memVo = adminService.getMemberInfoByIdx(vo.getIdx());
		vo.setMid(memVo.getMid());
		vo.setNickName(memVo.getNickName());
		
		int res = adminService.setAdminMemberBlockManagement(vo, str);
		
		HttpSession session = request.getSession();
		
		if(!str.equals("d")) {
			String nickName = (String) session.getAttribute("sNickName");
			vo.setBlockGiver(nickName);
			adminService.setBlockReasonData(vo);			
		}
		
		
		if(res != 0) return "redirect:/message/adminMemberBlockManagementOk";
		else return "redirect:/message/adminMemberBlockManagementNo";
	}

	// 랜덤노래추천 관리화면
	@RequestMapping(value = "/admin/adminRandomSongRecommand" , method = RequestMethod.GET)
	public String adminRandomSongRecommandGet(Model model, HttpServletRequest request) {
		HttpSession session = request.getSession();
		int sRandomsongRecommandSw = 0;
		
		ArrayList<RandomSongRecommandVO> vos = adminService.getSongList();
		model.addAttribute("vos", vos);
		session.setAttribute("sRandomsongRecommandSw", sRandomsongRecommandSw);
		return "admin/adminRandomSongRecommand"; 
	}
	
	// 랜덤노래추천 추가
	@ResponseBody
	@RequestMapping(value = "/admin/adminRandomSongRecommand" , method = RequestMethod.POST)
	public String adminRandomSongRecommandPost(RandomSongRecommandVO vo) {	
		int res = adminService.setRandomSongRecommandInput(vo);
		return res + ""; 
	}
	
	// 회원 제재내역 관리
	@RequestMapping(value = "/admin/blockManagement" , method = RequestMethod.GET)
	public String blockManagementGet(Model model) {
		ArrayList<BlockReasonDataVO> vos = adminService.getBlockReasonDataList();
		
		model.addAttribute("vos", vos);
		return "admin/blockManagement";
	}
	
	// 관리자 권한관리 화면
	@RequestMapping(value = "/admin/adminAuthorityManage" , method = RequestMethod.GET)
	public String authorityManageGet(Model model, int idx, HttpSession session) {

		MemberVO vo = adminService.getAdministerInfo(idx);
		int memLevel = (int) session.getAttribute("sLevel");
		
		model.addAttribute("vo", vo);
		model.addAttribute("memLevel", memLevel);
		return "admin/adminAuthorityManage";
	}
	
	// 관리자 권한관리 기능
	@ResponseBody
	@RequestMapping(value = "/admin/adminAuthorityManage" , method = RequestMethod.POST)
	public String authorityManagePost(int idx, int memLevel, String part, 
		@RequestParam(name="check", defaultValue = "0", required = false)	int check) {
		int sw = 0, result = 0;
		String res = "";
		
		System.out.println(idx);
		System.out.println(memLevel);
		System.out.println(part);
		System.out.println(check);
		
		// 회원에게 권한 부여하기
		if(check == 111) {
			int res2 = adminService.setMemberGiveAdmin(idx, memLevel, part); 
			return res2 + "" + idx;
		}
		
		// 운영자,관리자 권한 수정하기
		sw = adminService.getAdminExistCheck(memLevel, part);
		if(sw == 111) return 111 + "";
		else if(sw == 112) return 112 + "";
		else if(sw == 999) res = "empty";
		
		
		if(res.equals("empty")) {
			result = adminService.setAdministerAuthorityChenge(idx, memLevel, part);
		}
		
		return result + "";
	}
	
	// 관리자 권한제거
	@ResponseBody
	@RequestMapping(value = "/admin/authorityDelete" , method = RequestMethod.POST)
	public String authorityDeletePost(int idx) {
		int res = adminService.setAuthorityDelete(idx);
		return res + "";
	}
	
	// 랜덤노래추천 곡 삭제
	@RequestMapping(value = "/admin/adminRandomSongRecommandDelete" , method = RequestMethod.GET)
	public String randomSongRecommandDeletePost(int idx, String songName) {
		int res = adminService.setRandomSongRecommandDelete(idx);
		
		if(res != 0) return "redirect:/message/randomSongRecommandDeleteOk?songName="+songName;
		else return "redirect:/message/randomSongRecommandDeleteNo?songName="+songName;
	}
	
	// 랜덤노래추천 곡 수정화면
	@RequestMapping(value = "/admin/adminRandomSongRecommandUpdate" , method = RequestMethod.GET)
	public String randomSongRecommandUpdateGet(Model model, int idx) {
		RandomSongRecommandVO vo = adminService.getRecommandSongList(idx);
		model.addAttribute("vo", vo);
		model.addAttribute("idx", idx);
		return "admin/adminRandomSongRecommandUpdate";
	}
	
	// 랜덤노래추천 곡 수정 실행
	@ResponseBody
	@RequestMapping(value = "/admin/adminRandomSongRecommandUpdate" , method = RequestMethod.POST)
	public String randomSongRecommandUpdatePost(RandomSongRecommandVO vo) {
		int res = adminService.setRecommandSongUpdate(vo);
		return res + "";
	}
	
	
	public ResponseEntity<Map<String, String>> ExceptionHandler(Exception e) {
		System.out.println("e : " + e.getMessage());

		HttpHeaders responseHeaders = new HttpHeaders();
		HttpStatus httpStatus = HttpStatus.BAD_REQUEST;
		
		Map<String, String> map = new HashMap<String, String>();
		map.put("error type", httpStatus.getReasonPhrase());
		map.put("code", "400");
		map.put("message", "에러 발생");		
		
		return new ResponseEntity<Map<String,String>>(map, responseHeaders, httpStatus);
	}
	
	
	
	
	
	
	
	
	
	
	
	
}
