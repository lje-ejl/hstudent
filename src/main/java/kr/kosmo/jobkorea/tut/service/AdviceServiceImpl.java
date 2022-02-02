package kr.kosmo.jobkorea.tut.service;

import java.util.List;
import java.util.Map;

import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.kosmo.jobkorea.tut.model.AdviceModel;
import kr.kosmo.jobkorea.adm.model.RegisterListControlModel;
import kr.kosmo.jobkorea.cur.model.CourseModel;
import kr.kosmo.jobkorea.tut.dao.AdviceDao;

@Service
public class AdviceServiceImpl implements AdviceService{
	// Set logger
	private final Logger logger = LogManager.getLogger(this.getClass());
	
	// Get class name for logger
	private final String className = this.getClass().toString();
	
	@Autowired
	AdviceDao adv_dao;
	
	
	@Override
	public List<RegisterListControlModel> tutor_lec_list(Map<String, Object> paramMap) {

		List<RegisterListControlModel> tutor_lec_list = adv_dao.tutor_lec_list(paramMap);
		logger.info("   - 서비스 : " + paramMap);
		 return tutor_lec_list;
	}
	
	@Override
	public List<AdviceModel> std_list(Map<String, Object> paramMap) {
		List<AdviceModel> std_list= adv_dao.std_list(paramMap);
		
		return std_list;
	}
	

	@Override
	public AdviceModel adv_one(Map<String, Object> paramMap) {
		return adv_dao.adv_one(paramMap);
	}

	@Override
	public int adv_register(Map<String, Object> paramMap) {
		return adv_dao.adv_register(paramMap);
	}

	@Override
	public int adv_update(Map<String, Object> paramMap) {
		return adv_dao.adv_update(paramMap);
	}

	@Override
	public int countList_Advice(Map<String, Object> paramMap) throws Exception {
		return adv_dao.countList_Advice(paramMap);
	}

	@Override
	public int countList_lec(Map<String, Object> paramMap) {
		return adv_dao.countList_lec(paramMap);
	}

	@Override
	public List<AdviceModel> lec_stu_list(Map<String, Object> paramMap) {
		logger.info("   - 서비스 : " + paramMap);
		return adv_dao.lec_stu_list(paramMap);
	}

	@Override
	public int adv_del(Map<String, Object> paramMap) {
		return adv_dao.adv_del(paramMap);
	}

	


}
