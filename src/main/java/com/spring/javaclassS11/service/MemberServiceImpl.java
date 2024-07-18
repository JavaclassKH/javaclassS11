package com.spring.javaclassS11.service;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.spring.javaclassS11.dao.MemberDAO;
import com.spring.javaclassS11.vo.MemberVO;

@Service
public class MemberServiceImpl implements MemberService {

	@Autowired
	MemberDAO memberDAO;

	// 회원가입시 아이디 중복체크
	@Override public MemberVO getMemberIdCheck(String mid) { return memberDAO.getMemberIdCheck(mid); }
	
	// 회원가입시 닉네임 중복체크
	@Override public MemberVO getMemberNickCheck(String nickName) { return memberDAO.getMemberNickCheck(nickName); }
	
	// 회원가입
	@Override public int setMemberJoin(MemberVO vo) { return memberDAO.setMemberJoin(vo);	}

	// 로그인 시 마지막 방문일 업데이트
	@Override	public void setLastLoginDateUpdate(String now, String mid) { memberDAO.setLastLoginDateUpdate(now, mid); }

	// 방문카운트 올리기 (1일 1회)
	@Override
	public void setVisitCntPlus(String mid, String formatedNow) {
		String date = memberDAO.getDateBigyo(mid);
		date = date.substring(0,10);
		formatedNow = formatedNow.substring(0,10);
		
		if(!formatedNow.equals(date)) {
			memberDAO.setVisitCntPlus(mid);
		}
		
		else return;
	}

	// 
	@Override	public void setBlockDateOver(String mid) { memberDAO.setBlockDateOver(mid); }

	// 닉네임, 이메일로 아이디 찾기
	@Override public String memberMidFind(String nickName, String email) { 
	
		String mid = memberDAO.memberMidFind(nickName, email); 
		if(mid == null) {
			mid = "notFoundMid";
			return mid;		
		}
		String mid_1 = mid.substring(0,3);
		String mid_2 = mid.substring(3,mid.length());
		String yourMid = mid_1 + mid_2.replaceAll(".", "★");
		mid = mid + "/" +yourMid;
		
		return mid;
	}

	
	
	
	
	
}
