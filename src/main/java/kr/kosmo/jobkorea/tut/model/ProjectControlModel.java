package kr.kosmo.jobkorea.tut.model;

public class ProjectControlModel {
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
	////////////////////////////////////////////////////////
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
	/////////////////////////////////////////////////////////
	//과제 테이블 tb_hwk
	private int hwk_id;
	private String hwk_name;
	private String hwk_con;
	private String start;
	private String dead;
	private String hwk_fname;
	private String hwk_url;
	private String hwk_fsize;

	public int getHwk_id() {
		return hwk_id;
	}
	public void setHwk_id(int hwk_id) {
		this.hwk_id = hwk_id;
	}
	public String getHwk_name() {
		return hwk_name;
	}
	public void setHwk_name(String hwk_name) {
		this.hwk_name = hwk_name;
	}
	public String getHwk_con() {
		return hwk_con;
	}
	public void setHwk_con(String hwk_con) {
		this.hwk_con = hwk_con;
	}
	public String getStart() {
		return start;
	}
	public void setStart(String start) {
		this.start = start;
	}
	public String getDead() {
		return dead;
	}
	public void setDead(String dead) {
		this.dead = dead;
	}
	public String getHwk_fname() {
		return hwk_fname;
	}
	public void setHwk_fname(String hwk_fname) {
		this.hwk_fname = hwk_fname;
	}
	public String getHwk_url() {
		return hwk_url;
	}
	public void setHwk_url(String hwk_url) {
		this.hwk_url = hwk_url;
	}
	public String getHwk_fsize() {
		return hwk_fsize;
	}
	public void setHwk_fsize(String hwk_fsize) {
		this.hwk_fsize = hwk_fsize;
	}
	/////////////////////////////////////////////////
	//과제제출 테이블 tb_hwk_submit
	private String std_id;
	private String submit_con;
	private String submit_fname;
	private String submit_url;
	private String submit_fsize;
	private String submit_date;

	public String getStd_id() {
		return std_id;
	}
	public void setStd_id(String std_id) {
		this.std_id = std_id;
	}
	public String getSubmit_con() {
		return submit_con;
	}
	public void setSubmit_con(String submit_con) {
		this.submit_con = submit_con;
	}
	public String getSubmit_fname() {
		return submit_fname;
	}
	public void setSubmit_fname(String submit_fname) {
		this.submit_fname = submit_fname;
	}
	public String getSubmit_url() {
		return submit_url;
	}
	public void setSubmit_url(String submit_url) {
		this.submit_url = submit_url;
	}
	public String getSubmit_fsize() {
		return submit_fsize;
	}
	public void setSubmit_fsize(String submit_fsize) {
		this.submit_fsize = submit_fsize;
	}
	public String getSubmit_date() {
		return submit_date;
	}
	public void setSubmit_date(String submit_date) {
		this.submit_date = submit_date;
	}
	/////////////////////////////////////
	//userinfo 테이블
	private String name;
	private String std_num;

	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getStd_num() {
		return std_num;
	}
	public void setStd_num(String std_num) {
		this.std_num = std_num;
	}
}
