package com.spring.javaclassS11.controller;

import java.io.IOException;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.UUID;

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
import org.springframework.web.multipart.MultipartFile;

import com.spring.javaclassS11.common.JavaclassProvide;
import com.spring.javaclassS11.service.MemberService;
import com.spring.javaclassS11.vo.MemberVO;

@Controller
public class MemberController {
	
	@Autowired 
	MemberService memberService;
	
	@Autowired
	BCryptPasswordEncoder passwordEncoder;
	
	@Autowired
	JavaclassProvide javaclassProvide;

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
	
	// 마이페이지
	@RequestMapping(value = "/member/myPage" , method = RequestMethod.GET)
	public String myPageGet(Model model, HttpServletRequest request) { 
		HttpSession session = request.getSession();
		String mid = (String)session.getAttribute("sMid");
		if(mid == null || mid.equals("")) return "redirect:/message/sessionOff"; 		
		MemberVO vo = memberService.getMemberIdCheck(mid);		
		int totWriteCnt = memberService.getTotCnt("write", mid);
		//int totReplyWriteCnt = memberService.getTotCnt("ReplyWrite", mid);
		model.addAttribute("vo", vo);
		model.addAttribute("totWriteCnt", totWriteCnt);
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
			
			if(!vo.getMemberImage().equals("eImg.jpg")) {
				session.setAttribute("memberImage", vo.getMemberImage());
			}
		      
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
	
	
	// 회원가입 처리
	@RequestMapping(value = "/member/memberJoin" , method = RequestMethod.POST)
	public String memberJoinPost(MemberVO vo, MultipartFile fName) throws IOException { 
		int res = 0;
		System.out.println(vo);
		
		if(fName == null) vo.setMemberImage("eImg.jpg");
		
		vo.setPwd(passwordEncoder.encode(vo.getPwd()));
		String imsiTel = vo.getTel();
		String tel1 = imsiTel.substring(0, 3);
		String tel2 = imsiTel.substring(3, 7);
		String tel3 = imsiTel.substring(7, 11);
		
		String tel = tel1 + "-" + tel2 + "-" + tel3;
		vo.setTel(tel);
		
		String uid = UUID.randomUUID().toString().substring(0,8);
		String oFileName = fName.getOriginalFilename();
		String sFileName = vo.getMid() + "_" + uid + "_" + oFileName;
		vo.setMemberImage(sFileName);
		javaclassProvide.writeFile(fName, sFileName, "member");
		
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
	
	// 회원정보 업데이트 실행
	@RequestMapping(value = "/member/memberInfoUpdate" , method = RequestMethod.POST)
	public String memberInfoUpdatePost(Model model, HttpServletRequest request ,HttpSession session, MemberVO vo, MultipartFile fName) throws IOException { 
		String mid = (String)session.getAttribute("sMid");
		System.out.println("회원정보수정 vo : " + vo);
		
		// 사진 수정하지 않음.. 사진은 그대로
		if(fName.getOriginalFilename() == null || fName.getOriginalFilename().equals("")) {
			int res = memberService.setMemberInfoUpdate(vo, mid, 0);
			if(res != 0) return "redirect:/message/memberInfoUpdateOk";
		}
		// 사진이 수정됨
		else {
			
			String fileName = fName.getOriginalFilename();
			String sFileName = javaclassProvide.saveFileName(fileName, mid);
			javaclassProvide.writeFile(fName, sFileName, "member");
			session.removeAttribute("memberImage");
			session.setAttribute("memberImage", sFileName);
			vo.setMemberImage(sFileName);
			int res = memberService.setMemberInfoUpdate(vo, mid, 1);
			if(res != 0) return "redirect:/message/memberInfoUpdateOk"; 
		}
		
		return "redirect:/message/memberInfoUpdateNo"; 
	}
	
	// 아이디 찾기 화면
	@RequestMapping(value = "/member/midFind" , method = RequestMethod.GET)
	public String midFindGet() { return "member/midFind"; }
	
	// 아이디 찾기 실행
	@ResponseBody
	@RequestMapping(value = "/member/midFindCheck" , method = RequestMethod.POST)
	public String midFindCheckPost(String nickName, String email) { 
		String mid = memberService.memberMidFind(nickName, email);
		return mid; 
	}
	
	// 비밀번호 재설정 화면
	@RequestMapping(value = "/member/pwdReset" , method = RequestMethod.GET)
	public String pwdResetGet() { return "member/pwdReset"; }

	
	// 비밀번호 재설정 이전 회원정보 확인
	@ResponseBody
	@RequestMapping(value = "/member/pwdReset" , method = RequestMethod.POST)
	public String pwdResetPost(MemberVO vo, HttpServletRequest request) {
		HttpSession session = request.getSession();
		
		String result = memberService.getMemberExitsCheckForPwdReset(vo, session);		
		if(result == "notFound") return result;
		
		session.setAttribute("midBackUp", vo.getMid());
		
		return result;
	}
	
	// 비밀번호 재설정 인증문자 틀릴 시 세션에 저장했던 인증문자 삭제처리
	@RequestMapping(value = "/member/authNoDelete" , method = RequestMethod.GET)
	public String authNoDeleteGet(HttpSession session) { 
		session.removeAttribute("authNo");
		return "member/pwdReset"; 
	}
	
	// 비밀번호 재설정 실행하고 로그인 창으로 보내기
	@RequestMapping(value = "/member/pwdResetExecute" , method = RequestMethod.GET)
	public String pwdResetExecutePost(String resetPwd, HttpSession session) { 
		
		String encPwd = passwordEncoder.encode(resetPwd);
		String mid = (String) session.getAttribute("midBackUp");
		int res = memberService.setPwdReset(mid, encPwd);
		
		if(res != 0) return "redirect:/message/pwdResetExecuteOk";
		else return "redirect:/message/pwdResetExecuteNo"; 
	}
	
	
	
}









