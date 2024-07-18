package com.spring.javaclassS11.controller;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;

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

	// 로그인 화면으로 이동 
	/*
		check값이 true일 시에는 아이디찾기를 진행한 뒤 로그인 창으로 온 것이므로
		찾은 mid값을 아이디 입력창에 넣어준다
	*/
	@RequestMapping(value = "/member/memberLogin" , method = RequestMethod.GET)
	public String memberLoginGet(@RequestParam(name="mid", defaultValue = "", required = false) String mid, 
		@RequestParam(name="check", defaultValue = "false", required = false) String check, Model model) { 
		
		if(!check.equals("true")) return "member/memberLogin"; 
		
		else {
			model.addAttribute("mid", mid);
			model.addAttribute("check", check);
			return "member/memberLogin";
		}
	}
	
	@RequestMapping(value = "/member/myPage" , method = RequestMethod.GET)
	public String myPageGet(Model model, HttpServletRequest request) { 
		HttpSession session = request.getSession();
		String mid = (String)session.getAttribute("sMid");
		if(mid == null || mid.equals("")) return "redirect:/message/sessionOff"; 		
		MemberVO vo = memberService.getMemberIdCheck(mid);		
		
		
		model.addAttribute("vo", vo);
		return "member/myPage"; 
	}
	
	@RequestMapping(value = "/member/memberLogin" , method = RequestMethod.POST)
	public String memberLoginPost(String mid, String pwd, HttpServletRequest request) { 
		
		MemberVO vo = memberService.getMemberIdCheck(mid);
		
		if(vo != null && passwordEncoder.matches(pwd, vo.getPwd())) {
			int blockDate_diff = vo.getBlockDate_diff();
			// 휴면회원&제제회원 로그인 방지
			if(vo.getMemLevel() == 1) { return "redirect:/message/memberLoginRestMember"; } // 휴면회원(메일로 재인증)
			
			// 제재진행회원(남은 제재기간 안내)
			if(vo.getMemLevel() == 99 && blockDate_diff > 0) {
				return "redirect:/message/memberLoginBlockMember?blockDate="+blockDate_diff;
			}
			
			// 제재기간 종료회원
			if(blockDate_diff <= 0) {
				if(vo.getMemLevel() == 99 && vo.getBlockCnt() >= 3) {
					return "redirect:/message/memberBlockCntOverThree?mid="+mid;
				}
				else if(vo.getMemLevel() == 99 && vo.getBlockCnt() <= 2) {
					memberService.setBlockDateOver(mid);
				}
			}
			
			
			/*
			else if(vo.getMemLevel() == 99) {	
				
				// 제제기간이 전부 끝난 뒤 제재횟수가 3번 이상인 회원의 자격심사(로그인 방지)
				if(vo.getBlockCnt() >= 3 && blockDate_diff <= 0) {
					System.out.println("제제횟수 3번 이상");
					return "redirect:/message/memberBlockCntOverThree?mid="+mid;
				}
				// 제재종료회원(제재기간 종료&제제횟수 3회 미만)
				else if(blockDate_diff <= 0 && vo.getBlockCnt() < 3) {
					System.out.println("제제횟수 3번 미만");
					memberService.setBlockDateOver(mid);
				}
				// 제재회원(남은 제재기간 안내)
				else {
					System.out.println("제제기간 남음");
					return "redirect:/message/memberLoginBlockMember?blockDate="+blockDate_diff; 
				}
			}
			*/
				
			
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
			
		      
			LocalDateTime now = LocalDateTime.now();        

			String formatedNow = now.format(DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss"));        
			
			memberService.setVisitCntPlus(mid, formatedNow);  // 로그인시 최종접속일 확인하여 방문횟수 증가처리
			memberService.setLastLoginDateUpdate(formatedNow, mid);  // 방문횟수 증가여부 확인, 처리 후 최종접속일 업데이트
			
			
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
	
	@RequestMapping(value = "/member/memberJoinAgreement" , method = RequestMethod.GET)
	public String memberJoinAgreementGet() { return "member/memberJoinAgreement"; }
	
	@RequestMapping(value = "/member/memberJoin" , method = RequestMethod.GET)
	public String memberJoinGet() { return "member/memberJoin"; }
	
	@RequestMapping(value = "/member/memberJoin" , method = RequestMethod.POST)
	public String memberJoinPost(MemberVO vo) { 
		int res = 0;
		
		if(vo.getMemberImage().equals("") || vo.getMemberImage() == null) vo.setMemberImage("eImg.jpg");
		
		vo.setPwd(passwordEncoder.encode(vo.getPwd()));
		String imsiTel = vo.getTel();
		String tel1 = imsiTel.substring(0, 3);
		String tel2 = imsiTel.substring(3, 7);
		String tel3 = imsiTel.substring(7, 11);
		
		String tel = tel1 + "-" + tel2 + "-" + tel3;
		vo.setTel(tel);
		
		// 회원사진저장(서비스 객체에서 처리후 저장)		
		res = memberService.setMemberJoin(vo);
		
		if(res != 0) return "redirect:/message/memberJoinOk"; 
		else return "redirect:/message/memberJoinNo"; 
	}
	
	// 회원가입 시 아이디 체크
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
	
	// 회원가입 시 닉네임 체크
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
	
	// 회원정보 업데이트
	@RequestMapping(value = "/member/memberInfoUpdate" , method = RequestMethod.GET)
	public String memberInfoUpdateGet(Model model, HttpSession session) { 
		String mid = (String)session.getAttribute("sMid");
		
		MemberVO vo = memberService.getMemberIdCheck(mid);
		
		model.addAttribute("vo", vo);
		return "member/memberInfoUpdate"; 
	}
	
	// 아이디 찾기
	@RequestMapping(value = "/member/midFind" , method = RequestMethod.GET)
	public String midFindGet() { return "member/midFind"; }
	
	// 아이디 찾기
	@ResponseBody
	@RequestMapping(value = "/member/midFindCheck" , method = RequestMethod.POST)
	public String midFindCheckPost(String nickName, String email) { 
		String mid = memberService.memberMidFind(nickName, email);
		return mid; 
	}
	
	
	
	
}









