package com.spring.javaclassS11.service;

import java.util.ArrayList;

import com.spring.javaclassS11.vo.FreeBoardVO;

public interface BoardService {

	public ArrayList<FreeBoardVO> getFreeBoardList();

	public FreeBoardVO getFreeBoardContent(int idx);

	
	
	
}
