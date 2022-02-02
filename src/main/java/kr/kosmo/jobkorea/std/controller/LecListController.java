package kr.kosmo.jobkorea.std.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;
import org.apache.poi.util.SystemOutLogger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import kr.kosmo.jobkorea.std.model.LecListModel;
import kr.kosmo.jobkorea.std.service.LecListService;


@SuppressWarnings("unused")
@Controller
@RequestMapping("/std/")
public class LecListController {

	/* 2020.11.13 임지은 
	 * Autowired는 팔짱이다!(연결고리)
	 * MVC(Model, View, Controller)패턴에서 
	 * controller는 service와 팔짱
	 * service는 dao와 팔짱!
	 * service는 controller와 dao사이에서 왔다갔다하면서 서빙하는 역할.
	 * */	
	@Autowired
	LecListService lecListService;	
	// Set logger
	private final Logger logger = LogManager.getLogger(this.getClass());

	// Get class name for logger
	private final String className = this.getClass().toString();

	
	//초기화면
	@RequestMapping("lectureList.do")
	public String init(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception {
		
		//List<LecListModel> listLec = lecListService.listLec(paramMap);
		//model.addAttribute("listLec", listLec);


		return "std/learn_sup/LectureList";
	}
	

	//과목 리스트 불러오기
	@RequestMapping("selectLecList.do")
	public String searchLec(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception {
	/*	
		String lec_name = (String) request.getAttribute("keyword");
		paramMap.put("lec_name",lec_name);
		lecListService.searchLec(paramMap);
		
		List<LecListModel> searchLec = lecListService.searchLec(paramMap);
		model.addAttribute("searchLec", searchLec);*/
		
		int currentPage = Integer.parseInt((String) paramMap.get("currentPage")); // 현재페이지
	    int pageSize = Integer.parseInt((String) paramMap.get("pageSize"));
	    int pageIndex = (currentPage - 1) * pageSize;
		
		paramMap.put("pageIndex", pageIndex);
		paramMap.put("pageSize", pageSize);
		
		
		
		System.out.println("doskdosk"+paramMap);
		List<LecListModel> listLec = lecListService.listLec(paramMap);
		
		int totalCount = lecListService.countListLec(paramMap);
		
		model.addAttribute("listLec", listLec);
	    model.addAttribute("totalCntLec", totalCount);
	    model.addAttribute("pageSize", pageSize);
	    model.addAttribute("currentPageLec",currentPage);
	    
	    
		return "std/learn_sup/LectureListCallback";
	}
	
	//과목 상세조회
	@RequestMapping("detailLecList.do")
	public String lectureInfo(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception {
		
		String loginID = (String) session.getAttribute("loginId");
		paramMap.put("loginID", loginID);
		
		LecListModel lecInfo = lecListService.lecInfo(paramMap);
		List<LecListModel> lecWeekPlan = lecListService.lecWeekPlan(paramMap);
		LecListModel idCheck = lecListService.idCheck(paramMap);
		
		model.addAttribute("lecInfo", lecInfo);
		model.addAttribute("lecWeekPlan", lecWeekPlan);
		model.addAttribute("idCheck", idCheck);
		
		
		
				
		return "std/learn_sup/LectureListCallback1";
	}
	
	//수강신청
	@RequestMapping("applyLecture.do")
	@ResponseBody
	public Map<String, Object> applyLec(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session)throws Exception{
		
		String loginID = (String) session.getAttribute("loginId");
		paramMap.put("loginID", loginID);
		
		LecListModel numCheck = lecListService.numCheck(paramMap);
		
		Map<String, Object> resultMap = new HashMap<String, Object>();
		
		
		if ((numCheck.getPre_pnum()<numCheck.getMax_pnum())){
		
			//1이 온다
			int applyVal = lecListService.lecApply(paramMap);
			int applyVal2 = lecListService.lecApply2(paramMap);
		
		
		resultMap.put("result","수강신청이 완료되었습니다.");
		}
		
		else
		{
			resultMap.put("result","최대 수강인원보다 많은 인원이 신청할 수 없습니다.");
		}
		
		
		return resultMap;
	}
	
	//수강취소
	@RequestMapping("cancelLecture.do")
	@ResponseBody
	public Map<String, Object> cancelLec(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session)throws Exception{
		
		String loginID = (String) session.getAttribute("loginId");
		paramMap.put("loginID", loginID);
		int lec_id = Integer.parseInt((String) paramMap.get("lec_id"));
		
		LecListModel okCheck = lecListService.okCheck(paramMap);
		LecListModel idCheck = lecListService.idCheck(paramMap);
		
		Map<String, Object> resultMap = new HashMap<String, Object>();
		
		
		
		if (lec_id == idCheck.getLec_id() && okCheck.getApv().equals("N")){
		
			//1이 온다
			int cancelVal = lecListService.lecCancel(paramMap);
			int cancelVal2 = lecListService.lecCancel2(paramMap);
			
			System.out.println(lec_id);
			System.out.println(idCheck.getLec_id());
			System.out.println(okCheck.getApv());
			
		
		
		resultMap.put("result","수강취소가 완료되었습니다.");
		}
		
		else {
			resultMap.put("result","수강취소가 불가능합니다.");
		}
		
		
		return resultMap;
	}

}
