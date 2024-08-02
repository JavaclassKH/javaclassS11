package com.spring.javaclassS11.service;

import java.util.ArrayList;

import org.springframework.web.multipart.MultipartFile;

import com.spring.javaclassS11.vo.SongSuggestionsVO;
import com.spring.javaclassS11.vo.ChoreographySuggestionsVO;

public interface SuggestionsService {

	public ArrayList<SongSuggestionsVO> getsongSuggestionsList(int startIndexNo, int pageSize);

	public int setSongSuggestionsInput(SongSuggestionsVO vo, MultipartFile fName);

	public SongSuggestionsVO getSongSuggestionsContent(int idx);

	public ArrayList<ChoreographySuggestionsVO> getChoreographySuggestionsList(int startIndexNo, int pageSize);

	public ChoreographySuggestionsVO getChoreographySuggestionsContent(int idx);

	public int setChoreographySuggestionsInput(ChoreographySuggestionsVO vo, MultipartFile fName);

}
