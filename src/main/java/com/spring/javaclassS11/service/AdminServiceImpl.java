package com.spring.javaclassS11.service;

import java.util.ArrayList;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.spring.javaclassS11.dao.AdminDAO;
import com.spring.javaclassS11.vo.MemberVO;

@Service
public class AdminServiceImpl implements AdminService {

	@Autowired
	AdminDAO adminDAO;
	/** leftSide에 사용할 카페정보 잠시 adminService 빌려서 처리함 */
	@Override	public String getMasterNickName() { return adminDAO.getMasterNickName(); } 
	
	@Override	public int getCafeMemberCount() { return adminDAO.getCafeMemberCount();	}

	@Override	public int getCafeVisitCount() { return adminDAO.getCafeVisitCount(); }

	/** 진짜 Admin에서 사용 */
	// 관리자목록 가져오기
	@Override public ArrayList<MemberVO> getAdminList() { return adminDAO.getAdminList(); }

	// 전체회원목록 가져오기
	@Override	public ArrayList<MemberVO> getAdminMemberList() {	return adminDAO.getAdminMemberList(); }

	// 전체회원목록 중 선택등급 회원만 조회
	@Override public ArrayList<MemberVO> getAdminMemberLevelList(int level) {	return adminDAO.getAdminMemberLevelList(level); }

	// 선택회원 회원등급 지정한 등급으로 일괄변경
	@Override	public int setAdminMemberLevelChange(int idx, int level) { return adminDAO.setAdminMemberLevelChange(idx,level); }

	// 선택한 회원 정보 상세보기
	@Override public MemberVO getAdminMemberInfo(int idx) { return adminDAO.getAdminMemberInfo(idx); }

	// 회원 아이디/닉네임 강제변경
	@Override	public int adminMemberMidNickNameChange(String mid, String nickName, int idx) { return adminDAO.adminMemberMidNickNameChange(mid, nickName, idx); }

	// 회원 아이디/닉네임 검색(부분)
	@Override	public ArrayList<MemberVO> getAdminMemberSearchList(String memberSearch, String flag) { return adminDAO.getAdminMemberSearchList(memberSearch, flag);	}
	
	// 회원 아이디/닉네임 검색(전체)
	@Override	public MemberVO getAdminMemberSearch(String memberSearch, String flag) { return adminDAO.getAdminMemberSearch(memberSearch, flag); }

	// 회원 제재시스템 관리(부여,수정,삭제)
	@Override	public int setAdminMemberBlockManagement(String str, String blockEndDate, String blockStartDate, int idx) {	return adminDAO.setAdminMemberBlockManagement(str, blockEndDate, blockStartDate, idx); }




	
}
