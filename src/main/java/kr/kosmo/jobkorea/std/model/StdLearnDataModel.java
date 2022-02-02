package kr.kosmo.jobkorea.std.model;

public class StdLearnDataModel {
	
	private int lec_id;
	private int learn_data_id;
	private String learn_tit;
	private String lec_name;
	private String learn_con;
	private String w_date;
	private String learn_fname;
	private String learn_url;
	private String learn_fsize;
	
	public String getLec_name() {
		return lec_name;
	}
	public void setLec_name(String lec_name) {
		this.lec_name = lec_name;
	}
	
	public String getLearn_fname() {
		return learn_fname;
	}
	public void setLearn_fname(String learn_fname) {
		this.learn_fname = learn_fname;
	}
	public String getLearn_url() {
		return learn_url;
	}
	public void setLearn_url(String learn_url) {
		this.learn_url = learn_url;
	}
	public String getLearn_fsize() {
		return learn_fsize;
	}
	public void setLearn_fsize(String learn_fsize) {
		this.learn_fsize = learn_fsize;
	}
	public String getLearn_con() {
		return learn_con;
	}
	public void setLearn_con(String learn_con) {
		this.learn_con = learn_con;
	}
	
	public int getLec_id() {
		return lec_id;
	}
	public void setLec_id(int lec_id) {
		this.lec_id = lec_id;
	}
	public int getLearn_data_id() {
		return learn_data_id;
	}
	public void setLearn_data_id(int learn_data_id) {
		this.learn_data_id = learn_data_id;
	}
	public String getLearn_tit() {
		return learn_tit;
	}
	public void setLearn_tit(String learn_tit) {
		this.learn_tit = learn_tit;
	}
	public String getW_date() {
		return w_date;
	}
	public void setW_date(String w_date) {
		this.w_date = w_date;
	}
	
}

