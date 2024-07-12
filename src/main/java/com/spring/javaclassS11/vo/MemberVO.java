package com.spring.javaclassS11.vo;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class MemberVO {

	// Member 데이터베이스 기본 컬럼
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
	private String blockStartDate;
	private String blockEndDate;
	private int blockCnt;
	private String part;

	// 제재회원 날짜계산 필드 (SQL에서 비교)
	private int blockDate_diff;
	
	
	
	
}










