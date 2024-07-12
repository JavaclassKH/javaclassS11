package com.spring.javaclassS11.dao;

import java.util.ArrayList;

import org.apache.ibatis.annotations.Param;

import com.spring.javaclassS11.vo.MemberVO;

public interface AdminDAO {

	public ArrayList<MemberVO> getAdminList();

	public String getMasterNickName();

	public int getCafeMemberCount();

	public int getCafeVisitCount();

	public ArrayList<MemberVO> getAdminMemberList();

	public ArrayList<MemberVO> getAdminMemberLevelList(@Param("level") int level);

	public int setAdminMemberLevelChange(@Param("idx") int idx, @Param("level") int level);

	public MemberVO getAdminMemberInfo(@Param("idx") int idx);

	public int adminMemberMidNickNameChange(@Param("mid") String mid, @Param("nickName") String nickName, @Param("idx") int idx);

	public ArrayList<MemberVO> getAdminMemberSearchList(@Param("memberSearch") String memberSearch, @Param("flag") String flag);

	public MemberVO getAdminMemberSearch(@Param("memberSearch") String memberSearch,@Param("flag") String flag);

	public int setAdminMemberBlockManagement(@Param("str") String str, @Param("blockEndDate") String blockEndDate, @Param("blockStartDate") String blockStartDate, @Param("idx") int idx);

}
