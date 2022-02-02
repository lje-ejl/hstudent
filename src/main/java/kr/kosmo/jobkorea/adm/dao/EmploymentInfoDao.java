package kr.kosmo.jobkorea.adm.dao;

import java.util.List;
import java.util.Map;

import kr.kosmo.jobkorea.adm.model.EmploymentInfoModel;
import kr.kosmo.jobkorea.adm.model.RegisterListControlModel;
import kr.kosmo.jobkorea.login.model.RegisterInfoModel;

public interface EmploymentInfoDao {

	//취업 정보 리스트
	public List<EmploymentInfoModel> list_emp(Map<String, Object> paramMap)throws Exception;

	//취업 정보 등록한 학생 수 카운트
	public int cnt_list_epm(Map<String, Object> paramMap)throws Exception;
	
	//학생 정보 리스트
	public List<RegisterInfoModel> list_std(Map<String, Object> paramMap)throws Exception;
	
	//학생 카운트
	public int cnt_list_std(Map<String, Object> paramMap)throws Exception;

	//학생 프로필 
	public RegisterInfoModel sel_std(Map<String, Object> paramMap)throws Exception;
	
	//학생 프로필 안 강의 내역 
	public List<RegisterListControlModel>list_std_lec(Map<String, Object> paramMap)throws Exception;
	
	//취업 정보 등록
	public void insert_emp(Map<String, Object> paramMap)throws Exception;
	
	//취업 정보 업데이트
	public void update_emp(Map<String, Object> paramMap)throws Exception; 
	
	//취업 정보 삭제
	public void del_emp(Map<String, Object>paramMap)throws Exception;

	//취업 정보 단건 조회
	public EmploymentInfoModel sel_emp(Map<String, Object> paramMap)throws Exception;

	//강의 수 조회
	public int cnt_list_lec(Map<String, Object> paramMap)throws Exception;
	
	//회사 정보 조회
	public List<RegisterInfoModel> list_comp (Map<String, Object> paramMap)throws Exception;

}
