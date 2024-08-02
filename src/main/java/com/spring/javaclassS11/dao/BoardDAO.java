package com.spring.javaclassS11.dao;

import java.util.ArrayList;

import org.apache.ibatis.annotations.Param;

import com.spring.javaclassS11.vo.FreeBoardReplyVO;
import com.spring.javaclassS11.vo.FreeBoardVO;
import com.spring.javaclassS11.vo.FromIVEVO;
import com.spring.javaclassS11.vo.ToIVEVO;

public interface BoardDAO {

	public ArrayList<FreeBoardVO> getFreeBoardList(@Param("startIndexNo") int startIndexNo,@Param("pageSize") int pageSize);

	public int totRecCnt(@Param("part") String part);

	public FreeBoardVO getFreeBoardContent(@Param("idx") int idx);

	public ArrayList<FromIVEVO> getFromIVEList(@Param("startIndexNo") int startIndexNo,@Param("pageSize") int pageSize);

	public int setFreeBoardInput(@Param("vo") FreeBoardVO vo);

	public int setFromIVEInput(@Param("vo") FromIVEVO vo);

	public FromIVEVO getFromIVEContent(@Param("idx") int idx);

	public ArrayList<ToIVEVO> getToIVEList(@Param("startIndexNo") int startIndexNo,@Param("pageSize") int pageSize);

	public ToIVEVO getToIVEContent(@Param("idx") int idx);

	public ArrayList<FreeBoardReplyVO> getBoardReplyList(@Param("idx") int idx);

	public int setFreeBoardReplyInput(@Param("vo") FreeBoardReplyVO vo);

	public int setFreeBoardReplyDelete(@Param("idx") int idx);

}
