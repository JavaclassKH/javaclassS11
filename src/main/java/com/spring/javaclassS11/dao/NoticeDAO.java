package com.spring.javaclassS11.dao;

import java.util.ArrayList;

import org.apache.ibatis.annotations.Param;

import com.spring.javaclassS11.vo.NoticeVO;
import com.spring.javaclassS11.vo.PagVO;

public interface NoticeDAO {

	public int totRecCnt();

	public ArrayList<NoticeVO> getNoticeBoardList(@Param("pageVo") PagVO pageVo);

	public NoticeVO getNoticeBoardContent(@Param("idx") int idx);

	public int setNoticeInput(@Param("vo") NoticeVO vo);

	public void setReadNumPlus(@Param("idx") int idx);

	public int setNoticeUpdate(@Param("vo") NoticeVO vo);

	



}
