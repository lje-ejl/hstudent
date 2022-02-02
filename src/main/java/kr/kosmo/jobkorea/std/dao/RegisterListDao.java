package kr.kosmo.jobkorea.std.dao;

import java.util.List;
import java.util.Map;

import kr.kosmo.jobkorea.std.model.RegisterListModel;
import kr.kosmo.jobkorea.std.model.SurveyListModel;

public interface RegisterListDao {
	//학생 수강 정보 조회
	public RegisterListModel selectRegisterList (Map<String, Object> paramMap) throws Exception;
	//학생 출석 상태 조회
	public RegisterListModel countAtdState (Map<String, Object> paramMap) throws Exception;
	/** 학생 수강 정보 카운트*/
	public int totalCnt(Map<String, Object> paramMap) throws Exception;
	//설문지조회
	public List<SurveyListModel> srvyqueList (Map<String, Object> paramMap) throws Exception;
	//질문 개수 카운트
	public int countsrvyList(Map<String, Object> paramMap) throws Exception;
	//설문답&리뷰
	public int srvyQueSub(Map<String, Object> paramMap) throws Exception;
	public void srvyReview(Map<String, Object> paramMap) throws Exception;
	//설문완료상태 변경
	public void stdSrvy_chk(Map<String, Object> paramMap) throws Exception;
	//설문카운트를 위한 조회 srvyList
	public int srvyList(Map<String, Object> paramMap) throws Exception;
	//처음 하는 거면 insert 해주기
	public void srvyCntInsert (Map<String, Object> paramMap) throws Exception;
	//설문 카운트 넣어주기
	public void srvyCnt (Map<String, Object> paramMap) throws Exception;
	
	
}
