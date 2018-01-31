package com.tfarm.member.controller;

import java.util.List;
import java.util.Map;
import java.util.Random;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.tfarm.member.model.MemberDetailDto;
import com.tfarm.member.model.MemberDto;
import com.tfarm.member.model.ZipDto;
import com.tfarm.member.model.service.MailService;
import com.tfarm.member.model.service.MemberService;
import com.tfarm.util.StringEncoder;

import net.tanesha.recaptcha.ReCaptchaImpl;
import net.tanesha.recaptcha.ReCaptchaResponse;

@Controller
@RequestMapping("/user")
public class MemberController {
	
	@Autowired
	private MemberService memberService;
	
	@Autowired
	private MailService mailService;
	
	@RequestMapping(value="/join.tfarm", method=RequestMethod.GET)
	public String join() {
		return "redirect:/join/join.jsp";
	}
	
	@RequestMapping(value="/join.tfarm", method=RequestMethod.POST)
	public ModelAndView join(MemberDetailDto memberDetailDto) {
		ModelAndView mav = new ModelAndView();
		int cnt = memberService.pwCheck(memberDetailDto.getMem_id(), memberDetailDto.getMem_pw());
		String viewName = "/index";
		if(cnt != 1){
			int cntt = memberService.registerMember(memberDetailDto);
			if(cntt != 0) {
				mav.addObject("registerinfo", memberDetailDto);
				viewName = "/WEB-INF/join/registerok";
			}
		}
		mav.setViewName(viewName);
		return mav;
	}
	@RequestMapping(value="/email.tfarm", method=RequestMethod.POST)
	public @ResponseBody String send(HttpSession session,HttpServletRequest request, @RequestParam(value="email") String email){
		int randomCode = new Random().nextInt(1000) + 1000;
		String joinCode = String.valueOf(randomCode);
		String subject = "TFARM 회원가입 승인 번호 입니다.";
		StringBuilder sb = new StringBuilder();
		sb.append("회원가입 승인 번호는").append(joinCode).append("입니다.");		
		boolean result = mailService.send(subject, sb.toString(), "selre4824@gamil.com", email);
		JSONObject json = new JSONObject();
		json.put("result", result);
		json.put("joincode", joinCode);
		return json.toJSONString();
	}
	
	@RequestMapping(value="/email.tfarm", method=RequestMethod.GET)
	public @ResponseBody String send(HttpSession session,HttpServletRequest request, 
			@RequestParam(value="email") String email,
			@RequestParam(value="id") String id){
		JSONObject json = new JSONObject();
		int cnt = memberService.idCheck(id);
		if(cnt != 0){
			int randomCode = new Random().nextInt(100000) + 100000;
			String joinCode = String.valueOf(randomCode);
			String subject = "TFARM 임시  비밀번호 입니다.";
			StringBuilder sb = new StringBuilder();
			sb.append("임시 비밀번호는").append(joinCode).append("입니다.");		
			boolean result = mailService.send(subject, sb.toString(), "selre4824@gamil.com", email);
			int cnt1 = memberService.pwUpdate(id,joinCode);
			json.put("result", cnt1);
		}else{
			json.put("result", 0);
		}
		return json.toJSONString();
	}
	
	@RequestMapping(value="/jusopopup.tfarm")
	public String jusoPopup() {
		return "redirect:/join/jusoPopup.jsp";
	}
	
	@RequestMapping(value="/home.tfarm")
	public String home() {
		return "redirect:/index.jsp";
	}
	
	@RequestMapping(value="/pwcheck.tfarm")
	public ModelAndView confirmpass() {
		ModelAndView mav = new ModelAndView();
		mav.setViewName("/WEB-INF/mypage/confirmpass");
		return mav;
	}
	
	@RequestMapping(value="/mypage.tfarm")
	public ModelAndView mypage(@RequestParam(value="mem_id", required=true) String id, 
			@RequestParam(value="mem_pw", required=true) String pass) {
		ModelAndView mav = new ModelAndView();
		int cnt = memberService.pwCheck(id, pass);
		String viewName = "/WEB-INF/mypage/confirmpass";
		if(cnt !=0) {
			viewName = "/WEB-INF/mypage/mypage";
		}
		mav.setViewName(viewName);
		return mav;
	}
	
	@RequestMapping(value="/socialmypage.tfarm")
	public ModelAndView mypage() {
		ModelAndView mav = new ModelAndView();
		mav.setViewName("/WEB-INF/mypage/mypage");
		return mav;
	}
	
	@RequestMapping(value="/modifyPass.tfarm")
	public @ResponseBody String modifyPass(@RequestParam(value="mem_no", required=true) String number){
		String password = memberService.bringPw(number);
		JSONObject json = new JSONObject();
		json.put("pass", password);
		return json.toJSONString();
	}
	
