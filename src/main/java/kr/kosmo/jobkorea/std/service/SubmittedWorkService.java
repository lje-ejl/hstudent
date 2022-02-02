package kr.kosmo.jobkorea.std.service;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import kr.kosmo.jobkorea.cmnt.model.CmntBbsAtmtFilModel;
import kr.kosmo.jobkorea.std.model.RegisterListModel;
import kr.kosmo.jobkorea.std.model.SubmittedWorkModel;

public interface SubmittedWorkService {
	
	/** 과제 리스트 조회 */
	public List<SubmittedWorkModel> hwkList(Map<String, Object> paramMap) throws Exception;
	
	/** 과제리스트 카운트 조회 */
	public int countHwkList(Map<String, Object> paramMap) throws Exception;
	
	/** 과제리스트 아이디로 상세 조회 (모달)*/
	public SubmittedWorkModel choiceHwkList(Map<String, Object> paramMap) throws Exception;
	
	/** 과제아이디로 insert (모달)*/
	public int insertHwk(Map<String, Object> paramMap, HttpServletRequest  request) throws Exception;
	
	/** 과제 수정 */
	public int updateHwkSubFile(Map<String, Object>paramMap, HttpServletRequest  request) throws Exception;

	/** 과제 단건 삭제 */
	public int deleteHwkSub(Map<String, Object>paramMap) throws Exception;
	
}

