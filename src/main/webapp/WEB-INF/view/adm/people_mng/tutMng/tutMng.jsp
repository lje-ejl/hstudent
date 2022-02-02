<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>강사 관리</title>

<jsp:include page="/WEB-INF/view/common/common_include.jsp"></jsp:include>

<!--추가 스크립트  -->
<script src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script type="text/javascript" charset="utf-8" src="${CTX_PATH}/js/popFindZipCode.js"></script>
<script type="text/javascript" charset="utf-8" src="${CTX_PATH}/js/register.js"></script>
<%-- <link rel="stylesheet" type="text/css" href="${CTX_PATH}/css/admin/login.css" /> --%>

<script type="text/javascript">
	//강사 목록 페이징 설정
	var pageSize = 10;
	var pageBlockSize = 5;

	/** OnLoad event */
	$(document).ready(function() {

		//강사목록 조회
		flist_tut();

		// 버튼 이벤트 등록
		fRegisterButtonClickEvent();

		$("#to_date").change(function() {
			if ($("#to_date").val() < $("#from_date").val()) {
				alert("최소기간 보다 작을수 없습니다.")
				$("#to_date").val('');
			}
		});
	});

	/** 버튼 이벤트 등록 */
	function fRegisterButtonClickEvent() {
		$('a[name=btn]').click(function(e) {
			e.preventDefault();

			var btnId = $(this).attr('id');

			switch (btnId) {
			case 'btnSave':
				fsave_adv();
				break;
			case 'RegisterCom':
				IDCheck('BRegisterForm');
				break;
			case 'btnClose':
				gfCloseModal();
				break;
			}
		});
	}

	/** 강사 목록 조회 */
	function flist_tut(currentPage, user_type) {

		currentPage = currentPage || 1;
		user_type = user_type || '';
		searchWord = $("#searchWord").val();
		searchKey = $("#searchKey").val();
		from_date = $("#from_date").val();
		to_date = $("#to_date").val();
		lec_id = $("#lec_list").val();

		$("#tmp_type").val(user_type);

		var param = {
			searchKey : searchKey,
			searchWord : searchWord,
			lec_id : lec_id,
			currentPage : currentPage,
			pageSize : pageSize,
			from_date : from_date,
			to_date : to_date,
			user_type : user_type
		}

		var resultCallback = function(data) {
			flist_tut_result(data, currentPage);
		};

		callAjax("/adm/list_tut.do", "post", "text", true, param,
				resultCallback);
	}

	/** 강사목록 조회 콜백 함수 */
	function flist_tut_result(data, currentPage) {

		// 기존 목록 삭제
		$('#tut_list').empty();

		// 신규 목록 생성
		$('#tut_list').append(data);

		// 총 개수 추출
		var totalCnt = $("#totalCnt").val();

		// 페이지 네비게이션 생성
		var user_type = $("#tmp_type").val();
		var paginationHtml = getPaginationHtml(currentPage, totalCnt, pageSize,
				pageBlockSize, 'flist_tut', [ user_type ]);
		$("#Pagination").empty().append(paginationHtml);

		// 현재 페이지 설정
		$("#currentPage").val(currentPage);

	}

	/** 유저 단건 조회 */
	function ftut_info(loginID) {
		$("#tmp_user").val(loginID);

		var param = {
			loginID : loginID
		};

		var resultCallback = function(data) {
			ftut_info_result(data);
		};

		callAjax("/adm/user_info.do", "post", "json", true, param,
				resultCallback);
	}

	/** 유저 단건 조회 콜백 함수*/
	function ftut_info_result(data) {

		if (data.result == "SUCCESS") {

			// 모달 팝업
			gfModalPop("#layer1");

			// 그룹코드 폼 데이터 설정
			fInit_tut(data.user_model);

		} else {
			alert(data.resultMsg);
		}
	}

	/** 학생 정보출력  */
	function fInit_tut(object) {
		$("#tut_id").text(object.loginID);
		$("#tut_num").text(object.tut_num);
		$("#tut_name").text(object.name);
		$("#tut_birth").text(object.birth);
		$("#tut_tel").text(object.tel);
		$("#tut_sex").text(object.sex);
		if(object.addr != null){
		$("#tut_addr").text(object.addr.replace(/,/gi, " "));
		}
		$("#tut_mail").text(object.mail);

		fslist_lecture(object.loginID);
	}

	/**학생 수강 목록 조회 */
	function fslist_lecture(loginID) {

		var param = {
			loginID : loginID,
			user_type : 'b'
		}

		var resultCallback = function(data) {
			flist_lecture_result(data);
		};

		callAjax("/adm/slist_lec.do", "post", "text", true, param,
				resultCallback);
	}

	/** 모달 강의목록 콜백 함수 */
	function flist_lecture_result(data) {
		console.log(data);

		// 기존 목록 삭제
		$('#slec_list').empty();

		// 신규 목록 생성
		$('#slec_list').append(data);
	}

	/** 회원 생성 모달 실행 */
	function fPopModal_user(loginID) {
		// 상담 모달 폼 초기화
		fInit_tut();
		fslist_lecture();

		gfModalPop("#layer1");

	}

	/** 유저 밴 */
	function ban_user(loginID) {

		var result = confirm('정말 탈퇴시키시겠습니까?');

		if (result) {
			var param = {
				loginID : loginID
			}
			var resultCallback = function(data) {
				ban_user_result(data);
			};

			callAjax("/adm/ban_user.do", "post", "json", true, param,
					resultCallback);
			flist_tut();
		} else {
		}

	}

	/** 유저 밴 콜백 함수 */
	function ban_user_result(data) {

		var currentPage = $("#currentPage").val();
		var lec_id = $("#tmp_lec").val();

		if (data.result == "SUCCESS") {

			// 응답 메시지 출력
			alert(data.resultMsg);

			// 모달 닫기
			gfCloseModal();

			// 학생 목록 조회
			flist_tut(currentPage, lec_id);

		} else {
			alert(data.resultMsg);
		}
	}

	//강사 승인 
	function apv_tut(loginID) {
		var result = confirm('승인 하시겠습니까?');

		if (result) {
			var param = {
				loginID : loginID
			}
			var resultCallback = function(data) {
				apv_tut_result(data);
			};

			callAjax("/adm/apv_tut.do", "post", "json", true, param,
					resultCallback);
			flist_tut();
		} else {

		}

	}

	//강사 승인 콜백

	function apv_tut_result(data) {

		var currentPage = $("#currentPage").val();

		if (data.result == "SUCCESS") {

			// 응답 메시지 출력
			alert(data.resultMsg);

			// 모달 닫기
			gfCloseModal();

			// 학생 목록 조회
			flist_tut(currentPage);

		} else {
			alert(data.resultMsg);
		}
	}
	
	/* 강사 회원가입 */
	function fRegisterB() {
		gfModalPop("#layerB");
	}
	
	// 우편번호 api
	function execDaumPostcode(loginaddr,loginaddr1,detailaddr) {
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
				document.getElementById(detailaddr).value = data.zonecode;
				document.getElementById(loginaddr).value = addr;
				// 커서를 상세주소 필드로 이동한다.
				document.getElementById(loginaddr1).focus();
			}
		}).open({ });
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
	
