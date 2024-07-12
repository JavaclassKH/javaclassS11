package com.spring.javaclassS11.service;

import java.util.ArrayList;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.spring.javaclassS11.dao.BoardDAO;
import com.spring.javaclassS11.vo.FreeBoardVO;

@Service
public class BoardServiceImpl implements BoardService {

	@Autowired
	BoardDAO boardDAO;

	@Override	public ArrayList<FreeBoardVO> getFreeBoardList() { return boardDAO.getFreeBoardList(); }

	@Override
	public FreeBoardVO getFreeBoardContent(int idx) {	return boardDAO.getFreeBoardContent(idx); }
	
}
