package kr.kosmo.jobkorea.tut.dao;

import java.util.List;
import java.util.Map;

import kr.kosmo.jobkorea.adm.model.RegisterListControlModel;
import kr.kosmo.jobkorea.tut.model.AdviceModel;
import kr.kosmo.jobkorea.tut.model.LecturePlanModel;

public interface LecturePlanDao {
	
	public List<LecturePlanModel> tutor_lec_list(Map<String,Object> paramMap);
	 
	public int countList_lec(Map<String, Object> paramMap);
	
	public LecturePlanModel plan_one(Map<String,Object> paramMap);
	
	public List<LecturePlanModel> week_list(Map<String,Object> paramMap);
	
	public int plan_register(Map<String,Object> paramMap);
		
	public int week_register(Map<String,Object> paramMap);
	
	public int week_up(Map<String,Object> paramMap);
	
	public int chk_week(Map<String,Object> paramMap);

	public int week_del(Map<String,Object> paramMap);
	
	public List<LecturePlanModel> mlec_list(Map<String,Object> paramMap);
	
}
