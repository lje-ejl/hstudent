<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<title>JobKorea</title>

<jsp:include page="/WEB-INF/view/common/common_include.jsp"></jsp:include>
<script src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<style type="text/css">
.divComGrpCodList tr {
	height: 50px;
}
  
.inputStyle {
	width: 100px;
	height: 28px;
}
  
.content select {
	width: 100px;
}

/* upload */
.filebox .upload-name {
	display: inline-block;
	padding: .5em .75em;
	font-size: inherit;
	font-family: inherit;
	line-height: normal;
	vertical-align: middle;
	background-color: #f5f5f5;
	border: 1px solid #ebebeb;
	border-bottom-color: #e2e2e2;
	border-radius: .25em;
	-webkit-appearance: none;
	-moz-appearance: none;
	appearance: none;
}
.changeModal input{
    width: 300px;
    height: 25px;
    padding: 5px;
}

#file_name{
	cursor: pointer;
	font-weight: bold;
}
</style>

<script type="text/javascript">
	//우편번호 api
	function execDaumPostcode(q) {
		new daum.Postcode({
			oncomplete : function(data) {
				// 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

				// 각 주소의 노출 규칙에 따라 주소를 조합한다.
				// 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
				var addr = ''; // 주소 변수
				var extraAddr = ''; // 참고항목 변수

				//사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
				if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
					addr = data.roadAddress;
				} else { // 사용자가 지번 주소를 선택했을 경우(J)
					addr = data.jibunAddress;
				}

				// 사용자가 선택한 주소가 도로명 타입일때 참고항목을 조합한다.
				if (data.userSelectedType === 'R') {
					// 법정동명이 있을 경우 추가한다. (법정리는 제외)
					// 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
					if (data.bname !== '' && /[동|로|가]$/g.test(data.bname)) {
						extraAddr += data.bname;
					}
					// 건물명이 있고, 공동주택일 경우 추가한다.
					if (data.buildingName !== '' && data.apartment === 'Y') {
						extraAddr += (extraAddr !== '' ? ', '
								+ data.buildingName : data.buildingName);
					}
				}

				// 우편번호와 주소 정보를 해당 필드에 넣는다.
				document.getElementById('detailaddr').value = data.zonecode;
				document.getElementById("loginaddr").value = addr;
				// 커서를 상세주소 필드로 이동한다.
				document.getElementById("loginaddr1").focus();
			}
		}).open({
			q : q
		});
	}

	/** OnLoad event */
	$(function() {
		// 정보 조회
		fListComnGrpCod();
	});

	
	/** 정보 조회 */
	function fListComnGrpCod() {
		var param = { qa_id : "" };

		var resultCallback = function(data) {
			fSelectGrpCodResult(data);
		};

		callAjax("/std/selectInfo.do", "post", "json", true, param, resultCallback);
	}

	/** 정보 조회 콜백 함수*/
	function fSelectGrpCodResult(data) {
		//console.log(JSON.stringify(userInfo));

		var userInfo = data.userInfo; // userInfo map
		var splitAddr = userInfo.addr.split(","); // 주소 분할
		
		if (data.result == "SUCCESS") {
			$("#std_num").val(userInfo.std_num);
			$("#loginID").val(userInfo.loginID);
			$("#registerName").val(userInfo.name);
			$("#registerPwd").val(userInfo.password);
			$("#registerEmail").val(userInfo.email);
			$("#tel2").val(userInfo.tel2);
			$("#tel3").val(userInfo.tel3);
			$("#detailaddr").val(splitAddr[0]);
			$("#loginaddr").val(splitAddr[1]);
			$("#loginaddr1").val(splitAddr[2]);
			$("#file_name").val(userInfo.file_name);
			
			// 파일 업로드 url 담겨있음
			$("#downloadFile").val(userInfo.file_path);
			$("#downloadFileName").val(userInfo.file_name);
			
			// select box -> selected조건
			$.each($("#tel1 > option"), function(index, item){
				if($(item).text() == userInfo.tel1){
					$(item).prop("selected", true);
				}
			})

		} else {
			alert(data.resultMsg);
		}
	}
	
	// 저장 버튼 클릭 시 동작
 	$(document).on("click", "#saveBtn", function(){
 		if($("#registerPwdOk").val().trim() == ""){
			alert("비밀번호를 입력해주세요.");
			return false;
 		}else if($("#registerPwd").val() != $("#registerPwdOk").val()){
			alert("비밀번호가 불일치합니다.");
			return false;
 		}else{
 			fSaveData();
 			alert("개인정보가 변경되었습니다.");
		}
	});
	 

