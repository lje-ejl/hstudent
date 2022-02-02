package kr.kosmo.jobkorea.adm.controller;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
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

import kr.kosmo.jobkorea.adm.model.c_SurveyControlModel;
import kr.kosmo.jobkorea.adm.service.c_SurveyControlService;
import kr.kosmo.jobkorea.adm.model.Que;

/* 정수빈 작업 */
@Controller
@RequestMapping("/adm")
public class c_SurveyControlController {
	 
	@Autowired
	c_SurveyControlService c_surveyControlService;
	
	
	// 페이지 로딩
	@RequestMapping("c_surveyControl.do")
	public String c_surveyControl(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request, HttpServletResponse response, HttpSession session) throws Exception{
		
		return "/adm/learn_mng/survery/c_surveyControl";
	}
	
	
	// 강사 리스트
	@RequestMapping("c_surveyControl1.do")
	public String c_surveyControl1(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request, HttpServletResponse response, HttpSession session) throws Exception{
		
		int currentPage = Integer.parseInt((String)paramMap.get("currentPage"));	
		int pageSize    = Integer.parseInt((String)paramMap.get("pageSize"));	    
		int pageIndex   = (currentPage-1)*pageSize;								    
		
		paramMap.put("pageIndex", pageIndex);
		paramMap.put("pageSize", pageSize);
		
		// 강의 목록
		List<c_SurveyControlModel> tutor_List = c_surveyControlService.tut_List_Select(paramMap);
		
		// 강의 총 개수
		int tut_Total = (c_surveyControlService.tut_Cnt_Select(paramMap)).getTut_Total();
		
		model.addAttribute("tutor_List",tutor_List);
		model.addAttribute("tut_Total" ,tut_Total );
		return "/adm/learn_mng/survery/c_surveyControl1";
	}
	
	
	// 강의 리스트
	@RequestMapping("c_lecList.do")
	public String c_surveryDetail(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request, HttpServletResponse response, HttpSession session) throws Exception{
		
		int currentPage = Integer.parseInt((String)paramMap.get("currentPage"));	
		int pageSize    = Integer.parseInt((String)paramMap.get("pageSize"));	    
		int pageIndex   = (currentPage-1)*pageSize;								    
		paramMap.put("pageIndex", pageIndex);
		paramMap.put("pageSize", pageSize);
		
		// 강의 목록
		List<c_SurveyControlModel> lec_List = c_surveyControlService.lec_List_Select(paramMap);
		
		// 강의 개수
		int lec_Total = (c_surveyControlService.lec_Cnt_Select(paramMap)).getLec_Total();
		
		model.addAttribute("lec_List", lec_List);
		model.addAttribute("lec_Total" ,lec_Total );
		return "/adm/learn_mng/survery/c_surveyControl2";
	}
	
	
	// 설문조사 도표
	@RequestMapping("c_survey.do")
	@ResponseBody
	public Map<String, Object> surveryDetail(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request, HttpServletResponse response, HttpSession session) throws Exception{

		Map<String, Object> resultMap = new HashMap<String, Object>();
		c_SurveyControlModel result = c_surveyControlService.srvy_One_Select(paramMap);
		
		// 문제 
		String que = result.getQue();
		
		// 답안 항목 /통계
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
	
	
	// 설문조사 10번
	@RequestMapping("c_survery_Detail10.do")
	public String surveryDetail10(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request, HttpServletResponse response, HttpSession session) throws Exception{
		
		int currentPage = Integer.parseInt((String)paramMap.get("currentPage"));	
		int pageSize    = Integer.parseInt((String)paramMap.get("pageSize"));	    
		int pageIndex   = (currentPage-1)*pageSize;								    
		paramMap.put("pageIndex", pageIndex);
		paramMap.put("pageSize" , pageSize);
		
		List<c_SurveyControlModel> survey10 = c_surveyControlService.c_srvy_Que10_Select(paramMap);
		int survery10_Total = c_surveyControlService.c_srvy_Que10_Num_Select(paramMap).getSurvery10_Total();
		
		model.addAttribute("survey10",survey10);
		model.addAttribute("survery10_Total",survery10_Total);
		
		return "/adm/learn_mng/survery/c_surveyControl3";
	}
}