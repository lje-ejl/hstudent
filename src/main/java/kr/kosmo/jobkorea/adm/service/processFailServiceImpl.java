package kr.kosmo.jobkorea.adm.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.kosmo.jobkorea.adm.dao.processFailDao;
import kr.kosmo.jobkorea.adm.model.processFailModel;




@Service
public class processFailServiceImpl implements processFailService {

	@Autowired
	processFailDao processFailDao;
	
	
	//강의실 리스트 조회
	@Override
	public List<processFailModel> lec_List_Select(Map<String, Object> paramMap) throws Exception {
		List<processFailModel> lec_List_Select = processFailDao.lec_List_Select(paramMap);
		return lec_List_Select;
	}

	//강의실 리스트 카운트 조회
	@Override
	public int lec_Cnt_Select(Map<String, Object> paramMap) throws Exception {
		
		int lec_Total = processFailDao.lec_Cnt_Select(paramMap);
		
		return lec_Total;
	}
	//통계 리스트 조회
	@Override
	public List<processFailModel> lec_Name_List(Map<String, Object> paramMap) throws Exception {
		List<processFailModel> lec_Name_List = processFailDao.lec_Name_List(paramMap);
		return lec_Name_List;
	}


}
	

