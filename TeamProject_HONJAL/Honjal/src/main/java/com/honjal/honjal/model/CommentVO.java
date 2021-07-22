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
public class CommentVO {

	private String comment_num;		// 댓글번호
	private String content_num;		// 글번호
	private String member_num;		// 글쓴 유저번호
	private String board_code;		// 게시판코드
	private String comment_writer;	// 댓글작성자
	private String comment_text;	// 댓글내용
	private String comment_time;	// 댓글작성시각

}