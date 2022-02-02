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
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.kosmo.jobkorea.adm.model.RegisterListControlModel;
import kr.kosmo.jobkorea.adm.model.testPersonControlModel;
import kr.kosmo.jobkorea.adm.service.RegistrerListControlService;
import kr.kosmo.jobkorea.adm.service.TestPersonControlService;



@Controller
@RequestMapping("/adm/")
public class testPersonControlController {

	@Autowired
	RegistrerListControlService regListService;
	 
	@Autowired
	TestPersonControlService tpservice;
	
	// Set logger
	private final Logger logger = LogManager.getLogger(this.getClass());

	// Get class name for logger
	private final String className = this.getClass().toString();
	
	
	
	//시험 대상자 관리 메인!
	@RequestMapping("testPersonControl.do")
	public String registerList(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception {
		
		logger.info("시험 대상자 관리 메인 " + className + ".tpservice");
		logger.info("시험 대상자 관리 메인 - paramMap : " + paramMap);
		
		//강의 리스트 뿌리기
		List<RegisterListControlModel>list_lec = regListService.list_lec(paramMap);
				
		//강의 인서트 option select 보이기 
		model.addAttribute("list_selval", list_lec);
		
		return "adm/learn_mng/testPersonControl";
	}
	
	
	//시험 강의 목록 리스트 조회!
	@RequestMapping("testListLec.do")
	@ResponseBody
	public Map<String, Object> testListLec (Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception {
		
		logger.info("강의 목록 리스트 " + className + ".testListLec");
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

		List<testPersonControlModel>list_lec = tpservice.list_lec(paramMap);
		resultMap.put("list_lec",list_lec);
		
		//페이징을 위한 강의 수 목록
		int totalCount = tpservice.cnt_list_lec(paramMap);
		
		resultMap.put("totalCount", totalCount);		
		resultMap.put("pageSize", pageSize);
		
		
		return resultMap;
	}	

	
	
	//시험 목록 조회
	/*@RequestMapping("listTest.do")
	@ResponseBody
	public Map<String, Object> listTest(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception {
		
		
		logger.info("학생 목록 조회 " + className + ".listTest");
		logger.info("   - paramMap : " + paramMap);
		
		int currentPage = Integer.parseInt((String)paramMap.get("currentPage"));	// 현재 페이지 번호
		int pageSize = Integer.parseInt((String)paramMap.get("pageSize"));			// 페이지 사이즈
		int pageIndex = (currentPage-1)*pageSize;												// 페이지 시작 row 번호
		
		paramMap.put("pageIndex", pageIndex);
		paramMap.put("pageSize", pageSize);
		
		Map<String, Object> resultMap = new HashMap<String, Object>();
		
		// 학생 목록 조회
		List<testPersonControlModel> list_test = tpservice.list_test(paramMap);
		resultMap.put("list_test",list_test);
		
		// 학생 목록 카운트 조회
		int totalCount = tpservice.cnt_list_test(paramMap);
		resultMap.put("totalCount", totalCount);
		resultMap.put("pageSize", pageSize);
		resultMap.put("currentPageCourse",currentPage);
		resultMap.put("list_test",list_test);

		return resultMap;
		
	}
	*/
	
	//학생 시험 조회
	@RequestMapping("stdTest.do")
	@ResponseBody
	public Map<String, Object> stdTest(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception {
		
		logger.info("강의 단건 조회 " + className + ".stdTest");
		logger.info("   - paramMap : " + paramMap);
		int currentPage = Integer.parseInt((String)paramMap.get("currentPage"));	// 현재 페이지 번호
		int pageSize = Integer.parseInt((String)paramMap.get("pageSize"));			// 페이지 사이즈
		int pageIndex = (currentPage-1)*pageSize;												// 페이지 시작 row 번호
		
		int lec_id = Integer.parseInt((String)paramMap.get("lec_id"));
		int test_id = Integer.parseInt((String)paramMap.get("test_id"));
		
		paramMap.put("pageIndex", pageIndex);
		paramMap.put("pageSize", pageSize);
		paramMap.put("lec_id",lec_id);
		paramMap.put("test_id", test_id);
		
		Map<String, Object> resultMap = new HashMap<String, Object>();
		
		// 학생 목록 조회
		List<testPersonControlModel> std_test = tpservice.std_test(paramMap);
		resultMap.put("std_test",std_test);
		
		// 학생 목록 카운트 조회
		int totalCount = tpservice.cnt_std_test(paramMap);
		
		resultMap.put("totalCount", totalCount);
		resultMap.put("pageSize", pageSize);
		resultMap.put("currentPageCourse",currentPage);
		
		resultMap.put("lec_id",lec_id);
		resultMap.put("test_id",test_id);

		return resultMap;
	}
	

	
	
}
