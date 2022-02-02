package kr.kosmo.jobkorea.adm.service;

import java.util.List;
import java.util.Map;

import kr.kosmo.jobkorea.adm.model.EquipmentControlModel;
import kr.kosmo.jobkorea.adm.model.LectureRoomModel;

public interface LectureRoomService {

	//강의실 목록 보기
	public List<LectureRoomModel> listLecrm(Map<String, Object> paramMap) throws Exception;
	
	//강의실 목록 카운트 조회
	public int countListLecrm(Map<String, Object> paramMap) throws Exception;
	
	//장비 목록 보기
	public List<EquipmentControlModel> listEquip(Map<String, Object>paramMap) throws Exception;
	
	//장비 목록 카운트 조회
	public int countListEquip(Map<String, Object> paramMap) throws Exception;
	
	//강의실 등록
	public int insertLecrm(Map<String, Object> paramMap) throws Exception;
	
	//강의실 수정
	public int updateLecrm(Map<String, Object> paramMap) throws Exception;
	 
	//강의실 삭제 
	public void deleteLecrm(Map<String, Object> paramMap) throws Exception;
	
	//강의실 단건 조회
	public LectureRoomModel selectLecrm(Map<String, Object> paramMap) throws Exception;
	

	
	
	
	
}