/* 파일업로드 시작 */
	/** 데이터 저장 */
	function fSaveData() {
		//summernote 의 내용을 textarea에 담는다.
		// var cntsCode = $('#summernote').summernote('code');
		// file form 값 생성
		var frm = document.getElementById("myForm");
		frm.enctype = 'multipart/form-data';
		var fileData = new FormData(frm);

		var resultCallback = function(data) {
			fSaveDataResult(data);
		};
	
		callAjaxFileUploadSetFormData("/std/updateInfo.do", "post", "json", true, fileData, resultCallback);
		//url, method, dataType, async, formData, callback
	}
	
	/** 데이터 저장 콜백 함수 */
	function fSaveDataResult(data) {
		if (data.result == "SUCCESS") {
			// 응답 메시지 출력
			$("#bbs_files_1").val("");	// 첨부파일
			
			fListComnGrpCod();
		} else {
			// 오류 응답 메시지 출력
			alert(data.resultMsg);
		}
	}
 
 	// 업로드시 input 태그 이름생성
	$(document).ready(function(){
		  var fileTarget = $('.filebox .upload-hidden');

		    fileTarget.on('change', function(){
		        if(window.FileReader){
		            var filename = $(this)[0].files[0].name;
		        } else {
		            var filename = $(this).val().split('/').pop().split('\\').pop();
		        }

		        $(this).siblings('.upload-name').val(filename);
		    });
		}); 
/* 파일 업로드 end */
		
		
	// 비밀번호 변경 클릭시 팝업창
	$(document).on("click","#changePassBtn",function(){
		gfModalPop("#layer1");
		
	});
	
	// 비밀번호 변경 btn
	function confirmPass(){
		var currentPass = $("#currentPass").val();
		var changePass1 = $("#changePass1").val();
		var changePass2 = $("#changePass2").val();
		
		var param = {
				changePass1 : changePass1
		}
		
		// 비밀번호 변경 검사
		if(currentPass =="" || changePass1=="" || changePass2==""){
			alert("비밀번호를 입력해주세요.");
			return false;	
		}else if(currentPass != $("#registerPwd").val()){
			alert("현재 비밀번호가 일치하지 않습니다.");
			return false;
		}else if(changePass1 != changePass2){
			alert("새 비밀번호가 일치하지 않습니다.");
			return false;
		}else if(changePass1 == $("#registerPwd").val()){
			alert("새로운 비밀번호로 변경해주세요.");
			return false;
		}
		
		var resultCallback = function(data) {
			confirmPassResult(data);
		};
		callAjax("/std/changePass.do", "post", "json", true, param , resultCallback);
	}
	
	
	/** 비밀번호 변경 콜백 함수 */
	function confirmPassResult(data) {
		if (data.result == "SUCCESS") {
			// 응답 메시지 출력
			alert(data.resultMsg);
			
			// 폼초기화
			location.reload();
		} else {
			// 오류 응답 메시지 출력
			alert(data.resultMsg);
		}
	}
	
	// 파일 다운
	function downloadHwk(url){
        var url = $("#downloadFile").val();
		var urlName = $("#downloadFileName").val();
        
        $.ajax({
           success : function(){
              var params = "";
              params += "<input type='hidden' name='rs_url' value='"+ url +"' />";
              params += "<input type='hidden' name='rs_name' value='"+ urlName +"' />";
              jQuery("<form action='/std/downloadFile.do' method='post'>" + params+ "</form>").appendTo('body').submit().remove();
              alert("다운로드 완료");
           }
        });
     }
	
	// 이메일 유효성검사
	$(document).on("input","#registerEmail",function(){
		//var regExp =  /^[\w]{4,}@[\w]+(\.[\w]+){1,3}$/;
		var regExp = /^[A-Za-z0-9_\.\-]+@[A-Za-z0-9\-]+\.[A-Za-z0-9\-]+/;		

		if(!regExp.test($("input[id='registerEmail']").val())){
			$("#checkMail").text("* 이메일 형식이 유효하지 않습니다.");
			return false;
		}else{
			// 초기화
			$("#checkMail").text("");
			return true;
		}
		
	});
	
	function passwordInit(){
		$("#currentPass").val("");
		$("#changePass1").val("");
		$("#changePass2").val("");
	}
