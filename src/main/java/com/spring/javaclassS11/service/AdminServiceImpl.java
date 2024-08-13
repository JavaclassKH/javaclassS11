package com.spring.javaclassS11.service;

import java.util.ArrayList;
import java.util.UUID;

import org.apache.commons.lang3.RandomStringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.spring.javaclassS11.dao.AdminDAO;
import com.spring.javaclassS11.vo.BlockReasonDataVO;
import com.spring.javaclassS11.vo.LobbyPostVO;
import com.spring.javaclassS11.vo.MemberVO;
import com.spring.javaclassS11.vo.RandomSongRecommandVO;

@Service
public class AdminServiceImpl implements AdminService {

	@Autowired
	AdminDAO adminDAO;

	/** leftSide에 사용할 카페 정보를 잠시 adminService을 빌려서 처리함 */
	@Override	public String getMasterNickName() { return adminDAO.getMasterNickName(); } 
	@Override	public int getCafeMemberCount() { return adminDAO.getCafeMemberCount();	}
	@Override	public int getCafeVisitCount() { return adminDAO.getCafeVisitCount(); }
	@Override public ArrayList<LobbyPostVO> getLobbyPost() { return adminDAO.getLobbyPost(); }
	@Override public int setLobbyPostInsert(String nickName, String post) { return adminDAO.setLobbyPostInsert(nickName, post); }

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
	@Override	public int setAdminMemberBlockManagement(BlockReasonDataVO vo, String str) { return adminDAO.setAdminMemberBlockManagement(vo, str); }

	// 랜덤노래추천 노래 추가
	@Override public int setRandomSongRecommandInput(RandomSongRecommandVO vo) { 
		String size = vo.getRecAlbumImg().replace("width=\"560\" ", "width=\"100%\" ");
		size = size.replace("height=\"315\"", "height=\"645\"");
		vo.setRecAlbumImg(size);		
		return adminDAO.setRandomSongRecommandInput(vo);
	}

	// 회원 제재내역 관리
	@Override public int setBlockReasonData(BlockReasonDataVO vo) { return adminDAO.setBlockReasonData(vo); }

	// 회원 재제시 제재내역 저장 위한 재제회원 정보 가져오기
	@Override
	public MemberVO getMemberInfoByIdx(int idx) { return adminDAO.getMemberInfoByIdx(idx); }

	// 제재내역 리스트 조회
	@Override public ArrayList<BlockReasonDataVO> getBlockReasonDataList() { return adminDAO.getBlockReasonDataList(); }

	// 운영자, 관리자의 정보와 권한 조회하기
	@Override
	public MemberVO getAdministerInfo(int idx) { return adminDAO.getAdministerInfo(idx); }

	// 운영자,관리자 권한 수정 전 해당 권한을 가진 운영자,관리자가 있는지 확인
	@Override	
	public int getAdminExistCheck(int memLevel, String part) {
		
		MemberVO vo = adminDAO.getAdministerExistCheck(memLevel, part);
		
		if(vo != null && memLevel == 111) {
			return 111;
		}
		else if(vo != null && memLevel == 112) {
			return 112;
		}
		else {
			return 999;			
		}
		
	}

	// 운영자 관리자 권한 수정 실행
	@Override
	public int setAdministerAuthorityChenge(int idx, int memLevel, String part) { return adminDAO.setAdministerAuthorityChenge(idx, memLevel, part); }

	// 일반회원에게 권한 부여
	@Override
	public int setMemberGiveAdmin(int idx, int memLevel, String part) { return adminDAO.setMemberGiveAdmin(idx ,memLevel,part);	}

	// 운영자, 관리자 권한 제거
	/** 
		운영자,관리자 전용 아이디, 닉네임을 강제로 변경한 뒤 해당 회원의 이메일로 발송해준다 
	 	이때, 강제로 변경시키기 위해 발생시킨 아이디와 닉네임을 가진 회원이 있는지를 체크하고 없다면 변경
	 	있다면 재발생 후 변경한다
	*/
	@Override	
	public int setAuthorityDelete(int idx) { 
		String mid_ = RandomStringUtils.randomAlphanumeric(8);
		String nickName_ = RandomStringUtils.randomAlphanumeric(4) + UUID.randomUUID().toString().substring(0,6);
		return adminDAO.setAuthorityDelete(idx);		
	}

	// 랜덤노래추천 관리화면에 노래명단띄우기
	@Override	public ArrayList<RandomSongRecommandVO> getSongList() { return adminDAO.getSongList(); }

	// 랜덤노래추천 선택곡 삭제
	@Override	public int setRandomSongRecommandDelete(int idx) { return adminDAO.setRandomSongRecommandDelete(idx); }

	// 랜덤노래추천 선택곡 수정하기
	@Override public RandomSongRecommandVO getRecommandSongList(int idx) { return adminDAO.getRecommandSongList(idx); }

	// 랜덤노래추천 선택곡 수정하기	
	@Override	public int getSongData(int idx) { return adminDAO.getSongData(idx); }

	// 랜덤노래추천 선택곡 수정 실행
	@Override public int setRecommandSongUpdate(RandomSongRecommandVO vo) { 
	
		// <img src=/javaclassS11/images/noImage.jpg width=100% height=645> 이런 형식으로 저장되어야 noImage가 정상적으로 나온다!
		if(vo.getRecAlbumImg().equals("noImage.jpg")) {
			vo.setRecAlbumImg("<img src='${ctp}/images/noImage.jpg' width='100%' height='645' />");
			return adminDAO.setRecommandSongUpdate(vo); 
		}
		else {
			String size = vo.getRecAlbumImg().replace("width=\"560\" ", "width=\"100%\" ");
			size = size.replace("height=\"315\"", "height=\"645\"");
			vo.setRecAlbumImg(size);		
			return adminDAO.setRecommandSongUpdate(vo); 
		}
		
	}
	


	

	




	
}
