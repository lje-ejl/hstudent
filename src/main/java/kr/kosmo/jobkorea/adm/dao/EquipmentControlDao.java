package kr.kosmo.jobkorea.adm.dao;

import java.util.List;
import java.util.Map;

import kr.kosmo.jobkorea.adm.model.EquipmentControlModel;


//이민하 작업중

public interface EquipmentControlDao {

	
	/** 장비 목록 조회 */
	public List<EquipmentControlModel> listEquip(Map<String, Object>paramMap);
	
	/**	장비 목록 카운트 조회*/
	public int countListEquip(Map<String, Object> paramMap);
	
	
	/** 장비 등록 */
	public void insertEquip(Map<String, Object>paramMap);
	
	/** 장비 수정 */
	public void updateEquip(Map<String, Object>paramMap);

	/** 장비 삭제 */
	public void delEquip(Map<String, Object>paramMap);

	/** 과정 단건 조회 */
	public EquipmentControlModel selectEquip(Map<String, Object> paramMap) throws Exception;
	
	
	
}
