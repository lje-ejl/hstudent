package kr.kosmo.jobkorea.tut.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import kr.kosmo.jobkorea.tut.model.TestModel;
import kr.kosmo.jobkorea.tut.model.TestQue;
import kr.kosmo.jobkorea.tut.model.AttendanceModel;
import kr.kosmo.jobkorea.tut.model.LecInfo;
import kr.kosmo.jobkorea.tut.model.TestEnroll;

public interface TestService {
	
//수강생 목록 조회	
	public List<TestModel> listStu(int test_id)throws Exception;

	public int testEnroll(Map<String, Object> paramMap);
//	/** 게시글 목록 조회 */
//	public List<CmntBbsModel> listCmntBbs(Map<String, Object> paramMap) throws Exception;

	public List<TestEnroll> listTest(int lec_id);
	
	public LecInfo searchLec(String lec_name);
	
	public TestEnroll searchByTestId(int test_id);
	
	public LecInfo InfoById(int lec_id);
	
	public List<TestQue> listQue(int test_id);
	
	public int queReg(TestQue testQue);
	
	public int deleteQue(Map<String, Object> paramMap);

	public TestQue searchByNum(Map<String, Object> paramMap);
	
	public int updateQue(Map<String, Object> paramMap);

	public List<LecInfo> lecture_List_Select(Map<String, Object> paramMap);

	public List<AttendanceModel> atdList(int lec_id);
	
	public int atdStd(AttendanceModel attendanceModel);
	
	public AttendanceModel searchAtd(AttendanceModel attendanceModel);
	
	public int updateAtd(AttendanceModel attendanceModel);
	
	public List<AttendanceModel> atdAll(int lec_id);
	
	public List<AttendanceModel> nameList(int lec_id);
	
	public List<AttendanceModel> atd_Date(Map<String, Object> paramMap);	
	
	public int atd_plus(int lec_id);
	
	public List<AttendanceModel> searchByDate(Map<String, Object> paramMap);
	
}
