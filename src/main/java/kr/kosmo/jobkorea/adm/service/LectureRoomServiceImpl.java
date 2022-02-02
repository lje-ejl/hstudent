package kr.kosmo.jobkorea.adm.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.kosmo.jobkorea.adm.dao.LectureRoomDao;
import kr.kosmo.jobkorea.adm.model.EquipmentControlModel;
import kr.kosmo.jobkorea.adm.model.LectureRoomModel;

@Service
public class LectureRoomServiceImpl implements LectureRoomService {

	@Autowired
	LectureRoomDao lectureRoomDao;

	
	//강의실 목록 조회
	public List<LectureRoomModel> listLecrm(Map<String, Object> paramMap) throws Exception {
	
		List<LectureRoomModel> listLecrm = lectureRoomDao.listLecrm(paramMap);
		
		return listLecrm;
	}

	//강의실 목록 카운트 조회
	public int countListLecrm(Map<String, Object> paramMap) throws Exception {
		
		int totalCount = lectureRoomDao.countListLecrm(paramMap);
		
		return totalCount;
	}
	
	//장비 목록 조회
	public List<EquipmentControlModel> listEquip (Map<String, Object> paramMap) throws Exception {
	
		List<EquipmentControlModel> listEquip = lectureRoomDao.listEquip(paramMap);
	
		return listEquip;
	}
		
		
	//장비 목록 카운트 조회
	public int countListEquip(Map<String, Object> paramMap) throws Exception {
		
		int totalCount = lectureRoomDao.countListEquip(paramMap);
		
		return totalCount;
	}
	

	//강의실 등록
	public int insertLecrm(Map<String, Object> paramMap) throws Exception {
		return lectureRoomDao.insertLecrm(paramMap);
		
	}

	//강의실 수정
	public int updateLecrm(Map<String, Object> paramMap) throws Exception {
		return lectureRoomDao.updateLecrm(paramMap);
		
	}

	//강의실 삭제
	public void deleteLecrm(Map<String, Object> paramMap) throws Exception {
		lectureRoomDao.delLecrm(paramMap);
		return;
	}

	
	//강의실 단건 조회
	public LectureRoomModel selectLecrm(Map<String, Object> paramMap) throws Exception {
		return lectureRoomDao.selectLecrm(paramMap);
	}


	
	
}
