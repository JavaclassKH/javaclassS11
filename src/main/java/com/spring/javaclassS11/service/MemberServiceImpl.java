package com.spring.javaclassS11.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.spring.javaclassS11.dao.MemberDAO;
import com.spring.javaclassS11.vo.MemberVO;

@Service
public class MemberServiceImpl implements MemberService {

	@Autowired
	MemberDAO memberDAO;

	@Override public MemberVO getMemberIdCheck(String mid) { return memberDAO.getMemberIdCheck(mid); }
	
	@Override public MemberVO getMemberNickCheck(String nickName) { return memberDAO.getMemberNickCheck(nickName); }
	
	@Override public int setMemberJoin(MemberVO vo) { return memberDAO.setMemberJoin(vo);	}
	
}
