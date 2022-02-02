package kr.kosmo.jobkorea.adm.model;

//이민하 작업 중


public class EquipmentControlModel {

	//테이블에서 사용하는 메소드들을 생성
	private int equ_id;
	private int lecrm_id;
	private String equ_name;
	private int equ_num;
	private String equ_note;
	private String lecrm_name;
	
	public String getLecrm_name() {
		return lecrm_name;
	}
	public void setLecrm_name(String lecrm_name) {
		this.lecrm_name = lecrm_name;
	}
	public int getEqu_id() {
		return equ_id;
	}
	public void setEqu_id(int equ_id) {
		this.equ_id = equ_id;
	}
	public int getLecrm_id() {
		return lecrm_id;
	}
	public void setLecrm_id(int lecrm_id) {
		this.lecrm_id = lecrm_id;
	}
	public String getEqu_name() {
		return equ_name;
	}
	public void setEqu_name(String equ_name) {
		this.equ_name = equ_name;
	}
	public int getEqu_num() {
		return equ_num;
	}
	public void setEqu_num(int equ_num) {
		this.equ_num = equ_num;
	}
	public String getEqu_note() {
		return equ_note;
	}
	public void setEqu_note(String equ_note) {
		this.equ_note = equ_note;
	}
	
	
}
