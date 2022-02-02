package kr.kosmo.jobkorea.adm.dao;

import java.util.List;
import java.util.Map;

import kr.kosmo.jobkorea.adm.model.processFailModel;

public interface processFailDao {

	//강의 리스트
	public List<processFailModel> lec_List_Select(Map<String, Object>paramMap);
	
	
	//강의 리스트 카운트
	public int lec_Cnt_Select(Map<String, Object> paramMap);
	
	
	//차트 리스트
	public List<processFailModel> lec_Name_List(Map<String, Object>paramMap);

	

}
