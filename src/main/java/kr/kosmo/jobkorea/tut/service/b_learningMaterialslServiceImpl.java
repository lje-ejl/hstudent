package kr.kosmo.jobkorea.tut.service;

import java.io.File;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import kr.kosmo.jobkorea.adm.model.RegisterListControlModel;
import kr.kosmo.jobkorea.common.comnUtils.FileUtilCho;
import kr.kosmo.jobkorea.tut.dao.b_learningMaterialsDao;
import kr.kosmo.jobkorea.tut.model.b_learningMaterialsModel;



@Service
public class b_learningMaterialslServiceImpl implements b_learningMaterialsService {

	
	@Autowired
	b_learningMaterialsDao learnMatDao;

	 // Root path for file upload 
	   @Value("${fileUpload.rootPath}")
	   private String rootPath;
	   
	   // comment path for file upload
	   @Value("${fileUpload.subPath}")
	   private String subPath;
	
	// Set logger
	private final Logger logger = LogManager.getLogger(this.getClass());
   
	
	@Override
	public List<RegisterListControlModel> list_lec(Map<String, Object> paramMap) throws Exception {
		
		List<RegisterListControlModel> list_lec = learnMatDao.list_lec(paramMap);
		
		return list_lec;
	}
	
	
	@Override
	public List<b_learningMaterialsModel> list_mat(Map<String, Object> paramMap) throws Exception {
		
		List<b_learningMaterialsModel> list_mat = learnMatDao.list_mat(paramMap);
		
		return list_mat;
	}


	@Override
	public int cnt_list_mat(Map<String, Object> paramMap) throws Exception {
		
		int cnt_list_mat = learnMatDao.cnt_list_mat(paramMap);
		
		return cnt_list_mat;
	}

	@Override
	public b_learningMaterialsModel sel_mat(Map<String, Object> paramMap) throws Exception {

		b_learningMaterialsModel sel_mat = learnMatDao.sel_mat(paramMap);
		
		return sel_mat;
	}


	@Override
	public int insert_mat(Map<String, Object> paramMap, HttpServletRequest request) throws Exception {
		MultipartHttpServletRequest mpRequest = (MultipartHttpServletRequest)request;
		int ret = 0;
	    String searchKey = (String)paramMap.get("searchKey");
	    String learn_data_id = (String)paramMap.get("learn_data_id");
		
	    String itemFilePath = subPath + File.separator + searchKey + File.separator + learn_data_id + File.separator ;
	      FileUtilCho fileUtilCho = new FileUtilCho(mpRequest, rootPath, itemFilePath);
	      Map<String, Object> listFileUtilModel = fileUtilCho.uploadFiles();
	      try{
	    	 learnMatDao.insert_mat(paramMap); //첨부파일 없이 과제 내용 입력
	         System.out.println("확인작업"+listFileUtilModel);   
	         listFileUtilModel.put("searchKey", paramMap.get("searchKey"));
	         listFileUtilModel.put("learn_data_id", paramMap.get("learn_data_id"));
	         System.out.println("임플"+mpRequest );
	         if(mpRequest.getFile("bbs_files_1").getSize()>0){
	        	    ret = learnMatDao.updateSubFil(listFileUtilModel);
	         }else{
	             System.out.println("첨부파일 없어요");
	          }
	       }catch(Exception e){
	          throw e;
	       }
		
		return ret;
		
		
	}


	@Override
	public int updateSubFil(Map<String, Object> paramMap, HttpServletRequest request)throws Exception {
		  MultipartHttpServletRequest mpRequest = (MultipartHttpServletRequest)request;
	      
		  logger.info("   - paramMap : " + paramMap);
		  
		  
		  int ret = 0;
	      // 과제아이디 hwk_id, 학생아이디 std_id 
	      String searchKey = (String)paramMap.get("searchKey");
		  String learn_data_id = (String)paramMap.get("learn_data_id");
	      // 파일 저장  std_id = 작성자 id , hwk_id = 과제 id  
	      String itemFilePath = subPath + File.separator + searchKey + File.separator + learn_data_id + File.separator ;
	      FileUtilCho fileUtilCho = new FileUtilCho(mpRequest, rootPath, itemFilePath);
	      Map<String, Object> listFileUtilModel = fileUtilCho.uploadFiles();
	    
	      try{
	    	 
	         listFileUtilModel.put("searchKey", paramMap.get("searchKey"));
	         listFileUtilModel.put("learn_data_id", paramMap.get("learn_data_id"));
	         listFileUtilModel.put("learn_tit", paramMap.get("learn_tit"));
	         listFileUtilModel.put("learn_con", paramMap.get("learn_con"));
	         
	         System.out.println("searchKey : "+paramMap.get("searchKey") );
	         System.out.println("learn_data_id : "+paramMap.get("learn_data_id") );
	         
	         b_learningMaterialsModel model = learnMatDao.deleteList(paramMap);
	         String exName = model.getLearn_fname();
	         System.out.println("기존"+exName);
	         System.out.println("이후"+mpRequest.getFile("bbs_files_1"));
	         learnMatDao.update_mat(listFileUtilModel); //과제 내용 수정
	         System.out.println("확인작업"+listFileUtilModel);  
	         
	         if(mpRequest.getFile("bbs_files_1").getSize()>0){
	            System.out.println("있어요");
	            // 기존의 정보를 꺼내와서 삭제
	            Map<String, Object> deleteFile = new HashMap<>();
	            deleteFile.put("file_nm","\\materials\\"+paramMap.get("searchKey")+"\\"+paramMap.get("learn_data_id")+"\\"+model.getLearn_fname());
	            fileUtilCho.deleteFiles(deleteFile);
	            // 과제 DB 삭제
	            //int deleteret = learnMatDao.deleteFileInfo(paramMap);
	            //첨부파일 업데이트 실행
	            //if(deleteret > 0 ){
	               ret = learnMatDao.updateSubFil(listFileUtilModel);
	            //}
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
	   
	   public int del_mat(Map<String, Object>paramMap) throws Exception{
	   
	      int ret = 0;

	      try{
	         FileUtilCho fileUtilCho = new FileUtilCho();
	         
	         b_learningMaterialsModel model = learnMatDao.deleteList(paramMap);
	         
	         //                    homework\sasa023\2\1109.txt
	         // D:\FileRepository\\    homework\sasa023\2\1106.txt
	         Map<String, Object> deleteFile = new HashMap<>();
	         deleteFile.put("file_nm","\\materials\\"+paramMap.get("searchKey")+"\\"+paramMap.get("learn_data_id")+"\\"+model.getLearn_fname());
	         fileUtilCho.deleteFiles(deleteFile);
	         // \homework\sasa023\2\1111.txt
	         
	         // 과제 DB 삭제
	         ret = learnMatDao.del_mat(paramMap);
	         // 파일 삭제
	         fileUtilCho.deleteFiles(paramMap);
	         
	      }catch(Exception e){
	         throw e;
	      }
	      return ret;
	   }


	   
	   
	   
	}




