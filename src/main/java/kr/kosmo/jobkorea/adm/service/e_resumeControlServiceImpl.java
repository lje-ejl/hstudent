package kr.kosmo.jobkorea.adm.service;

import java.util.List;
import java.util.Map;
import kr.kosmo.jobkorea.adm.dao.e_resumeControlDao;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import kr.kosmo.jobkorea.adm.model.e_resumeControlModel;

@Service
public class e_resumeControlServiceImpl implements e_resumeControlService {

	@Autowired 
	e_resumeControlDao e_resumeControlDao;
	
	// 강의 목록	
	@Override
	public List<e_resumeControlModel> lec_List(Map<String, Object> paramMap) {
		return e_resumeControlDao.lec_List(paramMap);
	}

	// 강의 데이터 총 개수	
	@Override
	public e_resumeControlModel lec_Total(Map<String, Object> paramMap) {
		return e_resumeControlDao.lec_Total(paramMap);
	}

	// 학생 목록
	@Override
	public List<e_resumeControlModel> Std_List(Map<String, Object> paramMap) {
		return e_resumeControlDao.Std_List(paramMap);
	}

	// 학생  데이터 총 개수
	@Override
	public e_resumeControlModel Std_Total(Map<String, Object> paramMap) {
		return e_resumeControlDao.Std_Total(paramMap);
	}

	// 학생  정보	
	@Override
	public e_resumeControlModel Std_Detail(Map<String, Object> paramMap) {
		return e_resumeControlDao.Std_Detail(paramMap);
	}

	// 대표자 이메일 가져오기
	@Override
	public e_resumeControlModel E_Get_Mail(Map<String, Object> paramMap) {
		return e_resumeControlDao.E_Get_Mail(paramMap);
	}

	// 강의 이름 가져오기	
	@Override
	public e_resumeControlModel E_lec_Name(Map<String, Object> paramMap) {
		return e_resumeControlDao.E_lec_Name(paramMap);
	}
	
	// 대표 목록
	@Override
	public List<e_resumeControlModel> C_Rpstt_List( Map<String, Object> paramMap ){
		return e_resumeControlDao.C_Rpstt_List(paramMap);
		
	}

	// 학생 파일정보 가져오기
	@Override
	public e_resumeControlModel std_File_List(Map<String, Object> paramMap) {
		return e_resumeControlDao.std_File_List(paramMap);
	}

	// 학생 이름 가져오기	
	@Override
	public e_resumeControlModel std_Name_List(Map<String, Object> paramMap) {
		return e_resumeControlDao.std_Name_List(paramMap);
	}

	// 회사 이름 가져오기
	@Override
	public e_resumeControlModel comp_name_List(Map<String, Object> paramMap) {
		return e_resumeControlDao.comp_name_List(paramMap);
	}
}
