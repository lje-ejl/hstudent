package kr.kosmo.jobkorea.tut.model;

import java.util.Date;

import lombok.Data;
import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

public class AdviceModel {
	private int adv_id;
	private int lec_id;
	private String lec_name;
	private String std_id;
	private String tut_id;
	private String std_name;
	private String tut_name;
	private String adv_con;
	private String adv_plc;
	private String adv_date;
	private String up_date;
	private String last_score;
	public int getAdv_id() {
		return adv_id;
	}
	public void setAdv_id(int adv_id) {
		this.adv_id = adv_id;
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
	public String getStd_id() {
		return std_id;
	}
	public void setStd_id(String std_id) {
		this.std_id = std_id;
	}
	public String getTut_id() {
		return tut_id;
	}
	public void setTut_id(String tut_id) {
		this.tut_id = tut_id;
	}
	public String getStd_name() {
		return std_name;
	}
	public void setStd_name(String std_name) {
		this.std_name = std_name;
	}
	public String getTut_name() {
		return tut_name;
	}
	public void setTut_name(String tut_name) {
		this.tut_name = tut_name;
	}
	public String getAdv_con() {
		return adv_con;
	}
	public void setAdv_con(String adv_con) {
		this.adv_con = adv_con;
	}
	public String getAdv_plc() {
		return adv_plc;
	}
	public void setAdv_plc(String adv_plc) {
		this.adv_plc = adv_plc;
	}
	public String getAdv_date() {
		return adv_date;
	}
	public void setAdv_date(String adv_date) {
		this.adv_date = adv_date;
	}
	public String getUp_date() {
		return up_date;
	}
	public void setUp_date(String up_date) {
		this.up_date = up_date;
	}
	public String getLast_score() {
		return last_score;
	}
	public void setLast_score(String last_score) {
		this.last_score = last_score;
	}
	@Override
	public String toString() {
		return "AdviceModel [adv_id=" + adv_id + ", lec_id=" + lec_id + ", lec_name=" + lec_name + ", std_id=" + std_id
				+ ", tut_id=" + tut_id + ", std_name=" + std_name + ", tut_name=" + tut_name + ", adv_con=" + adv_con
				+ ", adv_plc=" + adv_plc + ", adv_date=" + adv_date + ", up_date=" + up_date + ", last_score="
				+ last_score + "]";
	}
	
	
	
}
