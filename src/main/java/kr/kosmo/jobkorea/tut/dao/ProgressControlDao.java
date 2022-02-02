package kr.kosmo.jobkorea.tut.dao;

import java.util.List;
import java.util.Map;

import kr.kosmo.jobkorea.tut.model.ProgressControlModel;

public interface ProgressControlDao {
	public List<ProgressControlModel> showLectureList(Map<String, Object> paramMap);

	public List<ProgressControlModel> showLectureInfo(Map<String, Object> paramMap);
	
	public List<ProgressControlModel> showWeekplan(Map<String, Object> paramMap);

	public List<ProgressControlModel> countDay(Map<String, Object> paramMap);
}
