package kr.kosmo.jobkorea.adm.service;

import java.util.List;
import java.util.Map;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import kr.kosmo.jobkorea.adm.dao.c_SurveyControlDao;
import kr.kosmo.jobkorea.adm.model.c_SurveyControlModel;

/* 정수빈 작업 */
@Service
public class c_SurveyControlServiceImpl implements c_SurveyControlService{

	@Autowired 
	c_SurveyControlDao c_SurveyControlDao;

	// 강사 리스트
	@Override
	public List<c_SurveyControlModel> tut_List_Select(Map<String, Object> paramMap) {
		return c_SurveyControlDao.tut_List_Select(paramMap);
	}

	// 강사  총 인원수
	@Override
	public c_SurveyControlModel tut_Cnt_Select(Map<String, Object> paramMap) {
		return c_SurveyControlDao.tut_Cnt_Select(paramMap);
	}

	// 강의 리스트
	@Override
	public List<c_SurveyControlModel> lec_List_Select(Map<String, Object> paramMap) {
		return c_SurveyControlDao.lec_List_Select(paramMap);
	}

	// 강의 총 개수
	@Override
	public c_SurveyControlModel lec_Cnt_Select(Map<String, Object> paramMap) {
		return c_SurveyControlDao.lec_Cnt_Select(paramMap);
	}

	// 설문지
	@Override
	public c_SurveyControlModel srvy_One_Select(Map<String, Object> paramMap) {
		return c_SurveyControlDao.srvy_One_Select(paramMap);
	}

	// 설문지 10번
	@Override
	public List<c_SurveyControlModel> c_srvy_Que10_Select(Map<String, Object> paramMap) {
		return c_SurveyControlDao.c_srvy_Que10_Select(paramMap);
	}

	// 설문지 10번 총 개수
	@Override
	public c_SurveyControlModel c_srvy_Que10_Num_Select(Map<String, Object> paramMap) {
		return c_SurveyControlDao.c_srvy_Que10_Num_Select(paramMap);
	}
}
