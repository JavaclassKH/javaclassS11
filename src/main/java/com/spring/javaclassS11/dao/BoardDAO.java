package com.spring.javaclassS11.dao;

import java.util.ArrayList;

import org.apache.ibatis.annotations.Param;

import com.spring.javaclassS11.vo.FreeBoardVO;
import com.spring.javaclassS11.vo.FromIVEVO;

public interface BoardDAO {

	public ArrayList<FreeBoardVO> getFreeBoardList(@Param("startIndexNo") int startIndexNo,@Param("pageSize") int pageSize);

	public int totRecCnt(@Param("part") String part);

	public FreeBoardVO getFreeBoardContent(@Param("idx") int idx);

	public ArrayList<FromIVEVO> getFromIVEList(@Param("startIndexNo") int startIndexNo,@Param("pageSize") int pageSize);

	public int setFreeBoardInput(@Param("vo") FreeBoardVO vo);

	public int setFromIVEInput(@Param("vo") FromIVEVO vo);

}
