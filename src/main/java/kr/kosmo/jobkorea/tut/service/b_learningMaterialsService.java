package kr.kosmo.jobkorea.tut.service;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import kr.kosmo.jobkorea.adm.model.RegisterListControlModel;

import kr.kosmo.jobkorea.tut.model.b_learningMaterialsModel;

public interface b_learningMaterialsService {
	
	//강사 강의 조회
	public List<RegisterListControlModel> list_lec(Map<String, Object> paramMap)throws Exception;

	//과제 목록 조회
	public List<b_learningMaterialsModel> list_mat(Map<String, Object> paramMap)throws Exception;
	
	//목록 수 조회
	public int cnt_list_mat(Map<String, Object> paramMap)throws Exception;

	//과제 단건 조회
	public b_learningMaterialsModel sel_mat(Map<String, Object> paramMap)throws Exception;
	
	//과제 인서트 
	public int insert_mat(Map<String, Object> paramMap,HttpServletRequest  request) throws Exception;
	
	//파일 인서트 및 수정
	public int updateSubFil(Map<String, Object>paramMap,HttpServletRequest request)throws Exception;
	
	//과제 단건 삭제
	public int del_mat(Map<String, Object> paramMap) throws Exception;
	


	

}
