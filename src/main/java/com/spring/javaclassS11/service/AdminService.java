package com.spring.javaclassS11.service;

import java.util.ArrayList;

import com.spring.javaclassS11.vo.MemberVO;

public interface AdminService {

	public ArrayList<MemberVO> getAdminList();

	public ArrayList<MemberVO> getAdminMemberList();

	public ArrayList<MemberVO> getAdminMemberLevelList(int level);

	public String getMasterNickName();

	public int getCafeMemberCount();

	public int getCafeVisitCount();

	public int setAdminMemberLevelChange(int idx, int level);

	public MemberVO getAdminMemberInfo(int idx);

	public int adminMemberMidNickNameChange(String mid, String nickName, int idx);

	public ArrayList<MemberVO> getAdminMemberSearchList(String memberSearch, String flag);

	public MemberVO getAdminMemberSearch(String memberSearch, String flag);

	public int setAdminMemberBlockManagement(String str, String blockEndDate, String blockStartDate, int idx);



}
