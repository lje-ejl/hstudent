package kr.kosmo.jobkorea.tut.service;

import java.util.List;
import java.util.Map;

import kr.kosmo.jobkorea.tut.model.ProgressControlModel;

public interface ProgressControlService {
	List<ProgressControlModel> showLectureList(Map<String, Object> paramMap) throws Exception;

	List<ProgressControlModel> showLectureInfo(Map<String, Object> paramMap) throws Exception;
	
	List<ProgressControlModel> showWeekplan(Map<String, Object> paramMap) throws Exception;

	List<ProgressControlModel> countDay(Map<String, Object> paramMap) throws Exception;
}
