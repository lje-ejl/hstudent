package kr.kosmo.jobkorea.std.controller;

import java.io.File;
import java.net.URLEncoder;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.io.FileUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttributes;


import kr.kosmo.jobkorea.login.model.UserInfo;
import kr.kosmo.jobkorea.std.service.PersonalInfoService;

@SessionAttributes({"lgnInfoModel"})
@Controller
@RequestMapping("/std")
public class PersonalInfoController {
	
	@Autowired
	PersonalInfoService personalService;
	
	// 개인정보 초기화면
	@RequestMapping("/personalInfo.do")
	public String PersonalInfo(Model model, @RequestParam Map<String, Object> paramMap, HttpSession session) throws Exception{
		return "std/personalInfo";
	}
	  
	
	// 개인정보 조회
	@RequestMapping("/selectInfo.do")
	@ResponseBody
	public Map<String, Object> selectPersonalInfo(Model model, @RequestParam Map<String, Object> paramMap, 
										     HttpSession session) throws Exception{
		String login_id = (String) session.getAttribute("loginId");
		
		UserInfo userInfo = personalService.selectInfo(login_id);
		
		Map<String, Object> resultMap = new HashMap<String, Object>();
		resultMap.put("userInfo",userInfo);
		resultMap.put("result","SUCCESS");
		
		return resultMap;
	}
	
	// 개인정보 업데이트 + 이력서 첨부 insert
	@RequestMapping("/updateInfo.do")
	@ResponseBody
	public Map<String, Object> updatePersonalInfo(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception{
		
		String login_id = (String) session.getAttribute("loginId");
		String addr = (String) paramMap.get("addr2")+","+(String) paramMap.get("addr3") +","+ (String) paramMap.get("addr1");
		String tel = (String) paramMap.get("tel1")+"-"+(String) paramMap.get("tel2")+"-"+(String) paramMap.get("tel3");

		paramMap.put("addr", addr);
		paramMap.put("tel", tel);
		paramMap.put("login_id", login_id);
		
		int updateInfo = personalService.updatePersonalInfo(paramMap, request);
		
		Map<String, Object> resultMap = new HashMap<String, Object>();
		resultMap.put("result","SUCCESS");
		
		return resultMap;
	}
	
	
	// 비밀번호 변경
	@RequestMapping("/changePass.do")
	@ResponseBody
	public Map<String, Object> changePass(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception{
		String login_id = (String) session.getAttribute("loginId");
		paramMap.put("login_id", login_id);
		
		int changePwd = personalService.changePass(paramMap);
		
		Map<String, Object> resultMap = new HashMap<String, Object>();
		resultMap.put("result","SUCCESS");
		resultMap.put("resultMsg","비밀번호 변경이 완료되었습니다.");
		
		return resultMap;
	}
	
	// 파일다운로드
	@RequestMapping("downloadFile.do")
	public String downloadHwk(Model model, @RequestParam Map<String, Object> paramMap,
	HttpServletRequest request, HttpServletResponse response, HttpSession session) throws Exception{
		String file = (String) paramMap.get("rs_url");
		String fileName = (String) paramMap.get("rs_name");
		
		
		byte fileByte[] = FileUtils.readFileToByteArray(new File(file));
		response.setContentType("application/octet-stream");
		response.setContentLength(fileByte.length);
		response.setHeader("Content-Disposition", "attachment; fileName=\"" + URLEncoder.encode(fileName,"UTF-8")+"\";");
		response.setHeader("Content-Transfer-Encoding", "binary");
		response.getOutputStream().write(fileByte);
		       
		response.getOutputStream().flush();
		response.getOutputStream().close();
		  
		return "std/personalInfo";
	}
}
