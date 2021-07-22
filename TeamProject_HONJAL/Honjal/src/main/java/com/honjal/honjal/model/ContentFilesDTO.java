package com.honjal.honjal.model;

import java.util.List;

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
public class ContentFilesDTO {

	
	private String member_nname;	// 작성자 닉네임
	private String content_date;	// 작성날짜
	private String content_time;	// 작성시각
	private int content_view;		// 조회수
	private int content_good;	// 추천수
	private String content_title;	// 글제목
	private String content_text;	// 글내용
	
	
	
	private Long file_num;	// 파일번호
	private String content_num;	// 글번호
	private String member_num;	// 유저번호
	private String board_code;	// 게시판코드
	private String file_originname;	// 파일명
	private String file_upname;// 업로드파일명
	private String file_image;
	List<FileDTO> fileList;
}