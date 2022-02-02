package kr.kosmo.jobkorea.tut.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.kosmo.jobkorea.tut.dao.ProgressControlDao;
import kr.kosmo.jobkorea.tut.model.ProgressControlModel;

@Service
public class ProgressControlServiceImpl implements ProgressControlService{
	
	@Autowired
	private ProgressControlDao progressControlDao;

	@Override
	public List<ProgressControlModel> showLectureList(Map<String, Object> paramMap) throws Exception {
		return progressControlDao.showLectureList(paramMap);
	}

	@Override
	public List<ProgressControlModel> showLectureInfo(Map<String, Object> paramMap) throws Exception {
		return progressControlDao.showLectureInfo(paramMap);
	}
	
	public List<ProgressControlModel> showWeekplan(Map<String, Object> paramMap) throws Exception{
		return progressControlDao.showWeekplan(paramMap);
	}

	@Override
	public List<ProgressControlModel> countDay(Map<String, Object> paramMap) throws Exception {
		// TODO Auto-generated method stub
		return progressControlDao.countDay(paramMap);
	}
}
