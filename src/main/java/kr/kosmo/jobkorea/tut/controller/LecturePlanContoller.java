package kr.kosmo.jobkorea.tut.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.PostConstruct;
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

import kr.kosmo.jobkorea.adm.model.RegisterListControlModel;
import kr.kosmo.jobkorea.cur.model.CourseModel;
import kr.kosmo.jobkorea.login.model.UserInfo;
import kr.kosmo.jobkorea.system.model.ComnGrpCodModel;
import kr.kosmo.jobkorea.tut.model.AdviceModel;
import kr.kosmo.jobkorea.tut.model.LecturePlanModel;
import kr.kosmo.jobkorea.tut.service.AdviceService;
import kr.kosmo.jobkorea.tut.service.LecturePlanService;

@Controller
@RequestMapping("/tut/")
public class LecturePlanContoller {

	@Autowired
	LecturePlanService plan_sv;

	// Set logger
	private final Logger logger = LogManager.getLogger(this.getClass());

	// Get class name for logger
	private final String className = this.getClass().toString();

	/**
	 * 강의계획서 초기화면
	 */

	@RequestMapping("lecturePlan.do")
	public String tutor_lec_list(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) {
		paramMap.put("tutor_id", session.getAttribute("loginId"));

		// 강의 리스트 가져오기
		List<LecturePlanModel> mlist_lec = plan_sv.mlec_list(paramMap);
		model.addAttribute("mlist_lec", mlist_lec);
		logger.info("lec_list:" + mlist_lec);

		return "tut/learn_sup/lecture_plan/lecture_plan";
	}

	/* 강의 리스트 */
	@RequestMapping("Plist_lec.do")
	public String lec_list(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception {

		paramMap.put("tutor_id", session.getAttribute("loginId"));
		int currentPage = Integer.parseInt((String) paramMap.get("currentPage")); 
		int pageSize = Integer.parseInt((String) paramMap.get("pageSize")); 
		int pageIndex = (currentPage - 1) * pageSize;
		String searchWord = (String) paramMap.get("searchWord");
		logger.info("+ Start " + className + ".lec_list");
		logger.info("   - paramMap : " + paramMap);

		paramMap.put("pageIndex", pageIndex);
		paramMap.put("pageSize", pageSize);
		paramMap.put("searchWord_lec", searchWord);

		logger.info("   - putparamMap : " + paramMap);

		// 강의 리스트 가져오기
		List<LecturePlanModel> list_lec = plan_sv.tutor_lec_list(paramMap);
		model.addAttribute("list_lec", list_lec);
		logger.info("lec_list:" + list_lec);

		// 강의 목록 카운트 조회
		int totalCount = plan_sv.countList_lec(paramMap);
		model.addAttribute("totalCnt", totalCount);
		model.addAttribute("pageSize", pageSize);
		model.addAttribute("currentPage", currentPage);

		logger.info("+ End " + className + ".lec_list");

		return "tut/learn_sup/lecture_plan/lecList";
	}

	// 모달 강의정보
	@RequestMapping("Pmlec_info.do")
	@ResponseBody
	public Map<String, Object> select_adv(Model model, @RequestParam Map<String, Object> paramMap,
			HttpServletRequest request, HttpServletResponse response, HttpSession session) throws Exception {

		logger.info("+ Start " + className + ".selectComnGrpCod");
		logger.info("   - paramMap : " + paramMap);

		String result = "SUCCESS";
		String resultMsg = "조회 되었습니다.";
		
		// 모달창 강의정보 출력
		LecturePlanModel lec_info = plan_sv.plan_one(paramMap);
		//주차 계획 리스트 출력
		List<LecturePlanModel> week_plan=plan_sv.week_list(paramMap);

		Map<String, Object> resultMap = new HashMap<String, Object>();
		resultMap.put("result", result);
		resultMap.put("resultMsg", resultMsg);
		resultMap.put("lec_info", lec_info);
		resultMap.put("week_plan", week_plan);

		logger.info("+ End " + className + ".selectComnGrpCod");

		return resultMap;
	}
	
	//계획서 저장
	@RequestMapping("save_plan.do")
	@ResponseBody
	public Map<String, Object> save_advice(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception {
		
		logger.info("+ Start " + className + ".save_advice");
		logger.info("   - paramMap : " + paramMap);
		String result = "SUCCESS";
		String resultMsg = "저장 되었습니다.";
		
		// 그룹코드 신규 저장
		plan_sv.plan_register(paramMap);
	
		
		
		Map<String, Object> resultMap = new HashMap<String, Object>();
		resultMap.put("result", result);
		resultMap.put("resultMsg", resultMsg);
		
		logger.info("+ End " + className + ".save_advice");
		
		return resultMap;
	}
	
	//주간계획 저장
	@RequestMapping("week_plan_insert.do")
	@ResponseBody
	public Map<String, Object> week_plan_insert(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session,@RequestParam(value="week[]") List<String> week,@RequestParam(value="learn_goal[]") List<String> learn_goal,@RequestParam(value="learn_con[]") List<String> learn_con) throws Exception {
		
		//List<LecturePlanModel> plist = new ArrayList<>();
		logger.info("week:"+week);
		logger.info("learn_goal:"+learn_goal);
		logger.info("learn_con:"+learn_con);

		
		for (int i = 0; i < week.size(); i++) {
			paramMap.put("week",week.get(i));
			paramMap.put("learn_goal",learn_goal.get(i));
			paramMap.put("learn_con",learn_con.get(i));
			
			//체크해서 값이 없으면 insert 있으면 수정
			if(plan_sv.chk_week(paramMap)>0){
				plan_sv.week_up(paramMap);
			}else{
				plan_sv.week_register(paramMap);
			}
			
		}
		
		logger.info("+ Start " + className + ".save_advice");
		logger.info("   - paramMap : " + paramMap);
		String result = "SUCCESS";
		String resultMsg = "저장 되었습니다.";
		
	
		
		Map<String, Object> resultMap = new HashMap<String, Object>();
		resultMap.put("result", result);
		resultMap.put("resultMsg", resultMsg);
		
		logger.info("+ End " + className + ".save_advice");
		
		return resultMap;
	}
	
	//주간 계획삭제
		@RequestMapping("week_plan_del.do")
		@ResponseBody
		public Map<String, Object> deleteComnDtlCod(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
				HttpServletResponse response, HttpSession session) throws Exception {
			
			logger.info("+ Start " + className + ".deleteComnDtlCod");
			logger.info("   - paramMap : " + paramMap);

			String result = "SUCCESS";
			String resultMsg = "삭제 되었습니다.";
			
			// 상세코드 삭제
			plan_sv.week_del(paramMap);
			
			Map<String, Object> resultMap = new HashMap<String, Object>();
			resultMap.put("result", result);
			resultMap.put("resultMsg", resultMsg);
			
			logger.info("+ End " + className + ".deleteComnDtlCod");
			
			return resultMap;
		}
	
	

}