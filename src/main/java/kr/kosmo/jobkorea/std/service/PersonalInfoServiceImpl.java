package kr.kosmo.jobkorea.std.service;

import java.io.File;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import kr.kosmo.jobkorea.cmnt.model.CmntBbsAtmtFilModel;
import kr.kosmo.jobkorea.common.comnUtils.FileUtil;
import kr.kosmo.jobkorea.common.comnUtils.FileUtilCho;
import kr.kosmo.jobkorea.common.comnUtils.FileUtilModel;
import kr.kosmo.jobkorea.login.model.UserInfo;
import kr.kosmo.jobkorea.std.dao.PersonalInfoDao;

@Service
public class PersonalInfoServiceImpl implements PersonalInfoService{
	
	// 파일 업로드 위한 어노테이션 
	// Root path for file upload 
	@Value("${fileUpload.rootPath}")
	private String rootPath;
	
	// comment path for file upload
	@Value("${fileUpload.bbsPath}")
	private String bbsPath;
	
	  
	@Autowired
	PersonalInfoDao personalDao;
	
	// 조회
	@Override
	public UserInfo selectInfo(String login_id) throws Exception {
		UserInfo userInfo = personalDao. selectInfo(login_id);
		return userInfo;
	}

	// 업데이트
	@Override
	public int updatePersonalInfo(Map<String, Object> paramMap, HttpServletRequest request) throws Exception {
		// request를 mutipart로 형변환 시킴
		MultipartHttpServletRequest mpRequest = (MultipartHttpServletRequest) request;
		
		int ret = 0;
		
		// 로그인 ID 발번 -> resume 밑에 아이디별로 이력서를 저장하겠습니다.(겹칠 일 방지)
		String loginID = (String)paramMap.get("login_id");
		String itemFilePath = bbsPath + File.separator + File.separator + loginID + File.separator + File.separator;
		// 파일경로 : resume + "/" + "로긴아이디" + "/"

		// 여기서 fileUtilcho는 map을 써야합니다!
		// file_loc = "경로" , fileExtension = 확장자 , file_nm="파일이름" , file_size="파일 사이즈"
		FileUtilCho fileUtilCho = new FileUtilCho(mpRequest, rootPath, itemFilePath);
		Map<String, Object> listFileUtilModel = fileUtilCho.uploadFiles();

		try{
			// 게시'글' 저장
			ret = personalDao.updatePersonalInfo(paramMap);
			
			listFileUtilModel.put("login_id", paramMap.get("login_id"));
			
			// 파일 저장 -> 비어있지 않은경우 update시켜준다.
			
			// 개인정보를 조회해온다.
			UserInfo userInfo = personalDao. selectInfo(loginID);
			String exName = userInfo.getFile_name();
			
			//System.out.println("기존"+exName);
			//System.out.println("이후"+mpRequest.getFile("bbs_files_1"));
			
			//if(!mpRequest.getFile("bbs_files_1").equals("")){
			if(mpRequest.getFile("bbs_files_1").getSize()>0){
				System.out.println("있어요");
				
				// 여기서  update만 했으니까 -> 기존의 정보를 꺼내와서 삭제해야함.
				String login_id = (String) paramMap.get("login_id");
				UserInfo fileInfo = personalDao.selectInfo(login_id);
				
				Map<String, Object> deleteFile = new HashMap<>();
				// 이렇게 하지않고 DB에 있는 절대경로를 꺼내와서 fileUtilCho에서 delete하는 부분을 수정하는 방법도있습니다.
				deleteFile.put("file_nm",itemFilePath+fileInfo.getFile_name());
				fileUtilCho.deleteFiles(deleteFile);
					
				// db삭제
				int deleteResult = personalDao.deleteFileInfo(login_id);
				
				// db삭제에 성공하면 update를 시켜줍니다.
				if(deleteResult >0){
					ret = personalDao.saveResumeFile(listFileUtilModel);
				}
			
			}else{
				System.out.println("비어있어요");
			}
			
		}catch(Exception e){
			e.printStackTrace();
		}
		
		return ret;
	}
	
	// 비밀번호 변경
	@Override
	public int changePass(Map<String, Object> paramMap) throws Exception {
		int result = personalDao.changePass(paramMap);
		return result;
	}

}
