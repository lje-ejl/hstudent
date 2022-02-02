package kr.kosmo.jobkorea.std.service;

import java.util.List;
import java.util.Map;

import kr.kosmo.jobkorea.std.model.TestUser;
import kr.kosmo.jobkorea.tut.model.TestQue;

public interface TestApplicationsService {
	
	// 시험조회
	List<TestUser> selectTest(Map<String, Object> paramMap)throws Exception;

	// 시험 카운트 조회
	int countListComnGrpCod(Map<String, Object> paramMap)throws Exception;

	// 시험 문제 조회
	List<TestQue> applyTest(Map<String, Object> paramMap)throws Exception;

	// 시험 제출
	int submitTest(Map<String, Object> paramMap)throws Exception;
	
	// 시험 결과 조회
	TestQue selectAns(Map<String, Object> paramMap)throws Exception;
  
}
