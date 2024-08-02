package com.spring.javaclassS11.service;

import java.io.IOException;
import java.util.ArrayList;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.spring.javaclassS11.common.JavaclassProvide;
import com.spring.javaclassS11.dao.SuggestionsDAO;
import com.spring.javaclassS11.vo.SongSuggestionsVO;
import com.spring.javaclassS11.vo.ChoreographySuggestionsVO;

@Service
public class SuggestionsServiceImpl implements SuggestionsService {

	@Autowired
	SuggestionsDAO suggestionsDAO;
	
	@Autowired
	JavaclassProvide javaclassProvide;

	// 노래제안 게시판 List
	@Override	public ArrayList<SongSuggestionsVO> getsongSuggestionsList(int startIndexNo, int pageSize) { return suggestionsDAO.getsongSuggestionsList(startIndexNo, pageSize); }

	// 노래제안 게시판 글 작성
	@Override
	public int setSongSuggestionsInput(SongSuggestionsVO vo, MultipartFile fName) {
		int res = 0;
		// 파일을 올리지 않은 경우
		if(fName == null || fName.getOriginalFilename().equals("")) {
			vo.setSongFileName("noFile");
			res = suggestionsDAO.setSongSuggestionsInput(vo);
			return res;
		}
		// 파일을 올린 경우
		else {
			String fileName = fName.getOriginalFilename();
			String sFileName = javaclassProvide.saveFileName(fileName, vo.getMid());
			try { javaclassProvide.writeFile(fName, sFileName, "songSuggestions"); } 
			catch (IOException e) { e.printStackTrace(); }
			vo.setSongFileOriginName(fName.getOriginalFilename());
			vo.setSongFileName(sFileName);
			res = suggestionsDAO.setSongSuggestionsInput(vo);
			return res;
		}
	}

	// 노래제안 게시글 보기
	@Override	public SongSuggestionsVO getSongSuggestionsContent(int idx) { return suggestionsDAO.getSongSuggestionsContent(idx); }

	// 안무제안 게시판 보기
	@Override	public ArrayList<ChoreographySuggestionsVO> getChoreographySuggestionsList(int startIndexNo, int pageSize) { return suggestionsDAO.getChoreographySuggestionsList(startIndexNo, pageSize); }

	// 안무제안 게시글 보기
	@Override	public ChoreographySuggestionsVO getChoreographySuggestionsContent(int idx) { return suggestionsDAO.getChoreographySuggestionsContent(idx); }

	@Override
	public int setChoreographySuggestionsInput(ChoreographySuggestionsVO vo, MultipartFile fName) {
		int res = 0;
		// 파일을 올리지 않은 경우
		if(fName == null || fName.getOriginalFilename().equals("")) {
			vo.setChoreographyFileName("noFile");
			res = suggestionsDAO.setChoreographySuggestionsInput(vo);
			return res;
		}
		// 파일을 올린 경우
		else {
			String fileName = fName.getOriginalFilename();
			String sFileName = javaclassProvide.saveFileName(fileName, vo.getMid());
			try { javaclassProvide.writeFile(fName, sFileName, "choreographySuggestions"); } 
			catch (IOException e) { e.printStackTrace(); }
			vo.setChoreographyFileOriginName(fName.getOriginalFilename());
			vo.setChoreographyFileName(sFileName);
			res = suggestionsDAO.setChoreographySuggestionsInput(vo);
			return res;
		}
	}
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
}
