package com.spring.javaclassS11.service;

import java.util.ArrayList;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.spring.javaclassS11.dao.PlayDAO;
import com.spring.javaclassS11.vo.IVEQuizVO;
import com.spring.javaclassS11.vo.RandomSongRecommandVO;

@Service
public class PlayServiceImpl implements PlayService {

	@Autowired
	PlayDAO playDAO;

	// 검색분위기별 랜덤노래추천
	@Override	public RandomSongRecommandVO getRandomSongRecommandSearch(String search) { return playDAO.getRandomSongRecommandSearch(search); }

	// 랜덤노래추천
	@Override public RandomSongRecommandVO getRandomSongRecommand() { return playDAO.getRandomSongRecommand(); }

	// 아이브 상식퀴즈 리스트 
	@Override	public IVEQuizVO getIVEInfoQuizList(String part) { return playDAO.getIVEInfoQuizList(part); }
	
}
