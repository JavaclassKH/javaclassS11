package com.spring.javaclassS11.service;

import java.util.ArrayList;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.spring.javaclassS11.dao.BoardDAO;
import com.spring.javaclassS11.vo.FreeBoardVO;
import com.spring.javaclassS11.vo.FromIVEVO;

@Service
public class BoardServiceImpl implements BoardService {

	@Autowired
	BoardDAO boardDAO;

	// 자유게시판 메인화면
	@Override	public ArrayList<FreeBoardVO> getFreeBoardList(int startIndexNo, int pageSize) { return boardDAO.getFreeBoardList(startIndexNo, pageSize); }
	
	// 자유게시판 글 읽기
	@Override public FreeBoardVO getFreeBoardContent(int idx) {	return boardDAO.getFreeBoardContent(idx); }

	// 자유게시판 글쓰기
	@Override public int setFreeBoardInput(FreeBoardVO vo) { return boardDAO.setFreeBoardInput(vo); }
	
	// 아이브로부터 메인화면
	@Override
	public ArrayList<FromIVEVO> getFromIVEList(int startIndexNo, int pageSize) { return boardDAO.getFromIVEList(startIndexNo, pageSize); }

	// 아이브로부터 글쓰기
	@Override public int setFromIVEInput(FromIVEVO vo) { return boardDAO.setFromIVEInput(vo);	}
	
}
