package com.spring.javaclassS11.service;

import com.spring.javaclassS11.vo.IVEQuizVO;
import com.spring.javaclassS11.vo.RandomSongRecommandVO;

public interface PlayService {

	public RandomSongRecommandVO getRandomSongRecommandSearch(String search);

	public RandomSongRecommandVO getRandomSongRecommand();

	public IVEQuizVO getIVEInfoQuizList(String part);

}
