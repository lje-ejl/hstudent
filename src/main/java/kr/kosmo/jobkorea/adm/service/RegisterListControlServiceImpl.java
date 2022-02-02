package kr.kosmo.jobkorea.adm.service;

import java.util.List;
import java.util.Map;

import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.kosmo.jobkorea.adm.dao.RegisterListControlDao;
import kr.kosmo.jobkorea.adm.model.RegisterListControlModel;
import kr.kosmo.jobkorea.login.model.RegisterInfoModel;



@Service
public class RegisterListControlServiceImpl implements RegistrerListControlService {

	 // Set logger
	   private final Logger logger = LogManager.getLogger(this.getClass());
	   
	   // Get class name for logger
	   private final String className = this.getClass().toString();
	
	
	   	@Autowired
		RegisterListControlDao registerListDao;

	
	public List<RegisterListControlModel> list_lec(Map<String, Object> paramMap) throws Exception {
		
		List<RegisterListControlModel>list_lec = registerListDao.list_lec(paramMap);
		
		return list_lec;
	}
	
	public int cnt_list_lec(Map<String, Object> paramMap) throws Exception {
		
		int cnt_list_lec = registerListDao.cnt_list_lec(paramMap);
		
		return cnt_list_lec;

	}
	
	public List<RegisterInfoModel> list_std(Map<String, Object> paramMap) throws Exception {
		
		List<RegisterInfoModel> list_std = registerListDao.list_std(paramMap);
		
		return list_std;

	}
	
	public int cnt_list_std(Map<String, Object> paramMap) throws Exception {
		
		int cnt_list_std = registerListDao.cnt_list_std(paramMap);
		
		return cnt_list_std;

	}

	public void insert_lec(Map<String, Object> paramMap) throws Exception {

		registerListDao.insert_lec(paramMap);
		
		return;

	}

	public void update_lec(Map<String, Object> paramMap) throws Exception {
		
		registerListDao.update_lec(paramMap);
		
		return;


	}

	
	public void del_lec(Map<String, Object> paramMap) throws Exception {
		
		registerListDao.del_lec(paramMap);
		
		return;
		

	}

	
	public RegisterListControlModel sel_lec(Map<String, Object> paramMap) throws Exception {
	
		return registerListDao.sel_lec(paramMap);
	
	}

	@Override
	public List<RegisterListControlModel> listLecrm(Map<String, Object> paramMap) throws Exception {
		//강의실
		List<RegisterListControlModel>listLecrm = registerListDao.listLecrm(paramMap);
		
		return listLecrm;
	}

	@Override
	public List<RegisterListControlModel> tutor_list(Map<String, Object> paramMap) throws Exception {
		
		List<RegisterListControlModel> tutor_list= registerListDao.tutor_list(paramMap);
		return tutor_list;
	}
	

}
