package com.spring.javaclassS11.service;

import com.spring.javaclassS11.vo.MemberVO;

public interface MemberService {

	public MemberVO getMemberIdCheck(String mid);

	public MemberVO getMemberNickCheck(String nickName);

	public int setMemberJoin(MemberVO vo);

}
