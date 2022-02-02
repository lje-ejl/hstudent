package kr.kosmo.jobkorea.notice.controller;

import java.util.HashMap;
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
import org.springframework.web.bind.annotation.ResponseBody;

import kr.kosmo.jobkorea.notice.model.ANoticeModel;
import kr.kosmo.jobkorea.notice.service.ANoticeService;


@Controller
@RequestMapping("/notice")
public class ANoticeController {
	
	@Autowired
	ANoticeService aNoticeService;
	
	// 처음 로딜 될 때 공지사항 연결
	@RequestMapping("aNotice.do")
	public String init(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception {
		
		String loginID = (String) session.getAttribute("loginId");
		paramMap.put("loginID", loginID);
		
		
		ANoticeModel typeCheck = aNoticeService.typeCheck(paramMap);
		model.addAttribute("typeCheck",typeCheck);
		
		return "/notice/ANotice";
	}
	   
	// 관리자 공지사항 출력
	@RequestMapping("admNoticeList.do")
	public String admNoticeList(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request, HttpServletResponse response, HttpSession session) throws Exception {
		
		int currentPage = Integer.parseInt((String) paramMap.get("currentPage")); // 현재페이지
	    int pageSize = Integer.parseInt((String) paramMap.get("pageSize"));
	    int pageIndex = (currentPage - 1) * pageSize;
		
		paramMap.put("pageIndex", pageIndex);
		paramMap.put("pageSize", pageSize);
		
		
		List<ANoticeModel> admNotice = aNoticeService.admNotice(paramMap);
		
		int admNoticeCnt = aNoticeService.admNoticeCnt(paramMap);
		
		model.addAttribute("admNotice", admNotice);
	    model.addAttribute("admNoticeCnt", admNoticeCnt);
	    model.addAttribute("pageSize", pageSize);
	    model.addAttribute("admCurrentPage",currentPage);
	    
	    return "/notice/ANoticeAdm";
	}
	
	// 강사 공지사항 출력
	@RequestMapping("tutNoticeList.do")
	public String tutNoticeList(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request, HttpServletResponse response, HttpSession session) throws Exception {
		
		int currentPage = Integer.parseInt((String) paramMap.get("currentPage")); // 현재페이지
	    int pageSize = Integer.parseInt((String) paramMap.get("pageSize"));
	    int pageIndex = (currentPage - 1) * pageSize;
		
		paramMap.put("pageIndex", pageIndex);
		paramMap.put("pageSize", pageSize);
		
		
		List<ANoticeModel> tutNotice = aNoticeService.tutNotice(paramMap);
		
		int tutNoticeCnt = aNoticeService.tutNoticeCnt(paramMap);
		
		model.addAttribute("tutNotice", tutNotice);
	    model.addAttribute("tutNoticeCnt", tutNoticeCnt);
	    model.addAttribute("pageSize", pageSize);
	    model.addAttribute("tutCurrentPage",currentPage);
	    
	    return "/notice/ANoticeTut";
	}
	
	//관리자 공지사항 상세조회
	@RequestMapping("admDetail.do")
	public String admNoticeDetail(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception {
		
		aNoticeService.admHit(paramMap);
		ANoticeModel admDetail = aNoticeService.admDetail(paramMap);
		
		model.addAttribute("detail", admDetail);
		
		model.addAttribute("loginID", session.getAttribute("loginId"));
				
		return "/notice/ANoticeDetail";
		
	}
	
	//강사 공지사항 상세조회
	@RequestMapping("tutDetail.do")
	public String tutNoticeDetail(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception {
		
		aNoticeService.tutHit(paramMap);
		ANoticeModel tutDetail = aNoticeService.tutDetail(paramMap);
		
		model.addAttribute("detail", tutDetail);
		model.addAttribute("loginID", session.getAttribute("loginId"));
				
		return "/notice/ANoticeDetail";
		
	}		
	
	//공지사항 작성
	@RequestMapping("noticeWrite.do")
	@ResponseBody
	public Map<String, Object> noticeWrite(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session)throws Exception{
		
		String loginID = (String) session.getAttribute("loginId");
		paramMap.put("loginID", loginID);
		
		
		ANoticeModel typeCheck = aNoticeService.typeCheck(paramMap);
		Map<String, Object> resultMap = new HashMap<String, Object>();
		
		
		//관리자인지 강사인지 체크해서 작성
		if(typeCheck.getUser_type().equals("C")){
			System.out.println(typeCheck.getUser_type().equals("C"));
			int admWrite = aNoticeService.admWrite(paramMap);
				if(admWrite == 1){
					resultMap.put("result","게시글 작성을 성공하였습니다.");
				}
				else
				{
					resultMap.put("result","게시글 등록에 실패하였습니다.");
				}
		}
		else if(typeCheck.getUser_type().equals("B")){
			int tutWrite = aNoticeService.tutWrite(paramMap);
			System.out.println(tutWrite);
				if(tutWrite == 1){
					resultMap.put("result","게시글 작성을 성공하였습니다.");
				}
				else
				{
					resultMap.put("result","게시글 등록에 실패하였습니다.");
				}
			
		}
	
		return resultMap;
		
	}
	
	//공지사항 삭제
	@RequestMapping("noticeDelete.do")
	@ResponseBody
	public Map<String, Object> noticeDelete(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session)throws Exception{
		
		String loginID = (String) session.getAttribute("loginId");
		paramMap.put("loginID", loginID);
		
		
		ANoticeModel typeCheck = aNoticeService.typeCheck(paramMap);
		Map<String, Object> resultMap = new HashMap<String, Object>();
		
		
		//강사인지 관리자인지 체크하고 삭제
		if(typeCheck.getUser_type().equals("C")){
			int admDel = aNoticeService.admDel(paramMap);
				if(admDel == 1){
					resultMap.put("result","게시글을 삭제하였습니다.");
				}
				else
				{
					resultMap.put("result","게시글 삭제에 실패하였습니다.");
				}
		}
		else if(typeCheck.getUser_type().equals("B")){
			int tutDel = aNoticeService.tutDel(paramMap);
				if(tutDel == 1){
					resultMap.put("result","게시글을 삭제하였습니다.");
				}
				else
				{
					resultMap.put("result","게시글 삭제에 실패하였습니다.");
				}
			
		}
				
		return resultMap;
		
	}
	
	//공지사항 수정
	@RequestMapping("noticeUpdate.do")
	@ResponseBody
	public Map<String, Object> noticeUpdate(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session)throws Exception{
		
		String loginID = (String) session.getAttribute("loginId");
		paramMap.put("loginID", loginID);
		
		ANoticeModel typeCheck = aNoticeService.typeCheck(paramMap);
		Map<String, Object> resultMap = new HashMap<String, Object>();
		
		
		//강사인지 관리자인지 확인하고 수정
		if(typeCheck.getUser_type().equals("C")){
			int admUpdate = aNoticeService.admUpdate(paramMap);
				if(admUpdate == 1){
					resultMap.put("result","게시글을 수정하였습니다.");
				}
				else
				{
					resultMap.put("result","게시글 수정에 실패하였습니다.");
				}
		}
		else if(typeCheck.getUser_type().equals("B")){
			int tutUpdate = aNoticeService.tutUpdate(paramMap);
				if(tutUpdate == 1){
					resultMap.put("result","게시글을 수정하였습니다.");
				}
				else
				{
					resultMap.put("result","게시글 수정에 실패하였습니다.");
				}
			
		}
				
		return resultMap;
		
	}
	
	
	/*@RequestMapping("admWrite.do")
	@ResponseBody
	public Map<String, Object> admWrite(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session)throws Exception{
		
		String loginID = (String) session.getAttribute("loginId");
		paramMap.put("loginID", loginID);
		
		int admWrite = aNoticeService.admWrite(paramMap);
		
		Map<String, Object> resultMap = new HashMap<String, Object>();
		
		
		if (admWrite == 1){
		
		resultMap.put("result","SUCCESS");
		}
		
		else
		{
			resultMap.put("result","게시글 등록에 실패하였습니다.");
		}
		
		
		return resultMap;
	}
	
	@RequestMapping("tutWrite.do")
	@ResponseBody
	public Map<String, Object> tutWrite(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session)throws Exception{
		
		String loginID = (String) session.getAttribute("loginId");
		paramMap.put("loginID", loginID);
		
		int tutWrite = aNoticeService.tutWrite(paramMap);
		
		Map<String, Object> resultMap = new HashMap<String, Object>();
		
		
		if (tutWrite == 1){
		
		resultMap.put("result","SUCCESS");
		}
		
		else
		{
			resultMap.put("result","게시글 등록에 실패하였습니다.");
		}
		
		
		return resultMap;
	}*/
	
	}
	