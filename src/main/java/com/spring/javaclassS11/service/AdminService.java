package com.spring.javaclassS11.service;

import java.util.ArrayList;

import com.spring.javaclassS11.vo.BlockReasonDataVO;
import com.spring.javaclassS11.vo.LobbyPostVO;
import com.spring.javaclassS11.vo.MemberVO;
import com.spring.javaclassS11.vo.RandomSongRecommandVO;

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

	public int setAdminMemberBlockManagement(BlockReasonDataVO vo, String str);

	public int setRandomSongRecommandInput(RandomSongRecommandVO vo);

	public int setBlockReasonData(BlockReasonDataVO vo);

	public MemberVO getMemberInfoByIdx(int idx);

	public ArrayList<BlockReasonDataVO> getBlockReasonDataList();

	public MemberVO getAdministerInfo(int idx);

	public int getAdminExistCheck(int memLevel, String part);

	public int setAdministerAuthorityChenge(int idx, int memLevel, String part);

	public int setMemberGiveAdmin(int idx, int memLevel, String part);

	public int setAuthorityDelete(int idx);

	public ArrayList<RandomSongRecommandVO> getSongList();

	public int setRandomSongRecommandDelete(int idx);

	public RandomSongRecommandVO getRecommandSongList(int idx);

	public ArrayList<LobbyPostVO> getLobbyPost();

	public int setLobbyPostInsert(String nickName, String post);

	public int setRecommandSongUpdate(int idx, RandomSongRecommandVO vo);



}
