package kr.kosmo.jobkorea.tut.service;
import java.util.List;
import java.util.Map;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import kr.kosmo.jobkorea.tut.dao.SurveyControlDao;
import kr.kosmo.jobkorea.tut.model.SurveyControlModel;

/* 정수빈 작업 */
@Service
public class SurveyControlServiceImpl implements SurveyControlService{
	
	@Autowired
	SurveyControlDao surveyControlDao;

	// 강의 목록
	@Override
	public List<SurveyControlModel> lecture_List_Select( Map<String, Object> paramMap ) {
		return surveyControlDao.lecture_List_Select(paramMap);
	}

	// 강의 설문 상세
	@Override
	public SurveyControlModel survery_Detail_Select(Map<String, Object> paramMap) {
		return surveyControlDao.survery_Detail_Select(paramMap);
	}

	// 설문지 문항
	@Override
	public SurveyControlModel  srvy_Que_Select(Map<String, Object> paramMap) {
		return surveyControlDao.srvy_Que_Select(paramMap);
	}

	// 강의 개수
	@Override
	public SurveyControlModel lecture_Cnt_Select(Map<String, Object> paramMap) {
		return surveyControlDao.lecture_Cnt_Select(paramMap);
	}

	// 설문지 10번
	@Override
	public List<SurveyControlModel> c_srvy_Que10_Select(Map<String, Object> paramMap) {
		return surveyControlDao.c_srvy_Que10_Select(paramMap);
	}

	// 설문지 10번 총 개수
	@Override
	public SurveyControlModel c_srvy_Que10_Num_Select(Map<String, Object> paramMap) {
		return surveyControlDao.c_srvy_Que10_Num_Select(paramMap);
	}

	// 설문지 문항	
	@Override
	public List<SurveyControlModel> srvy_One_Select(Map<String, Object> paramMap) {
		return surveyControlDao.srvy_One_Select(paramMap);
	}
}
