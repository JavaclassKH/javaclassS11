package com.spring.javaclassS11.vo;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class MemberVO {

	private int idx;
	private String mid;
	private String pwd;
	private String name;
	private String nickName;
	private String tel;
	private String email;
	private String birthday;
	private String address;
	private String memberImage;
	private String fangirlReason;
	private String joinDate;
	private String lastLoginDate;
	private int visitCnt;
	private int totWriteCnt;
	private int totReplyWriteCnt;
	private int IVEQuizScore;
	private int memLevel;
	private int blockDate;
	private int blockCnt;
	private String part;

}
