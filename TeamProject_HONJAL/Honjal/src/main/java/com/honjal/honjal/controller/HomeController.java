package com.honjal.honjal.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.honjal.honjal.model.ContentListDTO;
import com.honjal.honjal.service.ContentService;
import com.honjal.honjal.service.FileService;

import lombok.RequiredArgsConstructor;

@RequiredArgsConstructor
@Controller
public class HomeController {
	
	protected final ContentService contentService;
	
	@Qualifier("fileServiceV2")
	protected final FileService fileService;
	
	@RequestMapping(value = {"/",""}, method = RequestMethod.GET)
	public String home(Model model) {
		
		List<ContentListDTO> list = contentService.allContent();
		
		model.addAttribute("CONTENTS",list);
		return "home";
	}
	
	@RequestMapping(value = "/sub", method = RequestMethod.POST)
	public String home(
			@RequestParam("one_file") MultipartFile one_file,
			MultipartHttpServletRequest m_file) {
	
		List<MultipartFile> files = m_file.getFiles("m_file");
		
		return "home";
}
}
