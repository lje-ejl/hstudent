package kr.kosmo.jobkorea.tut.controller;


import java.io.File;
import java.net.URLEncoder;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletRequest;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.io.FileUtils;
import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;


import kr.kosmo.jobkorea.adm.model.RegisterListControlModel;
import kr.kosmo.jobkorea.tut.model.b_learningMaterialsModel;
import kr.kosmo.jobkorea.tut.service.b_learningMaterialsService;

@Controller
@RequestMapping("/tut/")
public class b_learningMaterialsController {
	
	
		@Autowired
		b_learningMaterialsService learnMatService;
			
		// Set logger
		private final Logger logger = LogManager.getLogger(this.getClass());

		// Get class name for logger
		private final String className = this.getClass().toString();
		
		//강의 목록 관리 메인!
		@RequestMapping("b_learningMaterials.do")
		public String MaterialsMain(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
				HttpServletResponse response, HttpSession session) throws Exception {
			
			logger.info("학습 자료 메인 " + className + ".b_learningMaterials");
			logger.info("학습 자료 메인 - paramMap : " + paramMap);
		
			String tutor_id = (String) session.getAttribute("loginId");
	        paramMap.put("tutor_id", tutor_id);
		
	        List<RegisterListControlModel> list_lec = learnMatService.list_lec(paramMap);
	        model.addAttribute("list_lec", list_lec);
	        
	        List<RegisterListControlModel> list_lecf = learnMatService.list_lec(paramMap);
	        model.addAttribute("list_lecF", list_lec.get(0));
	        //System.out.println(list_lecf.get(0).toString());
	        logger.info("list_lecf.get(0).toString() - paramMap : " + list_lecf.toString());
	        return "tut/learn_sup/b_learningMaterials";
		}
		
		@RequestMapping("listMat.do")
		@ResponseBody
		public Map<String, Object> MatList(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
				HttpServletResponse response, HttpSession session) throws Exception {
			
			logger.info("학습 자료 리스트 " + className + ".listMat.do");
			logger.info("학습 자료 리스트 - paramMap : " + paramMap);
		
			int currentPage = Integer.parseInt((String)paramMap.get("currentPage"));	// 현재 페이지 번호
			int pageSize = Integer.parseInt((String)paramMap.get("pageSize"));			// 페이지 사이즈
			int pageIndex = (currentPage-1)*pageSize;									// 페이지 시작 row 번호
			
			paramMap.put("pageIndex", pageIndex);
			paramMap.put("pageSize", pageSize);

			//검색 조건 확인!
			String searchKey = (String) paramMap.get("searchKey");

			paramMap.put("searchKey", searchKey);
			
			Map<String, Object> resultMap = new HashMap<String, Object>();
			
			List<b_learningMaterialsModel> list_mat = learnMatService.list_mat(paramMap);

			//페이징을 위한 강의 수 목록
			int totalCount = learnMatService.cnt_list_mat(paramMap);
			
			resultMap.put("totalCount", totalCount);		
			resultMap.put("pageSize", pageSize);
			resultMap.put("list_mat",list_mat);
			
			return resultMap;
		}
		
		@RequestMapping("selMat.do")
		@ResponseBody
		public Map<String, Object> selMat(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
				HttpServletResponse response, HttpSession session) throws Exception {
			
			logger.info("selMat " + className + ".selMat.do");
			logger.info("selMat - paramMap : " + paramMap);
			
			String learn_data_id = (String) paramMap.get("learn_data_id");
			String searchKey = (String) paramMap.get("searchKey");
			
			paramMap.put("learn_data_id", learn_data_id);
			paramMap.put("searchKey", searchKey);
	         
			  String result = "SUCCESS";
		      String resultMsg = "조회 되었습니다.";

			
			Map<String, Object> resultMap = new HashMap<String, Object>();
			
			b_learningMaterialsModel sel_mat = learnMatService.sel_mat(paramMap);

	         resultMap.put("result", result);
	         resultMap.put("resultMsg", resultMsg);


			resultMap.put("sel_mat",sel_mat);
			
			return resultMap;
		}
		

