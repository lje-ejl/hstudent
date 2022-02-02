package kr.kosmo.jobkorea.std.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.kosmo.jobkorea.std.model.RegisterListModel;
import kr.kosmo.jobkorea.std.model.SurveyListModel;
import kr.kosmo.jobkorea.std.service.RegisterListService; 

@Controller
@RequestMapping("/std")
public class RegisterListController {

	@Autowired
	RegisterListService registerListService;
	
	private final Logger logger = LogManager.getLogger(this.getClass());
	private final String className = this.getClass().toString();
	
	//수강목록 화면 이동
	@RequestMapping("/registerList.do")
	public String registerList (Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception{
		logger.info("+ Start " + className + ".registerList");
		logger.info("   - paramMap : " + paramMap);
		
		return "/std/learn_mng/registerList";
	}
	
	//수강목록 data가져오기
	@RequestMapping("/registerListSel.do")
	@ResponseBody
	public Map<String, Object> registerListSel (Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception {
		//세션에서 로그인 값 가져오기.
		String std_id = (String) session.getAttribute("loginId");
		paramMap.put("loginID", std_id);
	
		logger.info("+ Start " + className + ".registerListSel");
		logger.info("   - paramMap : " + paramMap);
		 
		String result = "SUCCESS";
		String resultMsg = "조회 되었습니다.";
		
		Map<String, Object> resultMap = new HashMap<String, Object>();
		
		int totalCnt = registerListService.totalCnt(paramMap);
		//data가 있을때
		if(totalCnt == 1 ){
			RegisterListModel registermodel = registerListService.regListModel(paramMap);
			paramMap.put("lec_id", registermodel.getLec_id());
			RegisterListModel registercount = registerListService.regListCount(paramMap);
			resultMap.put("registermodel", registermodel);
			resultMap.put("registercount", registercount);
			resultMap.put("totalCnt", totalCnt);
			resultMap.put("result", result);
			resultMap.put("resultMsg", resultMsg);
		}else{
			resultMap.put("totalCnt", totalCnt);
		}
		
		//System.out.println("래지스터어" + registermodel.getLec_id());
		
		//resultMap.put("registermodel", registermodel);
		//resultMap.put("registercount", registercount);
		
		return resultMap;
	}
	//설문조사 모달 data
	@RequestMapping("/surveySubmit.do")
	public String surveySubmit (Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception{
		String std_id = (String) session.getAttribute("loginId");
		paramMap.put("loginID", std_id);
		
		int currentPage = Integer.parseInt((String)paramMap.get("currentPage"));	// 현재 페이지 번호
		int pageSize = Integer.parseInt((String)paramMap.get("pageSize"));			// 페이지 사이즈
		int pageIndex = (currentPage-1)*pageSize;									// 페이지 시작 row 번호
				
		paramMap.put("pageIndex", pageIndex);
		paramMap.put("pageSize", pageSize);
		
		List<SurveyListModel> surveyListModel = registerListService.srvyqueList(paramMap); //설문내용 조회
		int totalCount = registerListService.countsrvyList(paramMap);  //카운트
		
		logger.info("+ Start " + className + ".surveySubmit");
		logger.info("   - paramMap : " + paramMap);
		
		model.addAttribute("surveyList", surveyListModel);
		model.addAttribute("totalCount", totalCount);
		
		model.addAttribute("pageSize",pageSize);
		model.addAttribute("currentPage",currentPage);
		
		logger.info("+ End " + className + ".surveySubmit");
		
		return "/std/learn_mng/surveyList";
	}
	
	@RequestMapping("/surveyInsert.do")
	@ResponseBody
	public Map<String, Object> surveyInsert (Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception {	
		String std_id = (String) session.getAttribute("loginId");
		paramMap.put("loginID", std_id);
		
		logger.info("+ Start " + className + ".surveyInsert");
		logger.info("   - paramMap : " + paramMap);
		
		Map<String, Object> resultMap = new HashMap<String, Object>();
		
		registerListService.srvyQueSub(paramMap); //설문답
		registerListService.srvyReview(paramMap); //리뷰리뷰 입력
		registerListService.stdSrvy_chk(paramMap); //설문 상태 업데이트 
		
		resultMap.put("result", "SUCCESS");
		
		logger.info("+ End " + className + ".surveyInsert");

		return resultMap;
	}
	
	
}
