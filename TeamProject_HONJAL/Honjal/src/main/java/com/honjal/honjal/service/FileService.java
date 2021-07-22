package com.honjal.honjal.service;

import java.util.List;

import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

public interface FileService {
	
	public String fileUp(MultipartFile file)throws Exception;
	   
	public List<String>filesUp(MultipartHttpServletRequest files)throws Exception;
	   
	List<String> fileUp(MultipartFile file, MultipartHttpServletRequest files) throws Exception;

}