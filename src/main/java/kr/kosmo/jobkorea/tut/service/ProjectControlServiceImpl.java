package kr.kosmo.jobkorea.tut.service;

import java.io.File;
import java.util.List;
import java.util.Map;
import javax.servlet.http.HttpServletRequest;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import kr.kosmo.jobkorea.common.comnUtils.FileUtilCho;
import kr.kosmo.jobkorea.tut.dao.ProjectControlDao;
import kr.kosmo.jobkorea.tut.model.ProjectControlModel;

@Service
public class ProjectControlServiceImpl implements ProjectControlService{
	
	// 파일 업로드 위한 어노테이션 
	// Root path for file upload 
	@Value("${fileUpload.rootPath}")
	private String rootPath;
	
	@Autowired
	private ProjectControlDao projectControlDao;
	
	@Override
	public List<ProjectControlModel> showLectureList(Map<String, Object> paramMap) throws Exception {
		return projectControlDao.showLectureList(paramMap);
	}

	@Override
	public List<ProjectControlModel> showLectureInfo(Map<String, Object> paramMap) throws Exception {
		return projectControlDao.showLectureInfo(paramMap);
	}

	@Override
	public List<ProjectControlModel> showProjectInfo(Map<String, Object> paramMap) throws Exception {
		return projectControlDao.showProjectInfo(paramMap);
	}

	@Override
	public List<ProjectControlModel> showSubmitInfo(Map<String, Object> paramMap) throws Exception {
		// TODO Auto-generated method stub
		return projectControlDao.showSubmitInfo(paramMap);
	}

	@Override
	public ProjectControlModel showStudentCon(Map<String, Object> paramMap) throws Exception {
		// TODO Auto-generated method stub
		return projectControlDao.showStudentCon(paramMap);
	}

	@Override
	public ProjectControlModel showProjectInfo2(Map<String, Object> paramMap) throws Exception {
		// TODO Auto-generated method stub
		return projectControlDao.showProjectInfo2(paramMap);
	}


	@Override
	public int updateProject(Map<String, Object> paramMap, HttpServletRequest request) throws Exception {
		MultipartHttpServletRequest mpRequest = (MultipartHttpServletRequest) request;
		int ret = 0;
		
		String lec_id = (String) paramMap.get("lec_id");
		paramMap.put("lec_id", Integer.parseInt(lec_id));
		
		String hwk_id = (String) paramMap.get("hwk_id");
		paramMap.put("hwk_id", Integer.parseInt(hwk_id));
		
		String itemFilePath = "project" + File.separator + File.separator + lec_id + File.separator + File.separator;
		
		FileUtilCho fileUtilCho = new FileUtilCho(mpRequest, rootPath, itemFilePath);
		Map<String, Object> listFileUtilModel = fileUtilCho.uploadFiles();
		
		paramMap.put("hwk_fname", listFileUtilModel.get("file_nm"));
		paramMap.put("hwk_url", listFileUtilModel.get("file_loc"));
		paramMap.put("hwk_fsize", listFileUtilModel.get("file_size"));
		
		System.out.println("업로드한 파일 이름 : "+paramMap.get("hwk_fname"));
		System.out.println("업로드한 파일 url : "+paramMap.get("hwk_url"));
		System.out.println("업로드한 파일 사이즈 : "+paramMap.get("hwk_fsize"));
		
		try{
			ret = projectControlDao.updateProject(paramMap);
		}catch(Exception e){
			e.printStackTrace();
		}
		return ret;
	}
	
	// 과제 생성
	@Override
	public int makeProject(Map<String, Object> paramMap, HttpServletRequest request) throws Exception {
		MultipartHttpServletRequest mpRequest = (MultipartHttpServletRequest) request;
		
		int ret = 0;
		
		String lec_id = (String) paramMap.get("cccc");
		paramMap.put("lec_id", Integer.parseInt(lec_id));
		
		String itemFilePath = "project" + File.separator + File.separator + lec_id + File.separator + File.separator;
		
		FileUtilCho fileUtilCho = new FileUtilCho(mpRequest, rootPath, itemFilePath);
		Map<String, Object> listFileUtilModel = fileUtilCho.uploadFiles();
		
		paramMap.put("hwk_fname", listFileUtilModel.get("file_nm"));
		paramMap.put("hwk_url", listFileUtilModel.get("file_loc"));
		paramMap.put("hwk_fsize", listFileUtilModel.get("file_size"));
		
		try{
			ret = projectControlDao.makeProject(paramMap);
		}catch(Exception e){
			e.printStackTrace();
		}
		return ret;
	}
}
