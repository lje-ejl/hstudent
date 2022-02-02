package kr.kosmo.jobkorea.std.model;

public class SurveyListModel {
	
	private int que_num; //설문 질문 번호
	private String que; //설문 질문 
	private String que_one; //설문 1번보기 
	private String que_two; //설문 2번보기 
	private String que_three; //설문 3번보기 
	private String que_four; //설문 4번보기 
	private String que_five; //설문 5번보기 
	
	private int select_num; //학생 선택 답
	
	private int lec_id; //강의 아이디
	private String srvy_chk; //설문조사 여부
	
	public int getQue_num() {
		return que_num;
	}
	public void setQue_num(int que_num) {
		this.que_num = que_num;
	}
	public String getQue() {
		return que;
	}
	public void setQue(String que) {
		this.que = que;
	}
	public String getQue_one() {
		return que_one;
	}
	public void setQue_one(String que_one) {
		this.que_one = que_one;
	}
	public String getQue_two() {
		return que_two;
	}
	public void setQue_two(String que_two) {
		this.que_two = que_two;
	}
	public String getQue_three() {
		return que_three;
	}
	public void setQue_three(String que_three) {
		this.que_three = que_three;
	}
	public String getQue_four() {
		return que_four;
	}
	public void setQue_four(String que_four) {
		this.que_four = que_four;
	}
	public String getQue_five() {
		return que_five;
	}
	public void setQue_five(String que_five) {
		this.que_five = que_five;
	}
	
	public int getLec_id() {
		return lec_id;
	}
	public void setLec_id(int lec_id) {
		this.lec_id = lec_id;
	}
	public String getSrvy_chk() {
		return srvy_chk;
	}
	public void setSrvy_chk(String srvy_chk) {
		this.srvy_chk = srvy_chk;
	}
	
	public int getSelect_num() {
		return select_num;
	}
	public void setSelect_num(int select_num) {
		this.select_num = select_num;
	}
	
	
}
