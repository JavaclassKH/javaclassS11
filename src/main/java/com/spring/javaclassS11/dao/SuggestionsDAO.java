package com.spring.javaclassS11.dao;

import java.util.ArrayList;

import org.apache.ibatis.annotations.Param;

import com.spring.javaclassS11.vo.SongSuggestionsVO;
import com.spring.javaclassS11.vo.ChoreographySuggestionsVO;

public interface SuggestionsDAO {

	public ArrayList<SongSuggestionsVO> getsongSuggestionsList(@Param("startIndexNo") int startIndexNo,@Param("pageSize") int pageSize);

	public int setSongSuggestionsInput(@Param("vo") SongSuggestionsVO vo);

	public SongSuggestionsVO getSongSuggestionsContent(@Param("idx") int idx);

	public ArrayList<ChoreographySuggestionsVO> getChoreographySuggestionsList(@Param("startIndexNo") int startIndexNo ,@Param("pageSize") int pageSize);

	public ChoreographySuggestionsVO getChoreographySuggestionsContent(@Param("idx") int idx);

	public int setChoreographySuggestionsInput(@Param("vo") ChoreographySuggestionsVO vo);

}
