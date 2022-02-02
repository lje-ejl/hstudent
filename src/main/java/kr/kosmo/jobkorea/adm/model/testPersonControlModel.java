package kr.kosmo.jobkorea.adm.model;


public class testPersonControlModel {
		

		//tb_test(시험 테이블)
		private int test_id; //시험 ID
		private int lec_id; //강의 ID
		private String test_name; //시험명
		private String test_sort; //시험 분류
		private String test_start; //시작일
		private String test_end; //종료일
		
		//tb_test_user(시험 응시 정보 테이블)
		private String std_id;
		private int test_sco;
		
		//tb_lec_info(강의 정보 테이블)
		private String lec_name; //강의명
		private String c_st; //강의 시작일
		private String c_end; //강의 종료일
		private String pre_pnum;
		
		//tb_userinfo(회원테이블)
		private String name;// 이름 
		private String loginID;
		
		//DB_tb_test_user
		private String sco; //시험점수가 있는 사람 - 응시자 수
		private String minNum; // 미응시자 수
		
		private String std_num;
		

	public String getStd_num() {
			return std_num;
		}
		public void setStd_num(String std_num) {
			this.std_num = std_num;
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
	public String getTest_name() {
		return test_name;
	}
	public void setTest_name(String test_name) {
		this.test_name = test_name;
	}
	public String getTest_sort() {
		return test_sort;
	}
	public void setTest_sort(String test_sort) {
		this.test_sort = test_sort;
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
	public String getStd_id() {
		return std_id;
	}
	public void setStd_id(String std_id) {
		this.std_id = std_id;
	}
	public int getTest_sco() {
		return test_sco;
	}
	public void setTest_sco(int test_sco) {
		this.test_sco = test_sco;
	}
	public String getLec_name() {
		return lec_name;
	}
	public void setLec_name(String lec_name) {
		this.lec_name = lec_name;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getLoginID() {
		return loginID;
	}
	public void setLoginID(String loginID) {
		this.loginID = loginID;
	}
	public String getSco() {
		return sco;
	}
	public void setSco(String sco) {
		this.sco = sco;
	}
	public String getMinNum() {
		return minNum;
	}
	public void setMinNum(String minNum) {
		this.minNum = minNum;
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
	
	public String getPre_pnum() {
		return pre_pnum;
	}
	public void setPre_pnum(String pre_pnum) {
		this.pre_pnum = pre_pnum;
	}
	
}
