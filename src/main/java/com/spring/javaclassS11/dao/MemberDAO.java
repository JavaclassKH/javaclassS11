package com.spring.javaclassS11.dao;

import org.apache.ibatis.annotations.Param;

import com.spring.javaclassS11.vo.MemberVO;

public interface MemberDAO {

	public MemberVO getMemberIdCheck(@Param("mid") String mid);

	public MemberVO getMemberNickCheck(@Param("nickName") String nickName);

	public int setMemberJoin(@Param("vo") MemberVO vo);

	public void setLastLoginDateUpdate(@Param("now") String now,@Param("mid") String mid);

	public String getDateBigyo(@Param("mid") String mid);

	public void setVisitCntPlus(@Param("mid") String mid);

	public void setBlockDateOver(@Param("mid") String mid);

	public String memberMidFind(@Param("nickName") String nickName,@Param("email") String email);

	public MemberVO getMemberExitsCheckForPwdReset(@Param("vo") MemberVO vo);

	public int setPwdReset(@Param("mid") String mid,@Param("encPwd") String encPwd);

}
