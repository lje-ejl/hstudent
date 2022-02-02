package kr.kosmo.jobkorea.std.service;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.kosmo.jobkorea.std.dao.TestApplicationDao;
import kr.kosmo.jobkorea.std.model.TestUser;
import kr.kosmo.jobkorea.tut.model.TestQue;


@Service
public class TestApplicationsServiceImpl implements TestApplicationsService{

	@Autowired
	TestApplicationDao TestApplyDao;
	
	// 시험 조회
	@Override
	public List<TestUser> selectTest(Map<String, Object> paramMap) throws Exception {
		List<TestUser> testList = TestApplyDao.selectTest(paramMap);
		return testList;
	}  
	
	// 시험 카운트 조회
	@Override
	public int countListComnGrpCod(Map<String, Object> paramMap) throws Exception {
		int result = TestApplyDao.countListComnGrpCod(paramMap);
		return result;
	}
	
	// 시험 문제 조회
	@Override
	public List<TestQue> applyTest(Map<String, Object> paramMap) throws Exception {
		List<TestQue> testList = TestApplyDao.applyTest(paramMap);
		return testList;
	}
	
	// 시험 결과 insert
	// 기존의 답과 비교하는 로직 처리 부분 (학생이 제출한 답안:paramMap /실제답안:testList에 담겨있음)
	@Override
	public int submitTest(Map<String, Object> paramMap) throws Exception {
		
		List<TestQue> testList = TestApplyDao.applyTest(paramMap);
		
		// 값 보내기 위한 초기화 부분
		double sumScore = 0; //= 총점수
		double popScore = (100/(double)testList.size()); //= 개당점수 
		String pass = ""; // pass여부(A:통과/B:재시험/C:불합격)
		ArrayList<String> test_ans = new ArrayList<>();
		
		for(int i=0; i<testList.size(); i++){
			
			if(paramMap.get("test"+(i+1)).equals(testList.get(i).getQue_ans())){
				//System.out.println("학생답"+paramMap.get("test"+(i+1)));
				//System.out.println("실제답"+testList.get(i).getQue_ans());
				System.out.println(i + "번째에 값이 같습니다");
				
				sumScore += popScore;
			}else{
				System.out.println(i + "번째에 값이 다릅니다.");
				//System.out.println("학생답"+paramMap.get("test"+(i+1)));
				//System.out.println("실제답"+testList.get(i).getQue_ans());
			}
			
			test_ans.add((String) paramMap.get("test"+(i+1)));
		}
		
		String str = StringUtils.join(test_ans, ",");
		
		// 총점수에 따라 pass여부 넣어줌
		if(sumScore>=60){
			pass = "A";
		}else{
			pass = "C";
		}
		
		paramMap.put("test_sco", sumScore);
		paramMap.put("pass", pass);
		paramMap.put("test_ans", str);
		
		int result = TestApplyDao.submitTest(paramMap);

		return result;
	}

	// 시험 결과 조회
	@Override
	public TestQue selectAns(Map<String, Object> paramMap) throws Exception {
		TestQue ansList = TestApplyDao.selectAns(paramMap);
		return ansList;
	}

	
}
