package kr.kosmo.jobkorea.std.model;

public class EduInfo {	

	private String loginID;
	private int seq; 
	private String edu_name;
	private String start_date;
	private String end_date;
	private String edu_center;
	
	public String getLoginID() {
		return loginID;
	}
	public void setLoginID(String loginID) {
		this.loginID = loginID;
	}
	public int getSeq() {
		return seq;
	}
	public void setSeq(int seq) {
		this.seq = seq;
	}
	public String getEdu_name() {
		return edu_name;
	}
	public void setEdu_name(String edu_name) {
		this.edu_name = edu_name;
	}
	public String getStart_date() {
		return start_date;
	}
	public void setStart_date(String start_date) {
		this.start_date = start_date;
	}
	public String getEnd_date() {
		return end_date;
	}
	public void setEnd_date(String end_date) {
		this.end_date = end_date;
	}
	public String getEdu_center() {
		return edu_center;
	}
	public void setEdu_center(String edu_center) {
		this.edu_center = edu_center;
	}
}
