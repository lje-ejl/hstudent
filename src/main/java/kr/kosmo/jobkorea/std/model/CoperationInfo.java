package kr.kosmo.jobkorea.std.model;

public class CoperationInfo {	

	private String loginID;
	private int seq; 
	private String cop_name;
	private String entry_date;
	private String out_date;
	private String grade;
	private String work;
	
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
	public String getCop_name() {
		return cop_name;
	}
	public void setCop_name(String cop_name) {
		this.cop_name = cop_name;
	}
	public String getEntry_date() {
		return entry_date;
	}
	public void setEntry_date(String entry_date) {
		this.entry_date = entry_date;
	}
	public String getOut_date() {
		return out_date;
	}
	public void setOut_date(String out_date) {
		this.out_date = out_date;
	}
	public String getGrade() {
		return grade;
	}
	public void setGrade(String grade) {
		this.grade = grade;
	}
	public String getWork() {
		return work;
	}
	public void setWork(String work) {
		this.work = work;
	}	
}
