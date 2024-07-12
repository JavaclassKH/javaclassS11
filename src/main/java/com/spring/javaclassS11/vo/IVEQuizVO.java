package com.spring.javaclassS11.vo;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class IVEQuizVO {
	private int idx;
	private String quizPart;
	private String quizQuestion;
	private String quizAnswer;
	private String quizbogi;
	private int quizScore;
}

