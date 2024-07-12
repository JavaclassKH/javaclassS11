package com.spring.javaclassS11.dao;

import org.apache.ibatis.annotations.Param;

import com.spring.javaclassS11.vo.IVEQuizVO;
import com.spring.javaclassS11.vo.RandomSongRecommandVO;

public interface PlayDAO {

	public RandomSongRecommandVO getRandomSongRecommandSearch(@Param("search") String search);

	public RandomSongRecommandVO getRandomSongRecommand();

	public IVEQuizVO getIVEInfoQuizList(@Param("part") String part);

}
