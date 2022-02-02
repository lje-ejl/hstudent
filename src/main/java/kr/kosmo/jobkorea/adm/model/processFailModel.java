package kr.kosmo.jobkorea.adm.model;

import java.sql.Date;

public class processFailModel {

	
	private int lec_id;
	private String lec_name;
	private String startdate;
	private String enddate;
	private int process_day;
	private int pre_pnum;
	private String std_id;
	private int fail;
	private int pass;
	private int atd_per;
	private int sresult;
	private int fresult;
	
	
	
	public int getSresult() {
		return sresult;
	}



	public void setSresult(int sresult) {
		this.sresult = sresult;
	}



	public int getFresult() {
		return fresult;
	}



	public void setFresult(int fresult) {
		this.fresult = fresult;
	}



	private String data;

	
	
	public int getAtd_per() {
		return atd_per;
	}



	public void setAtd_per(int atd_per) {
		this.atd_per = atd_per;
	}



	


	public String getData() {
		return data;
	}



	public void setData(String data) {
		this.data = data;
	}


	public int getFail() {
		return fail;
	}



	public void setFail(int fail) {
		this.fail = fail;
	}



	public int getPass() {
		return pass;
	}



	public void setPass(int pass) {
		this.pass = pass;
	}



	public String getStd_id() {
		return std_id;
	}



	public void setStd_id(String std_id) {
		this.std_id = std_id;
	}




	public int getLec_id() {
		return lec_id;
	}



	public void setLec_id(int lec_id) {
		this.lec_id = lec_id;
	}



	public String getLec_name() {
		return lec_name;
	}



	public void setLec_name(String lec_name) {
		this.lec_name = lec_name;
	}



	public String getStartdate() {
		return startdate;
	}



	public void setStartdate(String startdate) {
		this.startdate = startdate;
	}



	public String getEnddate() {
		return enddate;
	}



	public void setEnddate(String enddate) {
		this.enddate = enddate;
	}



	public int getProcess_day() {
		return process_day;
	}



	public void setProcess_day(int process_day) {
		this.process_day = process_day;
	}



	public int getPre_pnum() {
		return pre_pnum;
	}



	public void setPre_pnum(int pre_pnum) {
		this.pre_pnum = pre_pnum;
	}




	
	
	
}