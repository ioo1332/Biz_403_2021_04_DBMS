package com.honjal.honjal.service;

import org.springframework.ui.Model;

import com.honjal.honjal.model.MemberVO;

public interface MemberService {

	public MemberVO join(MemberVO memberVO);
	public MemberVO update(MemberVO memberVO);
	public MemberVO findById(String member_id);
	
	public MemberVO login(MemberVO memberVO, Model model);

}