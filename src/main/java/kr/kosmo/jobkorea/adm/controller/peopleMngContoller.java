package kr.kosmo.jobkorea.adm.controller;

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
import kr.kosmo.jobkorea.adm.service.lectureAdviceService;
import kr.kosmo.jobkorea.adm.service.peopleMngService;
import kr.kosmo.jobkorea.cur.model.CourseModel;
import kr.kosmo.jobkorea.login.model.RegisterInfoModel;
import kr.kosmo.jobkorea.login.model.UserInfo;
import kr.kosmo.jobkorea.login.service.RegisterService;
import kr.kosmo.jobkorea.system.model.ComnGrpCodModel;
import kr.kosmo.jobkorea.tut.model.AdviceModel;

import kr.kosmo.jobkorea.tut.service.AdviceService;

@Controller
@RequestMapping("/adm/")
public class peopleMngContoller {

	@Autowired
	peopleMngService pmg_sv;
	
	@Autowired
	RegisterService registerService;
	

	
	// Set logger
	private final Logger logger = LogManager.getLogger(this.getClass());

	// Get class name for logger
	private final String className = this.getClass().toString();

	/** 학생 관리 */

	
	@RequestMapping("studentControl.do")
	public String tutor_lec_list(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) {
		logger.info("   - paramMap : " + paramMap);

		return "adm/people_mng/stdMng/stdMng";
	}