</script>


</head>
<body>
	<form id="myForm" action="" method="">
		<input type="hidden" id="currentPage" value="1"> <input
			type="hidden" id="tmp_type" name="user_type" value=""> <input
			type="hidden" id="tmp_user" name="loginID" value=""> <input
			type="hidden" name="action" id="action" value="">

		<!-- 모달 배경 -->
		<div id="mask"></div>

		<div id="wrap_area">

			<h2 class="hidden">header 영역</h2>
			<jsp:include page="/WEB-INF/view/common/header.jsp"></jsp:include>

			<h2 class="hidden">컨텐츠 영역</h2>
			<div id="container">
				<ul>
					<li class="lnb">
						<!-- lnb 영역 --> <jsp:include
							page="/WEB-INF/view/common/lnbMenu.jsp"></jsp:include> <!--// lnb 영역 -->
					</li>
					<li class="contents">
						<!-- contents -->
						<h3 class="hidden">contents 영역</h3> <!-- content -->
						<div class="content">

							<p class="Location">
								<a href="/notice/aNotice.do" class="btn_set home">메인으로</a> <a href=""
									class="btn_nav">인원 관리</a> <span class="btn_nav bold">강사
									관리</span> <a href="/adm/tutorControl.do" class="btn_set refresh">새로고침</a>
							</p>


							<!--학생 목록  -->

							<p class="conTitle mt50">
								<span>강사 목록</span> <span class="fr"> <select
									id="searchKey" name="searchKey" style="width: 80px;">
										<option value="all" id="option1" selected="selected">전체</option>
										<option value="name" id="option1">강사명</option>
										<option value="id" id="option1">ID</option>
										<option value="tel" id="option2">전화번호</option>
								</select><input type="text" id="searchWord" name="searchWord"
									onKeyDown="if(event.keyCode == 13) flist_tut()"
									style="height: 28px;"> <a class="btnType blue"
									href="javascript:flist_tut()" name="search"><span
										id="searchEnter">검색</span></a> <a class="btnType blue"
									href="javascript:fRegisterB();" name="modal"><span>신규
											등록</span></a>
								</span>
							</p>
							<span class="fr">
								<p class="Location">
									<Strong>가입일 조회 </Strong> <input type="date" id="from_date">~<input
										type="date" id="to_date"> <a class="btnType blue"
										href="javascript:flist_tut()" name="search"><span
										id="searchEnter">조회</span></a>
								</p>
							</span>

							<span class="fl"> <a id="user_typeB"
								class="btnType3 color2" href="javascript:flist_tut(1,'B')"><span>승인
										강사</span></a> <a id="user_typeD" class="btnType3 color1"
								href="javascript:flist_tut(1,'D')"><span>미승인 강사</span></a>
							</span>

							<!--학생 리스트  -->
							<div class="div_list_advice" id="div_list_advice">
								<table class="col">
									<caption>caption</caption>
									<colgroup>
										<col width="10%">
										<col width="5%">
										<col width="5%">
										<col width="5%">
										<col width="5%">
									</colgroup>
									<thead>
										<tr>
											<th scope="col">강사명 (ID)</th>
											<th scope="col">휴대전화</th>
											<th scope="col">가입일자</th>
											<th scope="col">승인여부</th>
											<th scope="col"></th>
										</tr>
									</thead>
									<tbody id="tut_list"></tbody>
								</table>
							</div>

							<div class="paging_area" id="Pagination"></div>
						</div> <!--// content -->

						<h3 class="hidden">풋터 영역</h3> <jsp:include
							page="/WEB-INF/view/common/footer.jsp"></jsp:include>
					</li>
				</ul>
			</div>
		</div>


		<!-- 모달팝업 -->
		<div id="layer1" class="layerPop layerType2" style="width: 600px;">
			<dl>
				<dt>
					<strong>강사 정보</strong>
				</dt>
				<dd class="content">
					<!-- s : 여기에 내용입력 -->
					<table class="row">
						<caption>caption</caption>
						<colgroup>
							<col width="120px">
							<col width="*">
							<col width="120px">
							<col width="*">
						</colgroup>
						<tbody>
							<tr>
								<th scope="row">ID</th>
								<td id="tut_id"></td>
								<th scope="row">이름</th>
								<td id="tut_name"></td>
							</tr>
							<tr>
								<th scope="row">생년월일</th>
								<td id="tut_birth"></td>
								<th scope="row">성별</th>
								<td id="tut_sex"></td>
							</tr>
							<tr>
								<th scope="row">전화 번호</th>
								<td id="tut_tel"></td>
								<th scope="row">이메일</th>
								<td id="tut_mail"></td>
							</tr>
							<tr>
								<th scope="row">주소</th>
								<td colspan="6" id="tut_addr" ></td>
							</tr>
							<tr>
								<td colspan="6">
									<p class="conTitle mt20">
										<span>강의 목록</span>
									</p>
									<table class="col">
										<caption>caption</caption>
										<colgroup>
											<col width="5%">
											<col width="10%">
											<col width="20%">
											<col width="10%">
											<col width="10%">
											<col width="10%">
										</colgroup>
										<thead>
											<tr>
												<th scope="col">강의ID</th>
												<th scope="col">강의명</th>
												<th scope="col">기간</th>
												<th scope="col">상태</th>
											</tr>
										</thead>
										<tbody id="slec_list"></tbody>
									</table>
								</td>
							</tr>
						</tbody>
					</table>

					<!-- e : 여기에 내용입력 -->

					<div class="btn_areaC mt30">
						<a href="" class="btnType gray" id="btnClose" name="btn"><span>닫기</span></a>
					</div>
				</dd>
			</dl>
			<a href="" class="closePop"><span class="hidden">닫기</span></a>
		</div>
		</form>

