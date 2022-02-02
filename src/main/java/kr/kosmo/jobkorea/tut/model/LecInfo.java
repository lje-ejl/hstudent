package kr.kosmo.jobkorea.tut.model;

import lombok.Data;

@Data
public class LecInfo {
	
	private int lec_id;
	private String tutor_id;
	private int lecrm_id;
	private String tutor_name;
	private String lec_name;
	private int max_pnum;
	private int pre_pnum;
	private String c_st;
	private String c_end;
	private int process_day;
	private int pre_day;
	private String lec_goal;
	private String atd_plan;
	private String lec_sort;
	//추가
	private int day_result;
	}
