package kr.kosmo.jobkorea.std.model;

public class TestUser {
	// tb_test_user 테이블
	private String std_id;
	private int test_id;
	private int lec_id;
	private int test_sco;
	private String pass;
	private String test_ans;
	  
	private String test_start;
	private String test_end;
	
	private String lec_name;
	private String test_name;
	
	private String tutor_name;
	
	public String getStd_id() {
		return std_id;
	}
	public void setStd_id(String std_id) {
		this.std_id = std_id;
	}
	public int getTest_id() {
		return test_id;
	}
	public void setTest_id(int test_id) {
		this.test_id = test_id;
	}
	public int getLec_id() {
		return lec_id;
	}
	public void setLec_id(int lec_id) {
		this.lec_id = lec_id;
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
	public String getTest_start() {
		return test_start;
	}
	public void setTest_start(String test_start) {
		this.test_start = test_start;
	}
	public String getTest_end() {
		return test_end;
	}
	public void setTest_end(String test_end) {
		this.test_end = test_end;
	}
	public String getLec_name() {
		return lec_name;
	}
	public void setLec_name(String lec_name) {
		this.lec_name = lec_name;
	}
	public String getTest_name() {
		return test_name;
	}
	public void setTest_name(String test_name) {
		this.test_name = test_name;
	}
	public String getTutor_name() {
		return tutor_name;
	}
	public void setTutor_name(String tutor_name) {
		this.tutor_name = tutor_name;
	}
	
	
	
	
}
