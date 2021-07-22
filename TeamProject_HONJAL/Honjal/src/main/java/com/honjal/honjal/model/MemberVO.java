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
public class MemberVO {

	private Integer member_num;  	// 유저번호
	private int member_level;	// 권한등급
	private String member_id;		// 아이디
	private String member_pw;		// 비밀번호
	private String member_nname;	// 닉네임
	private String member_email;	// 이메일
	
}
