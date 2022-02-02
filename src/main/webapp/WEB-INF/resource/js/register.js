


// 유효값 검사
var idCheckResult = "" ;

function AfValidateStudent() {
	var chk = checkNotEmpty(
			[
				    [ "AregisterName"  ,"이름을 입력해 주세요."     ]
				,	[ "AregisterId"    ,"아이디를 입력해 주세요."    ]
				,	[ "AregisterPwd"   ,"비밀번호를 입력해 주세요."   ]
				,	[ "AregisterPwdOk" ,"비밀번호 확인를 입력해 주세요."] 	
				,	[ "Aloginaddr"     ,"주소를 입력해 주세요."     ] 
				,	[ "Aloginaddr1"    ,"상세주소를 입력해 주세요."   ] 					    
				,	[ "Adetailaddr"    ,"우편번호를 입력해 주세요."   ] 	
			    ,	[ "AregisterSex"   ,"성별를 선택해 주세요."     ] 
				,	[ "AregisterPhone1","연락처을 입력해 주세요."    ]
				,	[ "AregisterPhone2","연락처을 입력해 주세요."    ]
				,	[ "AregisterPhone3","연락처을 입력해 주세요."    ]
			    ,	[ "AregisterPid1"  ,"주민번호를 입력해 주세요."   ]
				,	[ "AregisterPid2"  ,"주민번호를 입력해 주세요."   ]
				,	[ "AregisterEmail1","이메일을 입력해 주세요."    ]
				,	[ "AregisterEmail2","이메일을 입력해 주세요."    ]
			]
	);
	if (!chk) { return; }
	
	// 이름 체크
	var  name   = $("#AregisterName").val();
	var $name   = $('#AregisterName');
	if(name.length > 20){
		alert("이름은 20자 이하로 입력해주세요.");
	    ($name).focus();
	    return;
	}
	//id 체크
	var  Id   = $("#AregisterId").val();
	var $Id   = $('#AregisterId');	
	if(Id.length < 5 || Id.length > 20){
		alert("아이디는 5~20 자로 입력해주세요.");
	   ($Id).focus();
	   return;
	}
	
	//비밀번호 체크
	var  pass1   = $("#AregisterPwd"  ).val();
	var  pass2   = $("#AregisterPwdOk").val();
	var $pass2   = $('#AregisterPwdOk');
	
	if(pass1.length < 5 || pass1.length > 15 ){
		alert("비밀번호는 5~15 글자로 입력해주세요");
	   ($pass2).focus();
	   return;
	}
	if(pass1 != pass2){
		alert("비밀번호가 일치하지 않습니다");
	   ($$pass2).focus();
	   return;
	}	
	//연락처 체크
	var  phone1   = $("#AregisterPhone1").val();
	var $phone1   = $('#AregisterPhone1');	
	if(phone1.length != 3 ){
		alert("연락처 형식을 맞춰주세요");
	    ($phone1).focus();
	    return;
	}	
	var  phone2   = $("#AregisterPhone2").val();
	var $phone2   = $('#AregisterPhone2');	
	if(phone2.length != 4 ){
		alert("연락처 형식을 맞춰주세요");
	    ($phone2).focus();
	    return;
	}
	var  phone3   = $("#AregisterPhone3").val();
	var $phone3   = $('#AregisterPhone3');	
	if(phone3.length != 4 ){
		alert("연락처 형식을 맞춰주세요");
	    ($phone3).focus();
	    return;
	}	
	// 주민번호 체크
	var  Pid1   = $("#AregisterPid1").val();
	var  Pid2   = $("#AregisterPid2").val();
	var $Pid1   = $('#AregisterPid1');	
	var $Pid2   = $('#AregisterPid2');		
	if(Pid1.length != 6 ){
		alert("주민번호 형식을 맞춰주세요");
	    ($Pid1).focus();
	    return;
	}
	if( Pid2.length != 7 ){
		alert("주민번호 형식을 맞춰주세요");
	    ($Pid2).focus();
	    return;		
	}
	// 이메일 체크
	var  pattern_spc = /[~!@#$%^&*()_+|<>?:{}]/;
	var  Email1   = $("#AregisterEmail1").val();
	var  Email2   = $("#AregisterEmail2").val();
	var $Email1   = $('#AregisterEmail1');
	var $Email2   = $('#AregisterEmail2');

	if(pattern_spc.test(Email1)){
		alert("이메일에 특수 문자를 사용하실 수 없습니다.");
		($Email1).focus();
		return;
	}
	if(pattern_spc.test(Email2)){
		alert("이메일에 특수 문자를 사용하실 수 없습니다.");
	   ($Email2).focus();
	    return;
	}	
	return true;
}

function BfValidateStudent() {
	var chk = checkNotEmpty(
			[
				    [ "BregisterName"  ,"이름을 입력해 주세요."      ]
				,	[ "BregisterId"    ,"아이디를 입력해 주세요."     ]
				,	[ "BregisterPwd"   ,"비밀번호를 입력해 주세요."    ]
				,	[ "BregisterPwdOk" ,"비밀번호 확인를 입력해 주세요." ]  	
				,	[ "Bloginaddr"     ,"주소를 입력해 주세요."      ] 
				,	[ "Bloginaddr1"    ,"상세주소를 입력해 주세요."    ] 					    
				,	[ "Bdetailaddr"    ,"우편번호를 입력해 주세요."    ] 
				,	[ "BregisterSex"   ,"성별를 입력해 주세요."      ] 
				,	[ "BregisterPhone1","전화번호를 입력해 주세요."    ]
				,	[ "BregisterPhone2","전화번호를 입력해 주세요."    ]
				,	[ "BregisterPhone3","전화번호를 입력해 주세요."    ]
				,	[ "BregisterPid1"  ,"주민번호를 입력해 주세요."    ]
				,	[ "BregisterPid2"  ,"주민번호를 입력해 주세요."    ]
				,	[ "BregisterEmail1" ,"이메일을 입력해 주세요."    ] 
				,	[ "BregisterEmail2" ,"이메일을 입력해 주세요."    ] 
			]
	);
	if (!chk) { return; }

	// 이름 체크
	var  name   = $("#BregisterName").val();
	var $name   = $('#BregisterName');
	if(name.length > 20){
		alert("이름은 20자 이하로 입력해주세요.");
	    ($name).focus();
	    return;
	}
	
	//id 체크
	var  Id   = $("#BregisterId").val();
	var $Id   = $('#BregisterId');	
	if(Id.length < 5 || Id.length > 20){
		alert("아이디는 5~20 자로 입력해주세요.");
	   ($Id).focus();
	   return;
	}
	
	//비밀번호 체크
	var  pass1   = $("#BregisterPwd"  ).val();
	var  pass2   = $("#BregisterPwdOk").val();
	var $pass2   = $('#BregisterPwdOk');
	
	if(pass1.length < 5 || pass1.length > 15 ){
		alert("비밀번호는 5~15 글자로 입력해주세요");
	   ($pass2).focus();
	   return;
	}
	if(pass1 != pass2){
		alert("비밀번호가 일치하지 않습니다");
	   ($$pass2).focus();
	   return;
	}	
	
	//연락처 체크
	var  phone1   = $("#BregisterPhone1").val();
	var $phone1   = $('#BregisterPhone1');	
	if(phone1.length != 3 ){
		alert("연락처 형식을 맞춰주세요");
	    ($phone1).focus();
	    return;
	}	

	
	var  phone2   = $("#BregisterPhone2").val();
	var $phone2   = $('#BregisterPhone2');	
	if(phone2.length != 4 ){
		alert("연락처 형식을 맞춰주세요");
	    ($phone2).focus();
	    return;
	}
	
	
	var  phone3   = $("#BregisterPhone3").val();
	var $phone3   = $('#BregisterPhone3');	
	if(phone3.length != 4 ){
		alert("연락처 형식을 맞춰주세요");
	    ($phone3).focus();
	    return;
	}	
	
	// 주민번호 체크
	var  Pid1   = $("#BregisterPid1").val();
	var  Pid2   = $("#BregisterPid2").val();
	var $Pid1   = $('#BregisterPid1');	
	var $Pid2   = $('#BregisterPid2');		
	if(Pid1.length != 6 ){
		alert("주민번호 형식을 맞춰주세요");
	    ($Pid1).focus();
	    return;
	}
	if( Pid2.length != 7 ){
		alert("주민번호 형식을 맞춰주세요");
	    ($Pid2).focus();
	    return;		
	}
	
	// 이메일 체크
	var  pattern_spc = /[~!@#$%^&*()_+|<>?:{}]/;
	var  Email1   = $("#BregisterEmail1").val();
	var  Email2   = $("#BregisterEmail2").val();
	var $Email1   = $('#BregisterEmail1');
	var $Email2   = $('#BregisterEmail2');

	if(pattern_spc.test(Email1)){
		alert("이메일에 특수 문자를 사용하실 수 없습니다.");
		($Email1).focus();
		return;
	}
	if(pattern_spc.test(Email2)){
		alert("이메일에 특수 문자를 사용하실 수 없습니다.");
	   ($Email2).focus();
	    return;
	}	
	
	return true;
}

function DfValidateStudent() {
	var chk = checkNotEmpty(
			[
				    [ "DregisterName"      ,"대표자명을 입력해 주세요."    ]
				,   [ "DregisterComp_name" ,"기업이름을 입력해 주세요."    ]   
				,	[ "DregisterId"        ,"아이디를 입력해 주세요."     ]
				,	[ "DregisterPwd"       ,"비밀번호를 입력해 주세요."    ]
				,	[ "DregisterPwdOk"     ,"비밀번호 확인를 입력해 주세요." ] 	
				,	[ "DregisterComp_addr" ,"기업 주소를 입력해 주세요."   ] 
				,	[ "DregisterComp_addr1","기업 상세 주소를 입력해 주세요." ] 					    
				,	[ "DregisterComp_addr2","우편번호를 입력해 주세요."    ] 	
				,	[ "DregisterSex"       ,"성별을 선텍해 주세요."      ] 	   
			    ,	[ "DregisterTel1"      ,"연락처를 선텍해 주세요."     ] 
			    ,	[ "DregisterTel2"      ,"연락처를 선텍해 주세요."     ] 
			    ,	[ "DregisterTel3"      ,"연락처를 선텍해 주세요."     ] 
				,	[ "Dregistercomp_tel1" ,"기업 연락처를 선텍해 주세요."  ] 
				,	[ "Dregistercomp_tel2" ,"기업 연락처를 선텍해 주세요."  ] 
			    ,	[ "Dregistercomp_tel3" ,"기업 연락처를 선텍해 주세요."  ]				    
			    ,	[ "DregisterPid"       ,"주민번호를 선텍해 주세요."    ] 	   
			    ,	[ "DregisterPid1"      ,"주민번호를 입력해 주세요."    ]
				,	[ "DregisterPid2"      ,"주민번호를 입력해 주세요."    ]
				,	[ "DregisterEmail1"    ,"이메일을 입력해 주세요."     ]
				,	[ "DregisterEmail2"    ,"이메일을 이메일을 입력해 주세요."] 				  
			]
	);
	if (!chk) { return; }

	// 이름 체크
	var  name   = $("#DregisterName").val();
	var $name   = $('#DregisterName');
	if(name.length > 20){
		alert("이름은 20자 이하로 입력해주세요.");
	    ($name).focus();
	    return;
	}
	
	//id 체크
	var  Id   = $("#DregisterId").val();
	var $Id   = $('#DregisterId');	
	if(Id.length < 5 || Id.length > 20){
		alert("아이디는 5~20 자로 입력해주세요.");
	   ($Id).focus();
	   return;
	}
	
	//비밀번호 체크
	var  pass1   = $("#DregisterPwd"  ).val();
	var  pass2   = $("#DregisterPwdOk").val();
	var $pass2   = $('#DregisterPwdOk');
	
	if(pass1.length < 5 || pass1.length > 15 ){
		alert("비밀번호는 5~15 글자로 입력해주세요");
	   ($pass2).focus();
	   return;
	}
	if(pass1 != pass2){
		alert("비밀번호가 일치하지 않습니다");
	   ($$pass2).focus();
	   return;
	}	
	
	//연락처 체크
	var  phone1   = $("#DregisterTel1").val();
	var $phone1   = $('#DregisterTel1');	
	if(phone1.length != 3 ){
		alert("연락처 형식을 맞춰주세요");
	    ($phone1).focus();
	    return;
	}	

	
	var  phone2   = $("#DregisterTel2").val();
	var $phone2   = $('#DregisterTel2');	
	if(phone2.length != 4 ){
		alert("연락처 형식을 맞춰주세요");
	    ($phone2).focus();
	    return;
	}
	
	
	var  phone3   = $("#DregisterTel3").val();
	var $phone3   = $('#DregisterTel3');	
	if(phone3.length != 4 ){
		alert("연락처 형식을 맞춰주세요");
	    ($phone3).focus();
	    return;
	}	
	
	// 기업 연락처
	var  phone1   = $("#Dregistercomp_tel1").val();
	var $phone1   = $('#Dregistercomp_tel1');	
	if(phone1.length != 3 ){
		alert("기업 연락처 형식을 맞춰주세요");
	    ($phone1).focus();
	    return;
	}	

	
	var  phone2   = $("#Dregistercomp_tel2").val();
	var $phone2   = $('#Dregistercomp_tel2');	
	if(phone2.length != 4 ){
		alert("기업 연락처 형식을 맞춰주세요");
	    ($phone2).focus();
	    return;
	}
	
	
	var  phone3   = $("#Dregistercomp_tel3").val();
	var $phone3   = $('#Dregistercomp_tel3');	
	if(phone3.length != 4 ){
		alert("기업 연락처 형식을 맞춰주세요");
	    ($phone3).focus();
	    return;
	}	
	
	// 주민번호 체크
	var  Pid1   = $("#DregisterPid1").val();
	var  Pid2   = $("#DregisterPid2").val();
	var $Pid1   = $('#DregisterPid1');	
	var $Pid2   = $('#DregisterPid2');		
	if(Pid1.length != 6 ){
		alert("주민번호 형식을 맞춰주세요");
	    ($Pid1).focus();
	    return;
	}
	if( Pid2.length != 7 ){
		alert("주민번호 형식을 맞춰주세요");
	    ($Pid2).focus();
	    return;		
	}
	
	// 이메일 체크
	var  pattern_spc = /[~!@#$%^&*()_+|<>?:{}]/;
	var  Email1   = $("#DregisterEmail1").val();
	var  Email2   = $("#DregisterEmail2").val();
	var $Email1   = $('#DregisterEmail1');
	var $Email2   = $('#DregisterEmail2');

	if(pattern_spc.test(Email1)){
		alert("이메일에 특수 문자를 사용하실 수 없습니다.");
		($Email1).focus();
		return;
	}
	if(pattern_spc.test(Email2)){
		alert("이메일에 특수 문자를 사용하실 수 없습니다.");
	   ($Email2).focus();
	    return;
	}	
	
	return true;
	
}

function IDCheck( form ) {
	$.ajax({
		url : "/id_check.do",
		type : "POST",
		async : true ,
		//data : $('#ARegisterForm').serialize(),
		data : $("#"+form).serialize(),
		success : function(data) {
			if(data.OK=="N"){
				alert("아이디가 중복 되었습니다");
			}else{
				if( form == "ARegisterForm" ){
					ACompleteRegister(form);
				}else if( form == "BRegisterForm" ){
					BCompleteRegister(form);
				}else if( form == "DRegisterForm" ){
					DCompleteRegister(form);
				}
			}
		},
		error : function() {
			alert("회원가입 에러");
		}
	});		
}



/* 일반 회원가입  완료*/
function ACompleteRegister( form ) {
	if ( ! AfValidateStudent() ) {return;}
	$.ajax({
		url : "/aregister.do",
		type : "POST",
		data : $("#"+form).serialize(),
		success : function(data) {
			alert("회원가입이 완료 되었습니다");
			location.href = "studentControl.do";
		},
		error : function() {
			alert("[ 회원 신규 등록 에러 ]");
		}
	});
}


/* 강사 회원가입  완료*/
function BCompleteRegister( form ) {
	if ( ! BfValidateStudent() ) {return;}
	$.ajax({
		url : "/bregister.do",
		type : "POST",
		data : $('#'+form).serialize(),
		success : function(data) {
			alert("회원가입이 완료 되었습니다");
			location.href = "tutorControl.do";
		},
		error : function() {
			alert("[ 강사 신규 등록 에러 ]");
		}
	});
}


/* 기업 회원가입  완료*/
function DCompleteRegister( form ) {
	if ( ! DfValidateStudent() ) {return;}
	$.ajax({
		url : "/dregister.do",
		type : "POST",
		data :$('#'+form).serialize(),
		success : function(data) {
			alert("회원가입이 완료 되었습니다");
			location.href = "ceoControl.do";
		},
		error : function() {
			alert("[ 기업 신규 등록 에러 ]");
		}
	});
}


















//생일 선택
function Today(year,mon,day){
  if(year == "null" && mon == "null" && day == "null"){       
  today = new Date();
  this_year=today.getFullYear();
  this_month=today.getMonth();
  this_month+=1;
  
  if(this_month <10) 
 	 this_month="0" + this_month;

  this_day=today.getDate();
  if(this_day<10) 
 	 this_day="0" + this_day;     
}
else{  
  var this_year = eval(year);
  var this_month = eval(mon); 
  var this_day = eval(day);
}

montharray=new Array(31, 29, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31); 
maxdays = montharray[this_month-1]; 
//아래는 윤달을 구하는 것
if (this_month==2) { 
   if ((this_year/4)!=parseInt(this_year/4)) maxdays=28; 
   else maxdays=29; 
} 

document.writeln("<select name='year' size=1 style=width:80px; height:20px; onChange='dateSelect(this.form,this.form.month.selectedIndex);'>");
for(i=this_year-50;i<this_year+1;i++){//현재 년도에서 과거로 5년까지 미래로 5년까지를 표시함
   if(i==this_year) document.writeln("<OPTION VALUE="+i+ " selected >" +i); 
   else document.writeln("<OPTION VALUE="+i+ ">" +i); 
 }    
document.writeln("</select>&nbsp;&nbsp;년&nbsp;&nbsp;");      
document.writeln("<select name='month' size=1 style=width:50px; height:20px; onChange='dateSelect(this.form,this.selectedIndex);'>");
for(i=1;i<=12;i++){ 
   if(i<10){
      if(i==this_month) 
     	 document.writeln("<OPTION VALUE=0" +i+ " selected >0"+i); 
      else 
     	 document.writeln("<OPTION VALUE=0" +i+ ">0"+i);
   }else{
      if(i==this_month) 
     	 document.writeln("<OPTION VALUE=" +i+ " selected >" +i);  
      else document.writeln("<OPTION VALUE=" +i+ ">" +i);  
   }                     
}         
document.writeln("</select>&nbsp;&nbsp;월&nbsp;&nbsp;");
document.writeln("<select name='day' size=1 style=width:50px; height:20px;>");
for(i=1;i<=maxdays;i++){ 
   if(i<10){
      if(i==this_day) 
     	 document.writeln("<OPTION VALUE=0" +i+ " selected >0"+i); 
      else 
     	 document.writeln("<OPTION VALUE=0" +i+ ">0"+i); 
   }else{
      if(i==this_day) 
     	 document.writeln("<OPTION VALUE=" +i+ " selected } >"+i); 
      else 
     	 document.writeln("<OPTION VALUE=" +i+ ">" +i);  
   }                     
 }         
document.writeln("</select>&nbsp;&nbsp;일&nbsp;&nbsp;"); 
}

function dateSelect(docForm,selectIndex) {
	watch = new Date(docForm.year.options[docForm.year.selectedIndex].text, docForm.month.options[docForm.month.selectedIndex].value,1);
	hourDiffer = watch - 86400000;
	calendar = new Date(hourDiffer);

	var daysInMonth = calendar.getDate();
		for (var i = 0; i < docForm.day.length; i++) {
			docForm.day.options[0] = null;
		}
		for (var i = 0; i < daysInMonth; i++) {
			docForm.day.options[i] = new Option(i+1);
	}
	document.form1.day.options[0].selected = true;
}



