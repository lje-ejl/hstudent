package kr.kosmo.jobkorea.adm.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.kosmo.jobkorea.adm.dao.testPersonControlDao;
import kr.kosmo.jobkorea.adm.model.RegisterListControlModel;
import kr.kosmo.jobkorea.adm.model.testPersonControlModel;
import kr.kosmo.jobkorea.login.model.RegisterInfoModel;



@Service
public class TestPersonControlServiceImpl implements TestPersonControlService {

	
	@Autowired
	testPersonControlDao testPerDao;
	
	@Override
	public List<testPersonControlModel> list_lec(Map<String, Object> paramMap) throws Exception {
		
		List<testPersonControlModel> list_lec = testPerDao.list_lec(paramMap);
		
		return list_lec;
	}

	
	public int cnt_list_lec(Map<String, Object> paramMap) throws Exception {
		
		int cnt_list_lec = testPerDao.cnt_list_lec(paramMap);
		
		return cnt_list_lec;
	}

	@Override
	public List<testPersonControlModel> list_test(Map<String, Object> paramMap) throws Exception {

		List<testPersonControlModel> list_test = testPerDao.list_test(paramMap);
		
		return list_test;
	}

	@Override
	public int cnt_list_test(Map<String, Object> paramMap) throws Exception {
		
		int cnt_list_test = testPerDao.cnt_list_test(paramMap);
		
		return cnt_list_test;
	}

	@Override
	public List<testPersonControlModel> std_test(Map<String, Object> paramMap) throws Exception {
		
		List<testPersonControlModel> std_test = testPerDao.std_test(paramMap);
		
		return std_test;
	}

	@Override
	public int cnt_std_test(Map<String, Object> paramMap) throws Exception {
		
		int cnt_std_test = testPerDao.cnt_std_test(paramMap);
		
		return cnt_std_test;
	}

}