	@RequestMapping(value="/infomodify.tfarm")
	public ModelAndView soInfomodify(MemberDetailDto memberDetailDto, HttpSession session){
		ModelAndView mav = new ModelAndView();
		int cnt = memberService.modify(memberDetailDto);
		String viewName = "/WEB-INF/mypage/mypage";
		if(cnt != 0){
			session.removeAttribute("userInfo");
			memberDetailDto = memberService.getSoInfo(memberDetailDto.getMem_no());
			session.setAttribute("userInfo", memberDetailDto);
			viewName = "/WEB-INF/mypage/mypage";			
		}
		mav.setViewName(viewName);
		return mav;
	}
	@RequestMapping(value="/login.tfarm", method=RequestMethod.GET)
	public String login() {
		return "redirect:/login/login.jsp";
	}
	
	@RequestMapping(value="/login.tfarm", method=RequestMethod.POST)
	public String login(@RequestParam(value="mem_id", required=true) String id,
			@RequestParam(value="mem_pw", required=true) String pass, HttpServletRequest request, HttpSession session) {
		String url = request.getHeader("referer");
		MemberDetailDto memberdetailDto = memberService.login(id, pass);
		session.setAttribute("userInfo", memberdetailDto);
		if(url.contains("login.jsp")) {
			url = "/index.jsp";
		}
		System.out.println("로그인 됬냐"+url);
		
		return "redirect:"+url;
	}
	@RequestMapping(value="/idfind.tfarm", method=RequestMethod.GET)
	public String idfind() {
		return "redirect:/login/idsearch.jsp";
	}
	@RequestMapping(value="/idfind.tfarm", method=RequestMethod.POST)
	public @ResponseBody String idfind(@RequestParam Map<String, String> map) {
		String name = memberService.idfind(map.get("name"),map.get("email").split("@")[0]);		
		JSONObject json = new JSONObject();
		json.put("name", name);		
		return json.toJSONString();
	}
	
	
	@RequestMapping(value="/social.tfarm", method=RequestMethod.POST)
	public String sociallogin(@RequestParam(value="semail", required=true) String semail,
			@RequestParam(value="sname",required=true) String sname, 
			@RequestParam(value="sid",required=true) String sid, HttpSession session){
		System.out.println("     뭐지???"+semail);
		String pass = sid; // 소셜은 우선 sid를 가지고 비밀번호를 찾는다.
		String name = sname;
		String email1 = semail.split("@")[0];		
		String email2 = semail.split("@")[1];
		String id = email1;
		MemberDetailDto memberdetailDto = memberService.socialLogin(pass);
		if(memberdetailDto != null){
			session.setAttribute("userInfo", memberdetailDto);
		}else{
			int regiok = memberService.socialRegister(id, pass,name,email1, email2);
			if(regiok != 0){				
				session.setAttribute("userInfo", memberdetailDto);			
			}else{
				System.out.println("카카오 등록실패");
			}
		}
		return "redirect:/index.jsp";		
	}
		
	@RequestMapping("/logout.tfarm")
	public String logout(HttpSession session) {
		session.removeAttribute("userInfo");
		return "redirect:/index.jsp";
	}

	@RequestMapping("/idcheck.tfarm")
	public @ResponseBody String idCheck(@RequestParam("sid") String sid) {
		int cnt = memberService.idCheck(sid);
		JSONObject json = new JSONObject();
		json.put("idcount", cnt);
		json.put("sid", StringEncoder.urlUtf(sid));
		return json.toJSONString();//{idcount : 0, sid : java2} << json
	}

//	@RequestMapping(value="/zipsearch.kitri",method=RequestMethod.GET)
//	public String zipSearch() {
//		return "redirect:/join/zipsearch.jsp";
//	}
//	
//	@RequestMapping(value="/zipsearch.kitri",method=RequestMethod.POST)
//	public @ResponseBody String zipSearch(@RequestParam("sdong") String sdong) {
//		System.out.println("검색동 : " + sdong);
//		List<ZipDto> list = memberService.zipSearch(sdong);
//		System.out.println("검색 갯수 : " + list.size());
//		JSONObject json = new JSONObject();
//		JSONArray jarray = new JSONArray();//[]
//		//[
//		//	{"zip1" : 123, "zip2" : 567, "sido" : "서울", "gugun" : "구로"}, 
//		//	{}, 
//		//	{}
//		//]
//		for(ZipDto zipDto : list) {
//			JSONObject zip = new JSONObject();//ZipDto
//			zip.put("zip1", zipDto.getZip1());
//			zip.put("zip2", zipDto.getZip2());
//			zip.put("sido", StringEncoder.urlUtf(zipDto.getSido()));
//			zip.put("gugun", StringEncoder.urlUtf(zipDto.getGugun()));
//			zip.put("dong", StringEncoder.urlUtf(zipDto.getDong()).replaceAll("\\+", "%20"));
//			zip.put("bunji", StringEncoder.urlUtf(zipDto.getBunji()).replaceAll("\\+", "%20"));
//			
//			jarray.add(zip);
//		}
//		//{"zlist" : [
//		//				{"zip1" : 123, "zip2" : 567, "sido" : "서울", "gugun" : "구로"}, 
//		//				{}, 
//		//				{}
//		//			 ]
//		//}
//		json.put("zlist", jarray);
//		System.out.println(json.toJSONString());
//		return json.toJSONString();
//	}
}















