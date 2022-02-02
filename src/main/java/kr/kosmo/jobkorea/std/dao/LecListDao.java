package kr.kosmo.jobkorea.std.dao;

import java.util.List;
import java.util.Map;

import kr.kosmo.jobkorea.std.model.LecListModel;


/*2020.11.13 임지은
 * dao는 data access object의 약자로서 
 * db와 실제로 접촉하는 객체이다.
 * 보통 dao 인터페이스에 dao Impl 객체를 만들어서 사용하지만
 * 현재 프레임워크는 Impl을 자동 생성하며 메소드의 이름이 
 * Mapper 쿼리의 호출 ID가 된다!
 * */

public interface LecListDao {

	public List<LecListModel> listLec(Map<String, Object> paramMap);

	public int countListLec(Map<String, Object> paramMap);
	
	public LecListModel lecInfo(Map<String, Object> paramMap);
	
	public LecListModel numCheck(Map<String, Object> paramMap);
	
	public List<LecListModel> lecWeekPlan(Map<String, Object> paramMap)throws Exception;
	
	public int lecApply(Map<String, Object> paramMap)throws Exception;
	
	public int lecApply2(Map<String, Object> paramMap)throws Exception;
	
	public LecListModel idCheck(Map<String, Object> paramMap);
	
	public int lecCancel(Map<String, Object> paramMap)throws Exception;
	
	public int lecCancel2(Map<String, Object> paramMap)throws Exception;
	
	public LecListModel okCheck(Map<String, Object> paramMap);
	
	
}
