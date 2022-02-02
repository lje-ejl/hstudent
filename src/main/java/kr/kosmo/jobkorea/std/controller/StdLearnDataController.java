package kr.kosmo.jobkorea.std.controller;

import java.io.File;
import java.net.URLEncoder;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import org.springframework.ui.Model;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.io.FileUtils;
import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;


import kr.kosmo.jobkorea.std.model.StdLearnDataModel;
import kr.kosmo.jobkorea.std.service.StdLearnDataService;



@SuppressWarnings("unused")
@Controller
@RequestMapping("/std/")
public class StdLearnDataController {

	/* 2020.11.13 임지은 
	 * Autowired는 팔짱이다!(연결고리)
	 * MVC(Model, View, Controller)패턴에서 
	 * controller는 service와 팔짱
	 * service는 dao와 팔짱!
	 * service는 controller와 dao사이에서 왔다갔다하면서 서빙하는 역할.
	 * */	
	@Autowired
	StdLearnDataService stdLearnDataService;	
	// Set logger
	private final Logger logger = LogManager.getLogger(this.getClass());

	// Get class name for logger
	private final String className = this.getClass().toString();
	
	

	//초기화면
	@RequestMapping("a_learningMaterials.do")
	public String init(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception {
		
		String loginID = (String) session.getAttribute("loginId");
		paramMap.put("loginID", loginID);
		
        StdLearnDataModel myLecture = stdLearnDataService.myLecture(paramMap);
		model.addAttribute("myLecture", myLecture);


		return "std/learn_sup/StdLearnData";
	}
	
	//학습자료 리스트 불러오기
	@RequestMapping("selectDataList.do")
	public String searchData(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception {

		String loginID = (String) session.getAttribute("loginId");
		paramMap.put("loginID", loginID);
		
		int currentPage = Integer.parseInt((String) paramMap.get("currentPage")); // 현재페이지
	    int pageSize = Integer.parseInt((String) paramMap.get("pageSize"));
	    int pageIndex = (currentPage - 1) * pageSize;
		
		paramMap.put("pageIndex", pageIndex);
		paramMap.put("pageSize", pageSize);
		
		
		
		System.out.println("doskdosk"+paramMap);
		List<StdLearnDataModel> dataList = stdLearnDataService.dataList(paramMap);
		
		int dataCount = stdLearnDataService.dataCount(paramMap);
		
		model.addAttribute("dataList", dataList);
	    model.addAttribute("dataCount", dataCount);
	    model.addAttribute("pageSize", pageSize);
	    model.addAttribute("currentPage",currentPage);
	    
	    
		return "std/learn_sup/StdLearnDataCallback";
	}
	
	//학습자료 상세조회
	@RequestMapping("detailData.do")
	public String dataInfo(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception {
		
		
		StdLearnDataModel dataInfo = stdLearnDataService.dataInfo(paramMap);

		model.addAttribute("dataInfo", dataInfo);
		
		return "std/learn_sup/StdLearnDataCallback1";
	}
	
	//학습자료 첨부파일 다운로드
	@RequestMapping("dataDownload.do")
	   public void dataDownload(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
	         HttpServletResponse response, HttpSession session) throws Exception {
	   
	      //logger.info("+ Start " + className + ".downloadBbsAtmtFil");
	      //logger.info("   - paramMap : " + paramMap);
	      
	      //byte fileByte[] = FileUtils.readFileToByteArray(new File(rootPath+cmntBbsAtmtFilModel.getAtmt_fil_psc_fil_nm()));
	      
		String file = (String)paramMap.get("learn_url");
		String filename = (String)paramMap.get("learn_fname");
		byte fileByte[] = FileUtils.readFileToByteArray(new File(file));
	      
	      response.setContentType("application/octet-stream");
	      response.setContentLength(fileByte.length);
	      response.setHeader("Content-Disposition", "attachment; fileName=\"" + URLEncoder.encode(filename,"UTF-8")+"\";");
	      response.setHeader("Content-Transfer-Encoding", "binary");
	      response.getOutputStream().write(fileByte);
	        
	      response.getOutputStream().flush();
	      response.getOutputStream().close();

	      //logger.info("+ End " + className + ".downloadBbsAtmtFil");
	   }

	
}
