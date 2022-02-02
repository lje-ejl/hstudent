package kr.kosmo.jobkorea.adm.dao;

import java.util.List;
import java.util.Map;

import kr.kosmo.jobkorea.adm.model.RegisterListControlModel;
import kr.kosmo.jobkorea.login.model.RegisterInfoModel;

public interface RegisterListControlDao{
	
	//강의 목록 조회
	public List<RegisterListControlModel> list_lec(Map<String, Object> paramMap)throws Exception;
	
	//강의 수 조회
	public int cnt_list_lec(Map<String, Object> paramMap)throws Exception;

	//학생 목록 조회 
	public List<RegisterInfoModel> list_std(Map<String, Object> paramMap) throws Exception;
	
	//학생 수 조회 
	public int cnt_list_std(Map<String, Object> paramMap) throws Exception;
	
	//강의 등록
	public void insert_lec(Map<String, Object> paramMap) throws Exception;
	
	//강의 수정
	public void update_lec(Map<String, Object> paramMap) throws Exception;
	
	//강의 삭제
	public void del_lec(Map<String, Object> paramMap) throws Exception;

	//업데이트 - 강의 한건 select
	public RegisterListControlModel sel_lec(Map<String, Object> paramMap)throws Exception;
	
	//강의실
	public List<RegisterListControlModel> listLecrm(Map<String, Object> paramMap)throws Exception;
	
	public List<RegisterListControlModel> tutor_list(Map<String, Object> paramMap)throws Exception;
	
}
