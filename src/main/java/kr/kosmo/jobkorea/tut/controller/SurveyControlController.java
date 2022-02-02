package kr.kosmo.jobkorea.tut.controller;
import java.util.ArrayList;
import java.util.Collection;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.ListIterator;
import java.util.Map;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.google.gson.Gson;

import kr.kosmo.jobkorea.tut.model.Que;
import kr.kosmo.jobkorea.tut.model.SurveyControlModel;
import kr.kosmo.jobkorea.tut.service.SurveyControlService;

/* 정수빈 작업 */
@Controller
@RequestMapping("/tut")
public class SurveyControlController {
	
	@Autowired
	SurveyControlService surveyControlService;
	
	
	// 페이지 로딩
	@RequestMapping("b_surveyControl.do")
	public String surveyControl(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request, HttpServletResponse response, HttpSession session) throws Exception{
		return "/tut/cmnt/survery/surveyControl";
	}
	
	
	// 강의 목록 출력한 HTML 반환
	@RequestMapping("surveyList.do")
	public String surveyList(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request, HttpServletResponse response, HttpSession session) throws Exception{
		paramMap.put("tutor_id", session.getAttribute("loginId"));
		
		// 페이징
		int currentPage = Integer.parseInt((String)paramMap.get("currentPage"));	
		int pageSize    = Integer.parseInt((String)paramMap.get("pageSize"));	   
		int pageIndex   = (currentPage-1)*pageSize;
		paramMap.put("pageIndex", pageIndex);
		paramMap.put("pageSize" , pageSize);
		
		// 강의 목록
		List<SurveyControlModel> surveyList = surveyControlService.lecture_List_Select(paramMap);
		
		// 강의 개수
		int survey_Total = (surveyControlService.lecture_Cnt_Select(paramMap)).getTut_Total();
		model.addAttribute("survey_Total" ,survey_Total );
		model.addAttribute("surveyList",surveyList);
		
		return "/tut/cmnt/survery/surveyControl1";
	}
	
	
	// 설문 
	@RequestMapping("survey.do")
	@ResponseBody
	public Map<String, Object> surveyControl1(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request, HttpServletResponse response, HttpSession session) throws Exception{
		
		Map<String, Object> resultMap = new HashMap<String, Object>();
		SurveyControlModel result = surveyControlService.srvy_Que_Select(paramMap);
		
		// 문제
		String que = result.getQue();
		
		// 보기 문항/통계
		List<Que> List = new ArrayList<Que>();
		
		Que Q = new Que();
		Q.setSValue(result.getAnswer_1());
		Q.setIValue(Integer.parseInt(result.getSum_1()));
		List.add(Q);
		
		Que Q1 = new Que();
		Q1.setSValue(result.getAnswer_2());
		Q1.setIValue(Integer.parseInt(result.getSum_2()));
		List.add(Q1);
		
		Que Q2 = new Que();
		Q2.setSValue(result.getAnswer_3());
		Q2.setIValue(Integer.parseInt(result.getSum_3()));
		List.add(Q2);
		
		Que Q3 = new Que();
		Q3.setSValue(result.getAnswer_4());
		Q3.setIValue(Integer.parseInt(result.getSum_4()));
		List.add(Q3);
		
		Que Q4 = new Que();
		Q4.setSValue(result.getAnswer_5());
		Q4.setIValue(Integer.parseInt(result.getSum_5()));
		List.add(Q4);
		
		resultMap.put("que", que);
		resultMap.put("result", List);
		
		return resultMap;
	}
	
	
	// 수업 후기
	@RequestMapping("surveryDetail10.do")
	public String surveryDetail10(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request, HttpServletResponse response, HttpSession session) throws Exception{
		
		int currentPage = Integer.parseInt((String)paramMap.get("currentPage"));	
		int pageSize    = Integer.parseInt((String)paramMap.get("pageSize"));	    
		int pageIndex   = (currentPage-1)*pageSize;								    
		paramMap.put("pageIndex", pageIndex);
		paramMap.put("pageSize" , pageSize);
		
		List<SurveyControlModel> survey10 = surveyControlService.c_srvy_Que10_Select(paramMap) ;
		int survery10_Total = surveyControlService.c_srvy_Que10_Num_Select(paramMap).getSurvery10_Total();

		model.addAttribute("survey10",survey10);
		model.addAttribute("survery10_Total",survery10_Total);
		
		return "/tut/cmnt/survery/surveyControl2";
	}
}
