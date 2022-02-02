package kr.kosmo.jobkorea.adm.service;

import java.util.Map;

import javax.servlet.http.HttpSession;

import kr.kosmo.jobkorea.commonbiz.model.MsgMgmtModel;


public interface MailService {
	public boolean resume_Mail(Map<String, Object>paramMap ) throws Exception ;
	public boolean C_resume_Mail(Map<String, Object>paramMap ) throws Exception ;
	
	// id  찾기 이메일 발송
	public int findId(Map<String, Object>paramMap ) throws Exception ;
	
	// Pass 찾기 이메일 발송
	public int findPass(Map<String, Object>paramMap ) throws Exception ;
}
