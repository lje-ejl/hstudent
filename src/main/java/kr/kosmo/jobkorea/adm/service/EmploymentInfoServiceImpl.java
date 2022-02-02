package kr.kosmo.jobkorea.adm.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.kosmo.jobkorea.adm.dao.EmploymentInfoDao;
import kr.kosmo.jobkorea.adm.dao.RegisterListControlDao;
import kr.kosmo.jobkorea.adm.model.EmploymentInfoModel;
import kr.kosmo.jobkorea.adm.model.RegisterListControlModel;
import kr.kosmo.jobkorea.login.model.RegisterInfoModel;

@Service
public class EmploymentInfoServiceImpl implements EmploymentInfoService {

	@Autowired
	EmploymentInfoDao empInfoDao;
	
	@Autowired
	RegisterListControlDao regListDao;
	
	@Override
	public List<EmploymentInfoModel> list_emp(Map<String, Object> paramMap) throws Exception {
		
		List<EmploymentInfoModel> list_emp = empInfoDao.list_emp(paramMap);
		
		return list_emp;
	}

	@Override
	public int cnt_list_epm(Map<String, Object> paramMap) throws Exception {
		
		int cnt_list_epm =  empInfoDao.cnt_list_epm(paramMap);
		
		return cnt_list_epm;
	}

	@Override
	public List<RegisterInfoModel> list_std(Map<String, Object> paramMap) throws Exception {
		List<RegisterInfoModel> list_std = empInfoDao.list_std(paramMap);
		
		return list_std;
	}

	@Override
	public List<RegisterInfoModel> list_comp(Map<String, Object> paramMap) throws Exception {
		List<RegisterInfoModel> list_comp = empInfoDao.list_comp(paramMap);
		return list_comp;
	}

	@Override
	public int cnt_list_std(Map<String, Object> paramMap) throws Exception {
		int cnt_list_std = empInfoDao.cnt_list_std(paramMap);
		return cnt_list_std;
	}

	@Override
	public RegisterInfoModel sel_std(Map<String, Object> paramMap) throws Exception {
		
		return empInfoDao.sel_std(paramMap);
	}

	@Override
	public List<RegisterListControlModel> list_std_lec(Map<String, Object> paramMap) throws Exception {
		List<RegisterListControlModel> list_std_lec = empInfoDao.list_std_lec(paramMap);
		return list_std_lec;
	}

	@Override
	public void insert_emp(Map<String, Object> paramMap) throws Exception {
			
		empInfoDao.insert_emp(paramMap);
		
		return;

	}

	@Override
	public void update_emp(Map<String, Object> paramMap) throws Exception {
		 	
		empInfoDao.update_emp(paramMap);
		
		return;

	}

	@Override
	public void del_emp(Map<String, Object> paramMap) throws Exception {
		
		empInfoDao.del_emp(paramMap);
		
		return;

	}

	@Override
	public EmploymentInfoModel sel_emp(Map<String, Object> paramMap) throws Exception {
		
		
		return empInfoDao.sel_emp(paramMap);
	}

	@Override
	public int cnt_list_lec(Map<String, Object> paramMap) throws Exception {

		int cnt_list_lec = empInfoDao.cnt_list_lec(paramMap);
		
		return cnt_list_lec;
	}

	
	
}
