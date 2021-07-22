package com.honjal.honjal.controller;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.honjal.honjal.model.MemberVO;
import com.honjal.honjal.service.MemberService;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@RequestMapping(value="/member")
@Controller
@RequiredArgsConstructor
public class MemberController {
	@Autowired
	public final MemberService memService;
	
	@RequestMapping(value = "/join", method = RequestMethod.GET)
	public String join(Model model) {
		
		model.addAttribute("BODY", "JOIN");
		return "home";
	}
	
	
	@RequestMapping(value="/join",method=RequestMethod.POST)
	public String join(MemberVO memberVO,Model model) {
		log.debug("회원가입정보{}",memberVO.toString());
		memberVO = memService.join(memberVO);
		
		return "redirect:/";
	}
	
	@ResponseBody
	@RequestMapping(value="/id_check",method=RequestMethod.GET)
	public String id_check(String member_id) {
		
		MemberVO memberVO = memService.findById(member_id);
        
		String returnMsg;
		
		if(memberVO == null) {
			returnMsg = "NOT_USE_ID";
		}else {
			returnMsg = "USE_ID";
		}
		return returnMsg;
	}
	
	@RequestMapping(value="/login/{url}")
	public String login(@PathVariable("url") String url) {
		return "redirect:/member/login?url=member";
	}
	
	@RequestMapping(value="/login",method=RequestMethod.GET)
	public String login(@RequestParam(name="url",required = false,defaultValue = "NONE") String url, Model model) {
		if(url=="NONE") {
			model.addAttribute("LOGIN_FAIL","LOGIN_REQ");
		}
		model.addAttribute("BODY","LOGIN");
		return "home";
	}
	
	@RequestMapping(value="/login",method=RequestMethod.POST)
	public String login(MemberVO memberVO,Model model,HttpSession session) {
		
		memberVO = memService.login(memberVO,model);
		if(memberVO == null) {
			model.addAttribute("BODY","LOGIN");
			return "home";
		}else {			
			session.setAttribute("MEMBER", memberVO);			
			return "redirect:/";
		}
	}
	
	@RequestMapping(value="/logout",method=RequestMethod.GET)
	public String logout(HttpSession session) {
		session.removeAttribute("MEMBER");
		return "redirect:/";
	}
	
}