package kr.kosmo.jobkorea.adm.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.ibatis.annotations.ResultMap;
import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.kosmo.jobkorea.adm.model.EmploymentInfoModel;
import kr.kosmo.jobkorea.adm.model.RegisterListControlModel;
import kr.kosmo.jobkorea.adm.service.EmploymentInfoService;
import kr.kosmo.jobkorea.login.model.RegisterInfoModel;

@Controller
@RequestMapping("/adm/")
public class employmentInfoContorller {


	@Autowired
	EmploymentInfoService empInfoservice;
	

	// Set logger
	private final Logger logger = LogManager.getLogger(this.getClass());

	// Get class name for logger 
	private final String className = this.getClass().toString();
	
	
	//1.취업 정보 목록 디폴트 SELECT
	@RequestMapping("employmentInfo.do")
	public String empInfo(Model model, @RequestParam Map<String, Object> paramMap
			,HttpSession session) throws Exception{
		
		List<RegisterInfoModel> comp = empInfoservice.list_comp(paramMap);
		logger.info("comp"+comp);
		model.addAttribute("comp", comp);
		
		
		
		return "adm/employ_mng/employmentInfo";
	}
	
	//2.취업 정보 등록된 학생 정보 리스트 SELECT
	@RequestMapping("listEmp.do")
	@ResponseBody
	public Map<String, Object>listEmp(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session)throws Exception{
		
		int currentPage = Integer.parseInt((String)paramMap.get("currentPage"));	// 현재 페이지 번호
		int pageSize = Integer.parseInt((String)paramMap.get("pageSize"));			// 페이지 사이즈
		int pageIndex = (currentPage-1)*pageSize;									// 페이지 시작 row 번호
		
		paramMap.put("pageIndex", pageIndex);
		paramMap.put("pageSize", pageSize);
		
	
		//검색 조건 확인!
		String searchKey = (String) paramMap.get("searchKey");
		String searchWord = (String) paramMap.get("searchWord");

		paramMap.put("searchKey", searchKey);
		paramMap.put("searchWord", searchWord);
		
		Map<String, Object> resultMap = new HashMap<String, Object>();
		
		List<EmploymentInfoModel> list_emp = empInfoservice.list_emp(paramMap);
		
		int totalCount = empInfoservice.cnt_list_epm(paramMap);
		
		resultMap.put("totalCount", totalCount);		
		resultMap.put("pageSize", pageSize);
		resultMap.put("list_emp",list_emp);

		logger.info("   - totalCount : " + totalCount);
		logger.info("   - pageSize : " + pageSize);
		logger.info("   - !!pageIndex : " + pageIndex);
		
		return resultMap;
	}
	
	//3.등록할 학생 목록 SELECT
	@RequestMapping("listEmpStd.do")
	@ResponseBody
	public Map<String, Object>listEmpStd(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session)throws Exception{
		
		int currentPage = Integer.parseInt((String)paramMap.get("currentPage"));	// 현재 페이지 번호
		int pageSize = Integer.parseInt((String)paramMap.get("pageSize"));			// 페이지 사이즈
		int pageIndex = (currentPage-1)*pageSize;									// 페이지 시작 row 번호
		
		paramMap.put("pageIndex", pageIndex);
		paramMap.put("pageSize", pageSize);

		//검색 조건 확인!
		String searchKey2 = (String) paramMap.get("searchKey2");
		String searchWord2 = (String) paramMap.get("searchWord2");

		paramMap.put("searchKey2", searchKey2);
		paramMap.put("searchWord2", searchWord2);
		
		Map<String, Object> resultMap = new HashMap<String, Object>();
		
		List<RegisterInfoModel> list_std = empInfoservice.list_std(paramMap);
		
		int totalCount = empInfoservice.cnt_list_std(paramMap);
		
		resultMap.put("totalCount", totalCount);		
		resultMap.put("pageSize", pageSize);
		resultMap.put("list_std",list_std);
	
		return resultMap;
	}
	
