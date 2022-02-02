package kr.kosmo.jobkorea.tut.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import kr.kosmo.jobkorea.tut.dao.TestDao;
import kr.kosmo.jobkorea.tut.model.TestModel;
import kr.kosmo.jobkorea.tut.model.TestQue;
import kr.kosmo.jobkorea.tut.model.AttendanceModel;
import kr.kosmo.jobkorea.tut.model.LecInfo;
import kr.kosmo.jobkorea.tut.model.TestEnroll;


@Service
public class TestServiceImpl implements TestService {

	
	@Autowired
	TestDao testdao;
	
	/** 학생 목록 조회 */
	public List<TestModel> listStu(int test_id) throws Exception {
		
		List<TestModel> listStu = testdao.listStu(test_id);
		
		return listStu;
	}
	
	public int testEnroll(Map<String, Object> paramMap) {
		
		int result = testdao.testEnroll(paramMap);
		
		return result;
	}
	public List<TestEnroll> listTest(int lec_id) {
		
		List<TestEnroll> listTest = testdao.listTest(lec_id);
		
		return listTest;
	}
	
	public LecInfo searchLec(String lec_name){
		
		LecInfo lecInfo = testdao.searchLec(lec_name);
		
		return lecInfo;
	}
	
	public TestEnroll searchByTestId(int test_id){
		
		TestEnroll testInfo = testdao.searchByTestId(test_id);
		
		return testInfo;
		
	}
	
	public LecInfo InfoById(int lec_id){
		
		LecInfo lecInfo = testdao.InfoById(lec_id);
		
		return lecInfo;
	}
	
	public List<TestQue> listQue(int test_id){
		
		List<TestQue> listQue = testdao.listQue(test_id);
		
		return listQue;
		
	}
	
	public int queReg(TestQue testQue){
		
		int result = testdao.queReg(testQue);
		
		return result;
	}
	
	public int deleteQue(Map<String, Object> paramMap){
		
		int result = testdao.deleteQue(paramMap);
		
		return result;
		
	}
	
	public TestQue searchByNum(Map<String, Object> paramMap){
		
		TestQue result = testdao.searchByNum(paramMap);
		
		return result;
	}
	
	public AttendanceModel searchAtd(AttendanceModel attendanceModel){
		
		AttendanceModel result = testdao.searchAtd(attendanceModel);
		
		return result;
	}
	
	public int updateQue(Map<String, Object> paramMap){
	
		int result = testdao.updateQue(paramMap);
		
		return result;
		
	}
	
	public List<LecInfo> lecture_List_Select(Map<String, Object> paramMap){
		
		List<LecInfo> lecture_List_Select = testdao.lecture_List_Select(paramMap);
		
		return lecture_List_Select;
	}
	
	public List<AttendanceModel> atdList(int lec_id){
		
		List<AttendanceModel> result = testdao.atdList(lec_id);
				
		return result;
	}
	
	public List<AttendanceModel> atdAll(int lec_id){
		
		List<AttendanceModel> result = testdao.atdAll(lec_id);
		
		return result;
		
	}
	
	public int atdStd(AttendanceModel attendanceModel){
		
		int result = testdao.atdStd(attendanceModel);
		
		return result;
	}
	
	public int updateAtd(AttendanceModel attendanceModel){
		
		int result = testdao.updateAtd(attendanceModel);
		
		return result;
	}
	
	public List<AttendanceModel> nameList(int lec_id){
		
		List<AttendanceModel> result = testdao.nameList(lec_id);
		
		return result;
		
	}
	
	public List<AttendanceModel> atd_Date(Map<String, Object> paramMap){
		
		return testdao.atd_Date(paramMap);
	}
	
	public int atd_plus(int lec_id){
		
		return testdao.atd_plus(lec_id);
	}
	
	public List<AttendanceModel> searchByDate(Map<String, Object> paramMap){
		
		return testdao.searchByDate(paramMap);
	}
	
}
