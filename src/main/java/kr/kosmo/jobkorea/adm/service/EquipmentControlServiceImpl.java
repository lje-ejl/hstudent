package kr.kosmo.jobkorea.adm.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.kosmo.jobkorea.adm.dao.EquipmentControlDao;
import kr.kosmo.jobkorea.adm.model.EquipmentControlModel;


//이민하 작업중

@Service
public class EquipmentControlServiceImpl implements EquipmentControlService {


	@Autowired
	EquipmentControlDao equipmentControlDao;
	
	
	//서비스에서 받아온 애들한테 기능을 넣어주는 메소드 구현????
	//서비스에 대한것을 상속받자!
	
	/** 장비 목록 조회*/
	@Override
	//모델 타입의 리스트 모델로 추출을 한다.
	public List<EquipmentControlModel> listEquip(Map<String, Object> paramMap) throws Exception {
		
		List<EquipmentControlModel> listEquip = equipmentControlDao.listEquip(paramMap);
		
		return listEquip;
	}

	/**	장비 목록 카운트 조회*/
	@Override
	public int countListEquip(Map<String, Object> paramMap) throws Exception {
		
		int totalCount = equipmentControlDao.countListEquip(paramMap);
	
		return totalCount;
	}
	

	/** 과정 등록 */
	public void insertEquip(Map<String, Object> paramMap) throws Exception {
		equipmentControlDao.insertEquip(paramMap);
		return;
	}	
	

	/** 과정 삭제 */
	public void delEquip(Map<String, Object> paramMap) throws Exception {
		equipmentControlDao.delEquip(paramMap);
		return;
	}
	
	
	
	/** 과정 수정 */
	public void updateEquip(Map<String, Object> paramMap) throws Exception {
		equipmentControlDao.updateEquip(paramMap);
		return;
	}	
	
	
	/** 과정 단건 조회 */
	public EquipmentControlModel selectEquip(Map<String, Object> paramMap) throws Exception {
		return equipmentControlDao.selectEquip(paramMap);		
	}	
	
	
	


}
