package kr.kosmo.jobkorea.std.dao;

import java.util.List;
import java.util.Map;

import kr.kosmo.jobkorea.cur.model.CourseModel;
import kr.kosmo.jobkorea.login.model.UserInfo;
import kr.kosmo.jobkorea.std.model.CoperationInfo;
import kr.kosmo.jobkorea.std.model.EduInfo;
import kr.kosmo.jobkorea.std.model.LicenseInfo;
import kr.kosmo.jobkorea.std.model.SchoolInfo;
import kr.kosmo.jobkorea.std.model.Skillnfo;

public interface StudentDao {

	/** 학생 목록 조회 */
	public List<UserInfo> liststudent(Map<String, Object> paramMap) throws Exception;
	
	/** 학생 목록 카운트 조회 */
	public int countListstudent(Map<String, Object> paramMap) throws Exception;
	
	/** 학생 한건 조회 */
	public UserInfo selectstudent(Map<String, Object> paramMap) throws Exception;
	
	/** 학생 학력 조회 */
	public List<SchoolInfo> selectstudentschool(Map<String, Object>paramMap);
	
	/** 학생 자격증 조회 */
	public List<LicenseInfo> selectstudentlicense(Map<String, Object>paramMap);
	
	/** 학생 경력 조회 */
	public List<CoperationInfo> selectstudentcop(Map<String, Object>paramMap);
	
	/** 학생 교육 조회 */
	public List<EduInfo> selectstudentedu(Map<String, Object>paramMap);

	/** 학생 스킬 조회 */
	public List<Skillnfo> selectstudentSkill(Map<String, Object>paramMap);
}