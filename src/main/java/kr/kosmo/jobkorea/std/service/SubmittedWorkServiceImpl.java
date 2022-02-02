package kr.kosmo.jobkorea.std.service;

import java.io.File;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.StringTokenizer;

import javax.servlet.http.HttpServletRequest;

import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import kr.kosmo.jobkorea.cmnt.model.CmntBbsAtmtFilModel;
import kr.kosmo.jobkorea.common.comnUtils.FileUtil;
import kr.kosmo.jobkorea.common.comnUtils.FileUtilCho;
import kr.kosmo.jobkorea.common.comnUtils.FileUtilModel;
import kr.kosmo.jobkorea.std.dao.SubmittedWorkDao;
import kr.kosmo.jobkorea.std.model.SubmittedWorkModel;

@Service
public class SubmittedWorkServiceImpl implements SubmittedWorkService{
	// Set logger
	private final Logger logger = LogManager.getLogger(this.getClass());
	// Get class name for logger
	private final String className = this.getClass().toString();

	@Autowired
	SubmittedWorkDao submittedWorkDao;
	
	// Root path for file upload 
	@Value("${fileUpload.rootPath}")
	private String rootPath;
	
	// comment path for file upload
	@Value("${fileUpload.hsPath}")
	private String hsPath;
	
	/**과제 목록 조회*/
	@Override
	public List<SubmittedWorkModel> hwkList(Map<String, Object> paramMap) throws Exception {
		List<SubmittedWorkModel> hwklist = submittedWorkDao.selectHwkList(paramMap);
		return hwklist;
	}
	
	/**과제 카운트 조회*/
	@Override
	public int countHwkList(Map<String, Object> paramMap) throws Exception {
		int totalCount = submittedWorkDao.countHwkList(paramMap);
		return totalCount;
	}

	/** 과제리스트 아이디로 상세 조회 (모달)*/
	@Override
	public SubmittedWorkModel choiceHwkList(Map<String, Object> paramMap) throws Exception {
		SubmittedWorkModel choiceHwkList = submittedWorkDao.choiceHwkList(paramMap);
		return choiceHwkList;
	}

	/** 과제 입력 (모달)*/
	@Override
	public int insertHwk(Map<String, Object> paramMap, HttpServletRequest request) throws Exception {
		MultipartHttpServletRequest mpRequest = (MultipartHttpServletRequest)request;
		int ret = 0;
		String hwk_id = (String)paramMap.get("hwk_id");
		String std_id = (String)paramMap.get("loginID");
		// std_id = 작성자 id , hwk_id = 과제 id  
		String itemFilePath = hsPath + File.separator+ File.separator + std_id + File.separator+ File.separator + hwk_id + File.separator+ File.separator ;
		FileUtilCho fileUtilCho = new FileUtilCho(mpRequest, rootPath, itemFilePath);
		Map<String, Object> listFileUtilModel = fileUtilCho.uploadFiles();
		try{
			submittedWorkDao.insertHwk(paramMap); //첨부파일 없이 과제 내용 입력
			System.out.println("확인작업"+listFileUtilModel);	
			listFileUtilModel.put("std_id", paramMap.get("loginID"));
			listFileUtilModel.put("hwk_id", paramMap.get("hwk_id"));
			System.out.println("임플"+mpRequest );
			if(mpRequest.getFile("bbs_files_1").getSize()>0){
				ret = submittedWorkDao.updateHwkSubFil(listFileUtilModel);
			}else{
				System.out.println("첨부파일 없어요");
			}
		}catch(Exception e){
			throw e;
		}
		return ret;
	}

	/** 과제 첨부파일 입력 (모달)*/
	public int updateHwkSubFile(Map<String, Object>paramMap, HttpServletRequest  request) throws Exception{
		MultipartHttpServletRequest mpRequest = (MultipartHttpServletRequest)request;
		int ret = 0;
		// 과제아이디 hwk_id, 학생아이디 std_id 
		String hwk_id = (String)paramMap.get("hwk_id");
		String std_id = (String)paramMap.get("loginID");
		// 파일 저장  std_id = 작성자 id , hwk_id = 과제 id  
		String itemFilePath = hsPath + File.separator + File.separator + std_id + File.separator + File.separator + hwk_id + File.separator + File.separator ;
		FileUtilCho fileUtilCho = new FileUtilCho(mpRequest, rootPath, itemFilePath);
		Map<String, Object> listFileUtilModel = fileUtilCho.uploadFiles();
		
		try{
			submittedWorkDao.updateHwk(paramMap); //과제 내용 수정
			//System.out.println("확인작업"+listFileUtilModel);	
			listFileUtilModel.put("std_id", paramMap.get("loginID"));
			listFileUtilModel.put("hwk_id", paramMap.get("hwk_id"));
			//System.out.println("임플"+mpRequest );
			SubmittedWorkModel model = submittedWorkDao.deleteList(paramMap);
			String exName = model.getSubmit_fname();
			System.out.println("기존"+exName);
			System.out.println("이후"+mpRequest.getFile("bbs_files_1"));
			
			if(mpRequest.getFile("bbs_files_1").getSize()>0){
				System.out.println("있어요");
				// 기존의 정보를 꺼내와서 삭제
				Map<String, Object> deleteFile = new HashMap<>();
				deleteFile.put("file_nm","homework\\\\"+paramMap.get("loginID")+"\\"+paramMap.get("hwk_id")+"\\"+model.getSubmit_fname());
				fileUtilCho.deleteFiles(deleteFile);
				// 과제 DB 삭제
				int deleteret = submittedWorkDao.deleteFileInfo(paramMap);
				//첨부파일 업데이트 실행
				if(deleteret > 0 ){
					ret = submittedWorkDao.updateHwkSubFil(listFileUtilModel); //파일 저장
				}
				
			}else{
				System.out.println("비어있어요");
			}
			
		}catch(Exception e){
			// 기존 파일 삭제
			fileUtilCho.deleteFiles(listFileUtilModel);
			throw e;
		}
		return ret;
	}

	/** 과제 삭제 */
	public int deleteHwkSub(Map<String, Object>paramMap) throws Exception{
		int ret = 0;
		try{
			FileUtilCho fileUtilCho = new FileUtilCho();
			SubmittedWorkModel model = submittedWorkDao.deleteList(paramMap);
			Map<String, Object> deleteFile = new HashMap<>();
			deleteFile.put("file_nm","\\homework\\"+paramMap.get("loginID")+"\\"+paramMap.get("hwk_id")+"\\"+model.getSubmit_fname());
			fileUtilCho.deleteFiles(deleteFile);
			// 과제 DB 삭제
			ret = submittedWorkDao.deleteHwkSub(paramMap);
			// 파일 삭제
			fileUtilCho.deleteFiles(paramMap);
		}catch(Exception e){
			throw e;
		}
		return ret;
	}

}
