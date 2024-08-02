package com.spring.javaclassS11.service;

import javax.servlet.http.HttpSession;

import com.spring.javaclassS11.vo.MemberVO;

public interface MemberService {

	public MemberVO getMemberIdCheck(String mid);

	public MemberVO getMemberNickCheck(String nickName);

	public int setMemberJoin(MemberVO vo);

	public void setLastLoginDateUpdate(String now, String mid);

	public void setVisitCntPlus(String mid, String formatedNow);

	public void setBlockDateOver(String mid);

	public String memberMidFind(String nickName, String email);

	public String getMemberExitsCheckForPwdReset(MemberVO vo, HttpSession session);

	public int setPwdReset(String mid, String encPwd);

	public int setMemberInfoUpdate(MemberVO vo, String mid, int sw);

	public int getTotCnt(String what, String mid);


}
