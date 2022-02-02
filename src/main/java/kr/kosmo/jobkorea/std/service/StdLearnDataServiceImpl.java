package kr.kosmo.jobkorea.std.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.kosmo.jobkorea.std.dao.StdLearnDataDao;
import kr.kosmo.jobkorea.std.model.StdLearnDataModel;
@Service
public class StdLearnDataServiceImpl implements StdLearnDataService {

	/* 2020.11.13 임지은 
	 * Autowired는 팔짱이다!(연결고리)
	 * MVC(Model, View, Controller)패턴에서 
	 * controller는 service와 팔짱
	 * service는 dao와 팔짱!
	 * service는 controller와 dao사이에서 왔다갔다하면서 서빙하는 역할.
	 * */
	@Autowired
	StdLearnDataDao stdLearnDataDao;

	@Override
	public List<StdLearnDataModel> dataList(Map<String, Object> paramMap) {
		List<StdLearnDataModel> dataList = stdLearnDataDao.dataList(paramMap);
		return dataList;
	}

	@Override
	public int dataCount(Map<String, Object> paramMap) {
		int dataCount = stdLearnDataDao.dataCount(paramMap);
		return dataCount;
	}

	@Override
	public StdLearnDataModel dataInfo(Map<String, Object> paramMap) {
		StdLearnDataModel dataInfo = stdLearnDataDao.dataInfo(paramMap);
		return dataInfo;
	}

	@Override
	public StdLearnDataModel myLecture(Map<String, Object> paramMap) {
		StdLearnDataModel myLecture = stdLearnDataDao.myLecture(paramMap);
		return myLecture;
	}

}
