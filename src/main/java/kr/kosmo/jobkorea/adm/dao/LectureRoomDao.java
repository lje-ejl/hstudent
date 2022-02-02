package kr.kosmo.jobkorea.adm.dao;

import java.util.List;
import java.util.Map;

import kr.kosmo.jobkorea.adm.model.EquipmentControlModel;
import kr.kosmo.jobkorea.adm.model.LectureRoomModel;

public interface LectureRoomDao {

	//강의실 목록 보기
	public List<LectureRoomModel> listLecrm(Map<String, Object>paramMap);
	
	//강의실 목록 카운트 조회
	public int countListLecrm(Map<String, Object>paramMap);
	
	//장비 목록 보기
	public List<EquipmentControlModel> listEquip(Map<String, Object>paramMap);
	
	//장비 목록 카운트 조회
	public int countListEquip(Map<String, Object>paramMap);
	
	//강의실 등록
	public int insertLecrm(Map<String, Object>paramMap);
	
	//강의실 수정
	public int updateLecrm(Map<String, Object>paramMap);
	
	//강의실 삭제 
	public void delLecrm(Map<String, Object>paramMap);

	//강의실 단건 조회
	public LectureRoomModel selectLecrm(Map<String, Object> paramMap) throws Exception;
	


	
}
