package kr.kosmo.jobkorea.adm.dao;

import java.util.List;
import java.util.Map;

import kr.kosmo.jobkorea.adm.model.e_resumeControlModel;

public interface e_resumeControlDao {
	
	// 강의 목록
	public List<e_resumeControlModel> lec_List( Map<String, Object> paramMap );
	
	// 강의 데이터 총 개수
	public e_resumeControlModel lec_Total( Map<String, Object> paramMap );
	
	// 학생 목록
	public List<e_resumeControlModel> Std_List( Map<String, Object> paramMap );	
	 
	// 학생  데이터 총 개수
	public e_resumeControlModel Std_Total( Map<String, Object> paramMap );
	
	// 학생  정보
	public e_resumeControlModel Std_Detail( Map<String, Object> paramMap );
	
	// 대표자 이메일 가져오기
	public e_resumeControlModel E_Get_Mail( Map<String, Object> paramMap );
	
	// 강의 이름 가져오기
	public e_resumeControlModel E_lec_Name( Map<String, Object> paramMap );
	
	// 대표 목록
	public List<e_resumeControlModel> C_Rpstt_List( Map<String, Object> paramMap );
	
	// 학생 이름 가져오기
	public e_resumeControlModel std_Name_List( Map<String, Object> paramMap );
	
	// 학생 파일정보 가져오기
	public e_resumeControlModel std_File_List( Map<String, Object> paramMap );
	
	// 회사 이름 가져오기
	public e_resumeControlModel comp_name_List( Map<String, Object> paramMap );
}
