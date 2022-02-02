package kr.kosmo.jobkorea.adm.service;

import java.util.List;
import java.util.Map;

import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.kosmo.jobkorea.tut.model.AdviceModel;
import kr.kosmo.jobkorea.adm.dao.lectureAdviceDao;
import kr.kosmo.jobkorea.adm.dao.peopleMngDao;
import kr.kosmo.jobkorea.adm.model.RegisterListControlModel;
import kr.kosmo.jobkorea.cur.model.CourseModel;
import kr.kosmo.jobkorea.login.model.RegisterInfoModel;
import kr.kosmo.jobkorea.tut.dao.AdviceDao;

@Service
public class peopleMngServiceImpl implements peopleMngService{
	// Set logger
	private final Logger logger = LogManager.getLogger(this.getClass());
	
	// Get class name for logger
	private final String className = this.getClass().toString();
	
	@Autowired
	peopleMngDao pmg_dao;

	@Override
	public int ban_user(Map<String, Object> paramMap) {
		return pmg_dao.ban_user(paramMap);
	}

	@Override
	public int register(Map<String, Object> paramMap) {
		return pmg_dao.register(paramMap);
	}

	@Override
	public RegisterInfoModel user_info(Map<String, Object> paramMap) {
		return pmg_dao.user_info(paramMap);
	}

	@Override
	public List<RegisterListControlModel> lec_list(Map<String, Object> paramMap) {
		return pmg_dao.lec_list(paramMap);
	}

	@Override
	public List<RegisterInfoModel> std_list(Map<String, Object> paramMap) {
		return pmg_dao.std_list(paramMap);
	}

	@Override
	public int countList_std(Map<String, Object> paramMap) {
		return pmg_dao.countList_std(paramMap);
	}

	@Override
	public List<RegisterListControlModel> std_lec_info(Map<String, Object> paramMap) {
		return pmg_dao.std_lec_info(paramMap);
	}

	@Override
	public List<RegisterInfoModel> tut_list(Map<String, Object> paramMap) {
		return pmg_dao.tut_list(paramMap);
	}

	@Override
	public int apv_tut(Map<String, Object> paramMap) {
		return pmg_dao.apv_tut(paramMap);
	}

	@Override
	public List<RegisterListControlModel> tlec_list(Map<String, Object> paramMap) {
		return pmg_dao.tlec_list(paramMap);
	}

	@Override
	public int countList_lec(Map<String, Object> paramMap) {
		return pmg_dao.countList_lec(paramMap);
	}

	@Override
	public int std_lec_count(Map<String, Object> paramMap) {
		return pmg_dao.std_lec_count(paramMap);
	}

	@Override
	public int countList_tut(Map<String, Object> paramMap) {
		return pmg_dao.countList_tut(paramMap);
	}

	@Override
	public int tut_lec_count(Map<String, Object> paramMap) {
		return pmg_dao.tut_lec_count(paramMap);
	}

	@Override
	public int ceo_up(Map<String, Object> paramMap) {
		return pmg_dao.ceo_up(paramMap);
	}
	



}
