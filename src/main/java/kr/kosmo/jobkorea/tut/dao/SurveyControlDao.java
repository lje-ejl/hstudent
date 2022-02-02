package kr.kosmo.jobkorea.tut.dao;
import java.util.List;
import java.util.Map;

import kr.kosmo.jobkorea.adm.model.c_SurveyControlModel;
import kr.kosmo.jobkorea.tut.model.SurveyControlModel;

/* 정수빈 작업 */
public interface SurveyControlDao {
	
	// 강의 목록
	public List<SurveyControlModel> lecture_List_Select( Map<String, Object> paramMap );
	
	// 강의 설문 상세
	public SurveyControlModel survery_Detail_Select( Map<String, Object> paramMap );
	
	// 설문지 문항
	public SurveyControlModel srvy_Que_Select( Map<String, Object> paramMap);
	
	// 강의 개수
	public SurveyControlModel lecture_Cnt_Select(Map<String, Object> paramMap);
	
	// 설문지 10번
	public List<SurveyControlModel> c_srvy_Que10_Select(Map<String, Object> paramMap) ;
	
	// 설문지 10번 총 개수
	public SurveyControlModel c_srvy_Que10_Num_Select(Map<String, Object> paramMap) ;
	
	// 설문지 문항	
	public List<SurveyControlModel>  srvy_One_Select(Map<String, Object> paramMap);
}
