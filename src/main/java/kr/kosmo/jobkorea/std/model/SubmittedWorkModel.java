package kr.kosmo.jobkorea.std.model;

public class SubmittedWorkModel {

	private String student_name; //학생이름
	private String tutor_name; //강사이름
	private String lec_name; //강의명
	
	private String hwk_name; //과제명
	private String hwk_con; //과제내용
	private String start; //과제 시작일
	private String dead; //과제 마감일
	
	private String hwk_fname; //파일이름(다운)
	private String hwk_url; //파일주소(다운)
	private String hwl_fsize; //파일사이즈(다운)
	
	private String submit_con; //과제내용(제출)
	
	private String submit_fname; //첨부파일이름(제출)
	private String submit_url; //첨부파일주소(제출)
	private String submit_fsize; //첨부파일사이즈(제출)
	
	private String submit_date; //제출한날짜
	
	private int hwk_id;  //과제 아이디 (중복X) 

	private int lec_id;  //강의아이디  

	private int hwk_id_sub;  //제출한 과제 아이디 (제출여부 위함)
	
	
	private String apv; //강의 수락 여부
	
	public int getHwk_id() {
		return hwk_id;
	}
	public void setHwk_id(int hwk_id) {
		this.hwk_id = hwk_id;
	}
	
	public String getStudent_name() {
		return student_name;
	}
	public void setStudent_name(String student_name) {
		this.student_name = student_name;
	}
	public String getTutor_name() {
		return tutor_name;
	}
	public void setTutor_name(String tutor_name) {
		this.tutor_name = tutor_name;
	}
	public String getLec_name() {
		return lec_name;
	}
	public void setLec_name(String lec_name) {
		this.lec_name = lec_name;
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
	public String getHwl_fsize() {
		return hwl_fsize;
	}
	public void setHwl_fsize(String hwl_fsize) {
		this.hwl_fsize = hwl_fsize;
	}
	public String getSubmit_con() {
		return submit_con;
	}
	public void setSubmit_con(String submit_con) {
		this.submit_con = submit_con;
	}
	public String getSubmit_date() {
		return submit_date;
	}
	public void setSubmit_date(String submit_date) {
		this.submit_date = submit_date;
	}
	public String getApv() {
		return apv;
	}
	public void setApv(String apv) {
		this.apv = apv;
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
	
	public int getHwk_id_sub() {
		return hwk_id_sub;
	}
	public void setHwk_id_sub(int hwk_id_sub) {
		this.hwk_id_sub = hwk_id_sub;
	}
	
	public int getLec_id() {
		return lec_id;
	}
	public void setLec_id(int lec_id) {
		this.lec_id = lec_id;
	}
	
	
	
}
