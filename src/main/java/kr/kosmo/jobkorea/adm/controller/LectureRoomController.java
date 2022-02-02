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
import kr.kosmo.jobkorea.adm.service.LectureRoomService;

//이민하 작업중

@Controller
@RequestMapping("/adm/")
@Service




public class LectureRoomController {

	@Autowired
	LectureRoomService lectureRoomService;
	
	private final Logger logger = LogManager.getLogger(this.getClass());

	private final String className = this.getClass().toString();

	
	
	
	//강의실 관리 초기 화면
	@RequestMapping("lectureRoom.do")
	public String lectureRoom(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception {
		
		logger.info("+ Start " + className + ".lectureRoom");
		logger.info("   - paramMap : " + paramMap);
		
		logger.info("+ End " + className + ".lectureRoom");

		
		
		
		
		return "adm/fac_mng/LectureRoom";
	}
	
	
	//강의실 목록 리스트 뿌리기
	@RequestMapping("listLecrm.do")
	@ResponseBody
	public Map<String, Object> listLecrm(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception {
		
		logger.info("+ Start " + className + ".listLecrm");
		logger.info("   - paramMap : " + paramMap);
		
		
		int currentPage = Integer.parseInt((String)paramMap.get("currentPage"));	
		int pageSize = Integer.parseInt((String)paramMap.get("pageSize"));			// 페이지 사이즈
		int pageIndex = (currentPage-1)*pageSize;	
		
		paramMap.put("pageIndex", pageIndex);
		paramMap.put("pageSize", pageSize);
		Map<String, Object> resultMap = new HashMap<String, Object>();
		
		
		
		//강의실 목록 조회
		List<LectureRoomModel> listLecrm = lectureRoomService.listLecrm(paramMap);
		resultMap.put("listLecrm", listLecrm);
		
		logger.info("+ End " + className + ".listLecrm");


		
		
		//공통 그룹코드 목록 카운트 조회
		int totalCount = lectureRoomService.countListLecrm(paramMap);

		resultMap.put("totalCount", totalCount);
		resultMap.put("pageSize", pageSize);
		resultMap.put("currentPageComnGrpCod",currentPage);

		logger.info("+ End " + className + ".countListLecrm");

		
		return resultMap;
	}
	
	
	/*장비 목록 조회*/
	@RequestMapping("listeEquip.do")
	@ResponseBody
	public Map<String, Object> listeEquip(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception {
	
		
		logger.info("+ Start " + className + ".listeEquip");
		logger.info("   - paramMap : " + paramMap);
		
		
		int currentPage = Integer.parseInt((String)paramMap.get("currentPage"));	
		int pageSize = Integer.parseInt((String)paramMap.get("pageSize"));			// 페이지 사이즈
		int pageIndex = (currentPage-1)*pageSize;	
		
		
		paramMap.put("pageIndex", pageIndex);
		paramMap.put("pageSize", pageSize);
		Map<String, Object> resultMap = new HashMap<String, Object>();
		

		//장비 목록 조회
		List<EquipmentControlModel> listEquip = lectureRoomService.listEquip(paramMap);
		resultMap.put("listEquip", listEquip);
		logger.info("+ End " + className + ".listEquip");

		
		
		//공통 그룹코드 목록 카운트 조회
		int totalCount = lectureRoomService.countListEquip(paramMap);

		resultMap.put("totalCount", totalCount);
		resultMap.put("pageSize", pageSize);
		resultMap.put("currentPageComnGrpCod",currentPage);

		logger.info("+ End " + className + ".countListEquip");

	
		
		
		
		return resultMap;
	}
	
	
	
	/**
	 *  과정 저장
	 */
	@RequestMapping("saveLecrm.do")
	@ResponseBody
	public Map<String, Object> saveLecrm(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception {
		
		logger.info("+ Start " + className + ".saveLecrm");
		logger.info("   - paramMap : " + paramMap);
		
		String action = (String)paramMap.get("action");
		String result = "SUCCESS";
		String resultMsg = "";
		
		if ("I".equals(action)) {
			// 과정 신규 저장
			int check= lectureRoomService.insertLecrm(paramMap);
			logger.info("체에에에에엥크"+check);
			if(check>0) {
				resultMsg ="저장되었습니다.";
			}else{
				resultMsg ="중복되는 강의실 명이 있습니다";
			}
		} else if("U".equals(action)) {
			// 과정 수정 저장
			lectureRoomService.updateLecrm(paramMap);
			resultMsg = "수정되었습니다.";
			System.out.println(paramMap);
		} else {
			result = "FALSE";
			resultMsg = "알수 없는 요청 입니다.";
		}
		
		Map<String, Object> resultMap = new HashMap<String, Object>();
		resultMap.put("result", result);
		resultMap.put("resultMsg", resultMsg);
		
		logger.info("+ End " + className + ".saveLecrm");
		
		return resultMap;
	}
	
	
	
	/**
	 *  장비 삭제
	 */
	@RequestMapping("Lecrmdel.do")
	@ResponseBody
	public Map<String, Object> Lecrmdel(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception {
		
		logger.info("+ Start " + className + ".Lecrmdel");
		logger.info("   - paramMap : " + paramMap);
		
		System.out.println(paramMap);
		String result = "SUCCESS";
		String resultMsg = "삭제 되었습니다.";
		
		// 과정 삭제
		lectureRoomService.deleteLecrm(paramMap);
		
		Map<String, Object> resultMap = new HashMap<String, Object>();
		resultMap.put("result", result);
		resultMap.put("resultMsg", resultMsg);
		
		logger.info("+ End " + className + ".Lecrmdel");
		
		return resultMap;
	}
	
	
	
	/**
	 *  과정 단건 조회
	 */
	@RequestMapping("Lecrmsel.do")
	@ResponseBody
	public Map<String, Object> Lecrmsel (Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception {
		
		logger.info("+ Start " + className + ".Lecrmsel");
		logger.info("   - paramMap : " + paramMap);

		String result = "SUCCESS";
		String resultMsg = "조회 되었습니다.";
		
		// 공통 그룹 코드 단건 조회
		LectureRoomModel Lecrminfo = lectureRoomService.selectLecrm(paramMap);
		
		Map<String, Object> resultMap = new HashMap<String, Object>();
		resultMap.put("result", result);
		resultMap.put("resultMsg", resultMsg);
		resultMap.put("Lecrminfo", Lecrminfo);
		
		logger.info("+ End " + className + ".Lecrmsel");
		
		
		
		
		return resultMap;
	}
	
	
	
	
	
}
