package kr.kosmo.jobkorea.adm.dao;

import java.util.List;
import java.util.Map;

import kr.kosmo.jobkorea.adm.model.RegisterListControlModel;

import kr.kosmo.jobkorea.tut.model.AdviceModel;

public interface lectureAdviceDao {
	
	public List<RegisterListControlModel> tutor_lec_list(Map<String,Object> paramMap);
	 
	public int countList_lec(Map<String, Object> paramMap);

	public List<AdviceModel> std_list(Map<String,Object> paramMap);
	
	public int countList_Advice(Map<String, Object> paramMap);
	 
	public AdviceModel adv_one(Map<String,Object> paramMap);
	
	public int adv_register(Map<String,Object> paramMap);
	
	public int adv_update(Map<String,Object> paramMap);
	
	public List<AdviceModel> lec_stu_list(Map<String,Object> paramMap);
	
	public int adv_del(Map<String,Object> paramMap);
}
