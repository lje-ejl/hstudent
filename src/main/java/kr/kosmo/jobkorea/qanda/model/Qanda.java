package kr.kosmo.jobkorea.qanda.model;

import java.util.Date;

import lombok.Data;
import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Data
@ToString
public class Qanda {
	
	@Getter
	@Setter
	private int qa_id;
	private String login_id;
	private String bod_tit;
	private String bod_con;
	private String regdate;
	private int hit;
	private String name;
	// hit = 조회수
	
	
}
