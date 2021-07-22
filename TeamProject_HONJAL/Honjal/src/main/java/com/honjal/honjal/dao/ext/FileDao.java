package com.honjal.honjal.dao.ext;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.honjal.honjal.dao.GenericDao;
import com.honjal.honjal.model.FileDTO;

public interface FileDao extends GenericDao<FileDao, Integer> {
	
	public int insertOrUpdate(FileDTO fileDto);
	public int insertWithList(@Param("filesList") List<FileDTO>filesList);
	public int insertOrUpdateWithList(@Param("filesList") List<FileDTO>filesList);


}