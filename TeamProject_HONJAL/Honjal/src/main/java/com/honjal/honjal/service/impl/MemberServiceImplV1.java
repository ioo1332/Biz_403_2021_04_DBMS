package com.honjal.honjal.service.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.ui.Model;

import com.honjal.honjal.dao.ext.MemberDao;
import com.honjal.honjal.model.MemberVO;
import com.honjal.honjal.service.MemberService;

import lombok.RequiredArgsConstructor;

@RequiredArgsConstructor
@Service("memberServiceV1")
public class MemberServiceImplV1 implements MemberService{

	protected final MemberDao memberDao;
	
	@Autowired
	public void create_member_table(MemberDao dummy) {
		Map<String, String> maps = new HashMap<String, String>();
		memberDao.create_table(maps);
	}
	@Override
	public MemberVO join(MemberVO memberVO) {

		List<MemberVO> members = memberDao.selectAll();
		if(members == null || members.size()<1) {
			memberVO.setMember_level(0);
		}else {
			memberVO.setMember_level(1);
		}
		memberDao.insertOrUpdate(memberVO);
		
		return memberVO;
	}

	@Override
	public MemberVO update(MemberVO memberVO) {

		return null;
	}

	@Override
	public MemberVO findById(String member_id) {

		MemberVO memberVO = memberDao.findById(member_id.trim());
		return memberVO;
	}

	@Override
	public MemberVO login(MemberVO memberVO, Model model) {

		MemberVO findVO = memberDao.findById(memberVO.getMember_id());
		if(findVO == null) {
			model.addAttribute("LOGIN_FAIL","NOT_MEMBER_ID");
			return null;
		}
		if(findVO.getMember_pw().equals(memberVO.getMember_pw())) {
			return findVO;
		}
		model.addAttribute("LOGIN_FAIL","NOT_PASS");
		return null;
	}

}