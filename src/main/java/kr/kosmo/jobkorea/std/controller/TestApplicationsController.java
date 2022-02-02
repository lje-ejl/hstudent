package kr.kosmo.jobkorea.std.controller;

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
import org.springframework.web.bind.annotation.SessionAttributes;

import kr.kosmo.jobkorea.std.model.TestUser;
import kr.kosmo.jobkorea.std.service.TestApplicationsService;
import kr.kosmo.jobkorea.tut.model.ProgressControlModel;
import kr.kosmo.jobkorea.tut.model.TestQue;

@SessionAttributes({"lgnInfoModel"})
@Controller
@RequestMapping("/std")
public class TestApplicationsController {
	
	@Autowired
	TestApplicationsService testapplyService;
	
	// 초기화면 연결
	@RequestMapping("/testApplications.do")
	public String testApply(HttpSession session)throws Exception{
		
		return "std/testApplycations";
	}
	
	// 시험조회 연결
	@RequestMapping("/selectMyTest.do")
	public String selectTest(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
					HttpServletResponse response, HttpSession session)throws Exception{

		int currentPage = Integer.parseInt((String) paramMap.get("currentPage")); // 현재페이지
		int pageSize = Integer.parseInt((String) paramMap.get("pageSize"));
		int pageIndex = (currentPage - 1) * pageSize;

		paramMap.put("pageIndex", pageIndex);
		paramMap.put("pageSize", pageSize);
		paramMap.put("loginId", session.getAttribute("loginId"));

		Map<String, Object> resultMap = new HashMap<String, Object>();
		
		List<TestUser> TestList = testapplyService.selectTest(paramMap);
		model.addAttribute("TestList", TestList);
		
		int totalCount = testapplyService.countListComnGrpCod(paramMap);
		
		model.addAttribute("totalCntComnGrpCod", totalCount);
		model.addAttribute("pageSize", pageSize);
		model.addAttribute("currentPageComnGrpCod",currentPage);
		
		// 콜백 화면 return 
		return "std/testApplicationsCallback";
	}
	
	
	// 시험 응시 클릭시 시험 문제 조회
	@RequestMapping("/applyTest.do")
	public String applyTest(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
						HttpServletResponse response, HttpSession session)throws Exception{
		List<TestQue> testList = testapplyService.applyTest(paramMap);

		model.addAttribute("testList", testList);
		
		return "std/testApplycationsExamCallback";
	}
	
	// 시험 응시(제출)
	@RequestMapping("/submitTest.do")
	@ResponseBody
	public Map<String, Object> submitTest(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session)throws Exception{
		paramMap.put("loginId", session.getAttribute("loginId"));
		
		int submitTest = testapplyService.submitTest(paramMap);
		
		Map<String, Object> resultMap = new HashMap<String, Object>();
		
		if(submitTest >0){
			resultMap.put("result","SUCCESS");
			resultMap.put("test_id",paramMap.get("test_id"));
			resultMap.put("lec_id",paramMap.get("lec_id"));
		}else{
			resultMap.put("result","FAIL");
		}
		
		return resultMap;
	}
	
	// 시험 결과 조회
	@RequestMapping("/checkResult.do")
	public String checkResult(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session)throws Exception{
		paramMap.put("loginId", session.getAttribute("loginId"));
		
		// 기존 정답을 조회!
		List<TestQue> testList = testapplyService.applyTest(paramMap);
		
		// 나의 답을 조회!
		TestQue ansList = testapplyService.selectAns(paramMap);
		
		model.addAttribute("testList", testList);
		model.addAttribute("ansList", ansList);
		
		return "std/testApplycationsResultCallback";
	}
}
