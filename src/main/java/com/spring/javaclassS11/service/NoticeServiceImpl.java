package com.spring.javaclassS11.service;

import java.util.ArrayList;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.spring.javaclassS11.dao.NoticeDAO;
import com.spring.javaclassS11.vo.NoticeVO;
import com.spring.javaclassS11.vo.PagVO;

@Service
public class NoticeServiceImpl implements NoticeService {

	@Autowired
	NoticeDAO noticeDAO;

	@Override public ArrayList<NoticeVO> getNoticeBoardList(PagVO pageVo) {	return noticeDAO.getNoticeBoardList(pageVo); }

	@Override	public NoticeVO getNoticeBoardContent(int idx) { return noticeDAO.getNoticeBoardContent(idx); }

	@Override public int setNoticeInput(NoticeVO vo) { return noticeDAO.setNoticeInput(vo); }

	@Override public void setReadNumPlus(int idx) { noticeDAO.setReadNumPlus(idx);}

	@Override public int setNoticeUpdate(NoticeVO vo) { return noticeDAO.setNoticeUpdate(vo);	}

	
	
	
	
}
