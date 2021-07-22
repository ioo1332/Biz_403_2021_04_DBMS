package com.honjal.honjal.controller;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.honjal.honjal.model.ContentDTO;
import com.honjal.honjal.model.ContentListDTO;
import com.honjal.honjal.model.ContentVO;
import com.honjal.honjal.model.MemberVO;
import com.honjal.honjal.service.ContentService;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@RequiredArgsConstructor
@RequestMapping("/board")
@Controller
public class BoardController {
	
	protected final ContentService contentService;

	@RequestMapping(value={"/{menu}","/{menu}/"}, method=RequestMethod.GET)
	public String board(@PathVariable("menu") String menu, Model model, HttpSession session) {
		
		String menu_str = menu.toUpperCase();
		String[] menu_arr = menu_str.split("-");
		// TIP-1 이면(말머리별 보기)  menu_arr 배열에 TIP, 1 이렇게 2개가 담김
		
		List<ContentListDTO> list = contentService.menuContent(menu_str);
		
		model.addAttribute("CONTENTS", list);
		
		if(menu_arr.length > 1) menu_str = menu_arr[0];
		// /TIP-1로 넘어오면 menu_str에 TIP만 담김
		
		model.addAttribute("SESSION", session.getAttribute("MEMBER"));
		model.addAttribute("BODY", "BOARD_MAIN");
		model.addAttribute("MENU", menu_str);
		return "home";
		
	}

	
	/*
	@RequestMapping(value={"/notice",""}, method=RequestMethod.GET)
	public String notice(Model model) {
		List<ContentListDTO> list = contentService.menuContent("NOT");
		model.addAttribute("CONTENTS", list);
		model.addAttribute("BODY", "BOARD_MAIN");
		model.addAttribute("MENU", "NOTICE");
		return "home";
	}
	
	@RequestMapping(value={"/info",""}, method=RequestMethod.GET)
	public String info(Model model) {
		List<ContentListDTO> list = contentService.menuContent("INF");
		model.addAttribute("CONTENTS", list);
		model.addAttribute("BODY", "BOARD_MAIN");
		model.addAttribute("MENU", "INFO");
		return "home";
	}
	
	@RequestMapping(value={"/tip",""}, method=RequestMethod.GET)
	public String tip(Model model) {
		List<ContentListDTO> list = contentService.menuContent("TIP");
		model.addAttribute("CONTENTS", list);
		model.addAttribute("BODY", "BOARD_MAIN");
		model.addAttribute("MENU", "TIP");
		return "home";
	}
	
	@RequestMapping(value={"/interior",""}, method=RequestMethod.GET)
	public String interior(Model model) {
		List<ContentListDTO> list = contentService.menuContent("INT");
		model.addAttribute("CONTENTS", list);
		model.addAttribute("BODY", "BOARD_MAIN");
		model.addAttribute("MENU", "INTERIOR");
		return "home";
	}
	
	@RequestMapping(value={"/talk",""}, method=RequestMethod.GET)
	public String talk(Model model) {
		List<ContentListDTO> list = contentService.menuContent("TAL");
		model.addAttribute("CONTENTS", list);
		model.addAttribute("BODY", "BOARD_MAIN");
		model.addAttribute("MENU", "TALK");
		return "home";
	}
	
	@RequestMapping(value={"/review",""}, method=RequestMethod.GET)
	public String review(Model model) {
		List<ContentListDTO> list = contentService.menuContent("REV");
		model.addAttribute("CONTENTS", list);
		model.addAttribute("BODY", "BOARD_MAIN");
		model.addAttribute("MENU", "REVIEW");
		return "home";
	}
	
	@RequestMapping(value={"/qna",""}, method=RequestMethod.GET)
	public String qna(Model model) {
		List<ContentListDTO> list = contentService.menuContent("QNA");
		model.addAttribute("CONTENTS", list);
		model.addAttribute("BODY", "BOARD_MAIN");
		model.addAttribute("MENU", "QNA");
		return "home";
	}
	
	*/
	
