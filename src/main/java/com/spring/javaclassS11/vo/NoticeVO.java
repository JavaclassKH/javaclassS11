package com.spring.javaclassS11.vo;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class NoticeVO {
	private int idx;
	private String mid;
	private String nickName;
	private String noticeWDate;
	private String noticeTitle;
	private String noticeContent;
	private int noticeReadNum;
}
