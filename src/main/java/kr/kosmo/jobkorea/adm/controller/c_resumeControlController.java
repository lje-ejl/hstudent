package kr.kosmo.jobkorea.adm.controller;
import java.io.File;
import java.net.URLEncoder;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import org.springframework.ui.Model;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.io.FileUtils;
import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.kosmo.jobkorea.adm.model.e_resumeControlModel;
import kr.kosmo.jobkorea.adm.service.MailService;
import kr.kosmo.jobkorea.adm.service.e_resumeControlService;
import kr.kosmo.jobkorea.cmnt.service.CmntBbsService;



// 정수빈 작성
@Controller
@RequestMapping("/adm/")
public class c_resumeControlController {
	 
	// Set logger
	private final Logger logger = LogManager.getLogger(this.getClass());

	// Get class name for logger
	private final String className = this.getClass().toString();
	
	// Root path for file upload 
	@Value("${fileUpload.rootPath}")
	private String rootPath;
	
	@Autowired
	CmntBbsService CmntBbsService;
	
	@Autowired
	e_resumeControlService resumeControlService;
	
	@Autowired
	MailService msgMgmtService;
	
	@RequestMapping("c_resumeControl.do")
	public String c_resumeControl(Model result, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,  HttpServletResponse response, HttpSession session) throws Exception {
		
		return "/adm/employ_mng/resume/c_resumeControl";
	}
	
	// 강의 목록s
	@RequestMapping("c_resumeControl_Lec_List.do")
	public String c_resumeControl_Lec_List(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,  HttpServletResponse response, HttpSession session) throws Exception {
		int currentPage = Integer.parseInt((String)paramMap.get("currentPage"));	// 현재 페이지 번호
		int pageSize    = Integer.parseInt((String)paramMap.get("pageSize"));	    // 페이지 사이즈
		int pageIndex   = (currentPage-1)*pageSize;								    // 페이지 시작 row 번호

		paramMap.put("pageIndex", pageIndex);
		paramMap.put("pageSize", pageSize);	
		List<e_resumeControlModel> Lec_list  = resumeControlService.lec_List(paramMap);
		e_resumeControlModel       lec_Total = resumeControlService.lec_Total(paramMap);
		model.addAttribute("Lec_list" ,Lec_list);
		model.addAttribute("lec_Total",lec_Total.getLec_Total());
		return "/adm/employ_mng/resume/c_resumeControl1";
	}
	
	// 수강 학생 목록
	@RequestMapping("c_resumeControl_Std_List.do")
	public String c_resumeControl_Std_List(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,  HttpServletResponse response, HttpSession session) throws Exception {
		int currentPage = Integer.parseInt((String)paramMap.get("currentPage"));	// 현재 페이지 번호
		int pageSize    = Integer.parseInt((String)paramMap.get("pageSize"));	    // 페이지 사이즈
		int pageIndex   = (currentPage-1)*pageSize;								    // 페이지 시작 row 번호
		paramMap.put("pageIndex", pageIndex);
		paramMap.put("pageSize", pageSize);	

		List<e_resumeControlModel> Std_list  = resumeControlService.Std_List(paramMap);
		e_resumeControlModel       Std_Total = resumeControlService.Std_Total(paramMap);

		for( e_resumeControlModel dto : Std_list ){
			dto.setRs_check((dto.getRs_fsize()== 0) ? "x":"o");
		}
		
		model.addAttribute("Std_list" ,Std_list);
		model.addAttribute("Max" ,Std_list.size()+1);
		model.addAttribute("Std_Total",Std_Total.getStd_Total());
		
		return "/adm/employ_mng/resume/c_resumeControl2";
	}	

	// 학생 정보
	@RequestMapping("c_resumeControl_std_Detail.do")
	public String c_resumeControl_std_Detail(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,  HttpServletResponse response, HttpSession session) throws Exception {
		e_resumeControlModel Std_Detail  = resumeControlService.Std_Detail(paramMap);
		model.addAttribute("Std_Detail",Std_Detail);
		return "/adm/employ_mng/resume/c_resumeControl3";
	}
	
