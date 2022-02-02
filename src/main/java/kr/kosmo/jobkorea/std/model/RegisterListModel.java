package kr.kosmo.jobkorea.std.model;

public class RegisterListModel {
	
	private String lec_id; 	//설문조사를 위한 강의아이디
	
	private String lec_name; 	//강의명
	private String tutor_name;	//강사명
	private String c_st;		//강의시작
	private String c_end;		//강의종료 - 강의기간
	private String lecrm_name;	//강의실
	private String atd_plan;	//출석계획
	private String lec_goal;	//강의목표
	private int pre_day;		//현재과정일수
	private int process_day;	//진도 (% = 현재과정일수/총과정일수)
	
	private int atd_day;	//출석상태 -출석, 지각, 결석 카운트 가져오기

	private int atd_cnt; //출석
	private int late_cnt; // 지각
	private int absent_cnt; //결석
	
	private String apv; //강의승낙여부
	
	private String srvy_chk; //설문조사 확인
	
	public String getLec_name() {
		return lec_name;
	}
	public void setLec_name(String lec_name) {
		this.lec_name = lec_name;
	}
	public String getTutor_name() {
		return tutor_name;
	}
	public void setTutor_name(String tutor_name) {
		this.tutor_name = tutor_name;
	}
	public String getC_st() {
		return c_st;
	}
	public void setC_st(String c_st) {
		this.c_st = c_st;
	}
	public String getC_end() {
		return c_end;
	}
	public void setC_end(String c_end) {
		this.c_end = c_end;
	}
	public String getLecrm_name() {
		return lecrm_name;
	}
	public void setLecrm_name(String lecrm_name) {
		this.lecrm_name = lecrm_name;
	}
	public String getAtd_plan() {
		return atd_plan;
	}
	public void setAtd_plan(String atd_plan) {
		this.atd_plan = atd_plan;
	}
	public String getLec_goal() {
		return lec_goal;
	}
	public void setLec_goal(String lec_goal) {
		this.lec_goal = lec_goal;
	}
	public int getPre_day() {
		return pre_day;
	}
	public void setPre_day(int pre_day) {
		this.pre_day = pre_day;
	}
	public int getProcess_day() {
		return process_day;
	}
	public void setProcess_day(int process_day) {
		this.process_day = process_day;
	}
	public int getAtd_day() {
		return atd_day;
	}
	public void setAtd_day(int atd_day) {
		this.atd_day = atd_day;
	}
	
	public int getAtd_cnt() {
		return atd_cnt;
	}
	public void setAtd_cnt(int atd_cnt) {
		this.atd_cnt = atd_cnt;
	}
	public int getLate_cnt() {
		return late_cnt;
	}
	public void setLate_cnt(int late_cnt) {
		this.late_cnt = late_cnt;
	}
	public int getAbsent_cnt() {
		return absent_cnt;
	}
	public void setAbsent_cnt(int absent_cnt) {
		this.absent_cnt = absent_cnt;
	}
	public String getApv() {
		return apv;
	}
	public void setApv(String apv) {
		this.apv = apv;
	}
	public String getSrvy_chk() {
		return srvy_chk;
	}
	public void setSrvy_chk(String srvy_chk) {
		this.srvy_chk = srvy_chk;
	}
	
	
	public String getLec_id() {
		return lec_id;
	}
	public void setLec_id(String lec_id) {
		this.lec_id = lec_id;
	}
	
	
	
	
}
