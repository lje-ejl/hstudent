package kr.kosmo.jobkorea.tut.model;

import lombok.Data;

/* 정수빈 작업 */
@Data
public class SurveyControlModel {

	// 강의 정보
	private String lec_id;
	private String lec_name;
	private String tutor_id;
	private String tutor_name;
	private String c_st;
	private String c_end;
	private String pre_pnum;
	private String lecrm_id;
	private int tut_Total;
	private int srvy_Pnum;
	private int row_num;
	
	// 설문지 문항
	private String que_num;
	private String que;
	
	private String answer_1;
	private String answer_2;
	private String answer_3;
	private String answer_4;
	private String answer_5;
	
	private String sum_1;
	private String sum_2;
	private String sum_3;
	private String sum_4;
	private String sum_5;
	
	// 10번 문제 
	private String lec_rv;
	private int survery10_Total;
	
	
}
