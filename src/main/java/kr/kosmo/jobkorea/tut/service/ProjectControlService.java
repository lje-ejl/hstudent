package kr.kosmo.jobkorea.tut.service;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import kr.kosmo.jobkorea.tut.model.ProjectControlModel;

public interface ProjectControlService {
	List<ProjectControlModel> showLectureList(Map<String, Object> paramMap) throws Exception;

	List<ProjectControlModel> showLectureInfo(Map<String, Object> paramMap) throws Exception;

	List<ProjectControlModel> showProjectInfo(Map<String, Object> paramMap) throws Exception;

	List<ProjectControlModel> showSubmitInfo(Map<String, Object> paramMap) throws Exception;

	ProjectControlModel showStudentCon(Map<String, Object> paramMap) throws Exception;

	ProjectControlModel showProjectInfo2(Map<String, Object> paramMap) throws Exception;

	

	
	int updateProject(Map<String, Object> paramMap, HttpServletRequest request) throws Exception;

	int makeProject(Map<String, Object> paramMap, HttpServletRequest request) throws Exception;

}
