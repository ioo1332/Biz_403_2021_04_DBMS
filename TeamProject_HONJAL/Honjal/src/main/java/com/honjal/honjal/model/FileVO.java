package com.honjal.honjal.model;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class FileVO {
	
	private String file_num;	// 파일번호
	private String content_num;	// 글번호
	private String member_num;	// 유저번호
	private String board_code;	// 게시판코드
	private String file_name;	// 파일명

}