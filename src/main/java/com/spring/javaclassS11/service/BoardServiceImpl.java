package com.spring.javaclassS11.service;

import java.util.ArrayList;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.spring.javaclassS11.dao.BoardDAO;
import com.spring.javaclassS11.vo.FreeBoardReplyVO;
import com.spring.javaclassS11.vo.FreeBoardVO;
import com.spring.javaclassS11.vo.FromIVEVO;
import com.spring.javaclassS11.vo.ToIVEVO;

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
	@Override public ArrayList<FromIVEVO> getFromIVEList(int startIndexNo, int pageSize) { return boardDAO.getFromIVEList(startIndexNo, pageSize); }

	// 아이브로부터 글쓰기
	@Override public int setFromIVEInput(FromIVEVO vo) { return boardDAO.setFromIVEInput(vo);	}

	// 아이브로부터 글 보기
	@Override	public FromIVEVO getFromIVEContent(int idx) { return boardDAO.getFromIVEContent(idx);	}

	// 아이브에게 메인화면
	@Override
	public ArrayList<ToIVEVO> getToIVEList(int startIndexNo, int pageSize) { return boardDAO.getToIVEList(startIndexNo, pageSize); }

	// 아이브에게 게시글 보기
	@Override	public ToIVEVO getToIVEContent(int idx) {	return boardDAO.getToIVEContent(idx); }

	// 자유게시판 글의 댓글 
	@Override public ArrayList<FreeBoardReplyVO> getBoardReplyList(int idx) { return boardDAO.getBoardReplyList(idx); }

	// 자유게시판 글에 댓글 작성하기
	@Override public int setFreeBoardReplyInput(FreeBoardReplyVO vo) { return boardDAO.setFreeBoardReplyInput(vo); }

	// 자유게시판 글에 댓글 삭제하기
	@Override	public int setFreeBoardReplyDelete(int idx) { return boardDAO.setFreeBoardReplyDelete(idx); }
	
	
	
	
	
	
}
