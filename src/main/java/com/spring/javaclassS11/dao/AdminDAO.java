package com.spring.javaclassS11.dao;

import java.util.ArrayList;

import org.apache.ibatis.annotations.Param;

import com.spring.javaclassS11.vo.BlockReasonDataVO;
import com.spring.javaclassS11.vo.MemberVO;
import com.spring.javaclassS11.vo.RandomSongRecommandVO;

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

	public int setAdminMemberBlockManagement(@Param("vo") BlockReasonDataVO vo, @Param("str") String str);

	public int setRandomSongRecommandInput(@Param("vo") RandomSongRecommandVO vo);

	public int setBlockReasonData(@Param("vo") BlockReasonDataVO vo);

	public MemberVO getMemberInfoByIdx(@Param("idx") int idx);

	public ArrayList<BlockReasonDataVO> getBlockReasonDataList();

	public MemberVO getAdministerInfo(int idx);

	public MemberVO getAdministerExistCheck(@Param("memLevel") int memLevel,@Param("part") String part);

	public int setAdministerAuthorityChenge(@Param("idx") int idx, @Param("memLevel") int memLevel, @Param("part") String part);

	public int setMemberGiveAdmin(@Param("idx") int idx,@Param("memLevel") int memLevel,@Param("part") String part);

	public int setAuthorityDelete(@Param("idx") int idx);

}
