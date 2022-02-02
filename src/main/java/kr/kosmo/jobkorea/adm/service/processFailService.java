package kr.kosmo.jobkorea.adm.service;

import java.util.List;
import java.util.Map;


import kr.kosmo.jobkorea.adm.model.processFailModel;


public interface processFailService {


	//강의실 목록 보기
	public List<processFailModel> lec_List_Select(Map<String, Object> paramMap) throws Exception;

	//강의 목록 카운트
	public int lec_Cnt_Select(Map<String, Object> paramMap) throws Exception;


	//강의명 리스트
	public List<processFailModel> lec_Name_List(Map<String, Object> paramMap) throws Exception;



}