package kr.kosmo.jobkorea.tut.model;

public class ProgressControlModel {
	//강의정보 테이블 tb_lec_info
	private int lec_id;
	private String tutor_id;
	private String lec_name;
	private String lecrm_id;
	private int max_pnum;
	private int pre_pnum;
	private String c_st;
	private String c_end;
	private int process_day;
	private int pre_day;
	private String lec_goal;
	private String atd_plan;
	private String lec_sort;
	private String tutor_name;
	
	private double p_count;
	
	
	public double getP_count() {
		return p_count;
	}
	public void setP_count(double p_count) {
		this.p_count = p_count;
	}
	public int getLec_id() {
		return lec_id;
	}
	public void setLec_id(int lec_id) {
		this.lec_id = lec_id;
	}
	public String getTutor_id() {
		return tutor_id;
	}
	public void setTutor_id(String tutor_id) {
		this.tutor_id = tutor_id;
	}
	public String getLec_name() {
		return lec_name;
	}
	public void setLec_name(String lec_name) {
		this.lec_name = lec_name;
	}
	public String getLecrm_id() {
		return lecrm_id;
	}
	public void setLecrm_id(String lecrm_id) {
		this.lecrm_id = lecrm_id;
	}
	public int getMax_pnum() {
		return max_pnum;
	}
	public void setMax_pnum(int max_pnum) {
		this.max_pnum = max_pnum;
	}
	public int getPre_pnum() {
		return pre_pnum;
	}
	public void setPre_pnum(int pre_pnum) {
		this.pre_pnum = pre_pnum;
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
	public int getProcess_day() {
		return process_day;
	}
	public void setProcess_day(int process_day) {
		this.process_day = process_day;
	}
	public int getPre_day() {
		return pre_day;
	}
	public void setPre_day(int pre_day) {
		this.pre_day = pre_day;
	}
	public String getLec_goal() {
		return lec_goal;
	}
	public void setLec_goal(String lec_goal) {
		this.lec_goal = lec_goal;
	}
	public String getAtd_plan() {
		return atd_plan;
	}
	public void setAtd_plan(String atd_plan) {
		this.atd_plan = atd_plan;
	}
	public String getLec_sort() {
		return lec_sort;
	}
	public void setLec_sort(String lec_sort) {
		this.lec_sort = lec_sort;
	}
	public String getTutor_name() {
		return tutor_name;
	}
	public void setTutor_name(String tutor_name) {
		this.tutor_name = tutor_name;
	}
	///////////////////////////////////////////////////////
	//강의실 테이블 tb_lecrm
	private String lecrm_name;
	private String lecrom_size;
	private int lecrm_snum;
	private String lecrm_note;
	
	public String getLecrm_name() {
		return lecrm_name;
	}
	public void setLecrm_name(String lecrm_name) {
		this.lecrm_name = lecrm_name;
	}
	public String getLecrom_size() {
		return lecrom_size;
	}
	public void setLecrom_size(String lecrom_size) {
		this.lecrom_size = lecrom_size;
	}
	public int getLecrm_snum() {
		return lecrm_snum;
	}
	public void setLecrm_snum(int lecrm_snum) {
		this.lecrm_snum = lecrm_snum;
	}
	public String getLecrm_note() {
		return lecrm_note;
	}
	public void setLecrm_note(String lecrm_note) {
		this.lecrm_note = lecrm_note;
	}
	///////////////////////////////////////////////////
	//강의계획서 tb_week_plan
	private String week;
	private String learn_con;
	private String learn_goal;
	
	public String getWeek() {
		return week;
	}
	public void setWeek(String week) {
		this.week = week;
	}
	public String getLearn_con() {
		return learn_con;
	}
	public void setLearn_con(String learn_con) {
		this.learn_con = learn_con;
	}
	public String getLearn_goal() {
		return learn_goal;
	}
	public void setLearn_goal(String learn_goal) {
		this.learn_goal = learn_goal;
	}
	
	/////////////////////////////////////////////////////
	
}