<!-- 강사  회원가입  -->
	<form id="BRegisterForm" action="" method="post">
		<div id="layerB" class="layerPop layerType2" style="width: 600px;">
			<dl>
				<dt>
					<strong>강사 회원 가입</strong>
				</dt>
				<dd class="content">
					<!-- s : 여기에 내용입력 -->
					<table class="row">
						<caption>caption</caption>
						<colgroup>
							<col width="120px">
							<col width="*">
							<col width="120px">
							<col width="*">
						</colgroup>

						<tbody>
							<tr class="sel">
								<th scope="row" colspan="4">
									<a href="javascript:AfPopModalLsmCod();" class="btnType gray regi_a" id="btnCloseLsmCod" name="btn">학생 회원가입</a>
									<a href="javascript:BfPopModalLsmCod();" class="btnType gray regi_a" id="btnCloseLsmCod" name="btn">강사 회원가입</a>
									<a href="javascript:DfPopModalLsmCod();" class="btnType gray regi_a" id="btnCloseLsmCod" name="btn">기업 회원가입</a>
								</th>
							</tr>
							<tr>
								<th scope="row">이름<span class="font_red">*</span></th>
								<td><input type="text" class="inputTxt p100" name="name" id="BregisterName" /></td>
								<th scope="row">아이디 <span class="font_red">*</span></th>
								<td><input type="text" class="inputTxt p100" name="loginID" id="BregisterId" /></td>
							</tr>
							<tr>
								<th scope="row">비밀번호 <span class="font_red">*</span></th>
								<td colspan="3"><input type="password" class="inputTxt p100" name="password" id="BregisterPwd" /></td>
							</tr>
							<tr>
								<th scope="row">비밀번호 확인<span class="font_red">*</span></th>
								<td colspan="3"><input type="password" class="inputTxt p100" name="password1" id="BregisterPwdOk" /></td>
							</tr>
							<tr>
								<th scope="row">우편번호<span class="font_red">*</span></th>
								<td colspan="2"><input type="text" class="inputTxt p100" name="user_post" id="Bdetailaddr" /></td>
								<td><input type="button" value="우편번호 찾기" onclick="execDaumPostcode('Bloginaddr','Bloginaddr1','Bdetailaddr')" class="address_search" /></td>
							</tr>							
							<tr>
								<th scope="row">주소<span class="font_red">*</span></th>
								<td colspan="3"><input type="text" class="inputTxt p100" name="addr" id="Bloginaddr" /></td>
							</tr>							
							<tr>
								<th scope="row">상세주소<span class="font_red">*</span></th>
								<td colspan="3"><input type="text" class="inputTxt p100" name="addr_detail" id="Bloginaddr1" /></td>
							</tr>
							<tr>
							     <th scope="row">성별 <span class="font_red">*</span></th>
					             <td colspan="3">
					             	<input type="radio" name="sex" value="M" id="BregisterSex">  &nbsp;&nbsp;&nbsp; 남  &nbsp;&nbsp;&nbsp; 
					             	<input type="radio" name="sex" value="F" id="BregisterSex">  &nbsp;&nbsp;&nbsp; 여  &nbsp;&nbsp;&nbsp; 
					             </td>
							</tr>
							<tr>
								<th scope="row">연락처 <span class="font_red">*</span></th>
								<td colspan="3">
									<input type="text" class="phone" name="tel1" id="BregisterPhone1" /> <b>&nbsp;&nbsp;-&nbsp;&nbsp;</b> 
									<input type="text" class="phone" name="tel2" id="BregisterPhone2" /> <b>&nbsp;&nbsp;-&nbsp;&nbsp;</b> 
									<input type="text" class="phone" name="tel3" id="BregisterPhone3" /> 
								</td>
							</tr>
							<tr>
								<th scope="row">생년 월일 <span class="font_red">*</span></th>
								<td colspan="3">
									<script language="javascript"> Today('null','null','null'); </script>
								</td>
							</tr>							
							<tr>
								<th scope="row">주민 번호 <span class="font_red">*</span></th>
								<td colspan="3">
									<input type="text"     class="pid" name="pid1" id="BregisterPid1" /> <b>&nbsp;&nbsp;-&nbsp;&nbsp;</b> 
									<input type="password" class="pid" name="pid2" id="BregisterPid2" />
								</td>
							</tr>	
							<tr>
								<th scope="row">이메일<span class="font_red">*</span></th>
								<td colspan="3">
									<input type="text" class="mail" name="mail1" id="BregisterEmail1" />
										&nbsp;&nbsp; @ &nbsp;&nbsp;
									<input type="text" class="mail" name="mail2" id="BregisterEmail2" />
								</td>
							</tr>
							<input type="hidden" name="user_type" value="B" />
						</tbody>
					</table>
					<div class="btn_areaC mt30">
						<a href="javascript:IDCheck('BRegisterForm');" class="btnType blue" id="RegisterCom" name="btn"><span>가입</span></a>
						<a href="" class="btnType gray" id="btnClose" name="btn"><span>취소</span></a>
					</div>
				</dd>
			</dl>
		</div>
	</form>
		</body>
	</html>