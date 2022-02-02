package kr.kosmo.jobkorea.adm.controller;

import java.util.ArrayList;
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

import kr.kosmo.jobkorea.adm.model.EquipmentControlModel;
import kr.kosmo.jobkorea.adm.model.processFailModel;
import kr.kosmo.jobkorea.adm.service.processFailService;


@Controller
@RequestMapping("/adm/")
public class processFailController{
		

	@Autowired
	processFailService processFailService;
	
	private final Logger logger = LogManager.getLogger(this.getClass());

	private final String className = this.getClass().toString();
	
	
	
	//메인페이지
	@RequestMapping("processFail.do")
	public String processFail(Model model,@RequestParam Map<String,Object> paramMap, HttpServletRequest request, HttpServletResponse response, HttpSession session) throws Exception{
	//src/main/webapp/WEB-INF/views 안에 있는 jsp파일하고 연결
	
		logger.info("+ Start " + className + ".processFail");
		logger.info("   - paramMap : " + paramMap);
		
		logger.info("+ End " + className + ".processFail");
		
		return "adm/stats/processFail";
	

	}
	
	
	//강의 리스트 불러오기
	@RequestMapping("lec_List_Select.do")
	@ResponseBody
	public Map<String, Object> lec_List_Select(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception {
		
		
		logger.info("+ Start " + className + ".lec_List_Select");
		logger.info("   - paramMap : " + paramMap);
		
		
		int currentPage = Integer.parseInt((String)paramMap.get("currentPage"));
		int pageSize = Integer.parseInt((String)paramMap.get("pageSize"));
		int pageIndex = (currentPage-1)*pageSize;
		
		logger.info("currentPage : " + currentPage);
		
		paramMap.put("pageIndex", pageIndex);
		paramMap.put("pageSize", pageSize);
		Map<String, Object> resultMap = new HashMap<String, Object>();

		
		logger.info("pageIndex" + pageIndex);
		logger.info("+ 2Start " + className + ".lec_List_Select");
		//강의 목록 조회
		List<processFailModel> lec_List_Select = processFailService.lec_List_Select(paramMap);
		for (int i = 0; i < lec_List_Select.size(); i++) {
			System.out.println("@@@@@@@@@@"+lec_List_Select.get(i).getStartdate());
		}
		// test!!!!!!!!!!!!!!!!!!!!!!!!!
		/*SimpleDateFormat format1 = new SimpleDateFormat( "yyyy.MM.dd");
		
		for (int i = 0; i < lec_List_Select.size(); i++) {
			System.out.println("!!!!!!!!!!!!!!!!!!!!!!"+format1.format(lec_List_Select.get(i).getStartdate()));
			System.out.println("!!!!!!!!!!!!!!!!!!!!!!"+lec_List_Select.get(i).getEnddate());
			lec_List_Select.get(i).setStartdate(format1.format(lec_List_Select.get(i).getStartdate()));
			
		}*/
		
		//!!!!!!!!!!!!!!!!!!!!!!!!
		
		resultMap.put("lec_List_Select",lec_List_Select);
		
		//logger.info("lec_List_Select :" + lec_List_Select);
		logger.info("+ 2End " + className + ".lec_List_Select");


		//공통 그룹코드 목록 카운트 조회
		//getTotalCount 저 부분 모델에 만들어 줘야 한다. 
		int lec_Total = processFailService.lec_Cnt_Select(paramMap);
		
		resultMap.put("lec_Total", lec_Total);
		resultMap.put("pageSize", pageSize);
		resultMap.put("currentPageComnGrpCod",currentPage);
		
	
		logger.info("lec_Total :" + lec_Total);
		
		logger.info("+ End " + className + ".lec_Cnt_Select");
		
		
		return resultMap;
	}
	
	
	
	//차트 리스트
	@RequestMapping("lec_Name_List.do")
	@ResponseBody
	public Map<String, Object> lec_Name_List(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception {
		
		Map<String, Object> resultMap = new HashMap<String, Object>();

		//강의명 배열
	    List<processFailModel> lec_Name_List2 = processFailService.lec_Name_List(paramMap);
		List<String> lec_Name_List = new ArrayList<String>(); 
		
		
		for( processFailModel dto : lec_Name_List2 ){
			lec_Name_List.add(dto.getLec_name());
			
		}
		
		//강의별 통과 카운트 배열
		List<processFailModel> lec_Name_List3 = processFailService.lec_Name_List(paramMap);
		List<Integer> lec_Name_List31 = new ArrayList<Integer>(); 
		
		for( processFailModel dto : lec_Name_List3 ){
			lec_Name_List31.add(dto.getPass());

		
		}
		
		//강의별 과락 카운트 배열
		List<processFailModel> lec_Name_List4 = processFailService.lec_Name_List(paramMap);
		List<Integer> lec_Name_List41 = new ArrayList<Integer>(); 
		
		for( processFailModel dto : lec_Name_List4 ){
			lec_Name_List41.add(dto.getFail());

		
		}
		
		//배열로 만든 애들 뷰에 전달할테니까 resultMap해서 이 안에 넣어줘!
		resultMap.put("lec_Name_List",lec_Name_List);
		resultMap.put("lec_Name_List31",lec_Name_List31);
		resultMap.put("lec_Name_List41",lec_Name_List41);

		
	
		
		logger.info("  !@!@! - paramMap : " + resultMap);
		
		logger.info("+ End " + className + ".lec_Name_List");
		
		return resultMap;
	
	}
	
	
	
	
	
}


