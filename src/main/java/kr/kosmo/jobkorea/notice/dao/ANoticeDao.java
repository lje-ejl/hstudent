package kr.kosmo.jobkorea.notice.dao;

import java.util.List;
import java.util.Map;

import kr.kosmo.jobkorea.notice.model.ANoticeModel;

public interface ANoticeDao {
	public List<ANoticeModel>  admNotice(Map<String, Object> paramMap);
	public int admNoticeCnt(Map<String, Object> paramMap);
	public List<ANoticeModel>  tutNotice(Map<String, Object> paramMap);
	public int tutNoticeCnt(Map<String, Object> paramMap);
	public ANoticeModel tutDetail(Map<String, Object> paramMap);
	public ANoticeModel admDetail(Map<String, Object> paramMap);
	public int admHit(Map<String, Object> paramMap);
	public int tutHit(Map<String, Object> paramMap);
	public int admWrite(Map<String, Object> paramMap);
	public int tutWrite(Map<String, Object> paramMap);
	public int admDel(Map<String, Object> paramMap);
	public int tutDel(Map<String, Object> paramMap);
	public ANoticeModel typeCheck(Map<String, Object> paramMap);
	public int admUpdate(Map<String, Object> paramMap);
	public int tutUpdate(Map<String, Object> paramMap);
}

