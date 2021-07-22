package com.honjal.honjal.dao.ext;

import com.honjal.honjal.dao.GenericDao;
import com.honjal.honjal.model.MemberVO;

public interface MemberDao extends GenericDao<MemberVO, String>{

	public int insertOrUpdate(MemberVO memberVO);

}