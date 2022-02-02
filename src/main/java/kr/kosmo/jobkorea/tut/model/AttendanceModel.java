package kr.kosmo.jobkorea.tut.model;

import lombok.Data;

@Data
public class AttendanceModel {
	
	private int lec_id;
	private String std_id;
	private String len_date;
	private String atd_time;
	private String atd_state;
	private String note;
	
	//join data 회원정보
	private String name;
	private String tel;
	
	//join data 수강생정보
	private int atd_day;
	
	//join data 강의정보
	private int pre_day;
	private int process_day;
	//distinct count, 출석일 뿌리기용
	private int count;
	private String d_len;
	private String all_state;
	private String ld;
	private int cnt;
	private int res;
}
