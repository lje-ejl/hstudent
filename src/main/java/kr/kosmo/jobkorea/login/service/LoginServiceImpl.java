package kr.kosmo.jobkorea.login.service;

import java.util.List;
import java.util.Map;

import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.kosmo.jobkorea.common.comnUtils.AESCryptoHelper;
import kr.kosmo.jobkorea.common.comnUtils.ComnUtil;
import kr.kosmo.jobkorea.login.dao.LoginDao;
import kr.kosmo.jobkorea.login.model.LgnInfoModel;
import kr.kosmo.jobkorea.login.model.UsrMnuAtrtModel;
import kr.kosmo.jobkorea.login.model.UsrMnuChildAtrtModel;

@Service
public class LoginServiceImpl implements LoginService {

	// Set logger
	private final Logger logger = LogManager.getLogger(this.getClass());
	
	@Autowired
	private LoginDao loginDao;
	
	/** 사용자 로그인 체크*/
	public String checkLogin(Map<String, Object> paramMap) throws Exception {
		return loginDao.checkLogin(paramMap);
	}
	
	/** 사용자 로그인 */
	public LgnInfoModel loginProc(Map<String, Object> paramMap) throws Exception {
		String password = paramMap.get("pwd").toString();
		
		//logger.info(" login before password : " + password);
		//AES 방식 암호화
		//password = AESCryptoHelper.encode( ComnUtil.AES_KEY, password);
		
		//logger.info(" login after password : " + password);
		paramMap.put("pwd", password);
		return loginDao.selectLogin(paramMap);
	}
	
	
	/**  사용자 메뉴 권한 */
	public List<UsrMnuAtrtModel> listUsrMnuAtrt(Map<String, Object> paramMap) throws Exception {	
		return loginDao.listUsrMnuAtrt(paramMap);
	}
	

	/**  사용자 자식 메뉴 권한 */
	public List<UsrMnuChildAtrtModel> listUsrChildMnuAtrt(Map<String, Object> paramMap) throws Exception{
		return loginDao.listUsrChildMnuAtrt(paramMap);

	}

	/** 사용자 ID 찾기 */
	public LgnInfoModel selectFindId(Map<String, Object> paramMap) throws Exception{
		return loginDao.selectFindId(paramMap);
	}

	/** 사용자 PW 찾기 */
	public LgnInfoModel selectFindPw(Map<String, Object> paramMap) throws Exception{
		String password = paramMap.get("pwd").toString();
		//AES 방식 암호화
		password = AESCryptoHelper.encode( ComnUtil.AES_KEY, password);
		paramMap.put("pwd", password);
		return loginDao.selectFindPw(paramMap);
	}

	/** 이메일 유무 확인 ID 찾기 */
	@Override
	public List<LgnInfoModel> findId(Map<String, Object> paramMap) throws Exception {
		return loginDao.findId(paramMap);
	}

	/** 아이디 유무 확인 pass 전송**/
	@Override
	public LgnInfoModel findPass(Map<String, Object> paramMap) throws Exception {
		return loginDao.findPass(paramMap);
	}

	/** 비밀번호 재발급 **/
	@Override
	public int findPassUpdate(Map<String, Object> paramMap) throws Exception {
		return loginDao.findPassUpdate(paramMap);
	}

}
