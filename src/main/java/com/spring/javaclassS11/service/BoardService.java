package com.spring.javaclassS11.service;

import java.util.ArrayList;

import com.spring.javaclassS11.vo.FreeBoardReplyVO;
import com.spring.javaclassS11.vo.FreeBoardVO;
import com.spring.javaclassS11.vo.FromIVEVO;
import com.spring.javaclassS11.vo.ToIVEVO;

public interface BoardService {

	public ArrayList<FreeBoardVO> getFreeBoardList(int startIndexNo, int pageSize);

	public FreeBoardVO getFreeBoardContent(int idx);

	public ArrayList<FromIVEVO> getFromIVEList(int startIndexNo, int pageSize);

	public int setFreeBoardInput(FreeBoardVO vo);

	public int setFromIVEInput(FromIVEVO vo);

	public FromIVEVO getFromIVEContent(int idx);

	public ArrayList<ToIVEVO> getToIVEList(int startIndexNo, int pageSize);

	public ToIVEVO getToIVEContent(int idx);

	public ArrayList<FreeBoardReplyVO> getBoardReplyList(int idx);

	public int setFreeBoardReplyInput(FreeBoardReplyVO vo);

	public int setFreeBoardReplyDelete(int idx);

	
	
	
}
