package com.spring.javaclassS11.vo;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class RandomSongRecommandVO {
	private int idx;
	private String songName;
	private String singer;
	private String genre;
	private String recAlbumImg;
	private String recVibe;
	private String recommandSongIdxKey;
}
