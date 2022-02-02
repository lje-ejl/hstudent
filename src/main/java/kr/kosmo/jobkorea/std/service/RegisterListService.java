package kr.kosmo.jobkorea.std.service;

import java.util.List;
import java.util.Map;

import kr.kosmo.jobkorea.std.model.RegisterListModel;
import kr.kosmo.jobkorea.std.model.SurveyListModel;

public interface RegisterListService {
	//학생 수강 정보 조회
	public RegisterListModel regListModel (Map<String, Object> paramMap) throws Exception;
	//학생 출석 상태 조회
	public RegisterListModel regListCount (Map<String, Object> paramMap) throws Exception;
	//학생 수강 카운트  (수강이 없을 경우)
	public int totalCnt(Map<String, Object> paramMap) throws Exception;
	//강의 설문지 조회
	public List<SurveyListModel> srvyqueList (Map<String, Object> paramMap) throws Exception;
	//설문 질문 카운트
	public int countsrvyList(Map<String, Object> paramMap) throws Exception;
	
	//설문답 (버튼, 리뷰)
	public void srvyQueSub(Map<String, Object> paramMap) throws Exception;
	public void srvyReview(Map<String, Object> paramMap) throws Exception;
	//설문완료상태 변경
	public void stdSrvy_chk(Map<String, Object> paramMap) throws Exception;
	
}
