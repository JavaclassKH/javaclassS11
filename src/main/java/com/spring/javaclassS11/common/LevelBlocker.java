package com.spring.javaclassS11.common;

import org.springframework.stereotype.Service;

// Intercepter 대신 controller 내에서 session에 저장된 회원등급으로 기능제한하는 메소드
@Service
public class LevelBlocker {

	public String levelBlocker(String part, int level) {
		
		// 자유게시판 글쓰기 방지 (정회원 이상)
		if(part.equals("freeBoardInput")) {
			if(level == 0)	return "level0Cut";
			else if(level == 2)	return "freeBoardInputLevel2";
			else return "Ok";
		}
		// fromIVE 입장 방지 (정회원 이상)
		else if(part.equals("fromIVEList")) {
			if(level == 0) return "level0Cut";
			else if(level == 2) return "fromIVEListLevel2";
			else return "Ok";
		}
		// toIVE 입장 방지 (정회원 이상)
		else if(part.equals("toIVEList")) {
			if(level == 0) return "level0Cut";
			else if(level == 2) return "toIVEListLevel2";
			else return "Ok";
		}
		// 노래제안 입장 방지 (우수회원 이상)
		else if(part.equals("songSuggestions")) {
			if(level == 0) return "level0Cut";
			else if(level == 2 || level == 3) return "songSuggestionsLevel4";
			else return "Ok";
		}
		// 안무제안 입장 방지 (우수회원 이상)
		else if(part.equals("choreographySuggestions")) {
			if(level == 0) return "level0Cut";
			else if(level == 2 || level == 3) return "choreographySuggestionsLevel4";
			else return "Ok";
		}
		else return "Ok";
		
		
	}
	
	
}
