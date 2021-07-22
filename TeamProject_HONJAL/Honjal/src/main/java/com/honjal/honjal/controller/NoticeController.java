package com.honjal.honjal.controller;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.honjal.honjal.model.ContentListDTO;
import com.honjal.honjal.model.ContentVO;
import com.honjal.honjal.service.ContentService;

import lombok.RequiredArgsConstructor;

@RequiredArgsConstructor
@RequestMapping("/notice")
@Controller
public class NoticeController {
	
	protected final ContentService contentService;
	
	@RequestMapping(value={"/",""}, method=RequestMethod.GET)
	public String main(Model model) {
		List<ContentListDTO> list = contentService.menuContent("NOT");
		model.addAttribute("CONTENTS", list);
		model.addAttribute("BODY", "BOARD_MAIN");
		model.addAttribute("MENU", "NOTICE");
		return "home";
	}
	
	@RequestMapping(value="/write", method=RequestMethod.GET)
	public String write(Model model, HttpSession session) {
//		MemberVO memberVO = (MemberVO) session.getAttribute("MEMBER");
//		Integer member_num = memberVO.getMember_num();
		
		ContentVO contentVO = ContentVO.builder().member_num(1).member_nname("csy").build();
		
		model.addAttribute("CONTENT", contentVO);
		model.addAttribute("BODY", "WRITE");
		model.addAttribute("MENU", "NOTICE");
		return "home";
	}
	
	@RequestMapping(value="/write", method=RequestMethod.POST)
	public String write(HttpSession session, ContentVO contentVO) throws Exception {
		Date date = new Date(System.currentTimeMillis());
		SimpleDateFormat sd = new SimpleDateFormat("yyyy-MM-dd");
		SimpleDateFormat st = new SimpleDateFormat("hh:mm:ss");
		String curDate = sd.format(date);
		String curTime = st.format(date);
		
//		contentVO = ContentVO.builder().board_code(category).content_date(curDate).content_time(curTime).content_view(0).content_good(0).build();
		
		contentVO.setBoard_code("NOT-1");
		contentVO.setContent_date(curDate);
		contentVO.setContent_time(curTime);
		contentVO.setContent_view(0);
		contentVO.setContent_good(0);
		
		contentService.insert(contentVO);
		return "redirect:/notice";
	}
	
	@RequestMapping(value="/read", method=RequestMethod.GET)
	public String read(Integer content_num, Model model) {
		ContentVO contentVO = contentService.findByIdContent(content_num);
		model.addAttribute("CONTENT",contentVO);
		model.addAttribute("BODY", "READ");
		model.addAttribute("MENU", "NOTICE");
		return "home";
	}
	
	@RequestMapping(value="/update", method=RequestMethod.GET)
	public String update(Integer content_num, Model model) {
		ContentVO contentVO = contentService.findByIdContent(content_num);
		model.addAttribute("CONTENT",contentVO);
		model.addAttribute("BODY", "UPDATE");
		model.addAttribute("MENU", "NOTICE");
		return "home";
	}
	
	@RequestMapping(value="/update", method=RequestMethod.POST)
	public String update(ContentVO contentVO, Model model) throws Exception {
		contentService.update(contentVO);
		model.addAttribute("CONTENT",contentVO);
		model.addAttribute("BODY", "READ");
		model.addAttribute("MENU", "NOTICE");
		return "home";
	}
	
	@RequestMapping(value="/delete", method=RequestMethod.GET)
	public String delete(Integer content_num, Model model) throws Exception {
		contentService.delete(content_num);
		return "redirect:/notice";
	}
	
}
