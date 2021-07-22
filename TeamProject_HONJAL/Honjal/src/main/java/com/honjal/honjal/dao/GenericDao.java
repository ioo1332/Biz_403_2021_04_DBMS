package com.honjal.honjal.dao;

import java.util.List;
import java.util.Map;

public interface GenericDao<VO, PK> {
	public List<VO> selectAll();
	public VO findById(PK pk);
	
	public void insert(VO vo);
	public void update(VO vo);
	public void delete(PK pk);
	
	public int create_table(Map<String,String> resultMaps);
}
