package kr.kosmo.jobkorea.tut.model;

import lombok.Data;

@Data
public class TestModel{
	
	//시험 등록
	
	//시험ID
	private int test_id;
	//강의ID
	private int lec_id;
	//시험명
	private String test_name;
	//시험분류
	private String test_sort;
	//시작일
	private String test_start;
	//종료일
	private String test_end;
	
	
	//join용 추가 변수
	private String std_id;
	private int test_sco;
	private String pass;
	private String name;
	private String sc;
	
}