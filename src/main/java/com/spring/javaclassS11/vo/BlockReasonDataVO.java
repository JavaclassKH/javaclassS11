package com.spring.javaclassS11.vo;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class BlockReasonDataVO {
	private int idx;
	private String mid;
	private String nickName;
	private String blockReason;
	private String blockStartDate;
	private String blockEndDate;
	private String blockGiver;
}
