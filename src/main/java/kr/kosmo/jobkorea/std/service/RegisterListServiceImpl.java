package kr.kosmo.jobkorea.std.service;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.kosmo.jobkorea.std.model.RegisterListModel;
import kr.kosmo.jobkorea.std.model.SurveyListModel;
import kr.kosmo.jobkorea.std.dao.RegisterListDao;

@Service
public class RegisterListServiceImpl implements RegisterListService{
	
	@Autowired
	RegisterListDao registerListDao;
	//본인 수강 정보 불러오기
	@Override
	public RegisterListModel regListModel(Map<String, Object> paramMap) throws Exception {
		
		RegisterListModel regListModel =  registerListDao.selectRegisterList(paramMap);
		
		return regListModel;
	}
	//출석 상태 불러오기
	@Override
	public RegisterListModel regListCount(Map<String, Object> paramMap) throws Exception {
		RegisterListModel regListCount =   registerListDao.countAtdState(paramMap);
		return regListCount;
	}
	//수강 정보 카운트 =1
	@Override
	public int totalCnt(Map<String, Object> paramMap) throws Exception {
		int totalCnt = registerListDao.totalCnt(paramMap);
		return totalCnt;
	}
	//설문 질문, 보기 불러오기
	@Override
	public List<SurveyListModel> srvyqueList(Map<String, Object> paramMap) throws Exception {
		List<SurveyListModel> srvyqueList = registerListDao.srvyqueList(paramMap);
		return srvyqueList;
	}
	//설문 질문 개수 조회 
	@Override
	public int countsrvyList(Map<String, Object> paramMap) throws Exception {
		int totalCount = registerListDao.countsrvyList(paramMap);
		return totalCount;
	}
	//설문 라디오버튼 값 DB insert
	@Override
	public void srvyQueSub(Map<String, Object> paramMap) throws Exception {
		List<String> answerList = new ArrayList<String>();
		for(int i=1; i<=9; i++){
			answerList.add((String) paramMap.get("answer"+i));
			//System.out.println("답" + answerList);
			paramMap.put("item", (String) paramMap.get("answer"+i));
			paramMap.put("que_num",i );
			int result = registerListDao.srvyQueSub(paramMap);
			
			if (paramMap.get("srvy_end") == null){
				if("1".equals((String)paramMap.get("answer"+i))){
					int t =  Integer.parseInt("1");
					paramMap.put("que_one", t);
				}else{
					int f = Integer.parseInt("0");
					paramMap.put("que_one", f);
				}
				if("2".equals((String)paramMap.get("answer"+i))){
					int t =  Integer.parseInt("1");
					paramMap.put("que_two", t);
				}else{
					int f = Integer.parseInt("0");
					paramMap.put("que_two", f);
				}
				if("3".equals((String)paramMap.get("answer"+i))){
					int t =  Integer.parseInt("1");
					paramMap.put("que_three", t);
				}else{
					int f = Integer.parseInt("0");
					paramMap.put("que_three", f);
				}
				if("4".equals((String)paramMap.get("answer"+i))){
					int t =  Integer.parseInt("1");
					paramMap.put("que_four", t);
				}else{
					int f = Integer.parseInt("0");
					paramMap.put("que_four", f);
				}
				if("5".equals((String)paramMap.get("answer"+i))){
					int t =  Integer.parseInt("1");
					paramMap.put("que_five", t);
				}else{
					int f = Integer.parseInt("0");
					paramMap.put("que_five", f);
				}
				if(registerListDao.srvyList(paramMap) == 9 ){
					//인설트
					registerListDao.srvyCnt(paramMap);
					//System.out.println("강의 누적");
				}else{
					registerListDao.srvyCntInsert(paramMap);
					//System.out.println("맨 처음 설문조사");
				}
			}
			
		}
	}
	
	//설문 강의 리뷰 DB insert
	@Override
	public void srvyReview(Map<String, Object> paramMap) throws Exception {
		registerListDao.srvyReview(paramMap);
	}
	//설문 완료 상태 변경
	@Override
	public void stdSrvy_chk(Map<String, Object> paramMap) throws Exception {
		registerListDao.stdSrvy_chk(paramMap);
	}
}
