package kr.kosmo.jobkorea.adm.service;

import java.util.List;
import java.util.Map;

import kr.kosmo.jobkorea.adm.model.RegisterListControlModel;
import kr.kosmo.jobkorea.login.model.RegisterInfoModel;
import kr.kosmo.jobkorea.tut.model.AdviceModel;

public interface peopleMngService {
	
/* 공통 */
	
	public int ban_user(Map<String,Object> paramMap);
	 
	public int register(Map<String, Object> paramMap);

	public RegisterInfoModel user_info(Map<String,Object> paramMap);
	
	/* 학생 */
	
	public List<RegisterListControlModel> lec_list(Map<String, Object> paramMap);
	
	public int countList_lec(Map<String,Object> paramMap);
	
	public List<RegisterInfoModel> std_list(Map<String,Object> paramMap);
	
	public int countList_std(Map<String,Object> paramMap);
	
	public List<RegisterListControlModel> std_lec_info(Map<String,Object> paramMap);
	
	public int std_lec_count(Map<String,Object> paramMap);

	
	/* 강사 */
	
	public List<RegisterInfoModel> tut_list(Map<String,Object> paramMap);
	
	public int countList_tut(Map<String,Object> paramMap);
	
	public int apv_tut(Map<String,Object> paramMap);
	
	public List<RegisterListControlModel> tlec_list(Map<String,Object> paramMap);
	
	public int tut_lec_count(Map<String,Object> paramMap);
	
	/*대표자 */
	 
	public int ceo_up(Map<String,Object> paramMap);
	
}