	@ResponseBody
	@RequestMapping(value="/write")
	public String login_check(HttpSession session) {
		MemberVO memberVO = (MemberVO) session.getAttribute("MEMBER");
		if(memberVO == null) {
			return "NULL";
		}
		return "OK";
	}
	// 글쓰기 버튼 누르면 login 여부 확인한 후 스크립트로 alert창 띄워주기 위해 ajax용 메서드 따로 만듦
	// write 메서드로 넘어가기 전에 검사해야함
	
	@RequestMapping(value="/{menu}/write", method=RequestMethod.GET)
	public String write( @PathVariable("menu") String menu,  Model model, HttpSession session) {
		
		MemberVO memberVO = (MemberVO) session.getAttribute("MEMBER");
		
		ContentVO contentVO = ContentVO.builder().member_num(memberVO.getMember_num()).member_nname(memberVO.getMember_nname()).build();
		
		model.addAttribute("CONTENT", contentVO);
		model.addAttribute("BODY", "WRITE");
		model.addAttribute("MENU",menu.toUpperCase());
		return "home";
	}
	
	@RequestMapping(value="/{menu}/write", method=RequestMethod.POST)
	public String write(String bcode, HttpSession session, ContentVO contentVO, ContentDTO contentDTO ,MultipartFile one_file, MultipartHttpServletRequest m_file) throws Exception {
		Date date = new Date(System.currentTimeMillis());
		SimpleDateFormat sd = new SimpleDateFormat("yyyy-MM-dd");
		SimpleDateFormat st = new SimpleDateFormat("hh:mm:ss");
		String curDate = sd.format(date);
		String curTime = st.format(date);
		
//		contentVO = ContentVO.builder().board_code(category).content_date(curDate).content_time(curTime).content_view(0).content_good(0).build();
		
		contentVO.setBoard_code(bcode);
		contentVO.setContent_date(curDate);
		contentVO.setContent_time(curTime);
		contentVO.setContent_view(0);
		contentVO.setContent_good(0);
		contentService.input(contentDTO, one_file, m_file);
		
		contentService.insert(contentVO);
		return "redirect:/board/{menu}";
	}
	
	@RequestMapping(value="/read", method=RequestMethod.GET)
	public String read(Integer content_num, Model model, HttpSession session) {
		ContentVO contentVO = contentService.findByIdContent(content_num);
		model.addAttribute("CONTENT",contentVO);
		model.addAttribute("SESSION", session.getAttribute("MEMBER"));
		model.addAttribute("BODY", "READ");
		return "home";
	}
	
	@RequestMapping(value="/update", method=RequestMethod.GET)
	public String update(Integer content_num, Model model) {
		ContentVO contentVO = contentService.findByIdContent(content_num);
		String bcode = contentVO.getBoard_code().substring(0, 3);
		// board_code 앞 3글자 따오기 (TIP)
		
		model.addAttribute(bcode);
		
		/*
		if(bcode.equals("TIP")) {
			model.addAttribute("MENU","TIP");
		} else if(bcode.equals("TAL")) {
			model.addAttribute("MENU","TALK");
		} else if(bcode.equals("REV")) {
			model.addAttribute("MENU","REVIEW");
		}
		*/
		
		model.addAttribute("CONTENT",contentVO);
		model.addAttribute("BODY", "UPDATE");
		return "home";
	}
	
	@RequestMapping(value="/update", method=RequestMethod.POST)
	public String update(ContentVO contentVO, Model model) throws Exception {
		contentService.update(contentVO);
		model.addAttribute("content_num", contentVO.getContent_num());
		return "redirect:/board/read";
	}
	
	@RequestMapping(value="/{menu}/delete", method=RequestMethod.GET)
	public String delete(Integer content_num, Model model) throws Exception {
		contentService.delete(content_num);
		return "redirect:/board/{menu}";
	}
	
	@RequestMapping(value="/{menu}/search/{type}", method=RequestMethod.GET)
	public String search(@PathVariable("menu") String menu, String search_word, Model model) throws Exception {
		contentService.searchTitleContent(menu, search_word);
		model.addAttribute("BODY", "BOARD_MAIN");
		return "home";
	}
	
}