		@RequestMapping("saveMat.do")
		@ResponseBody
		public Map<String, Object> saveMat(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
				HttpServletResponse response, HttpSession session) throws Exception {
			
			logger.info("과정저장" + className + ".saveMat");
			logger.info("   - paramMap : " + paramMap);
			
			String action = (String)paramMap.get("action");
			String result = "SUCCESS";
			String resultMsg = "저장 되었습니다.";
			
			String learn_data_id = (String) paramMap.get("learn_data_id");
			String searchKey = (String) paramMap.get("searchKey");
			
			paramMap.put("learn_data_id", learn_data_id);
			paramMap.put("searchKey", searchKey);
			
			if ("I".equals(action)) {
				// 과정 신규 저장
				learnMatService.insert_mat(paramMap, request);
			} else if("U".equals(action)) {
				// 과정 수정 저장
				
				int saveSubFil = learnMatService.updateSubFil(paramMap, request);
			} else {
				result = "FALSE";
				resultMsg = "알수 없는 요청입니다.";
			}
			
			Map<String, Object> resultMap = new HashMap<String, Object>();
			resultMap.put("result", result);
			resultMap.put("resultMsg", resultMsg);
			
			logger.info("+ End " + className + "saveMat.do");
			
			return resultMap;
		}

		   //과제 제출 삭제
		   @RequestMapping("/deleteMat.do")
		   @ResponseBody
		   public Map<String, Object> deleteMat(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
		         HttpServletResponse response, HttpSession session) throws Exception {
		      //세션에서 로그인 값 가져오기.
		      //String std_id = (String) session.getAttribute("loginId");
		      
			   String learn_data_id = (String) paramMap.get("learn_data_id");
			  // String searchKey = (String) paramMap.get("searchKey");
				
			   paramMap.put("learn_data_id", learn_data_id);
			  // paramMap.put("searchKey", searchKey);
			  
		      System.out.println("delete확인"+ paramMap.get("learn_data_id"));
		      
		      logger.info("+ Start " + className + ".deleteMat");

		      String result = "SUCCESS";
		      String resultMsg = "삭제 되었습니다.";

		      logger.info("   - paramMap : " + paramMap);
		      // 게시글 삭제
		      learnMatService.del_mat(paramMap);
		      logger.info("   - paramMap : " + paramMap);
		      
		      Map<String, Object> resultMap = new HashMap<String, Object>();
		      resultMap.put("result", result);
		      resultMap.put("resultMsg", resultMsg);
		      
		      logger.info("+ End " + className + ".deleteMat");
		      
		      return resultMap;
		   }
		   
		   // 과제 목록 화면으로 이동
		   @RequestMapping("/downloadMat.do")
		      public String downloadMat(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request, HttpServletResponse response, HttpSession session) throws Exception{
		   /*      String fileName = (String) paramMap.get("learn_fname");
		         String file =(String)paramMap.get("learn_url");  //다운url설정 과제목록
		         //String file = "D:\\FileRepository\\project\\hwk_id\\testfile.txt";
		         
		         byte fileByte[] = FileUtils.readFileToByteArray(new File(file));
		         response.setContentType("application/octet-stream");
		         response.setContentLength(fileByte.length);
		         response.setHeader("Content-Disposition", "attachment; fileName=\"" + URLEncoder.encode(fileName,"UTF-8")+"\";");
		         //response.setHeader("Content-Disposition", "attachment; fileName=\"" + URLEncoder.encode(fileName,"UTF-8")+"\";");
		         response.setHeader("Content-Transfer-Encoding", "binary");
		         response.getOutputStream().write(fileByte);
		              
		         response.getOutputStream().flush();
		         response.getOutputStream().close();*/
		         
		         String file = (String) paramMap.get("learn_url");
		         String fileName = (String) paramMap.get("learn_fname");
		         System.out.println("파일이름" + fileName);
		         
		         byte fileByte[] = FileUtils.readFileToByteArray(new File(file));
		         response.setContentType("application/octet-stream");
		         response.setContentLength(fileByte.length);
		         response.setHeader("Content-Disposition", "attachment; fileName=\"" + URLEncoder.encode(fileName,"UTF-8")+"\";");
		         response.setHeader("Content-Transfer-Encoding", "binary");
		         response.getOutputStream().write(fileByte);
		                
		         response.getOutputStream().flush();
		         response.getOutputStream().close();

		         
		         return "tut/learn_sup/b_learningMaterials";
		      }

		}

