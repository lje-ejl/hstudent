package kr.kosmo.jobkorea.std.dao;

import java.util.List;
import java.util.Map;

import kr.kosmo.jobkorea.std.model.StdLearnDataModel;


/*2020.11.13 임지은
 * dao는 data access object의 약자로서 
 * db와 실제로 접촉하는 객체이다.
 * 보통 dao 인터페이스에 dao Impl 객체를 만들어서 사용하지만
 * 현재 프레임워크는 Impl을 자동 생성하며 메소드의 이름이 
 * Mapper 쿼리의 호출 ID가 된다!
 * */

public interface StdLearnDataDao {
	
	public List<StdLearnDataModel> dataList(Map<String, Object> paramMap);

	public int dataCount(Map<String, Object> paramMap);
	
	public StdLearnDataModel dataInfo(Map<String, Object> paramMap);
	
	public StdLearnDataModel myLecture(Map<String, Object> paramMap);
}
