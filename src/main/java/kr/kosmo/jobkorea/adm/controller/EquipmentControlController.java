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
import org.springframework.stereotype.Service;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.kosmo.jobkorea.adm.model.EquipmentControlModel;
import kr.kosmo.jobkorea.adm.model.LectureRoomModel;
import kr.kosmo.jobkorea.adm.service.EquipmentControlService;
import kr.kosmo.jobkorea.adm.service.LectureRoomService;




//이민하 작업중

@Controller
@RequestMapping("/adm/")
@Service
public class EquipmentControlController {
	
	
	@Autowired
	EquipmentControlService equipmentControlService;
	
	@Autowired
	LectureRoomService lectureRoomService;

	
	private final Logger logger = LogManager.getLogger(this.getClass());

	private final String className = this.getClass().toString();


	
	/*과정 초기 화면 */
	@RequestMapping("equipmentControl.do")
	public String equipmentControl(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
	HttpServletResponse response, HttpSession session) throws Exception {
		
		//logger는 밑에 이 부분이 잘 연결이 됐으면 로그창에 나오는 것들!!
	
		//List<EquipmentControlModel> listEquip = equipmentControlService.listEquip(paramMap);
		//model.addAttribute("listCourse", "asdfgh");

		logger.info("+ Start " + className + ".equipmentControl");
		   //강의실 리스트 뿌리기
		List<LectureRoomModel> listLecrm = lectureRoomService.listLecrm(paramMap);
		
		logger.info("listLecrm확인"+listLecrm);
	    //강의 인서트 option select 보이기 
		model.addAttribute("listLecrm", listLecrm);
		
		logger.info("   - paramMap : " + paramMap);
		
		logger.info("+ End " + className + ".equipmentControl");
		
	
		return "adm/fac_mng/EquipmentControl";
	}
	
	/*장비 목록 조회*/
	@RequestMapping("listEquip.do")
	@ResponseBody	
	public Map<String, Object> listEquip(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception {
	
		
		logger.info("+ Start " + className + ".listEquip");
		logger.info("   - paramMap : " + paramMap);
		
		
		
		int currentPage = Integer.parseInt((String)paramMap.get("currentPage"));	// 현재 페이지 번호
		int pageSize = Integer.parseInt((String)paramMap.get("pageSize"));			// 페이지 사이즈
		int pageIndex = (currentPage-1)*pageSize;												// 페이지 시작 row 번호

		paramMap.put("pageIndex", pageIndex);
		paramMap.put("pageSize", pageSize);
		Map<String, Object> resultMap = new HashMap<String, Object>();
		// 과정 목록 조회
		List<EquipmentControlModel> listEquip = equipmentControlService.listEquip(paramMap);
		resultMap.put("listEquip", listEquip);
		
		logger.info("+ End " + className + ".listEquip");

		
		//공통 그룹코드 목록 카운트 조회
		int totalCount = equipmentControlService.countListEquip(paramMap);

		resultMap.put("totalCount", totalCount);
		resultMap.put("pageSize", pageSize);
		resultMap.put("currentPageComnGrpCod",currentPage);

		logger.info("+ End " + totalCount + ".countListEquip");


	
		
		        
		return resultMap;

	}
	
	/**
	 *  과정 저장
	 */
	@RequestMapping("saveEquip.do")
	@ResponseBody
	public Map<String, Object> saveCourse(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception {
		
		logger.info("+ Start " + className + ".saveEquip");
		logger.info("   - paramMap : " + paramMap);
		
		String action = (String)paramMap.get("action");
		String result = "SUCCESS";
		String resultMsg = "저장 되었습니다.";
		
		if ("I".equals(action)) {
			// 과정 신규 저장
			equipmentControlService.insertEquip(paramMap);
		} else if("U".equals(action)) {
			// 과정 수정 저장
			equipmentControlService.updateEquip(paramMap);
			
			System.out.println(paramMap);
		} else {
			result = "FALSE";
			resultMsg = "알수 없는 요청 입니다.";
		}
		
		Map<String, Object> resultMap = new HashMap<String, Object>();
		resultMap.put("result", result);
		resultMap.put("resultMsg", resultMsg);
		
		logger.info("+ End " + className + ".saveEquip");
		
		return resultMap;
	}
	
	

	/**
	 *  과정 단건 조회
	 */
	@RequestMapping("Equipsel.do")
	@ResponseBody
	public Map<String, Object> coursesel (Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception {
		
		logger.info("+ Start " + className + ".Equipsel");
		logger.info("   - paramMap : " + paramMap);

		String result = "SUCCESS";
		String resultMsg = "조회 되었습니다.";
		
		// 공통 그룹 코드 단건 조회
		EquipmentControlModel equipinfo = equipmentControlService.selectEquip(paramMap);
		
		Map<String, Object> resultMap = new HashMap<String, Object>();
		resultMap.put("result", result);
		resultMap.put("resultMsg", resultMsg);
		resultMap.put("equipinfo", equipinfo);
		
		logger.info("+ End " + className + ".Equipsel");
		
		
		
		
		return resultMap;
	}
	
	
	
	/**
	 *  장비 삭제
	 */
	@RequestMapping("Equipdel.do")
	@ResponseBody
	public Map<String, Object> coursedel(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception {
		
		logger.info("+ Start " + className + ".Equipdel");
		logger.info("   - paramMap : " + paramMap);
		
		System.out.println(paramMap);
		String result = "SUCCESS";
		String resultMsg = "삭제 되었습니다.";
		
		// 과정 삭제
		equipmentControlService.delEquip(paramMap);
		
		Map<String, Object> resultMap = new HashMap<String, Object>();
		resultMap.put("result", result);
		resultMap.put("resultMsg", resultMsg);
		
		logger.info("+ End " + className + ".Equipdel");
		
		return resultMap;
	}


	
	
	
	
	
	
	
}
	