	/* 강의 리스트 */
	@RequestMapping("plist_lec.do")
	public String lec_list(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception {

		int currentPage = Integer.parseInt((String) paramMap.get("currentPage")); // 현재
																					// 페이지
																					// 번호
		int pageSize = Integer.parseInt((String) paramMap.get("pageSize")); // 페이지
																			// 사이즈
		int pageIndex = (currentPage - 1) * pageSize;
		String searchWord_lec = (String) paramMap.get("searchWord_lec");
		logger.info("+ Start " + className + ".lec_list");
		logger.info("   - paramMap : " + paramMap);

		paramMap.put("pageIndex", pageIndex);
		paramMap.put("pageSize", pageSize);
		paramMap.put("searchWord_lec", searchWord_lec);

		logger.info("   - putparamMap : " + paramMap);

		// 강의 리스트 가져오기
		List<RegisterListControlModel> list_lec = pmg_sv.lec_list(paramMap);
		model.addAttribute("list_lec", list_lec);
		logger.info("lec_list:" + list_lec);

		// 강의 목록 카운트 조회
		int totalCount = pmg_sv.countList_lec(paramMap);
		model.addAttribute("totalCnt_lec", totalCount);
		model.addAttribute("pageSize", pageSize);
		model.addAttribute("currentPage_lec", currentPage);

		logger.info("   - totalCnt : " + totalCount);
		logger.info("   - pageSize : " + pageSize);
		logger.info("   - currentPage : " + currentPage);

		logger.info("+ End " + className + ".lec_list");

		return "adm/people_mng/stdMng/lecList";
	}

	/* 학생 리스트 */
	@RequestMapping("list_std.do")
	public String std_list(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception {
		logger.info("   - paramMap : " + paramMap);

		String searchKey_std = (String) paramMap.get("searchKey_std");
		String searchWord_std = (String) paramMap.get("searchWord_std");
		int currentPage_std = Integer.parseInt((String) paramMap.get("currentPage_std")); // 현재
		logger.info("   - currentPage_std : " + currentPage_std);																			// 페이지
																					// 번호
		int pageSize_std = Integer.parseInt((String) paramMap.get("pageSize_std")); // 페이지
																			// 사이즈
		int pageIndex_std = (currentPage_std - 1) * pageSize_std;
		logger.info("   - pageIndex_std : " + currentPage_std);	
		logger.info("+ Start " + className + ".Advice_list");
		logger.info("   - paramMap : " + paramMap);

		paramMap.put("pageIndex_std", pageIndex_std);
		paramMap.put("pageSize_std", pageSize_std);
		paramMap.put("searchWord_std", searchWord_std);

		// 학생 목록 조회
		List<RegisterInfoModel> list_std = pmg_sv.std_list(paramMap);
		model.addAttribute("list_std", list_std);
		logger.info("   - list_std : " + list_std);

		// 상담 목록 카운트 조회
		int totalCount = pmg_sv.countList_std(paramMap);
		model.addAttribute("totalCnt_std", totalCount);
		model.addAttribute("pageSize_std", pageSize_std);
		model.addAttribute("currentPage_std", currentPage_std);

		logger.info("   - totalCnt : " + totalCount);
		logger.info("   - pageSize : " + pageSize_std);
		logger.info("   - currentPage : " + currentPage_std);

		logger.info("+ End " + className + ".list_advice");
		
		return "adm/people_mng/stdMng/stdList";
	}
	
	//회원정보 단건 조회
	@RequestMapping("user_info.do")
	@ResponseBody
	public Map<String, Object> select_adv (Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception {
		
		logger.info("+ Start " + className + ".selectComnGrpCod");
		logger.info("   - paramMap : " + paramMap);

		String result = "SUCCESS";
		String resultMsg = "조회 되었습니다.";
		
		// 회원정보 단건 조회
		RegisterInfoModel user_model = pmg_sv.user_info(paramMap);
		
		Map<String, Object> resultMap = new HashMap<String, Object>();
		resultMap.put("result", result);
		resultMap.put("resultMsg", resultMsg);
		resultMap.put("user_model", user_model);
		
		logger.info("+ End " + className + ".selectComnGrpCod");
		
		return resultMap;
	}
	
	//학생 강의 수강정보 리스트
	@RequestMapping("slist_lec.do")
	public String slec_list(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception {
		
		String user_type=(String) paramMap.get("user_type");
		
		logger.info("   - putparamMap : " + paramMap);

		
		
		// 상세정보창 강의목록 가져오기
		
		if(user_type.equals("b")){ //강사
			List<RegisterListControlModel> tlist_lec = pmg_sv.tlec_list(paramMap);
			model.addAttribute("tlist_lec", tlist_lec);
			logger.info("tlec_list:" + tlist_lec);
			int tut_lec_count = pmg_sv.tut_lec_count(paramMap);
			model.addAttribute("tut_lec_count", tut_lec_count);
			logger.info("tut_lec_count:" + tut_lec_count);
			return "adm/people_mng/tutMng/tut_lecList";
			
		}else if(user_type.equals("a")){ //학생
			List<RegisterListControlModel> slist_lec = pmg_sv.std_lec_info(paramMap);
			model.addAttribute("slist_lec", slist_lec);
			logger.info("slec_list:" + slist_lec);
			//강의 숫자 조회
			int std_lec_count = pmg_sv.std_lec_count(paramMap);
			model.addAttribute("std_lec_count", std_lec_count);
			logger.info("std_lec_count:" + std_lec_count);
			return "adm/people_mng/stdMng/std_lecList";
		}
				
		return "list_std.do";
	}
	
	
	
	//유저 정지
	@RequestMapping("ban_user.do")
	@ResponseBody
	public Map<String, Object> deleteComnDtlCod(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception {
		
		logger.info("+ Start " + className + ".deleteComnDtlCod");
		logger.info("   - paramMap : " + paramMap);

		String result = "SUCCESS";
		String resultMsg = "회원 :"+paramMap.get("loginID")+ "정지 되었습니다.";
		
		// 유저 정지
		pmg_sv.ban_user(paramMap);
		
		Map<String, Object> resultMap = new HashMap<String, Object>();
		resultMap.put("result", result);
		resultMap.put("resultMsg", resultMsg);
		
		logger.info("+ End " + className + ".deleteComnDtlCod");
		
		return resultMap;
	}
	
	
	
	/* 강사 */
	
	@RequestMapping("tutorControl.do")
	public String tutor_list(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) {
		logger.info("   - paramMap : " + paramMap);
		//전체 강의목록
		//model.addAttribute("total_lec", adv_sv.tutor_lec_list(paramMap));
		return "adm/people_mng/tutMng/tutMng";
	}
	
	
	
	/* 강사 리스트 */
	@RequestMapping("list_tut.do")
	public String tut_list(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception {
		logger.info("   - paramMap : " + paramMap);

		String searchKey = (String) paramMap.get("searchKey");
		String searchWord = (String) paramMap.get("searchWord");
		int currentPage = Integer.parseInt((String) paramMap.get("currentPage")); // 현재
		logger.info("   - currentPage : " + currentPage);																			// 페이지
																					// 번호
		int pageSize= Integer.parseInt((String) paramMap.get("pageSize")); // 페이지
																			// 사이즈
		int pageIndex = (currentPage - 1) * pageSize;
		logger.info("   - pageIndex : " + pageIndex);	
		logger.info("+ Start " + className + ".Advice_list");
		logger.info("   - paramMap : " + paramMap);

		paramMap.put("pageIndex", pageIndex);
		paramMap.put("pageSize", pageSize);
		paramMap.put("searchWord", searchWord);

		// 강사 목록 조회
		List<RegisterInfoModel> list_tut = pmg_sv.tut_list(paramMap);
		model.addAttribute("list_tut", list_tut);
		logger.info("   - list_tut : " + list_tut);

		// 강사 목록 카운트 조회
		int totalCount = pmg_sv.countList_tut(paramMap);
		model.addAttribute("totalCnt", totalCount);
		model.addAttribute("pageSize", pageSize);
		model.addAttribute("currentPage", currentPage);

		logger.info("   - totalCnt : " + totalCount);
		logger.info("   - pageSize : " + pageSize);
		logger.info("   - currentPage : " + currentPage);

		logger.info("+ End " + className + ".list_advice");
	
	
	return "adm/people_mng/tutMng/tutList";	
		
	}
	
	//강사 승인
	@RequestMapping("apv_tut.do")
	@ResponseBody
	public Map<String, Object> apv_tut(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception {
		
		logger.info("+ Start " + className + ".deleteComnDtlCod");
		logger.info("   - paramMap : " + paramMap);

		String result = "SUCCESS";
		String resultMsg = "회원 :"+paramMap.get("loginID")+ "승인 되었습니다.";
		
		// 유저 정지
		pmg_sv.apv_tut(paramMap);
		
		Map<String, Object> resultMap = new HashMap<String, Object>();
		resultMap.put("result", result);
		resultMap.put("resultMsg", resultMsg);
		
		logger.info("+ End " + className + ".deleteComnDtlCod");
		
		return resultMap;
	}
	
	
	/* 대표자 */
	
	@RequestMapping("ceoControl.do")
	public String ceo_page(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) {
		logger.info("   - paramMap : " + paramMap);

		return "adm/people_mng/ceoMng/ceoMng";
	}
	
	//대표자 목록
	
	/* 대표자 리스트 */
	@RequestMapping("list_ceo.do")
	public String ceo_list(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception {
		logger.info("   - paramMap : " + paramMap);

		String searchKey = (String) paramMap.get("searchKey");
		String searchWord = (String) paramMap.get("searchWord");
		int currentPage = Integer.parseInt((String) paramMap.get("currentPage")); // 현재
		logger.info("   - currentPage : " + currentPage);																			// 페이지
																					// 번호
		int pageSize= Integer.parseInt((String) paramMap.get("pageSize")); // 페이지
																			// 사이즈
		int pageIndex = (currentPage - 1) * pageSize;
		logger.info("   - pageIndex : " + pageIndex);	
		logger.info("+ Start " + className + ".Advice_list");
		logger.info("   - paramMap : " + paramMap);

		paramMap.put("pageIndex", pageIndex);
		paramMap.put("pageSize", pageSize);
		paramMap.put("searchWord", searchWord);
		
		// 강사 목록 조회
				List<RegisterInfoModel> list_ceo = pmg_sv.tut_list(paramMap);
				model.addAttribute("list_ceo", list_ceo);
				logger.info("   - list_ceo : " + list_ceo);
				
		// 강사 목록 카운트 조회
		int totalCount = pmg_sv.countList_tut(paramMap);
		model.addAttribute("totalCnt", totalCount);
		model.addAttribute("pageSize", pageSize);
		model.addAttribute("currentPage", currentPage);

		logger.info("   - totalCnt : " + totalCount);
		logger.info("   - pageSize : " + pageSize);
		logger.info("   - currentPage : " + currentPage);

		logger.info("+ End " + className + ".list_advice");
	
	
	return "adm/people_mng/ceoMng/ceoList";	
		
	}
	
	//대표자 정보수정
	@RequestMapping("ceo_up.do")
	@ResponseBody
	public Map<String, Object> ceo_up(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception {
		
		logger.info("+ Start " + className + ".deleteComnDtlCod");
		logger.info("   - paramMap : " + paramMap);

		String result = "SUCCESS";
		String resultMsg = "회원 :"+paramMap.get("loginID")+ "수정 되었습니다.";
		
		// 유저 정지
		pmg_sv.ceo_up(paramMap);
		
		Map<String, Object> resultMap = new HashMap<String, Object>();
		resultMap.put("result", result);
		resultMap.put("resultMsg", resultMsg);
		
		logger.info("+ End " + className + ".deleteComnDtlCod");
		
		return resultMap;
	}
	
	
/*	 계정생성 
	
	@RequestMapping("aregister.do")
	@ResponseBody
	public Map<String, Object> aregiste(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,  HttpServletResponse response, HttpSession session) throws Exception {
		logger.info("+ Start " + className + ".deleteComnDtlCod");
		logger.info("   - paramMap : " + paramMap);
		paramMap.put("addr", (String)paramMap.get("addr") +","+(String)paramMap.get("addr_detail")+","+(String)paramMap.get("user_post"));
		paramMap.put("tel",  (String)paramMap.get("tel1") +"-"+(String)paramMap.get("tel2")       +"-"+(String)paramMap.get("tel3"));
		paramMap.put("birth",(String)paramMap.get("year") +    (String)paramMap.get("month")      +    (String)paramMap.get("day") );
		paramMap.put("pid",  (String)paramMap.get("pid1") +"-"+(String)paramMap.get("pid2"));
		paramMap.put("mail", (String)paramMap.get("mail1")+"@"+(String)paramMap.get("mail2"));
		

		String result = "SUCCESS";
		String resultMsg = "회원 :"+paramMap.get("loginID")+ "생성 되었습니다.";
		
		
		Map<String, Object> resultMap = new HashMap<String, Object>();
		resultMap.put("result", result);
		resultMap.put("resultMsg", resultMsg);
		
		
		pmg_sv
		return resultMap;
	}
	
	@RequestMapping("bregister.do")
	@ResponseBody
	public String bregiste(Model result, @RequestParam Map<String, Object> paramMap, HttpServletRequest request, HttpServletResponse response, HttpSession session) throws Exception {
		paramMap.put("addr", (String)paramMap.get("addr") +","+(String)paramMap.get("addr_detail")+","+(String)paramMap.get("user_post"));
		paramMap.put("tel",  (String)paramMap.get("tel1") +"-"+(String)paramMap.get("tel2")       +"-"+(String)paramMap.get("tel3"));
		paramMap.put("birth",(String)paramMap.get("year") +    (String)paramMap.get("month")      +    (String)paramMap.get("day") );
		paramMap.put("pid",  (String)paramMap.get("pid1") +"-"+(String)paramMap.get("pid2"));
		paramMap.put("mail", (String)paramMap.get("mail1")+"@"+(String)paramMap.get("mail2"));
		
		registerService.bregister(paramMap);
		return null;
	}
	
	@RequestMapping("dregister.do")
	@ResponseBody
	public String dregiste(Model result, @RequestParam Map<String, Object> paramMap, HttpServletRequest request, HttpServletResponse response, HttpSession session) throws Exception {
		paramMap.put("comp_addr", (String)paramMap.get("comp_addr") +","+(String)paramMap.get("comp_addr1")+","+(String)paramMap.get("comp_addr2"));
		paramMap.put("tel",       (String)paramMap.get("tel1")      +"-"+(String)paramMap.get("tel2")      +"-"+(String)paramMap.get("tel3"));
		paramMap.put("comp_tel",  (String)paramMap.get("comp_tel1") +"-"+(String)paramMap.get("comp_tel2") +"-"+(String)paramMap.get("comp_tel3"));
		paramMap.put("birth",     (String)paramMap.get("year")          +(String)paramMap.get("month")     +    (String)paramMap.get("day") );
		paramMap.put("pid",       (String)paramMap.get("pid1")      +"-"+(String)paramMap.get("pid2"));
		paramMap.put("comp_mail", (String)paramMap.get("mail1")     +"@"+(String)paramMap.get("mail2"));

		registerService.dregister(paramMap);
		return null;
	}*/
	
	
}