	//7.미 등록된 학생 INSERT
	

	
	//4.이력서 등록을 위한 단건 조회
	@RequestMapping("SelEmp.do")
	@ResponseBody
	public Map<String, Object> selEmp(Model model,@RequestParam Map<String, Object>paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session)throws Exception{
		logger.info("이력서 단건 조회 " + className + ".SelEmp");
		logger.info("   - paramMap : " + paramMap);

		String result = "SUCCESS";
		String resultMsg = "조회 되었습니다.";
		
		
		EmploymentInfoModel sel_emp = empInfoservice.sel_emp(paramMap);
		
		Map<String,Object> resultMap = new HashMap<String,Object>();
		
		resultMap.put("result", result);
		resultMap.put("resultMsg", resultMsg);
		resultMap.put("sel_emp", sel_emp);
		
		
		return resultMap;
	}
	
	//4.등록된 학생 UPDATE
	@RequestMapping("saveEmp.do")
	@ResponseBody
	public Map<String, Object> saveEmp(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception {
		
		logger.info("과정저장" + className + ".saveEmp");
		logger.info("   - paramMap : " + paramMap);
		
		String action = (String)paramMap.get("action");
		String result = "SUCCESS";
		String resultMsg = "저장 되었습니다.";
		
		if("I".equals(action)){
			
			empInfoservice.insert_emp(paramMap);
		
		}else if("U".equals(action)){
			
			empInfoservice.update_emp(paramMap);
			
			System.out.println("업데이트확인");
		
		}else{
			result = "FALSE";
			resultMsg = "알 수 없는 요청입니다.";
		}
		
		Map<String, Object> resultMap = new HashMap<String, Object>();
		resultMap.put("result", result);
		resultMap.put("resultMsg", resultMsg);
		
		logger.info("+ End " + className + "saveEmp.do");
		
		return resultMap;
	}
	
	//5.등록된 학생 DELETE
	@RequestMapping("delEmp.do")
	@ResponseBody
	public Map<String, Object>delEmp(Model model, @RequestParam Map<String, Object>paramMap, HttpServletRequest request
			,HttpServletResponse response, HttpSession session) throws Exception{
		
		logger.info("이력서 삭제 "+ className + ".delEmp");
		logger.info("   - paramMap : " + paramMap);

		String result = "SUCCESS";
		String resultMsg = "삭제 되었습니다.";
		
		empInfoservice.del_emp(paramMap);
		
		Map<String, Object> resultMap = new HashMap<String,Object>();
		
		resultMap.put("result", result);
		resultMap.put("resultMsg", resultMsg);
		
		return resultMap;
	}
	//6.미 등록된 학생목록 
	//7.미 등록된 학생 INSERT
	
	//8.학생 프로필 SELECT
	//4.이력서 등록을 위한 단건 조회
	@RequestMapping("SelStd.do")
	@ResponseBody
	public Map<String, Object> selStd(Model model,@RequestParam Map<String, Object>paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session)throws Exception{
		logger.info("이력서 단건 조회 " + className + ".SelStd");
		logger.info("   - paramMap : " + paramMap);

		String result = "SUCCESS";
		String resultMsg = "조회 되었습니다.";
		
		
		RegisterInfoModel sel_std = empInfoservice.sel_std(paramMap);
		List<RegisterListControlModel> list_std_lec = empInfoservice.list_std_lec(paramMap);
		
		int total_cnt = empInfoservice.cnt_list_lec(paramMap);
		/*List<RegisterListControlModel> list_std_lec = empInfoservice.list_std_lec(paramMap);
		model.addAttribute("list_std_lec", list_std_lec);*/
		Map<String,Object> resultMap = new HashMap<String,Object>();
		
		resultMap.put("result", result);
		
		resultMap.put("resultMsg", resultMsg);
		
		resultMap.put("sel_std", sel_std);
		resultMap.put("list_std_lec", list_std_lec);
		resultMap.put("total", total_cnt);
		logger.info("   - totalCount : " + total_cnt);
		
		return resultMap;
		
	}
	
	
	//9.학생명 검색- 정보 리스트 SELECT - 디폴트 값 없애기 if문
	
}
