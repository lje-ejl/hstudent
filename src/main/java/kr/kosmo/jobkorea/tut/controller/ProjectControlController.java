package kr.kosmo.jobkorea.tut.controller;

import java.io.File;
import java.net.URLEncoder;
import java.util.HashMap;
import java.util.List;
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

import kr.kosmo.jobkorea.tut.model.ProjectControlModel;
import kr.kosmo.jobkorea.tut.service.ProjectControlService;

@Controller
@RequestMapping("/tut/")
public class ProjectControlController {
	@Autowired
	ProjectControlService projectControlService;
	
	@RequestMapping("projectControl.do")
	public String init(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request, HttpServletResponse response, HttpSession session) throws Exception{
		
		String tutor_id = (String) session.getAttribute("loginId");
		paramMap.put("tutor_id", tutor_id);
		List<ProjectControlModel> lectureList = projectControlService.showLectureList(paramMap);
		model.addAttribute("lectureList", lectureList);
		
		return "tut/learn_mng/projectControl";
	}
	
	//셀렉트박스 클릭하면 lec_id넘겨서 수업정보, 과제정보 불러오기
	@RequestMapping("selectedLectureInfo2.do")
	public String selectedLectureInfo(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request, HttpServletResponse response, HttpSession session) throws Exception{
		String lec_id = (String) request.getParameter("lec_id");
		paramMap.put("lec_id", Integer.parseInt(lec_id));
		
		List<ProjectControlModel> lectureInfo = projectControlService.showLectureInfo(paramMap);
		model.addAttribute("lectureInfo", lectureInfo);
		List<ProjectControlModel> projectInfo = projectControlService.showProjectInfo(paramMap);
		model.addAttribute("bbbb", projectInfo);
		
		model.addAttribute("cccc", lectureInfo.get(0).getLec_id());
		
		return "tut/learn_mng/projectControl";
	}
	
	//제출한 학생 불러오기
	@RequestMapping("submitInfo.do")
	public String submitInfo(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request, HttpServletResponse response, HttpSession session) throws Exception{
		String hwk_id = (String) paramMap.get("hwk_id");
		paramMap.put("hwk_id", Integer.parseInt(hwk_id));
		
		List<ProjectControlModel> submitInfo = projectControlService.showSubmitInfo(paramMap);
		model.addAttribute("submitInfo", submitInfo);
		
		return "tut/learn_mng/project/projectControl_submitName";
	}
	
	//제출한 학생의 과제 자세히 보기
	@RequestMapping("studentProjectCon.do")
	public String studentProjectCon(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request, HttpServletResponse response, HttpSession session) throws Exception{
		String std_id = (String) paramMap.get("std_id");
		paramMap.put("std_id", std_id);
		String hwk_id = (String) paramMap.get("hwk_id");
		paramMap.put("hwk_id", Integer.parseInt(hwk_id));
		
		ProjectControlModel studentCon = projectControlService.showStudentCon(paramMap);
		model.addAttribute("ac", studentCon);
		
		return "tut/learn_mng/project/projectControl_studentCon";
	}
	
	//강사가 올린 과제 정보 자세히 보기
	@RequestMapping("projectInfo2.do")
	public String projectInfo2(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request, HttpServletResponse response, HttpSession session) throws Exception{
		String hwk_id = (String) paramMap.get("hwk_id");
		paramMap.put("hwk_id", Integer.parseInt(hwk_id));
		ProjectControlModel projectInfo = projectControlService.showProjectInfo2(paramMap);
		model.addAttribute("projectInfo", projectInfo);
		
		return "tut/learn_mng/project/projectControl_projectInfo";
	}
	
	
	//과제를 수정하기위해 강의아이디와 과제아이디 가져오기
	@RequestMapping("newInputModal.do")
	public String newInputModal(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request, HttpServletResponse response, HttpSession session) throws Exception{
		String hwk_id = (String) paramMap.get("hwk_id");
		model.addAttribute("abc", Integer.parseInt(hwk_id));
		
		String lec_id = (String) paramMap.get("lec_id");
		model.addAttribute("abcd", Integer.parseInt(lec_id));
		
		return "tut/learn_mng/project/projectControl_updateHwk";
	}
	
	
	//과제수정하기 파일다운로드기능 포함
	@RequestMapping("updateProject.do")
	@ResponseBody
	public Map<String, Object> updateProject(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request, HttpServletResponse response, HttpSession session) throws Exception{
		
		int complete = projectControlService.updateProject(paramMap, request);
		System.out.println(complete);
		
		Map<String, Object> resultMap = new HashMap<String, Object>();
		resultMap.put("result","SUCCESS");
		
		return resultMap;
	}
	
	//과제만들기 파일업로드포함
	@RequestMapping("makeProject.do")
	@ResponseBody
	public Map<String, Object> makeProejct(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request, HttpServletResponse response, HttpSession session) throws Exception{
		
		// paramMap = 일반적인 text , request = 파일
		int complete = projectControlService.makeProject(paramMap, request);
		System.out.println(complete);
		
		Map<String, Object> resultMap = new HashMap<String, Object>();
		resultMap.put("result","SUCCESS");
		
		return resultMap;
	}
	
	
	//학생이 제출한 과제 다운로드하기
	@RequestMapping("downloadHwk.do")
	public String downloadHwk(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request, HttpServletResponse response, HttpSession session) throws Exception{
		
		String file = (String) paramMap.get("submit_url");
		String fileFname = (String) paramMap.get("submit_fname");
		System.out.println(file);
		System.out.println(fileFname);
		
		byte fileByte[] = FileUtils.readFileToByteArray(new File(file));
		response.setContentType("application/octet-stream");
		response.setContentLength(fileByte.length);
		response.setHeader("Content-Disposition", "attachment; fileName=\"" + URLEncoder.encode(fileFname,"UTF-8")+"\";");
		response.setHeader("Content-Transfer-Encoding", "binary");
		response.getOutputStream().write(fileByte);
		     
		response.getOutputStream().flush();
		response.getOutputStream().close();
		
		return "tut/learn_mng/projectControl";
	}
	
	//강사가 올린 과제 다운로드하기
	@RequestMapping("downloadTutor.do")
	public String downloadTutor(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request, HttpServletResponse response, HttpSession session) throws Exception{
		
		String file = (String) paramMap.get("hwk_url");
		String fileFname = (String) paramMap.get("hwk_fname");
		System.out.println(file);
		System.out.println(fileFname);
		
		byte fileByte[] = FileUtils.readFileToByteArray(new File(file));
		response.setContentType("application/octet-stream");
		response.setContentLength(fileByte.length);
		response.setHeader("Content-Disposition", "attachment; fileName=\"" + URLEncoder.encode(fileFname,"UTF-8")+"\";");//file대신에 파일이름칼럼넣어라
		response.setHeader("Content-Transfer-Encoding", "binary");
		response.getOutputStream().write(fileByte);
		     
		response.getOutputStream().flush();
		response.getOutputStream().close();
		
		
		return "tut/learn_mng/projectControl";
	}
}