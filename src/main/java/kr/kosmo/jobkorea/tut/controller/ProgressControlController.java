package kr.kosmo.jobkorea.tut.controller;

import java.util.List;
import java.util.Map;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import kr.kosmo.jobkorea.tut.model.ProgressControlModel;
import kr.kosmo.jobkorea.tut.service.ProgressControlService;

@Controller
@RequestMapping("/tut/")
public class ProgressControlController {
	
	@Autowired
	ProgressControlService progressControlService;
	
	@RequestMapping("progressControl.do")
	public String init(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request, HttpServletResponse response, HttpSession session) throws Exception{
		
		String tutor_id = (String) session.getAttribute("loginId");
		paramMap.put("tutor_id", tutor_id);
		
		List<ProgressControlModel> lectureList = progressControlService.showLectureList(paramMap);
		model.addAttribute("lectureList", lectureList);
		
		return "tut/learn_mng/progressControl";
	}
	
	@RequestMapping("selectedLedtureInfo.do")
	public String showLectureInfo(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request, HttpServletResponse response, HttpSession session) throws Exception{
		
		String lec_id = request.getParameter("lec_id");
		paramMap.put("lec_id", Integer.parseInt(lec_id));
		List<ProgressControlModel> lectureInfo = progressControlService.showLectureInfo(paramMap);
		model.addAttribute("aaa", lectureInfo);
		
		List<ProgressControlModel> weekplan = progressControlService.showWeekplan(paramMap);
		model.addAttribute("bbb", weekplan);
		
		List<ProgressControlModel> days = progressControlService.countDay(paramMap);
		model.addAttribute("ccc", days);
		
	    return "tut/learn_mng/progressControl";
	}
}
