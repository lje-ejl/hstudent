package kr.kosmo.jobkorea.tut.dao;

import java.util.List;
import java.util.Map;

import kr.kosmo.jobkorea.tut.model.ProjectControlModel;

public interface ProjectControlDao {

	public List<ProjectControlModel> showLectureList(Map<String, Object> paramMap);

	public List<ProjectControlModel> showLectureInfo(Map<String, Object> paramMap);

	public List<ProjectControlModel> showProjectInfo(Map<String, Object> paramMap);

	public List<ProjectControlModel> showSubmitInfo(Map<String, Object> paramMap);

	public ProjectControlModel showStudentCon(Map<String, Object> paramMap);

	public ProjectControlModel showProjectInfo2(Map<String, Object> paramMap);



	// 
	public int makeProject(Map<String, Object> paramMap);

	public int updateProject(Map<String, Object> paramMap);


	
}
