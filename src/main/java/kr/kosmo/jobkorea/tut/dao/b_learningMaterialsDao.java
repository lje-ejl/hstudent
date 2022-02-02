package kr.kosmo.jobkorea.tut.dao;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import kr.kosmo.jobkorea.adm.model.RegisterListControlModel;
import kr.kosmo.jobkorea.adm.model.testPersonControlModel;
import kr.kosmo.jobkorea.tut.model.b_learningMaterialsModel;


public interface b_learningMaterialsDao {
	
		//강사 강의 조회
		public List<RegisterListControlModel> list_lec(Map<String, Object> paramMap)throws Exception;
	
		//과제 목록 조회
		public List<b_learningMaterialsModel> list_mat(Map<String, Object> paramMap)throws Exception;
		
		//목록 수 조회
		public int cnt_list_mat(Map<String, Object> paramMap)throws Exception;

		//과제 단건 조회
		public b_learningMaterialsModel sel_mat(Map<String, Object> paramMap)throws Exception;
		
		//과제 인서트 
		public void insert_mat(Map<String, Object> paramMap) throws Exception;
		
		//과제 업데이트 
		public void update_mat(Map<String, Object> paramMap) throws Exception;
		
		//파일 인서트 및 수정
		public int updateSubFil(Map<String, Object>paramMap);
		
		//파일 삭제 목록 조회
		public b_learningMaterialsModel deleteList(Map<String, Object>paramMap);
		
		//파일 업데이트 확인
		public int deleteFileInfo(Map<String, Object>paramMap);
		
		//과제 삭제
		public int del_mat(Map<String, Object> paramMap) throws Exception;
		
		
}
