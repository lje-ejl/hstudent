package kr.kosmo.jobkorea.tut.controller;

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
import kr.kosmo.jobkorea.tut.model.LectureStudentInfoModel;
import kr.kosmo.jobkorea.tut.service.LectureStudentInfoService;

@Controller
@RequestMapping("/tut/")
public class LectureStudentInfoController {
   
   @Autowired
   LectureStudentInfoService lectureStudentInfoService;
   
   
   //초기화면 : 강의목록과 강의정보 수강생정보 한번에 불러오기 강의번호가 높은 순으로(강의번호 숫자가 클수록 최근에 만들어진 강좌라고 가정)
   @RequestMapping("lectureStudentInfo.do")
   public String lectureStudentInfo (Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request, HttpServletResponse response, HttpSession session) throws Exception{

      String tutor_id = (String) session.getAttribute("loginId");
      paramMap.put("tutor_id", tutor_id);
      
      List<LectureStudentInfoModel> lectureList = lectureStudentInfoService.showLectureList(paramMap);
      model.addAttribute("lectureList", lectureList);
      
      paramMap.put("lec_id", lectureList.get(0).getLec_id());
      
      List<LectureStudentInfoModel> lectureInfo = lectureStudentInfoService.showLectureInfo(paramMap);
      model.addAttribute("lectureInfo", lectureInfo);

      List<LectureStudentInfoModel> studentsInfo = lectureStudentInfoService.showStudentsInfo(paramMap);
      model.addAttribute("studentsInfo", studentsInfo);
      
      return "tut/learn_mng/lectureStudentInfo";
   }
   
   @RequestMapping("lectureStudentInfo2.do")
   public String lectureStudentInfo2 (Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request, HttpServletResponse response, HttpSession session) throws Exception{
      
      String tutor_id = (String) session.getAttribute("loginId");
      paramMap.put("tutor_id", tutor_id);
      List<LectureStudentInfoModel> lectureList = lectureStudentInfoService.showLectureList(paramMap);
      
      model.addAttribute("lectureList", lectureList);
      
      return "tut/learn_mng/lectureStudentInfo";
   }
   
   
   
   @RequestMapping("selectedLectureInfo.do")
   public String showLectureInfo(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request, HttpServletResponse response, HttpSession session) throws Exception{
	   String lec_id = request.getParameter("lec_id");
	   paramMap.put("lec_id", Integer.parseInt(lec_id));
	   
	   List<LectureStudentInfoModel> lectureInfo = lectureStudentInfoService.showLectureInfo(paramMap);
	   model.addAttribute("lectureInfo", lectureInfo);
		      
	   List<LectureStudentInfoModel> studentsInfo = lectureStudentInfoService.showStudentsInfo(paramMap);
	   model.addAttribute("studentsInfo", studentsInfo);
		      
	   return "tut/learn_mng/lectureStudentInfo";
   }
   
   
   
   @RequestMapping("approveUpdate1.do")
   public void approveUpdate1(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request, HttpServletResponse response, HttpSession session) throws Exception{
	   String std_id = (String) paramMap.get("loginID");
	   paramMap.put("std_id", std_id);
	   String lec_id = (String) paramMap.get("lec_id");
	   paramMap.put("lec_id", Integer.parseInt(lec_id));
	   
	   lectureStudentInfoService.approveUpdate1(paramMap);
	   lectureStudentInfoService.attendanceUpdate1(paramMap);
   }
   
   @RequestMapping("approveUpdate2.do")
   public void approveUpdate2(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request, HttpServletResponse response, HttpSession session) throws Exception{
	   String std_id = (String) paramMap.get("loginID");
	   paramMap.put("std_id", std_id);
	   String lec_id = (String) paramMap.get("lec_id");
	   paramMap.put("lec_id", Integer.parseInt(lec_id));
	   
	   lectureStudentInfoService.approveUpdate2(paramMap);
	   lectureStudentInfoService.attendanceUpdate2(paramMap);
	   lectureStudentInfoService.deleteStudent(paramMap);
	   lectureStudentInfoService.decreasePrePnum(paramMap);
   }
   
   
   @RequestMapping("setApv.do")
   public void setApv(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request, HttpServletResponse response, HttpSession session) throws Exception{
	   String lec_id = (String) paramMap.get("lec_id");
	   paramMap.put("lec_id", lec_id);
	   lectureStudentInfoService.setApv(paramMap);
   }
}