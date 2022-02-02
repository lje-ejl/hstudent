package kr.kosmo.jobkorea.adm.controller;

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
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.kosmo.jobkorea.adm.model.RegisterListControlModel;
import kr.kosmo.jobkorea.adm.service.RegistrerListControlService;
import kr.kosmo.jobkorea.common.comnUtils.ComnCodUtil;
import kr.kosmo.jobkorea.cur.model.CourseModel;
import kr.kosmo.jobkorea.login.model.RegisterInfoModel;
import kr.kosmo.jobkorea.system.model.ComnCodUtilModel;



@Controller
@RequestMapping("/adm/")
public class registerListControlContorller {

	
	@Autowired
	RegistrerListControlService regListService;
	
	// Set logger
	private final Logger logger = LogManager.getLogger(this.getClass());

	// Get class name for logger
	private final String className = this.getClass().toString();
	
	//강의 목록 관리 메인!
	@RequestMapping("registerListControl.do")
	public String registerList(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception {
		
		logger.info("강의 목록 관리 메인 " + className + ".registerList");
		logger.info("강의 목록 관리 메인 - paramMap : " + paramMap);
		
		//강의 리스트 뿌리기
		List<RegisterListControlModel>list_lec = regListService.list_lec(paramMap);
		List<RegisterListControlModel>tutor_list = regListService.tutor_list(paramMap);
		
		//강의 인서트 option select 보이기 
		model.addAttribute("tutor_list", tutor_list);
		List<RegisterListControlModel>list_rm = regListService.listLecrm(paramMap);
		//resultMap.put("list_rm",list_rm);
		model.addAttribute("list_rm", list_rm);
		
		
		return "adm/learn_mng/registerListControl";
	}
	
	
	//강의 목록 리스트 조회~!
	@RequestMapping("listLec.do")
	@ResponseBody
	public Map<String, Object>listLec(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception {
		
		logger.info("강의 목록 리스트 " + className + ".listLec");
		logger.info("paramMap : " + paramMap);
		
		int currentPage = Integer.parseInt((String)paramMap.get("currentPage"));	// 현재 페이지 번호
		int pageSize = Integer.parseInt((String)paramMap.get("pageSize"));			// 페이지 사이즈
		int pageIndex = (currentPage-1)*pageSize;									// 페이지 시작 row 번호
		
		
		logger.info("   - currentPage : " + currentPage);
		logger.info("   - pageSize : " + pageSize);
		logger.info("   - pageIndex : " + pageIndex);
		
		paramMap.put("pageIndex", pageIndex);
		paramMap.put("pageSize", pageSize);
		
		//검색 조건 확인!
		String searchKey = (String) paramMap.get("searchKey");
		String searchWord = (String) paramMap.get("searchWord");

		paramMap.put("searchKey", searchKey);
		paramMap.put("searchWord", searchWord);
		
		Map<String, Object> resultMap = new HashMap<String, Object>();

		List<RegisterListControlModel>list_lec = regListService.list_lec(paramMap);

		//페이징을 위한 강의 수 목록
		int totalCount = regListService.cnt_list_lec(paramMap);
		
		resultMap.put("totalCount", totalCount);		
		resultMap.put("pageSize", pageSize);
		resultMap.put("list_lec",list_lec);
		
		return resultMap;
	}	

	
	/**
	 * 학생 목록 조회
	 */
	@RequestMapping("listStd.do")
	@ResponseBody
	public Map<String, Object> liststudent(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception {
		
		
		logger.info("학생 목록 조회 " + className + ".list_std");
		logger.info("   - paramMap : " + paramMap);
		
		int currentPage = Integer.parseInt((String)paramMap.get("currentPage"));	// 현재 페이지 번호
		int pageSize = Integer.parseInt((String)paramMap.get("pageSize"));			// 페이지 사이즈
		int pageIndex = (currentPage-1)*pageSize;												// 페이지 시작 row 번호
		int lec_id = Integer.parseInt((String)paramMap.get("lec_id"));
		
		paramMap.put("pageIndex", pageIndex);
		paramMap.put("pageSize", pageSize);
		paramMap.put("lec_id",lec_id);
		
		Map<String, Object> resultMap = new HashMap<String, Object>();
		// 학생 목록 조회
		List<RegisterInfoModel> list_std = regListService.list_std(paramMap);
		resultMap.put("list_std",list_std);

		// 학생 목록 카운트 조회
		int totalCount = regListService.cnt_list_std(paramMap);
		resultMap.put("totalCount", totalCount);
		
		resultMap.put("pageSize", pageSize);
		resultMap.put("currentPageCourse",currentPage);
		resultMap.put("lec_id", lec_id);

		return resultMap;
		
	}		
	
	/**
	 *  과정 저장
	 */
	@RequestMapping("saveLec.do")
	@ResponseBody
	public Map<String, Object> saveCourse(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception {
		
		logger.info("과정저장" + className + ".saveCourse");
		logger.info("   - paramMap : " + paramMap);
		
		String action = (String)paramMap.get("action");
		String result = "SUCCESS";
		String resultMsg = "저장 되었습니다.";
		
		if ("I".equals(action)) {
			// 과정 신규 저장
			regListService.insert_lec(paramMap);
		} else if("U".equals(action)) {
			// 과정 수정 저장
			regListService.update_lec(paramMap);
		} else {
			result = "FALSE";
			resultMsg = "알수 없는 요청입니다.";
		}
		
		Map<String, Object> resultMap = new HashMap<String, Object>();
		resultMap.put("result", result);
		resultMap.put("resultMsg", resultMsg);
		
		logger.info("+ End " + className + "saveLec.do");
		
		return resultMap;
	}

	@RequestMapping("delLec.do")
	@ResponseBody
	public Map<String, Object> del_lec(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception {
		
		logger.info("+ Start " + className + ".delLec");
		logger.info("   - paramMap : " + paramMap);

		String result = "SUCCESS";
		String resultMsg = "삭제 되었습니다.";

		try {
			regListService.del_lec(paramMap);
		}catch(Exception e){
			 result = "FALSE";
			 resultMsg = "알수 없는 요청 입니다.";
		}
		
		Map<String, Object> resultMap = new HashMap<String, Object>();
		resultMap.put("result", result);
		resultMap.put("resultMsg", resultMsg);
		
		logger.info("+ End " + className + ".deleteComnGrpCod");
		
		return resultMap;
	}
	
	
	/**
	 *  과정 단건 조회
	 */
	@RequestMapping("lecSel.do")
	@ResponseBody
	public Map<String, Object> lec_sel (Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception {
		
		logger.info("강의 단건 조회 " + className + ".lec_sel");
		logger.info("   - paramMap : " + paramMap);

		String result = "SUCCESS";
		String resultMsg = "조회 되었습니다.";
		/*int lec_id = Integer.parseInt((String)paramMap.get("lec_id"));
		paramMap.put("lec_id",lec_id);*/
		
		RegisterListControlModel sel_lec = regListService.sel_lec(paramMap);
		
		Map<String, Object> resultMap = new HashMap<String, Object>();
		resultMap.put("result", result);
		resultMap.put("resultMsg", resultMsg);
		resultMap.put("sel_lec", sel_lec);
		/*resultMap.put("lec_id", lec_id);*/
		
		
		
		
		logger.info("+ End " + className + ".coursesel");
		
		return resultMap;
	}
	

	
	
	
}
