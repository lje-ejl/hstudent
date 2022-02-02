package kr.kosmo.jobkorea.notice.model;

public class ANoticeModel {
	private String loginId; 
	private String notice_tit;
	private int notice_id;
	private String notice_con;
	private String regdate;
	private int hit;
	private String name;
	private String user_type;
	
	
	public String getUser_type() {
		return user_type;
	}
	public void setUser_type(String user_type) {
		this.user_type = user_type;
	}
	public int getNotice_id() {
		return notice_id;
	}
	public void setNotice_id(int notice_id) {
		this.notice_id = notice_id;
	}
	public int getHit() {
		return hit;
	}
	public void setHit(int hit) {
		this.hit = hit;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getLoginId() {
		return loginId;
	}
	public void setLoginId(String loginId) {
		this.loginId = loginId;
	}
	public String getNotice_tit() {
		return notice_tit;
	}
	public void setNotice_tit(String notice_tit) {
		this.notice_tit = notice_tit;
	}
	
	public String getNotice_con() {
		return notice_con;
	}
	public void setNotice_con(String notice_con) {
		this.notice_con = notice_con;
	}
	public String getRegdate() {
		return regdate;
	}
	public void setRegdate(String regdate) {
		this.regdate = regdate;
	}
	
	
	
}
