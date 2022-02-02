package kr.kosmo.jobkorea.adm.model;

import lombok.Data;

@Data
public class e_resumeControlModel {
	
	// 강의
	private String lec_id;
	private String lec_name;
	private String tutor_name;
	private String pre_pnum;
	private String c_st;
	private String c_end;
	private String lec_Total;
	private int rownum;
	
	// 학생
	private String loginId;
	private String name;
	private String tel;
	private String mail;
	private String std_id;
	private String wp_state;
	private String Std_Total;
	private String birth;
	private String sex;
	private String std_num;
	
	// 이력서
	private String rs_fname;
	private String rs_url;
	private int rs_fsize;
	private String rs_check;
	
	// 기업
	private String comp_name;
	private String comp_tel;
}