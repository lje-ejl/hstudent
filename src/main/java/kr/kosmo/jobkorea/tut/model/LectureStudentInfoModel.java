package kr.kosmo.jobkorea.tut.model;

public class LectureStudentInfoModel {
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
   //////////////////////////////////////////////////////////////
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
//////////////////////////////////////////////////////////////
   //수강생정보 tb_lecstd_info
   private String std_id;
   private String srvy_chk;
   private String apv;
   private int atd_day;

   public String getStd_id() {
      return std_id;
   }
   public void setStd_id(String std_id) {
      this.std_id = std_id;
   }
   public String getSrvy_chk() {
      return srvy_chk;
   }
   public void setSrvy_chk(String srvy_chk) {
      this.srvy_chk = srvy_chk;
   }
   public String getApv() {
      return apv;
   }
   public void setApv(String apv) {
      this.apv = apv;
   }
   public int getAtd_day() {
      return atd_day;
   }
   public void setAtd_day(int atd_day) {
      this.atd_day = atd_day;
   }
   //////////////////////////////////////////////////
   //시험응시정보 tb_test_user
   private int test_id;
   private int test_sco;
   private String pass;
   private String test_ans;
   private String test_date;

   public int getTest_id() {
      return test_id;
   }
   public void setTest_id(int test_id) {
      this.test_id = test_id;
   }
   public int getTest_sco() {
      return test_sco;
   }
   public void setTest_sco(int test_sco) {
      this.test_sco = test_sco;
   }
   public String getPass() {
      return pass;
   }
   public void setPass(String pass) {
      this.pass = pass;
   }
   public String getTest_ans() {
      return test_ans;
   }
   public void setTest_ans(String test_ans) {
      this.test_ans = test_ans;
   }
   public String getTest_date() {
      return test_date;
   }
   public void setTest_date(String test_date) {
      this.test_date = test_date;
   }
   ///////////////////////////////////////////////////
   //회원 테이블 tb_userinfo
   private String name;
   private String std_num;
   private String tel;
   private String birth;
   private String loginID;
   
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
   public String getTel() {
      return tel;
   }
   public void setTel(String tel) {
      this.tel = tel;
   }
   public String getBirth() {
      return birth;
   }
   public void setBirth(String birth) {
      this.birth = birth;
   }
	public String getLoginID() {
		return loginID;
	}
	public void setLoginID(String loginID) {
		this.loginID = loginID;
	}
	//////////////////////////////////////////////////
	//출석부 테이블 tb_atd
	private String len_data;
	private String atd_time;
	private String atd_state;
	private String note;

	public String getLen_data() {
		return len_data;
	}
	public void setLen_data(String len_data) {
		this.len_data = len_data;
	}
	public String getAtd_time() {
		return atd_time;
	}
	public void setAtd_time(String atd_time) {
		this.atd_time = atd_time;
	}
	public String getAtd_state() {
		return atd_state;
	}
	public void setAtd_state(String atd_state) {
		this.atd_state = atd_state;
	}
	public String getNote() {
		return note;
	}
	public void setNote(String note) {
		this.note = note;
	}
}