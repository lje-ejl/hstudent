package kr.kosmo.jobkorea.std.service;

import java.util.List;
import java.util.Map;

import kr.kosmo.jobkorea.std.model.StdLearnDataModel;

//2020.11.13 임지은 
//실질적인 로직은 Impl 클래스에 구현되어 있음!
public interface StdLearnDataService {
	
	public List<StdLearnDataModel> dataList(Map<String, Object> paramMap);

	public int dataCount(Map<String, Object> paramMap);
	
	public StdLearnDataModel dataInfo(Map<String, Object> paramMap);
	
	public StdLearnDataModel myLecture(Map<String, Object> paramMap);


}
