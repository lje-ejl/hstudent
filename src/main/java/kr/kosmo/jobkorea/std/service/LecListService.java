package kr.kosmo.jobkorea.std.service;

import java.util.List;
import java.util.Map;

import kr.kosmo.jobkorea.std.model.LecListModel;

//2020.11.13 임지은 
//실질적인 로직은 Impl 클래스에 구현되어 있음!

public interface LecListService {

	public List<LecListModel> listLec(Map<String, Object> paramMap);

	public int countListLec(Map<String, Object> paramMap);
	
	public LecListModel lecInfo(Map<String, Object> paramMap);
	
	public List<LecListModel> lecWeekPlan(Map<String, Object> paramMap)throws Exception;
	
	public int lecApply(Map<String, Object> paramMap)throws Exception;
	
	public LecListModel numCheck(Map<String, Object> paramMap);
	
	public int lecApply2(Map<String, Object> paramMap)throws Exception;

	public LecListModel idCheck(Map<String, Object> paramMap);

	public int lecCancel(Map<String, Object> paramMap)throws Exception;
	
	public int lecCancel2(Map<String, Object> paramMap)throws Exception;
	
	public LecListModel okCheck(Map<String, Object> paramMap);

}
