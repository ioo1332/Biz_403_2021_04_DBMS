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
public class ContentReadDTO {

	private String content_title;
	private int content_good;
	private String content_date;
	private String content_time;
	private String member_nname;
	private String content_text;
	
}
