package kr.kosmo.jobkorea.std.dao;
 
import java.util.List;
import java.util.Map;

import kr.kosmo.jobkorea.std.model.SubmittedWorkModel;

public interface SubmittedWorkDao {
	/** 과제 리스트 조회하기 */
	public List<SubmittedWorkModel> selectHwkList(Map<String, Object> paramMap) throws Exception;
	/** 과제 리스트 카운트 */
	public int countHwkList(Map<String, Object> paramMap) throws Exception;
	/** 과제 아이디로 가져오기  */
	public SubmittedWorkModel choiceHwkList(Map<String, Object> paramMap) throws Exception;
	/** 과제 내용 등록 및 수정 */
	public void insertHwk(Map<String, Object> paramMap) throws Exception;
	public void updateHwk(Map<String, Object> paramMap) throws Exception;
	/** 과제 첨부파일 등록 및 수정 */
	public int updateHwkSubFil(Map<String, Object>paramMap);
	/** 과제 삭제 목록 조회? */ 
	public SubmittedWorkModel deleteList(Map<String, Object>paramMap);
	/** 과제 파일update 확인 */
	public int deleteFileInfo(Map<String, Object>paramMap);
	/** 과제 삭제 */
	public int deleteHwkSub(Map<String, Object>paramMap);
	
}
