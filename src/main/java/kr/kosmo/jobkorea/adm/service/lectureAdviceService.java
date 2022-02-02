package kr.kosmo.jobkorea.adm.service;

import java.util.List;
import java.util.Map;

import kr.kosmo.jobkorea.adm.model.RegisterListControlModel;
import kr.kosmo.jobkorea.tut.model.AdviceModel;

public interface lectureAdviceService {
	
	/*강사의 강의목록 */
	public List<RegisterListControlModel> tutor_lec_list(Map<String,Object> paramMap);
	/* 강사 강의목록 카운트*/
	public int countList_lec(Map<String, Object> paramMap);

	
	/*상담이력있는 수강생목록 */ 
	public List<AdviceModel> std_list(Map<String,Object> paramMap);
	
	/** 상담 목록 카운트 조회 */
	public int countList_Advice(Map<String, Object> paramMap) throws Exception;
	
	/*상담 상세정보 */
	public AdviceModel adv_one(Map<String,Object> paramMap);
	
	/*상담 등록 */
	public int adv_register(Map<String,Object> paramMap);
	
	/* 상담 수정 */
	public int adv_update(Map<String,Object> paramMap);
	
	/* 강의 수강 학생 목록 */
	public List<AdviceModel> lec_stu_list(Map<String,Object> paramMap);
	
	/* 상담 삭제 */
	public int adv_del(Map<String,Object> paramMap);
}
