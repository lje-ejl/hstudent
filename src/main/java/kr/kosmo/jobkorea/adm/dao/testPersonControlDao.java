package kr.kosmo.jobkorea.adm.dao;

import java.util.List;
import java.util.Map;


import kr.kosmo.jobkorea.adm.model.testPersonControlModel;


public interface testPersonControlDao {
	
		//강의 목록 조회
		public List<testPersonControlModel> list_lec(Map<String, Object> paramMap)throws Exception;
		
		//강의 수 조회
		public Integer cnt_list_lec(Map<String, Object> paramMap)throws Exception;

		//시험 목록 조회
		public List<testPersonControlModel> list_test(Map<String, Object> paramMap)throws Exception;
		
		//시험 수 조회
		public int cnt_list_test(Map<String, Object> paramMap)throws Exception;
		
		//학생 목록 조회 
		public List<testPersonControlModel> std_test(Map<String, Object> paramMap) throws Exception;
		
		//학생 수 조회 
		public int cnt_std_test(Map<String, Object> paramMap) throws Exception;
		
		
}
