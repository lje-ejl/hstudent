<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>학생 관리</title>

<jsp:include page="/WEB-INF/view/common/common_include.jsp"></jsp:include>

<!--추가 스크립트  -->
<script src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script type="text/javascript" charset="utf-8" src="${CTX_PATH}/js/popFindZipCode.js"></script>
<script type="text/javascript" charset="utf-8" src="${CTX_PATH}/js/register.js"></script>



<script type="text/javascript">

	//상담목록 페이징 설정
	var pageSize = 5;
	var pageSize_std = 10;
	var pageBlockSize = 5;

	/** OnLoad event */
	$(document).ready(function() {
		// 강의목록 조회
		flist_lec();

		// 버튼 이벤트 등록
		fRegisterButtonClickEvent();

		$("#Datepicker").datepicker({});

		$(".refresh").click(function() {
			$("#searchWord_std").val('');
			$("#searchWord_lec").val('');
		});
		
		$("#to_date").change(function() {
			if ($("#to_date").val() <$("#from_date").val()){
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
			case 'RegisterCom':
				IDCheck('ARegisterForm');
				break;
			case 'btnClose':
				gfCloseModal();
				break;
			}
		});
	}

	/** 강의목록 조회 */
	function flist_lec(currentPage) {

		currentPage = currentPage || 1;
		searchWord = $("#searchWord_lec").val();
		console.log("currentPage : " + currentPage);
		console.log("searchWord : " + searchWord);

		var param = {
			searchWord_lec : searchWord,
			currentPage : currentPage,
			pageSize : pageSize
		}

		var resultCallback = function(data) {
			flist_lec_result(data, currentPage);
		};
		//Ajax실행 방식
		//callAjax("Url",type,return,async or sync방식,넘겨준거,값,Callback함수 이름)
		callAjax("/adm/plist_lec.do", "post", "text", true, param,
				resultCallback);
	}

	/** 강의목록 조회 콜백 함수 */
	function flist_lec_result(data, currentPage) {

		//alert(data);


		// 기존 목록 삭제
		$('#lec_list').empty();

		// 신규 목록 생성
		$("#lec_list").append(data);

		// 총 개수 추출
		var totalCnt_lec = $("#totalCnt_lec").val();

		// 페이지 네비게이션 생성
		var paginationHtml = getPaginationHtml(currentPage, totalCnt_lec,
				pageSize, pageBlockSize, 'flist_lec');
	
		//alert(paginationHtml);
		$("#Pagination_lec").empty().append(paginationHtml);

		// 현재 페이지 설정
		$("#currentPage_lec").val(currentPage);

		flist_std();

	}

	/** 학생 목록 조회 */
	function flist_std(currentPage, lec_id) {
		currentPage = currentPage || 1;
		searchWord = $("#searchWord_std").val();
		searchKey = $("#searchKey_std").val();
		from_date =$("#from_date").val();
		to_date =$("#to_date").val();
		
		// 강의 정보 설정
		$("#tmp_lec").val(lec_id);

		var param = {
			searchKey_std : searchKey,
			searchWord_std : searchWord,
			lec_id : lec_id,
			currentPage_std : currentPage,
			pageSize_std : pageSize_std,
			from_date:from_date,
			to_date:to_date
		}

		var resultCallback = function(data) {
			flist_std_result(data, currentPage);
		};

		callAjax("/adm/list_std.do", "post", "text", true, param,
				resultCallback);
	}

	/** 상담 조회 콜백 함수 */
	function flist_std_result(data, currentPage) {

		// 기존 목록 삭제
		$('#std_list').empty();

		// 신규 목록 생성
		$('#std_list').append(data);

		// 총 개수 추출
		var totalCnt_std = $("#totalCnt_std").val();

		// 페이지 네비게이션 생성
		var lec_id = $("#tmp_lec").val();
		var paginationHtml = getPaginationHtml(currentPage, totalCnt_std,
				pageSize_std, pageBlockSize, 'flist_std', [ lec_id ]);
		$("#Pagination_std").empty().append(paginationHtml);

		// 현재 페이지 설정
		$("#currentPage_std").val(currentPage);

		//$('#searchWord_std').val('');

	}

	/** 유저 단건 조회 */
	function fstd_info(loginID) {
		$("#tmp_user").val(loginID);

		var param = {
			loginID : loginID
		};

		var resultCallback = function(data) {
			fstd_info_result(data);
		};

		callAjax("/adm/user_info.do", "post", "json", true, param,
				resultCallback);
	}

	/** 유저 단건 조회 콜백 함수*/
	function fstd_info_result(data) {

		if (data.result == "SUCCESS") {

			// 모달 팝업
			gfModalPop("#layer1");

			// 그룹코드 폼 데이터 설정
			fInit_std(data.user_model);

		} else {
			alert(data.resultMsg);
		}
	}

	/** 학생 정보출력  */
	function fInit_std(object) {
		$("#std_id").text(object.loginID);
		$("#std_num").text(object.std_num);
		$("#std_name").text(object.name);
		$("#std_birth").text(object.birth);
		$("#std_tel").text(object.tel);
		$("#std_sex").text(object.sex);
		if(object.addr != null){
		$("#std_addr").text(object.addr.replace(/,/gi, " "));
		}
		$("#std_mail").text(object.mail);

		fslist_lecture(object.loginID);
	}

	/**학생 수강 목록 조회 */
	function fslist_lecture(loginID) {
	
		var param = {
			loginID : loginID,
			user_type:'a'
		}

		var resultCallback = function(data) {
			flist_lecture_result(data);
		};

		callAjax("/adm/slist_lec.do", "post", "text", true, param,
				resultCallback);
	}

	/** 모달 강의목록 콜백 함수 */
	function flist_lecture_result(data) {
	

		// 기존 목록 삭제
		$('#slec_list').empty();

		// 신규 목록 생성
		$('#slec_list').append(data);
	}

	/** 회원 생성 모달 실행 */
	function fPopModal_user(loginID) {
		// 상담 모달 폼 초기화
		fInit_std();
		fslist_lecture();

		gfModalPop("#layer1");

	}

	/** 유저 밴 */
	function ban_user(loginID) {
		

		var result = confirm('정말 탈퇴시키시겠습니까?');

		if(result){
			var param = {
					loginID : loginID
				}			
		var resultCallback = function(data) {
			ban_user_result(data);
		};

		callAjax("/adm/ban_user.do", "post", "json", true, param, resultCallback);
		}else{
			flist_std();
		}
		flist_std();
	}

	/** 유저 밴 콜백 함수 */
	function ban_user_result(data) {

		var currentPage = $("#currentPage_adv").val();
		var lec_id = $("#tmp_lec").val();

		if (data.result == "SUCCESS") {

			// 응답 메시지 출력
			alert(data.resultMsg);

			// 모달 닫기
			gfCloseModal();

			// 학생 목록 조회
			flist_std(currentPage, lec_id);

		} else {
			alert(data.resultMsg);
		}
	}
	
	/** 가입 모달 실행 */
	function fPopModal_reg() {
			// 모달 팝업
			gfModalPop("#layerA");
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
			console.log("1");
			watch = new Date(docForm.year.options[docForm.year.selectedIndex].text, docForm.month.options[docForm.month.selectedIndex].value,1);
			console.log("2");
			hourDiffer = watch - 86400000;
			console.log("3");
			calendar = new Date(hourDiffer);
			console.log("4");
			var daysInMonth = calendar.getDate();
			console.log("5");
			
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
		<input type="hidden" id="currentPage_lec" value="1"> <input
			type="hidden" id="currentPage_std" value="1"> <input
			type="hidden" id="tmp_lec" value=""> <input type="hidden"
			id="tmp_user" name="loginID" value=""> <input type="hidden"
			name="action" id="action" value="">

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
									class="btn_nav">인원 관리</a> <span class="btn_nav bold">학생
									관리</span> <a href="/adm/studentControl.do" class="btn_set refresh">새로고침</a>
							</p>

							<p class="conTitle" id="searcharea">
								<span>학생 관리</span> <span class="fr"> <strong>강 의 명</strong> <input
									type="text" id="searchWord_lec" name="searchWord_lec"
									onKeyDown="if(event.keyCode == 13) flist_lec()"
									style="height: 28px;"> <a class="btnType blue"
									href="javascript:flist_lec()" name="search"><span
										id="searchEnter">검색</span></a></span>
							</p>


							<!--강의 리스트  -->
							<div class="div_list_advice" id="div_list_advice">
								<table class="col">
									<caption>caption</caption>
									<colgroup>
										<col width="5%">
										<col width="30%">
										<col width="10%">
									</colgroup>
									<thead>
										<tr>
											<th scope="col">과정 ID</th>
											<th scope="col">과정명 명</th>
											<th scope="col">기간</th>
										</tr>
									</thead>
									<tbody id="lec_list"></tbody>
								</table>
							</div>

							<div class="paging_area" id="Pagination_lec"></div>

							<!--학생 목록  -->


							<p class="conTitle mt50">
								<span>학생 목록</span> <span class="fr">
								
								 <select
									id="searchKey_std" name="searchKey_std" style="width: 80px;">
										<option value="all" id="option1" selected="selected">전체</option>
										<option value="stdNm" id="option1">학생명</option>
										<option value="stdId" id="option2">id</option>
										<option value="tel" id="option2">전화번호</option>
								</select><input type="text" id="searchWord_std" name="searchWord_std"
									onKeyDown="if(event.keyCode == 13) flist_std()"
									style="height: 28px;"> <a class="btnType blue"
									href="javascript:flist_std()" name="search"><span
										id="searchEnter">검색</span></a> <a class="btnType blue"
									href="javascript:fPopModal_reg()" name="modal"><span>신규
											등록</span></a>
								</span>
							</p>
							<span class="fr">
							<p class="Location">
								<Strong>가입일 조회 </Strong><input type="date" id="from_date">~<input type="date" id="to_date">
								<a class="btnType blue"
									href="javascript:flist_std()" name="search"><span
										id="searchEnter">조회</span></a> 	
								<a href="javascript:flist_std()" class="btn_set refresh">새로고침</a>
							</p>
							</span>
							<span class="fl"> 
							<a class="btnType3 color2" href="javascript:flist_std()"><span>전체</span></a>
							<a class="btnType3 color1" href="javascript:flist_std(1,'미수강')"><span>미수강</span></a>
								</span>
							<!--학생 리스트  -->
							<div class="div_list_advice" id="div_list_advice">
								<table class="col">
									<caption>caption</caption>
									<colgroup>
										<col width="10%">
										<col width="10%">
										<col width="20%">
										<col width="10%">
										<col width="10%">
										<col width="10%">
									</colgroup>
									<thead>
										<tr>
											<th scope="col">학번</th>
											<th scope="col">수강강의</th>
											<th scope="col">학생 명(ID)</th>
											<th scope="col">휴대전화</th>
											<th scope="col">가입일자</th>
											<th scope="col"></th>
										</tr>
									</thead>
									<tbody id="std_list"></tbody>
								</table>
							</div>

							<div class="paging_area" id="Pagination_std"></div>
						</div> <!--// content -->

						<h3 class="hidden">풋터 영역</h3> <jsp:include
							page="/WEB-INF/view/common/footer.jsp"></jsp:include>
					</li>
				</ul>
			</div>
		</div>
		</form>
		<!-- 모달팝업 -->
		<div id="layer1" class="layerPop layerType2" style="width: 600px;">
			<dl>
				<dt>
					<strong>학생 정보</strong>
				</dt>
				<dd class="content">
					<!-- s : 여기에 내용입력 -->
					<table class="row">
						<caption>caption</caption>
						<colgroup>
							<col width="10%">
							<col width="10%">
							<col width="10%">
							<col width="10%">
						</colgroup>
						<tbody>
							<tr>
								<th scope="row">ID</th>
								<td id="std_id"></td>
								<th scope="row">학번</th>
								<td id="std_num"></td>
							</tr>
							<tr>
								<th scope="row">이름</th>
								<td id="std_name"></td>
								<th scope="row">생년월일</th>
								<td id="std_birth"></td>
							</tr>
							<tr>
								<th scope="row">전화 번호</th>
								<td id="std_tel"></td>
								<th scope="row">성별</th>
								<td id="std_sex"></td>
							</tr>
							<tr>
								<th scope="row">이메일</th>
								<td id="std_mail" colspan="6"></td>
							</tr>
							<tr>
								<th scope="row">주소</th>
								<td id="std_addr" colspan="6"></td>
							</tr>
							<tr>
								<td colspan="6">
									<p class="conTitle mt20">
										<span>수강 내역</span>
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

		

		<!-- 모달팝업 -->
		<form id="ARegisterForm" action="" method="post">
		<input type="hidden" name="action" id="action" value="">
		<div id="layerA" class="layerPop layerType2" style="width: 600px;">
			<dl>
				<dt>
					<strong>학생 회원 가입</strong>
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
								<td><input type="text" class="inputTxt p100"  name="name" id="AregisterName" /></td>
								<th scope="row">아이디 <span class="font_red">*</span></th>
								<td><input type="text" class="inputTxt p100" name="loginID" id="AregisterId" /></td>
							</tr>
							<tr>
								<th scope="row">비밀번호 <span class="font_red">*</span></th>
								<td colspan="3"><input type="password" class="inputTxt p100" name="password" id="AregisterPwd" /></td>
							</tr>
							<tr>
								<th scope="row">비밀번호 확인<span class="font_red">*</span></th>
								<td colspan="3"><input type="password" class="inputTxt p100" name="password1" id="AregisterPwdOk" /></td>
							</tr>	
							<tr>
								<th scope="row">우편번호<span class="font_red">*</span></th>
								<td colspan="2"><input type="text" class="inputTxt p100" name="user_post" id="Adetailaddr" /></td>
								<td><input type="button" value="우편번호 찾기" onclick="execDaumPostcode('Aloginaddr','Aloginaddr1','Adetailaddr')" class="address_search" /></td>								
							</tr>
							<tr>
								<th scope="row">주소<span class="font_red">*</span></th>
								<td colspan="3"><input type="text" class="inputTxt p100" name="addr" id="Aloginaddr" /></td>
							</tr>
							<tr>
								<th scope="row">상세주소<span class="font_red">*</span></th>
								<td colspan="3"><input type="text" class="inputTxt p100" name="addr_detail" id="Aloginaddr1" /></td>
							</tr>
							<tr>
							<tr>
							     <th scope="row">성별 <span class="font_red">*</span></th>
					             <td colspan="3">
					             	<input type="radio" name="sex" value="M" id="AregisterSex">  &nbsp;&nbsp;&nbsp; 남  &nbsp;&nbsp;&nbsp; 
					             	<input type="radio" name="sex" value="F" id="AregisterSex">  &nbsp;&nbsp;&nbsp; 여  &nbsp;&nbsp;&nbsp; 
					             </td>
							</tr>
							<tr>
								<th scope="row">연락처 <span class="font_red">*</span></th>
								<td colspan="3">
									<input type="text" class="phone" name="tel1" id="AregisterPhone1" /> <b>&nbsp;&nbsp;-&nbsp;&nbsp;</b> 
									<input type="text" class="phone" name="tel2" id="AregisterPhone2" /> <b>&nbsp;&nbsp;-&nbsp;&nbsp;</b> 
									<input type="text" class="phone" name="tel3" id="AregisterPhone3" /> 
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
									<input type="text" class="pid" name="pid1" id="AregisterPid1" /> <b>&nbsp;&nbsp;-&nbsp;&nbsp;</b> 
									<input type="password" class="pid" name="pid2" id="AregisterPid2" />
								</td>
							</tr>	
							<tr>
								<th scope="row">이메일<span class="font_red">*</span></th>
								<td colspan="3">
									<input type="text" class="mail" name="mail1" id="AregisterEmail1" />
										&nbsp;&nbsp; @ &nbsp;&nbsp;
									<input type="text" class="mail" name="mail2" id="AregisterEmail2" />
								</td>
							</tr>
							<input type="hidden" name="user_type" value="A" />
						</tbody>
					</table>

					<div class="btn_areaC mt30">
						<a href="javascript:IDCheck('ARegisterForm');" class="btnType blue" id="RegisterCom" name="btn"><span>가입</span></a>
						<a href="" class="btnType gray" id="btnClose" name="btn"><span>취소</span></a>
					</div>
				</dd>
			</dl>
			<a href="" class="closePop"><span class="hidden">닫기</span></a>
		</div>
	</form>
	</body>
	</html>