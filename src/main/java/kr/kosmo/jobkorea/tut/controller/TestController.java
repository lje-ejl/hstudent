package kr.kosmo.jobkorea.tut.controller;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
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
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.kosmo.jobkorea.tut.model.AttendanceModel;
import kr.kosmo.jobkorea.tut.model.LecInfo;
import kr.kosmo.jobkorea.tut.model.LecStdInfo;
import kr.kosmo.jobkorea.tut.model.TestEnroll;
import kr.kosmo.jobkorea.tut.model.TestModel;
import kr.kosmo.jobkorea.tut.model.TestQue;
import kr.kosmo.jobkorea.tut.service.TestService;

@Controller
@RequestMapping("/tut")
public class TestController {
	
	@Autowired
	TestService TestService;
	
	/**
	 * 게시글 목록 조회
	 */
	
	// Set logger
		private final Logger logger = LogManager.getLogger(this.getClass());

		// Get class name for logger
		
		
	
	@RequestMapping("/checkGrades.do")
	public String checkGrades(@RequestParam Map<String, Object> paramMap,Model model,HttpSession session)throws Exception {

		  String tutor_id = (String) session.getAttribute("loginId");
	      paramMap.put("tutor_id", tutor_id);
	      List<LecInfo> lecture_List = TestService.lecture_List_Select(paramMap);
	      model.addAttribute("lecture_List", lecture_List);
		
		
		return "tut/learn_mng/checkGrades";
	}
	
	
	/*
	 * 수강생목록 조회(시험ID로 ajax)
	 */
	
	@ResponseBody
	@RequestMapping("/listStu")
	public List<TestModel> listStu(int test_id)throws Exception {

//		int currentPage = Integer.parseInt((String)paramMap.get("currentPage"));	// 현재 페이지 번호
//		int pageSize = Integer.parseInt((String)paramMap.get("pageSize"));			// 페이지 사이즈
//		int pageIndex = (currentPage-1)*pageSize;												// 페이지 시작 row 번호
				
//		paramMap.put("pageIndex", pageIndex);
//		paramMap.put("pageSize", pageSize);
		
		List<TestModel> listStu = TestService.listStu(test_id);
		
		return listStu;
	}
	
	/**
	 * 시험문제관리 페이지 이동
	 */
	
	@RequestMapping("/testControl.do")
	public String testControl(@RequestParam Map<String, Object> paramMap,HttpSession session,Model model)throws Exception {
		
		  String tutor_id = (String) session.getAttribute("loginId");
	      paramMap.put("tutor_id", tutor_id);
	      List<LecInfo> lecture_List = TestService.lecture_List_Select(paramMap);
	      model.addAttribute("lecture_List", lecture_List);
		
		return "tut/learn_mng/test";
	}
	
	@RequestMapping("/attendanceControl.do")
	public String atdMng(@RequestParam Map<String, Object> paramMap,HttpSession session,Model model)throws Exception {
		
		  String tutor_id = (String) session.getAttribute("loginId");
	      paramMap.put("tutor_id", tutor_id);
	      List<LecInfo> lecture_List = TestService.lecture_List_Select(paramMap);
	      model.addAttribute("lecture_List", lecture_List);
		
		return "tut/learn_mng/atdMngTest";
	}
	
	@ResponseBody
	@RequestMapping("/atdList")
	public List<AttendanceModel> atdList(int lec_id,HttpSession session)throws Exception {

		
		List<AttendanceModel> result = TestService.atdList(lec_id);
		
		return result;
	}
	
	@ResponseBody
	@RequestMapping("/atdAll")
	public List<AttendanceModel> atdAll(int lec_id){
		
		List<AttendanceModel> result = TestService.atdAll(lec_id);
		
		return result;
	}
	

	@RequestMapping("/atdMng_Detail")
	public String atdMng_Detail(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,  HttpServletResponse response, HttpSession session) throws Exception {

		List<AttendanceModel> result = TestService.nameList(Integer.parseInt((String) paramMap.get("lec_id")));
		ArrayList list = new ArrayList();

		for (int i = 0; i < result.size(); i++) {
			String[] a = result.get(i).getAll_state().split(",");
			String[] re = new String[a.length + 1];
			re[0] = result.get(i).getName();
			for (int j = 1; j < re.length; j++) {
				re[j] = a[j - 1];
			}
			list.add(re);
			paramMap.put("result", list);
		}
		model.addAttribute("atd_Date_List", TestService.atd_Date(paramMap));
		model.addAttribute("atd_std_List", list);

		return "/tut/learn_mng/atdMngTest2";
	}
	
	
	/**
	* 시험문제 등록
	*/
	@ResponseBody
	@RequestMapping(value = "/testEnroll")
	public String testEnroll(TestEnroll testEnroll,@RequestParam Map<String, Object> paramMap,
			HttpServletRequest request,  HttpServletResponse response, HttpSession session) {
		
		String test_start = (String)paramMap.get("test_start");
		String test_end = (String)paramMap.get("test_end");

		
		paramMap.put("test_start", test_start.substring(6,10)+ test_start.substring(0,2)+ test_start.substring(3,5));
		paramMap.put("test_end", test_end.substring(6,10)+ test_end.substring(0,2)+ test_end.substring(3,5));
		
		System.out.println("sdafdsafdsafdsafsdaf"+paramMap.get("test_name"));
		
		int result = TestService.testEnroll(paramMap);
			
		return null;
	}
	
