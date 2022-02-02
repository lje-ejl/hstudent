package kr.kosmo.jobkorea.adm.model;

public class EmploymentInfoModel {
	
	private int employ_id;//취업 정보 id
	private String std_id; //학생 id
	private String comp_name; // 회사명
	private String employ_day; // 입사일
	private String resign_day; //퇴사일
	private String wp_state; //재직 여부
	private String reg_state; //이력서 등록 여부
	private String comp_etc; //기타 회사

	public String getComp_etc() {
		return comp_etc;
	}

	public void setComp_etc(String comp_etc) {
		this.comp_etc = comp_etc;
	}

	//tb_userInfo
	private String name; //학생 이름 
	private String std_num; //학번
	private String tel; //번호
	private String loginID;//학생 id
	
	//tb_lec_info
	private String lec_id;//강의 id
	private String lec_name;//강의 id
	private String c_st;//시작일
	private String c_end;//종강일
	
	//강의 진행중 상태 표시 뷰단
	private String state;
	
	
	public String getState() {
		return state;
	}

	public void setState(String state) {
		this.state = state;
	}

	public String getLec_id() {
		return lec_id;
	}

	public void setLec_id(String lec_id) {
		this.lec_id = lec_id;
	}

	public String getLec_name() {
		return lec_name;
	}

	public void setLec_name(String lec_name) {
		this.lec_name = lec_name;
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

	public String getLoginID() {
		return loginID;
	}

	public void setLoginID(String loginID) {
		this.loginID = loginID;
	}

	public String getTel() {
		return tel;
	}

	public void setTel(String tel) {
		this.tel = tel;
	}

	public String getStd_num() {
		return std_num;
	}

	public void setStd_num(String std_num) {
		this.std_num = std_num;
	}

	public int getEmploy_id() {
		return employ_id;
	}

	public void setEmploy_id(int employ_id) {
		this.employ_id = employ_id;
	}

	public String getStd_id() {
		return std_id;
	}

	public void setStd_id(String std_id) {
		this.std_id = std_id;
	}

	public String getComp_name() {
		return comp_name;
	}

	public void setComp_name(String comp_name) {
		this.comp_name = comp_name;
	}

	public String getEmploy_day() {
		return employ_day;
	}

	public void setEmploy_day(String employ_day) {
		this.employ_day = employ_day;
	}

	public String getResign_day() {
		return resign_day;
	}

	public void setResign_day(String resign_day) {
		this.resign_day = resign_day;
	}

	public String getWp_state() {
		return wp_state;
	}

	public void setWp_state(String wp_state) {
		this.wp_state = wp_state;
	}

	
	public String getReg_state() {
		return reg_state;
	}

	public void setReg_state(String reg_state) {
		this.reg_state = reg_state;
	}
	
	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}
}
