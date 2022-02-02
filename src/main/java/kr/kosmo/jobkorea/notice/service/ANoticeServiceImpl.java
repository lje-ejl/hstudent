package kr.kosmo.jobkorea.notice.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.kosmo.jobkorea.notice.dao.ANoticeDao;
import kr.kosmo.jobkorea.notice.model.ANoticeModel;

@Service
public class ANoticeServiceImpl implements ANoticeService{

	@Autowired
	ANoticeDao aNoticeDao;

	@Override
	public List<ANoticeModel> admNotice(Map<String, Object> paramMap) {
		List<ANoticeModel> admNotice = aNoticeDao.admNotice(paramMap);
		return admNotice;
	}

	@Override
	public int admNoticeCnt(Map<String, Object> paramMap) {
		int admNoticeCnt = aNoticeDao.admNoticeCnt(paramMap);
		return admNoticeCnt;
	}

	@Override
	public List<ANoticeModel> tutNotice(Map<String, Object> paramMap) {
		List<ANoticeModel> tutNotice = aNoticeDao.tutNotice(paramMap);
		return tutNotice;
	}

	@Override
	public int tutNoticeCnt(Map<String, Object> paramMap) {
		int tutNoticeCnt = aNoticeDao.tutNoticeCnt(paramMap);
		return tutNoticeCnt;
	}

	@Override
	public ANoticeModel tutDetail(Map<String, Object> paramMap) {
		ANoticeModel tutDetail = aNoticeDao.tutDetail(paramMap);
		return tutDetail;
	}

	@Override
	public ANoticeModel admDetail(Map<String, Object> paramMap) {
		ANoticeModel admDetail = aNoticeDao.admDetail(paramMap);
		return admDetail;
	}

	@Override
	public int admHit(Map<String, Object> paramMap) {
		int admHit = aNoticeDao.admHit(paramMap);
		return admHit;
	}

	@Override
	public int tutHit(Map<String, Object> paramMap) {
		int tutHit = aNoticeDao.tutHit(paramMap);
		return tutHit;
	}

	@Override
	public int admWrite(Map<String, Object> paramMap) {
		int admWrite = aNoticeDao.admWrite(paramMap);
		return admWrite;
	}

	@Override
	public int tutWrite(Map<String, Object> paramMap) {
		int tutWrite = aNoticeDao.tutWrite(paramMap);
		return tutWrite;
	}

	@Override
	public int admDel(Map<String, Object> paramMap) {
		int admDel = aNoticeDao.admDel(paramMap);
		return admDel;
	}

	@Override
	public int tutDel(Map<String, Object> paramMap) {
		int tutDel = aNoticeDao.tutDel(paramMap);
		return tutDel;
	}

	@Override
	public ANoticeModel typeCheck(Map<String, Object> paramMap) {
		ANoticeModel typeCheck = aNoticeDao.typeCheck(paramMap);
		return typeCheck;
	}

	@Override
	public int admUpdate(Map<String, Object> paramMap) {
		int admUpdate = aNoticeDao.admUpdate(paramMap);
		return admUpdate;
	}

	@Override
	public int tutUpdate(Map<String, Object> paramMap) {
		int tutUpdate = aNoticeDao.tutUpdate(paramMap);
		return tutUpdate;
	}
	
	
}