package kr.kosmo.jobkorea.adm.service;

import java.util.Map;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import javax.mail.internet.MimeUtility;
import java.util.List;
import javax.activation.DataSource;
import javax.activation.FileDataSource;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.mail.MailException;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.stereotype.Service;
import kr.kosmo.jobkorea.adm.model.e_resumeControlModel;
import kr.kosmo.jobkorea.login.model.LgnInfoModel;

//정수빈 작성
@Service
public class MailServiceImpl implements MailService {
	
	@Value("${mail.sender}")
	private String MAIL_SENDER;
	
	@Autowired
	private JavaMailSender mailSender;

	// 대표자 이메일 발송
	@Override
	public boolean resume_Mail(Map<String, Object> paramMap) throws Exception {
		
		// 받는 사람 (대표자 이메일)
		String to_mail = (String) paramMap.get("mail");
		String to_name = (String) paramMap.get("loginId");
		// 메일 제목
		String subject = "[해피잡] \""+(String) paramMap.get("lec_name")+" \" 이력서 발송";
		String content = "안녕하세요  해피잡 입니다. <br>선택 하신   ";
		
		@SuppressWarnings("unchecked")
		List<e_resumeControlModel> list_mail = (List<e_resumeControlModel>) paramMap.get("list_mail");

		MimeMessage mail = mailSender.createMimeMessage();
		MimeMessageHelper mailHelper = new MimeMessageHelper(mail, true, "UTF-8");
		mailHelper.setSubject(subject);
	    mailHelper.setTo(new InternetAddress(to_mail, to_name, "UTF-8"));
	    
	    int i = 1;
	    content = "";
	    
		for (e_resumeControlModel data : list_mail) {
			// 메일 내용
			content += data.getName() ; 
			if(list_mail.size()!=i++){
				content += " , ";
			}else{
				content += " 이력서를 발송 드립니다.<br>";
				content += " 이력서를 참고 하시고 좋은 채용 되시길 바라겠습니다. <br>";
				content += " 감사합니다. <br>";
				content += " 해피잡 배상  <br>";
				content += " --------------------------------------------------------------------<br> ";
				content += " Message From Happyjob<br>"; 
				content += " T 02-3397-7111/ F 02-852-7324"; 
			}
			DataSource dataSource = new FileDataSource(data.getRs_url());
			mailHelper.addAttachment(MimeUtility.encodeText(data.getRs_fname(), "UTF-8", "B"), dataSource);
		}
		
		try{
			mailHelper.setText(content, true);
			mailSender.send(mail);
		}catch( MailException e ){
			return false;
		}
		return true;

	}

	// 관리자 이메일 발송
	@Override
	public boolean C_resume_Mail(Map<String, Object> paramMap) throws Exception {
		
		@SuppressWarnings("unchecked")
		List<e_resumeControlModel> rps_list = (List<e_resumeControlModel>) paramMap.get("rps_mail");
		
		@SuppressWarnings("unchecked")
		List<e_resumeControlModel> std_mail = (List<e_resumeControlModel>) paramMap.get("std_mail");
		
		
		for( e_resumeControlModel rps_mail: rps_list ){
			
			// 받는 사람 (대표자 이메일)
			String to_mail = rps_mail.getMail();
			String to_name = rps_mail.getComp_name();
			// 메일 제목
			String subject = "[해피잡] \""+(String) paramMap.get("lec_name")+" \" 이력서 발송";
			String content = "안녕하세요  해피잡 입니다. <br>선택 하신   ";
			
			MimeMessage mail = mailSender.createMimeMessage();
			MimeMessageHelper mailHelper = new MimeMessageHelper(mail, true, "UTF-8");
			mailHelper.setSubject(subject);
		    mailHelper.setTo(new InternetAddress(to_mail, to_name, "UTF-8"));
		    
		    int i = 1;
			for (e_resumeControlModel data : std_mail) {
				// 메일 내용
				content += data.getName() ; 
				if(std_mail.size()!=i++){
					content += " , ";
				}else{
					content += " 이력서를 발송 드립니다.<br>";
					content += " 이력서를 참고 하시고 좋은 채용 되시길 바라겠습니다. <br>";
					content += " 감사합니다. <br>";
					content += " 해피잡 배상  <br>";
					content += " --------------------------------------------------------------------<br> ";
					content += " Message From Happyjob<br>"; 
					content += " T 02-3397-7111/ F 02-852-7324"; 
				}
				DataSource dataSource = new FileDataSource(data.getRs_url());			
				mailHelper.addAttachment(MimeUtility.encodeText(data.getRs_fname(), "UTF-8", "B"), dataSource);
			}
			try{
				mailHelper.setText(content, true);
				mailSender.send(mail);
			}catch ( MailException e ){
				return false;
			}

		}
		return true;
	}
	
	// 아이디 찾기 이메일 발송
	@Override
	public int findId(Map<String, Object> paramMap) throws Exception {

		// 받는 사람 (대표자 이메일)
		String to_mail = (String) paramMap.get("email");
		String to_name = (String) paramMap.get("loginId");
		
		// 메일 제목
		String subject = " [해피잡] 요청 하신 아이디 입니다.";
		String content = "안녕하세요  해피잡 입니다.";	
		
		@SuppressWarnings("unchecked")
		List<LgnInfoModel> loginIdlist = (List<LgnInfoModel>) paramMap.get("loginIdlist");

		MimeMessage mail = mailSender.createMimeMessage();
		MimeMessageHelper mailHelper = new MimeMessageHelper(mail, true, "UTF-8");
		
		mailHelper.setSubject(subject);
	    mailHelper.setTo(new InternetAddress(to_mail, to_name, "UTF-8"));
	    
	    
		for ( LgnInfoModel data : loginIdlist ) {
			content += "<br>아이디 : "+data.getLgn_id() ;
		}
		content += "<br> 감사합니다. <br>";
		content += " 해피잡 배상  <br>";
		content += " ---------------------------------<br> ";
		content += " Message From Happyjob<br>"; 
		content += " T 02-3397-7111/ F 02-852-7324"; 
		
		mailHelper.setText(content, true);
		try{
			mailSender.send(mail);
			return 1;
		}catch( MailException e ){
			return 0;
		}
	}
	
	// 비밀번호 찾기 이메일 발송
	@Override
	public int findPass(Map<String, Object> paramMap) throws Exception {

		// 받는 사람 (대표자 이메일)
		String to_mail = (String) paramMap.get("email");
		String to_name = (String) paramMap.get("loginID");
		
		// 메일 제목
		String subject = " [해피잡] 변경하신 비밀번호 입니다.";
		String content = " 안녕하세요  해피잡 입니다. <br> "+to_name+" 님의 임시 비빌번호를 알려 드립니다.<br>";	
	           content += " 임시 비밀번호 : "+paramMap.get("pwd")+"<br>";
	   	   	   content += " 감사합니다. <br>";
			   content += " 해피잡 배상  <br>";
			   content += " ---------------------------------<br> ";
			   content += " Message From Happyjob<br>"; 
    		   content += " T 02-3397-7111/ F 02-852-7324";
		MimeMessage mail = mailSender.createMimeMessage();
		MimeMessageHelper mailHelper = new MimeMessageHelper(mail, true, "UTF-8");
		
		mailHelper.setSubject(subject);
	    mailHelper.setTo(new InternetAddress(to_mail, to_name, "UTF-8"));
		mailHelper.setText(content, true);
		try{
			mailSender.send(mail);
			return 1;
		}catch( MailException e ){
			return 0;
		}
	}	
}
