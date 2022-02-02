package kr.kosmo.jobkorea.login.model;

import lombok.Data;
import lombok.ToString;

@Data
@ToString
public class RegisterInfoModel {

	private String loginID ;
	private String user_type;
	private String name;
	private String password;
	private String tel;
	private String sex;
	private String birth;
	private String mail;
	private String addr;
	private String join_date;
	private String pid;
	private String std_Id;
	private String rs_fname;
	private String rs_url;
	private String rs_fsize;
	private String comp_name;
	private String comp_addr;
	private String comp_tel;
	private String comp_mail;
	
	//정이안 registerList.jsp 사용
	private String lec_name;//강의명
	private String std_num; // 학번
	private String atd;//출석률
	
	private int che;
	
	public String getLoginID() {
		return loginID;
	}

	public void setLoginID(String loginID) {
		this.loginID = loginID;
	}

	public String getUser_type() {
		return user_type;
	}

	public void setUser_type(String user_type) {
		this.user_type = user_type;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public String getTel() {
		return tel;
	}

	public void setTel(String tel) {
		this.tel = tel;
	}

	public String getSex() {
		return sex;
	}

	public void setSex(String sex) {
		this.sex = sex;
	}

	public String getBirth() {
		return birth;
	}

	public void setBirth(String birth) {
		this.birth = birth;
	}

	public String getMail() {
		return mail;
	}

	public void setMail(String mail) {
		this.mail = mail;
	}

	public String getAddr() {
		return addr;
	}

	public void setAddr(String addr) {
		this.addr = addr;
	}

	public String getJoin_date() {
		return join_date;
	}

	public void setJoin_date(String join_date) {
		this.join_date = join_date;
	}

	public String getPid() {
		return pid;
	}

	public void setPid(String pid) {
		this.pid = pid;
	}

	public String getStd_Id() {
		return std_Id;
	}

	public void setStd_Id(String std_Id) {
		this.std_Id = std_Id;
	}

	public String getRs_fname() {
		return rs_fname;
	}

	public void setRs_fname(String rs_fname) {
		this.rs_fname = rs_fname;
	}

	public String getRs_url() {
		return rs_url;
	}

	public void setRs_url(String rs_url) {
		this.rs_url = rs_url;
	}

	public String getRs_fsize() {
		return rs_fsize;
	}

	public void setRs_fsize(String rs_fsize) {
		this.rs_fsize = rs_fsize;
	}

	public String getComp_name() {
		return comp_name;
	}

	public void setComp_name(String comp_name) {
		this.comp_name = comp_name;
	}

	public String getComp_addr() {
		return comp_addr;
	}

	public void setComp_addr(String comp_addr) {
		this.comp_addr = comp_addr;
	}

	public String getComp_tel() {
		return comp_tel;
	}

	public void setComp_tel(String comp_tel) {
		this.comp_tel = comp_tel;
	}

	public String getComp_mail() {
		return comp_mail;
	}

	public void setComp_mail(String comp_mail) {
		this.comp_mail = comp_mail;
	}

	public String getLec_name() {
		return lec_name;
	}

	public void setLec_name(String lec_name) {
		this.lec_name = lec_name;
	}

	public String getStd_num() {
		return std_num;
	}

	public void setStd_num(String std_num) {
		this.std_num = std_num;
	}

	public String getAtd() {
		return atd;
	}

	public void setAtd(String atd) {
		this.atd = atd;
	}

	public int getChe() {
		return che;
	}

	public void setChe(int che) {
		this.che = che;
	}


}
