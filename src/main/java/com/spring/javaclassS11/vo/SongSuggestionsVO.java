package com.spring.javaclassS11.vo;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class SongSuggestionsVO {
	private int idx;
	private String mid;
	private String nickName;
	private String songSuggestionsTitle;
	private String songSuggestionsContent;
	private String songFileOriginName;
	private String songFileName;
	private String writeDate;
}


