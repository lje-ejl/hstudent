package kr.kosmo.jobkorea.std.dao;

import java.util.Map;

import org.springframework.web.multipart.MultipartHttpServletRequest;

import kr.kosmo.jobkorea.login.model.UserInfo;

public interface PersonalInfoDao {

	// 개인정보 조회
	public UserInfo selectInfo(String login_id) throws Exception;

	// 개인정보 수정
	public int updatePersonalInfo(Map<String, Object> paramMap)throws Exception;

	// 이력서 파일 저장 
	public int saveResumeFile(Map<String, Object> listFileUtilModel)throws Exception;
	
	// 비밀번호 변경
	public int changePass(Map<String, Object> paramMap)throws Exception;

	// 기존 파일 삭제
	public int deleteFileInfo(String login_id)throws Exception;
	
	
  
}
