package com.spring.javaclassS11.service;

import java.util.ArrayList;

import com.spring.javaclassS11.vo.FreeBoardVO;
import com.spring.javaclassS11.vo.FromIVEVO;

public interface BoardService {

	public ArrayList<FreeBoardVO> getFreeBoardList(int startIndexNo, int pageSize);

	public FreeBoardVO getFreeBoardContent(int idx);

	public ArrayList<FromIVEVO> getFromIVEList(int startIndexNo, int pageSize);

	public int setFreeBoardInput(FreeBoardVO vo);

	public int setFromIVEInput(FromIVEVO vo);

	
	
	
}
