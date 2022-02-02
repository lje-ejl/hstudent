package kr.kosmo.jobkorea.tut.service;

import java.util.List;
import java.util.Map;

import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.kosmo.jobkorea.tut.model.AdviceModel;
import kr.kosmo.jobkorea.tut.model.LecturePlanModel;
import kr.kosmo.jobkorea.adm.model.RegisterListControlModel;
import kr.kosmo.jobkorea.cur.model.CourseModel;
import kr.kosmo.jobkorea.tut.dao.AdviceDao;
import kr.kosmo.jobkorea.tut.dao.LecturePlanDao;

@Service
public class LecturePlanServiceImpl implements LecturePlanService{
	// Set logger
	private final Logger logger = LogManager.getLogger(this.getClass());
	
	// Get class name for logger
	private final String className = this.getClass().toString();
	
	@Autowired
	LecturePlanDao plan_dao;

	@Override
	public List<LecturePlanModel> tutor_lec_list(Map<String, Object> paramMap) {
		return plan_dao.tutor_lec_list(paramMap);
	}

	@Override
	public int countList_lec(Map<String, Object> paramMap) {
		return plan_dao.countList_lec(paramMap);
	}

	@Override
	public LecturePlanModel plan_one(Map<String, Object> paramMap) {
		return plan_dao.plan_one(paramMap);
	}

	@Override
	public List<LecturePlanModel> week_list(Map<String, Object> paramMap) {
		return plan_dao.week_list(paramMap);
	}

	@Override
	public int plan_register(Map<String, Object> paramMap) {
		return plan_dao.plan_register(paramMap);
	}

	@Override
	public int week_register(Map<String, Object> paramMap) {
		return plan_dao.week_register(paramMap);
	}

	@Override
	public int week_up(Map<String, Object> paramMap) {
		return plan_dao.week_up(paramMap);
	}

	@Override
	public int week_del(Map<String, Object> paramMap) {
		return plan_dao.week_del(paramMap);
	}

	@Override
	public int chk_week(Map<String, Object> paramMap) {
		return plan_dao.chk_week(paramMap);
	}

	@Override
	public List<LecturePlanModel> mlec_list(Map<String, Object> paramMap) {
		return plan_dao.mlec_list(paramMap);
	}
	
	
	


}
