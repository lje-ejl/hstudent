package kr.kosmo.jobkorea.std.service;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import kr.kosmo.jobkorea.login.model.UserInfo;

public interface PersonalInfoService {
	// 개인정보 조회
	public UserInfo selectInfo(String login_id) throws Exception;
	
	// 개인정보 수정
	public int updatePersonalInfo(Map<String, Object> paramMap, HttpServletRequest request)throws Exception;

	// 비밀번호 변경
	public int changePass(Map<String, Object> paramMap)throws Exception;

}  
