package kr.kosmo.jobkorea.std.controller;

import java.io.File;
import java.net.URLEncoder;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletRequest;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.io.FileUtils;
import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.kosmo.jobkorea.std.model.RegisterListModel;
import kr.kosmo.jobkorea.std.model.SubmittedWorkModel;
import kr.kosmo.jobkorea.std.service.StudentService;
import kr.kosmo.jobkorea.std.service.SubmittedWorkService;
import kr.kosmo.jobkorea.supportD.model.NoticeDModel;

@Controller
@RequestMapping("/std")
public class SubmittedWorkController {
	@Autowired
	SubmittedWorkService submittedWorkService;	
	
	private final Logger logger = LogManager.getLogger(this.getClass());
	private final String className = this.getClass().toString();
	
	//화면이동 
	@RequestMapping("/submittedWork.do")
	public String submittedWork (Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception{
			logger.info("+ Start " + className + ".submittedWork");
			logger.info("   - paramMap : " + paramMap);
			logger.info("+ End " + className + ".submittedWork");
		return "/std/learn_mng/submittedWork";
	}

	//과제목록조회하기
	@RequestMapping("/selHwkListjquery.do")
	public String selHwkListjquery(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception {
			String std_id = (String) session.getAttribute("loginId");  //로그인 세션 값 가져오기
			paramMap.put("loginID", std_id);
			
			logger.info("+ Start " + className + ".selHwkList");
			logger.info("   - paramMap : " + paramMap);
			
			int currentPage = Integer.parseInt((String)paramMap.get("currentPage"));	// 현재 페이지 번호
			int pageSize = Integer.parseInt((String)paramMap.get("pageSize"));			// 페이지 사이즈
			int pageIndex = (currentPage-1)*pageSize;									// 페이지 시작 row 번호
					
			paramMap.put("pageIndex", pageIndex);
			paramMap.put("pageSize", pageSize);
			
			List<SubmittedWorkModel> selHwkList = submittedWorkService.hwkList(paramMap);  //과제목록 가져오기
			
			//paramMap.put("lec_id", selHwkList.get(0).getLec_id());
			
			int totalCount = submittedWorkService.countHwkList(paramMap);  //카운트
			
			model.addAttribute("pageSize",pageSize);
			model.addAttribute("currentPage",currentPage);
			
			model.addAttribute("selHwkList",selHwkList);
			model.addAttribute("totalCount",totalCount);
			
			logger.info("+ End " + className + ".selHwkList");
			
			return "/std/learn_mng/submittedWorkList";
	}
	
	//선택 과제 data가져오기
	@RequestMapping("/choiceHwkList.do")
	@ResponseBody
		public Map<String, Object> choiceHwkList (Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
				HttpServletResponse response, HttpSession session) throws Exception {
			//세션에서 로그인 값 가져오기.
			String std_id = (String) session.getAttribute("loginId");
			paramMap.put("loginID", std_id);
			
			logger.info("+ Start " + className + ".choiceHwkList");
			logger.info("   - paramMap : " + paramMap);
			
			String result = "SUCCESS";
			String resultMsg = "조회 되었습니다.";
			
			SubmittedWorkModel choiceHwkList = submittedWorkService.choiceHwkList(paramMap);

			Map<String, Object> resultMap = new HashMap<String, Object>();
			
			resultMap.put("result", result);
			resultMap.put("resultMsg", resultMsg);
			
			resultMap.put("choiceHwkList", choiceHwkList);
			
			return resultMap;
		}
	
	//선택 과제 data insert-update
	@RequestMapping("/saveHwk.do")
	@ResponseBody
		public Map<String, Object> saveHwk(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
				HttpServletResponse response, HttpSession session) throws Exception {
			//세션에서 로그인 값 가져오기.
			String std_id = (String) session.getAttribute("loginId");
			paramMap.put("loginID", std_id);
			paramMap.put("std_id", std_id);
			
			String action = (String)paramMap.get("action");
			String result = "SUCCESS";
			String resultMsg = "저장 되었습니다.";
			
			logger.info("+ Start " + className + ".saveHwk");
			logger.info("   - paramMap : " + paramMap);
			
			if ("I".equals(action)) {
				
				submittedWorkService.insertHwk(paramMap, request); // 과제 신규 저장 
				
			} else if("U".equals(action)) {
				
				int saveHwkSubFil = submittedWorkService.updateHwkSubFile(paramMap, request);
				
			} else {
				
				result = "FALSE";
				resultMsg = "알수 없는 요청 입니다.";
			}
			
			Map<String, Object> resultMap = new HashMap<String, Object>();
			resultMap.put("result",result);
			resultMap.put("resultMsg", resultMsg);
			
			return resultMap;
		}
	//과제 제출 삭제
	@RequestMapping("/deleteHwk.do")
	@ResponseBody
	public Map<String, Object> deleteHwk(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception {
		//세션에서 로그인 값 가져오기.
		String std_id = (String) session.getAttribute("loginId");
		paramMap.put("loginID", std_id);
		paramMap.put("std_id", std_id);
		
		System.out.println(paramMap.get("hwk_id"));
		
		logger.info("+ Start " + className + ".deleteHwk");

		String result = "SUCCESS";
		String resultMsg = "삭제 되었습니다.";

		logger.info("   - paramMap : " + paramMap);
		// 게시글 삭제
		submittedWorkService.deleteHwkSub(paramMap);
		
		Map<String, Object> resultMap = new HashMap<String, Object>();
		resultMap.put("result", result);
		resultMap.put("resultMsg", resultMsg);
		
		logger.info("+ End " + className + ".deleteHwk");
		
		return resultMap;
	}
	//다운로드_by 창규창규 - 과제 목록 화면으로 이동
	@RequestMapping("/downloadHwk.do")
	   public String downloadHwk(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request, HttpServletResponse response, HttpSession session) throws Exception{
			String fileName = (String) paramMap.get("hwk_fname");
			String file =(String)paramMap.get("hwk_url");  //다운url설정 과제목록
			//String file = "D:\\FileRepository\\project\\hwk_id\\testfile.txt";
	      
	      byte fileByte[] = FileUtils.readFileToByteArray(new File(file));
	      response.setContentType("application/octet-stream");
	      response.setContentLength(fileByte.length);
	      response.setHeader("Content-Disposition", "attachment; fileName=\"" + URLEncoder.encode(fileName,"UTF-8")+"\";");
	      //response.setHeader("Content-Disposition", "attachment; fileName=\"" + URLEncoder.encode(file,"UTF-8")+"\";");
	      response.setHeader("Content-Transfer-Encoding", "binary");
	      response.getOutputStream().write(fileByte);
	           
	      response.getOutputStream().flush();
	      response.getOutputStream().close();
	      
	      return "/std/learn_mng/submittedWork";
	   }

}
