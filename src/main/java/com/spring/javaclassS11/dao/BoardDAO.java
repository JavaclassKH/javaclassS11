package com.spring.javaclassS11.dao;

import java.util.ArrayList;

import org.apache.ibatis.annotations.Param;

import com.spring.javaclassS11.vo.FreeBoardVO;

public interface BoardDAO {

	public ArrayList<FreeBoardVO> getFreeBoardList();

	public int totRecCnt();

	public FreeBoardVO getFreeBoardContent(@Param("idx") int idx);

}
