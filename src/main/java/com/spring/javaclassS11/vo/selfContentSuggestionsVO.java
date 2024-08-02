package com.spring.javaclassS11.vo;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class selfContentSuggestionsVO {
	private int idx;
	private String mid;
	private String nickName;
	private String selfContentSuggestionsTitle;
	private String selfContentSuggestionsContent;
	private String selfContentFileOriginName;
	private String selfContentFileName;
	private String writeDate;
}


