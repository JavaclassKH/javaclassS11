package com.spring.javaclassS11.service;

import java.util.ArrayList;

import com.spring.javaclassS11.vo.NoticeVO;
import com.spring.javaclassS11.vo.PagVO;

public interface NoticeService {

	public ArrayList<NoticeVO> getNoticeBoardList(PagVO pageVo);

	public NoticeVO getNoticeBoardContent(int idx);

	public int setNoticeInput(NoticeVO vo);

	public void setReadNumPlus(int idx);

	public int setNoticeUpdate(NoticeVO vo);


}
