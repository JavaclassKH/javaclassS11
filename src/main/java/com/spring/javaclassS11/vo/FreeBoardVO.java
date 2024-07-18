package com.spring.javaclassS11.vo;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class FreeBoardVO {
	private int idx;
	private String mid;
	private String nickName;
	private String writerIp;
	private String freeBoardTitle;
	private String freeBoardContent;
	private String writeDate;
	private int readNum;
	private int complainCnt;
	private int good;
	private int bad;
}