	@ResponseBody
	@RequestMapping("/getLecId")
	public int getLecId(String lec_name,Model model,HttpSession session)throws Exception {

		
		LecInfo lecInfo = TestService.searchLec(lec_name);
		
		int lec_id = lecInfo.getLec_id();
		
		return lec_id;
	}
	
	
	
	/*
	 * 강의id로 시험응시정보 불러오기
	*/
	@ResponseBody
	@RequestMapping("/listTest")
	public List<TestEnroll> listTest(int lec_id,HttpSession session)throws Exception {

		List<TestEnroll> listTest = TestService.listTest(lec_id);
		
		return listTest;
	}
	
	@RequestMapping(value = "examRegist", method = RequestMethod.GET)
	public String examRegist(int test_id, Model model,HttpSession session,@RequestParam Map<String, Object> paramMap) {
		// DB cust_number에대한 프로필 내용을 가져옴.
		TestEnroll result = TestService.searchByTestId(test_id);
		List<TestQue> queList = TestService.listQue(test_id);
		int resultId = result.getLec_id();
		LecInfo result2 = TestService.InfoById(resultId);
		String tut_name = result2.getTutor_name();
		String lecName = result2.getLec_name();
		
		List<TestEnroll> Test_List = TestService.listTest(resultId);
		
		String tutor_id = (String)session.getAttribute("loginId");
	    paramMap.put("tutor_id", tutor_id);
	    List<LecInfo> lecture_List = TestService.lecture_List_Select(paramMap);
	    model.addAttribute("Lec_Id, resultId");
	    model.addAttribute("lecture_List", lecture_List);
		model.addAttribute("test_List", Test_List);
		model.addAttribute("queList", queList);
		model.addAttribute("tut_name",tut_name );
		model.addAttribute("lecName", lecName );
		model.addAttribute("test_id", test_id);
		
		return "tut/learn_mng/examRegist";
	}
	
	@ResponseBody
	@RequestMapping("/queReg")
	public String queReg(TestQue testQue,@RequestParam Map<String, Object> paramMap){
		
		if(TestService.searchByNum(paramMap)!=null){
			return "fail";
		}else{
			TestService.queReg(testQue);
		}
		return "success";
	}
	
	@ResponseBody
	@RequestMapping("/listQue")
	public List<TestQue> listQue (int test_id){
		
		List<TestQue> listQue = TestService.listQue(test_id);
		
		return listQue;
		
	}
	
	@ResponseBody
	@RequestMapping("/updQue")
	public Map<String, Object> updQue(@RequestParam Map<String, Object> paramMap,HttpServletRequest request){
		
		int test_id = Integer.parseInt(String.valueOf(paramMap.get("test_id")));
		int que_num = Integer.parseInt(String.valueOf(paramMap.get("que_num")));
		System.out.println("sdfagfsdgfdsg"+test_id+que_num);
		System.out.println("1111111111111111");
		int result = TestService.updateQue(paramMap);
		System.out.println("2222222222222222");
		return null;
		
	}
	
	@ResponseBody
	@RequestMapping("/deleteQue")
	public Map<String, Object> deleteQue(@RequestParam Map<String, Object> paramMap){
		
		int test_id = Integer.parseInt(String.valueOf(paramMap.get("test_id")));
		int que_num = Integer.parseInt(String.valueOf(paramMap.get("que_num")));
		System.out.println("!!!!!!!!!!!!!!!!!!!!!!!!!"+test_id+que_num);
		int result = TestService.deleteQue(paramMap);
		
		return null;
	}
	
	@ResponseBody
	@RequestMapping("/setUpdate")
	public TestQue setUpdate(@RequestParam Map<String, Object> paramMap){
		
		int test_id = Integer.parseInt(String.valueOf(paramMap.get("test_id")));
		int que_num = Integer.parseInt(String.valueOf(paramMap.get("que_num")));
		
		TestQue result = TestService.searchByNum(paramMap);
		
		return result;
	}
	@ResponseBody
	@RequestMapping("/atdReg")
	public Map<String, Object> atdReg(Model model, @RequestParam(value="Arr[]") List<String> Arr, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,  HttpServletResponse response, HttpSession session) throws Exception {
	      
		
		  SimpleDateFormat format1 = new SimpleDateFormat( "yyyy-MM-dd");
		  Date time = new Date();
		  String time1 = format1.format(time);
		  paramMap.put("len_date", time1);
		  System.out.println("!!!!"+time1);
	      List<AttendanceModel> list_atd = new ArrayList<AttendanceModel>();
	      int lecId = 0;
	      for(String list : Arr) {
	    	  AttendanceModel result = new AttendanceModel();
	         String[] a = list.split(",");
	         result.setLec_id(Integer.parseInt(a[0]));
	         result.setStd_id(a[1]);
	         result.setAtd_state(a[2]);
	         result.setLen_date(time1);
	         lecId = result.getLec_id();
	         paramMap.put("lec_id", lecId);
	         list_atd.add(result);
	         paramMap.put("result", result);
	        }
	      if(TestService.searchByDate(paramMap).size()==0){
	    	  int a = TestService.atd_plus(lecId);
	      }
	      for (int i = 0; i<list_atd.size(); i++) {
	    	  AttendanceModel sys = new AttendanceModel();
	    	  sys = TestService.searchAtd(list_atd.get(i));
	    	  System.out.println(sys);
	    	  if(TestService.searchAtd(list_atd.get(i))== null){
	    		TestService.atdStd(list_atd.get(i));
	    	  }else{
	    		  int result = TestService.updateAtd(list_atd.get(i));
	    	  }
		}
	      return paramMap;
	   }   
}
