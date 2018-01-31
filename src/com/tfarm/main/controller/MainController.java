package com.tfarm.main.controller;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import org.eclipse.jdt.internal.compiler.ast.ReturnStatement;
import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;
import com.tfarm.board.model.BoardDto;
import com.tfarm.board.model.ReboardDto;
import com.tfarm.board.model.TicketDto;
import com.tfarm.board.service.BoardService;
import com.tfarm.board.service.MainService;
import com.tfarm.board.service.ReboardService;
import com.tfarm.board.service.TicketService;
import com.tfarm.common.service.CommonService;
import com.tfarm.util.BoardConstance;
import com.tfarm.util.PageNavigation;
import com.tfarm.util.StringEncoder;

@Controller
@RequestMapping("/main")
public class MainController {
	
	@Autowired
	private MainService mainService;
	
	@Autowired
	private BoardService boardService;
	
	@Autowired
	private ReboardService reboardService;
	
	@Autowired
	private TicketService ticketService;
	
	@Autowired
	private CommonService commonService;
	
	@RequestMapping(value="totallist.tfarm")
	public @ResponseBody String totallist(){
		List<BoardDto> blist = mainService.boardlist();
		
		JSONObject json = new JSONObject();
		JSONArray jarray = new JSONArray();
		for(BoardDto boardDto : blist){
			JSONObject board = new JSONObject();
			board.put("subject", StringEncoder.urlUtf(boardDto.getSubject()).replaceAll("\\+", "%20"));
			board.put("id", boardDto.getId());
			board.put("hit", boardDto.getHit());
			board.put("seq", boardDto.getSeq());
			board.put("bcode",boardDto.getBcode());

			jarray.add(board);
		}
		
		json.put("blist", jarray);
		return json.toJSONString();
	}
	
	@RequestMapping(value="totallist1.tfarm")
	public @ResponseBody String totallist1(){
		List<BoardDto> nlist = mainService.noticelist();
		
		JSONObject json = new JSONObject();
		JSONArray jarray = new JSONArray();
		for(BoardDto boardDto : nlist){
			JSONObject board = new JSONObject();
			board.put("subject", StringEncoder.urlUtf(boardDto.getSubject()).replaceAll("\\+", "%20"));
			board.put("id", boardDto.getId());
			board.put("hit", boardDto.getHit());
			board.put("seq", boardDto.getSeq());
			board.put("bcode",boardDto.getBcode());						
			jarray.add(board);
		}
		
		json.put("nlist", jarray);
		return json.toJSONString();
	}
	
	@RequestMapping(value="totallist2.tfarm")
	public @ResponseBody String totallist2(){
		List<TicketDto> tlist = mainService.ticketlist();
		
		JSONObject json = new JSONObject();
		JSONArray jarray = new JSONArray();
		for(TicketDto ticketDto : tlist){
			JSONObject ticket = new JSONObject();
			ticket.put("subject", StringEncoder.urlUtf(ticketDto.getSubject()).replaceAll("\\+", "%20"));
			ticket.put("id", ticketDto.getId());
			ticket.put("hit", ticketDto.getHit());
			ticket.put("seq", ticketDto.getSeq());
			ticket.put("bcode",ticketDto.getBcode());
			ticket.put("savafolder", ticketDto.getSavefolder());
			ticket.put("save_picture", ticketDto.getSave_picture());
			jarray.add(ticket);	
		}
		json.put("tlist", jarray);
		return json.toJSONString();
	}
	
	
	@RequestMapping(value="view.tfarm")
	public ModelAndView view(String seq){
		//공지
		ModelAndView mav = new ModelAndView();
		int seq1 = Integer.parseInt(seq);
		BoardDto boardDto = boardService.viewArticle(seq1);
		mav.setViewName("/WEB-INF/notice/view");
		mav.addObject("article", boardDto);

		return mav;
	}
	
	@RequestMapping(value="boardview.tfarm")
	public ModelAndView boardview(String seq){
		ModelAndView mav = new ModelAndView();
		int seq1 = Integer.parseInt(seq);
		ReboardDto reboardDto = reboardService.viewArticle(seq1);
		mav.setViewName("/WEB-INF/reboard/view");
		mav.addObject("article", reboardDto);
		
		return mav;

	}
	
	@RequestMapping(value="ticketview.tfarm")
	public ModelAndView ticketview(String seq){
		ModelAndView mav = new ModelAndView();
		int seq1 = Integer.parseInt(seq);
		TicketDto ticketDto = ticketService.viewArticle(seq1);
		System.out.println(ticketDto.getSubject());
		mav.setViewName("/WEB-INF/ticketboard/view");
		mav.addObject("article", ticketDto);
		return mav;
	}
	
	@RequestMapping(value = "/search.tfarm", method = RequestMethod.GET)
	public ModelAndView list(@RequestParam Map<String, String> map, HttpServletRequest request) {
		ModelAndView mav = new ModelAndView();
		String category = commonService.getCategory(Integer.parseInt(map.get("bcode")));
		List<TicketDto> list = ticketService.listArticle(map);
		System.out.println("첫번재"+map.get("bcode"));
		map.put("listsize", BoardConstance.BOARD_LIST_SIZE + "");
		PageNavigation navigation = commonService.makePageNavigation(map);
		navigation.setRoot(request.getContextPath());
		navigation.setBcode(Integer.parseInt(map.get("bcode")));
		navigation.setKey(map.get("key"));
		navigation.setWord(map.get("word"));
		navigation.setNavigator();
		mav.addObject("articlelist", list);
		mav.addObject("navigator", navigation);
		mav.addObject("querystring", map);
		mav.addObject("category", category);
		mav.setViewName("/WEB-INF/ticketboard/list");
		return mav;
	}
	
}
