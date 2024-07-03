package com.spring.javaclassS11.dao;

import org.apache.ibatis.annotations.Param;

import com.spring.javaclassS11.vo.MemberVO;

public interface MemberDAO {

	public MemberVO getMemberIdCheck(@Param("mid") String mid);

	public MemberVO getMemberNickCheck(@Param("nickName") String nickName);

	public int setMemberJoin(@Param("vo") MemberVO vo);

}