	// 학생 정보
	@RequestMapping("c_resumeControl_Check.do")
	public String c_resumeControl_Check(Model model, @RequestParam(value="std_mail_List[]") List<String> std_mail_List, @RequestParam(value="rps_mail_List[]") List<String> rps_mail_List, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,  HttpServletResponse response, HttpSession session) throws Exception {
		
		List<e_resumeControlModel> std_mail = new ArrayList<e_resumeControlModel>();
		List<e_resumeControlModel> rps_mail = new ArrayList<e_resumeControlModel>();
		for(String loginId : std_mail_List) {
			paramMap.put("loginId", loginId);
			e_resumeControlModel dto = resumeControlService.std_Name_List(paramMap);
			std_mail.add(dto);
        }
		
		for(String loginId : rps_mail_List) {
			paramMap.put("loginId", loginId);
			e_resumeControlModel dto = resumeControlService.comp_name_List(paramMap);
			dto.setMail(dto.getMail());
			dto.setComp_name(dto.getComp_name());
			rps_mail.add(dto);
        }
		paramMap.put("loginId", session.getAttribute("loginId"));
		model.addAttribute("from_mail",resumeControlService.E_Get_Mail(paramMap).getMail());
		model.addAttribute("lec_name" ,resumeControlService.E_lec_Name(paramMap).getLec_name());
		model.addAttribute("std_mail" ,std_mail);
		model.addAttribute("rps_mail" ,rps_mail);
		return "/adm/employ_mng/resume/c_resumeControl4";
	}
	
	// 학생 정보
	@RequestMapping("c_email_send.do")
	@ResponseBody
	public Map<String, Object> c_email_send(Model model, @RequestParam(value="std_mail_List[]") List<String> std_mail_List, @RequestParam(value="rps_mail_List[]") List<String> rps_mail_List,@RequestParam Map<String, Object> paramMap, HttpServletRequest request,  HttpServletResponse response, HttpSession session) throws Exception {
		
		List<e_resumeControlModel> std_mail = new ArrayList<e_resumeControlModel>();
		List<e_resumeControlModel> rps_mail = new ArrayList<e_resumeControlModel>();
		
		// 학생 이력서 파일 정보 가져오기
		for(String loginId : std_mail_List) {
			paramMap.put("loginId",loginId);
			e_resumeControlModel dto = new e_resumeControlModel();
			dto = resumeControlService.std_File_List(paramMap);
			std_mail.add(dto);
        }
		
		for(String loginId : rps_mail_List) {
			paramMap.put("loginId", loginId);
			e_resumeControlModel dto = resumeControlService.comp_name_List(paramMap);
			dto.setMail(dto.getMail());
			dto.setComp_name(dto.getComp_name());
			rps_mail.add(dto);
        }
		
		// 대표자 이메일 session에 담기.
		paramMap.put("loginId", session.getAttribute("loginId"));
		paramMap.put("mail", resumeControlService.E_Get_Mail(paramMap).getMail() );
		paramMap.put("std_mail" ,std_mail);
		paramMap.put("rps_mail" ,rps_mail);
		paramMap.put("lec_name" ,resumeControlService.E_lec_Name(paramMap).getLec_name());
		
		if(msgMgmtService.C_resume_Mail(paramMap) == true ){
			paramMap.put("msg", "이메일 전송 성공");
		}else{
			paramMap.put("msg", "이메일 전송 실패");
		}
		return paramMap;
	}	
	
	// 학생 정보
	@RequestMapping("c_email_rpstt_check.do")
	public String c_email_rpstt_check(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,  HttpServletResponse response, HttpSession session) throws Exception {
		List<e_resumeControlModel> rpstt_List = resumeControlService.C_Rpstt_List(paramMap);
		model.addAttribute("rpstt_List" ,rpstt_List);
		return "/adm/employ_mng/resume/c_resumeControl5";
	}	
	

	// 첨부파일 다운로드
	@RequestMapping("c_download.do")
	public void c_download(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception {
		
		logger.info("+ Start " + className + ".downloadBbsAtmtFil");
		logger.info("   - paramMap : " + paramMap);
		
		String file = (String)paramMap.get("rs_url");
		byte fileByte[] = FileUtils.readFileToByteArray(new File(file));
		
		response.setContentType("application/octet-stream");
	    response.setContentLength(fileByte.length);
	    response.setHeader("Content-Disposition", "attachment; fileName=\"" + URLEncoder.encode(file,"UTF-8")+"\";");
	    response.setHeader("Content-Transfer-Encoding", "binary");
	    response.getOutputStream().write(fileByte);
	     
	    response.getOutputStream().flush();
	    response.getOutputStream().close();

		logger.info("+ End " + className + ".downloadBbsAtmtFil");
	}
		
}