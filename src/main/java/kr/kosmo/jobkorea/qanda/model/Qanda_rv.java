package kr.kosmo.jobkorea.qanda.model;

import lombok.Data;
import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Data
@ToString
public class Qanda_rv {
	
	@Getter
	@Setter
	private int rv_id;
	private int qa_id;
	private String login_id;
	private String rv_con;
	private String regdate;
	private String name;
}