</script>

</head>
<body>
	<form id="myForm">

		<div id="mask"></div>

		<div id="wrap_area">

			<h2 class="hidden">header 영역</h2>
			<jsp:include page="/WEB-INF/view/common/header.jsp"></jsp:include>

			<h2 class="hidden">컨텐츠 영역</h2>
			<div id="container">
				<ul>
					<li class="lnb">
						<!-- lnb 영역 --> <jsp:include
							page="/WEB-INF/view/common/lnbMenu.jsp"></jsp:include>
					</li>

					<li class="contents">
						<!-- contents -->
						<h3 class="hidden">contents 영역</h3>
						<div class="content">

							<p class="Location">
								<a href="" class="btn_set home">메인으로</a> <a href=""
									class="btn_nav">학습관리</a> <span class="btn_nav bold">개인정보수정</span>
								<a href="javascript:location.reload();" class="btn_set refresh">새로고침</a>
							</p>

							<p class="conTitle">
								<span>필수 입력사항</span>
							</p>

							<div class="divComGrpCodList">
								<table class="row">
									<caption>caption</caption>
									<colgroup>
										<col width="120px">
										<col width="*">
										<col width="120px">
										<col width="350px">
									</colgroup>

									<tbody>
										<tr>
											<th scope="row">학번</th>
											<td><input type="text" class="inputTxt p100"
												name="std_num" id="std_num" disabled readonly/></td>

											<th scope="row">아이디</th>
											<td>
												<input type="text" class="inputTxt p100" name="loginID" id="loginID" disabled/>
											</td>
										</tr>

										<tr>
											<th scope="row">이름</th>
											<td><input type="text" class="inputTxt p100"
												name="name" id="registerName" disabled readonly/></td>

											<th scope="row">우편번호</th>
											<td colspan="2">
											<input type="text" style="width: 218px; height: 28px;" name="addr1" id="detailaddr" />
											<input type="button" value="우편번호 찾기"
												onclick="execDaumPostcode()"
													style="width: 100px; height: 30px; margin-left:2px;" />
											</td>

										</tr>
										<tr>
											<th scope="row">비밀번호</th>
											<td colspan="">
											<input type="password" class="inputTxt" name="password" id="registerPwd" disabled readonly style="width: 294px;"/>
											<input type="button" class="btnType" id="changePassBtn" value="비밀번호 변경" style="height: 30px; width:100px; margin-left: 4px;">	
											</td>
											
											<th scope="row">주소</th>
											<td colspan=""><input type="text" class="inputTxt p100" name="addr2" id="loginaddr" /></td>

										</tr>
										<tr>
											<th scope="row">비밀번호 확인<span class="font_red"> *</span></th>
											<td colspan="">
												<input type="password" class="inputTxt p100" name="password1" id="registerPwdOk" />
											</td>

											<th scope="row">상세주소</th>
											<td colspan=""><input type="text" class="inputTxt p100"
												name="addr3" id="loginaddr1" /></td>
										</tr>

										<tr>
											<th scope="row">연락처</th>
											<td colspan="3">
												<select id="tel1" name="tel1">
													<option>010</option>
													<option>011</option>
													<option>016</option>
													<option>017</option>
													<option>070</option>
												</select> 
												<input type="tel" class="inputStyle" name="tel2" id="tel2" maxlength="4" />
												<input type="tel" class="inputStyle" name="tel3" id="tel3" maxlength="4" />
											</td>
										</tr>

										<tr>
											<th scope="row">이메일</th>
											<td colspan="3">
												<input type="text" class="" name="mail" id="registerEmail" style="width: 404px; height: 28px;" />
												<span class="font_red" id="checkMail"></span>
											</td>
										</tr>
			
										<input type="hidden" name="user_type" value="S" />

									</tbody>
								</table>
							</div>
							<!-- divComGrpCodList end -->

							<br> <br>

							<p class="conTitle">
								<span>추가 입력사항</span> <span class="fr"></span>
							</p>

							<div class="divComGrpCodList" style="margin-top: 10px;">
								<table class="row">
									<caption>caption</caption>
									<colgroup>
										<col width="120px">
										<col width="*">
									</colgroup>

									<tbody>
										<tr>
											<th scope="row">이력서<span style="font-size: 5px;">(다운로드)</span></th>
											<td>
												<!--  파일업로드 -->
												<div class="filebox bs3-primary">
										        	<!-- <input class="upload-name" id="file_name" name="file_name" disabled="disabled"> -->
										        	<a href="javascript:downloadHwk();">
										        		<input class="upload-name" id="file_name" name="file_name" disabled="disabled">
										        	</a>
										            <!--  <label for="ex_filename">업로드</label>  -->
										        	<input type="file" id="bbs_files_1"  name="bbs_files_1" class="upload-hidden">
										        	
													<input type="hidden" id="downloadFile"> 
													<input type="hidden" id="downloadFileName"> 
					                          	    
										        </div>
										        <!-- 파일업로드 end -->
											</td>

										</tr>
									</tbody>
								</table>
								
								<div style="text-align: center; margin-top: 15px;">
									<a href="" class="btnType blue" id="saveBtn" >
										<span>저장</span>
									</a> 
								</div>
								
								
							</div>

						</div> <!--// content -->
					</li>
				</ul>
			</div>
		</div>
		</form>				
						
						
		<!-- modal 영역 -->
		<div id="layer1" class="layerPop layerType2 changeModal" style="width: 400px; height:330px; text-align: center;">
			
			<div class="hidden"></div>
			<dl>
				<dt>
					<strong>비밀번호변경</strong>
				</dt>
				<dd class="changeModal">
			
							<div class="font_red" style="margin-bottom: 10px;">
								* 이전에 사용한 적 없는 비밀번호가 안전합니다.<br>
									새로운 비밀번호로 변경해 주세요.
							</div>
							<div style="margin-bottom: 7px;">
								<input type="password" placeholder="현재 비밀번호" id="currentPass">
							</div>
							<div style="margin-bottom: 1px;">
								<input type="password" placeholder="새 비밀번호" id="changePass1">
							</div>
							<div>
								<input type="password" placeholder="새 비밀번호 확인" id="changePass2">
							</div>
		
					<div style="text-align: center; margin: 20px;">
						<a href="javascript:confirmPass();" class="btnType blue " id="btnInsertDtlCod"><span>확인</span></a>
						<a href="javascript:gfCloseModal();" class="btnType blue"><span>취소</span></a>
					</div>

				</dd>
			</dl>
			<a href="" class="closePop" onclick="passwordInit()"><span class="hidden">닫기</span></a>
		</div>
		<!-- modal end -->

		<h3 class="hidden">풋터 영역</h3> 
		<jsp:include page="/WEB-INF/view/common/footer.jsp"></jsp:include>

</body>
</html>