package kr.kosmo.jobkorea.adm.dao;

import java.util.List;
import java.util.Map;

import kr.kosmo.jobkorea.adm.model.c_SurveyControlModel;

/* 정수빈 작업 */
public interface c_SurveyControlDao {

	// 강사 리스트
	public List<c_SurveyControlModel> tut_List_Select(Map<String, Object> paramMap);

	// 강사  총 인원수
	public c_SurveyControlModel tut_Cnt_Select(Map<String, Object> paramMap);
	 
	// 강의 리스트
	public List<c_SurveyControlModel> lec_List_Select(Map<String, Object> paramMap) ;
	
	// 강의 총 개수
	public c_SurveyControlModel lec_Cnt_Select(Map<String, Object> paramMap);
	
	// 설문지 문항	
	public c_SurveyControlModel srvy_One_Select(Map<String, Object> paramMap);
	
	// 설문지 10번
	public List<c_SurveyControlModel> c_srvy_Que10_Select(Map<String, Object> paramMap) ;
	
	// 설문지 10번 총 개수
	public c_SurveyControlModel c_srvy_Que10_Num_Select(Map<String, Object> paramMap) ;
}
