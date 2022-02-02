package kr.kosmo.jobkorea.std.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.kosmo.jobkorea.std.dao.LecListDao;
import kr.kosmo.jobkorea.std.model.LecListModel;
@Service
public class LecListServiceImpl implements LecListService {

	/* 2020.11.13 임지은 
	 * Autowired는 팔짱이다!(연결고리)
	 * MVC(Model, View, Controller)패턴에서 
	 * controller는 service와 팔짱
	 * service는 dao와 팔짱!
	 * service는 controller와 dao사이에서 왔다갔다하면서 서빙하는 역할.
	 * */
	@Autowired
	LecListDao lecListDao;
	
	/** 강의 목록 조회 */
	@Override
	public List<LecListModel> listLec(Map<String, Object> paramMap) {
		List<LecListModel> listLec = lecListDao.listLec(paramMap);
		return listLec;
	}
	
	/** 강의 목록 카운트 조회 - 페이징 위해서 필요함! */
	@Override
	public int countListLec(Map<String, Object> paramMap) {
		int totalCount = lecListDao.countListLec(paramMap);
		return totalCount;
	}
	
	@Override
	public LecListModel lecInfo(Map<String, Object> paramMap){
		LecListModel lecInfo = lecListDao.lecInfo(paramMap);
		return lecInfo;
	}
	
	@Override
	public List<LecListModel> lecWeekPlan(Map<String, Object> paramMap)throws Exception{
		List<LecListModel> lecWeekPlan = lecListDao.lecWeekPlan(paramMap);
		return lecWeekPlan;
	}
	
	@Override
	public int lecApply(Map<String, Object> paramMap)throws Exception{
		int result = lecListDao.lecApply(paramMap);
		return result;
	}
	
	@Override
	public int lecApply2(Map<String, Object> paramMap)throws Exception{
		int result = lecListDao.lecApply2(paramMap);
		return result;
	}

	@Override
	public LecListModel numCheck(Map<String, Object> paramMap) {
		LecListModel numCheck = lecListDao.numCheck(paramMap);
		return numCheck;
	}

	@Override
	public LecListModel idCheck(Map<String, Object> paramMap) {
		LecListModel idCheck = lecListDao.idCheck(paramMap);
		return idCheck;
	}

	@Override
	public int lecCancel(Map<String, Object> paramMap) throws Exception {
		int result = lecListDao.lecCancel(paramMap);
		return result;
	}

	@Override
	public int lecCancel2(Map<String, Object> paramMap) throws Exception {
		int result = lecListDao.lecCancel2(paramMap);
		return result;
	}

	@Override
	public LecListModel okCheck(Map<String, Object> paramMap) {
		LecListModel okCheck = lecListDao.okCheck(paramMap);
		return okCheck;
	}
	

}
