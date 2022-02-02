<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>강의계획서 관리</title>

<jsp:include page="/WEB-INF/view/common/common_include.jsp"></jsp:include>

<script type="text/javascript">
	//상담목록 페이징 설정
	var pageSize = 10;
	var pageBlockSize = 5;

	/** OnLoad event */
	$(document).ready(function() {
		// 강의목록 조회
		flist_lec(1,'ing');

		// 버튼 이벤트 등록
		fRegisterButtonClickEvent();
	});

	/** 버튼 이벤트 등록 */
	function fRegisterButtonClickEvent() {
		$('a[name=btn]').click(function(e) {
			e.preventDefault();

			var btnId = $(this).attr('id');

			switch (btnId) {
			case 'btnSave':
				fsave();
				break;
			case 'btnWSave':
				fweek_plan_insert();
				break;
			case 'btnWadd':
				fweek_add();
				break;
			case 'btnWdel':
				fweek_del();
				break;
			case 'btnUpdate':
				fsave_adv();
				break;
			case 'btnClose':
				gfCloseModal();
				break;
			case 'btnDel':
				fDelete_adv();
				break;
			}
		});
	}

	/** 강의목록 조회 */
	function flist_lec(currentPage,progress) {

		currentPage = currentPage || 1;
		progress= progress;
		searchWord = $("#searchWord").val();
		searchKey = $("#searchKey").val();
		console.log("currentPage : " + currentPage);
		console.log("searchWord : " + searchWord);

		var param = {
			searchKey : searchKey,
			searchWord : searchWord,
			currentPage : currentPage,
			pageSize : pageSize,
			progress:progress
		}

		var resultCallback = function(data) {
			flist_lec_result(data, currentPage);
		};
		//Ajax실행 방식
		//callAjax("Url",type,return,async or sync방식,넘겨준거,값,Callback함수 이름)
		callAjax("/tut/Plist_lec.do", "post", "text", true, param,
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
		var totalCnt = $("#totalCnt").val();

		// 페이지 네비게이션 생성
		var paginationHtml = getPaginationHtml(currentPage, totalCnt, pageSize,
				pageBlockSize, 'flist_lec');
		//alert(paginationHtml);
		$("#Pagination").empty().append(paginationHtml);

		// 현재 페이지 설정
		$("#currentPage").val(currentPage);
	}

	/** 상담 모달 실행 */
	function fPopModal(lec_id) {
		// 신규 저장
		if (lec_id == null || lec_id == "") {

			// Tranjection type 설정
			$("#action").val("I");

			// 상담 모달 폼 초기화
			fInit();
			//flist_lecture();
			// 모달 팝업
			gfModalPop("#layer1");

			// 수정 저장
		} else {
			// Tranjection type 설정
			$("#action").val("U");

			// 그룹코드 단건 조회
			fSelec(lec_id);
		}
	}

	/** 모달 강의 목록 조회 */
	function flist_lecture() {

		var param = {}

		var resultCallback = function(data) {
			flist_lecture_result(data);
		};

		callAjax("/tut/Pmlist_lecture.do", "post", "text", true, param,
				resultCallback);
	}

	/** 모달 강의목록 콜백 함수 */
	function flist_lecture_result(data) {
		console.log(data);

		// 기존 목록 삭제
		$('#list_lecture').empty();

		// 신규 목록 생성
		$('#list_lecture').append(data);
	}

	/** 상담 저장 validation */
	function fValidate_adv() {

		var chk = checkNotEmpty([ [ "adv_con", "상담내용을 입력해 주세요." ] ]);

		if (!chk) {
			return;
		}

		return true;
	}

	/** 계획서 저장 */
	function fsave() {

		// vaildation 체크
		if (!fValidate_adv()) {
			return;
		}

		var resultCallback = function(data) {
			fsave_result(data);
		};

		callAjax("/tut/save_plan.do", "post", "json", true, $("#myForm")
				.serialize(), resultCallback);
	}

	/** 계획서 저장 콜백 함수 */
	function fsave_result(data) {

		// 목록 조회 페이지 번호
		var currentPage = "1";
		if ($("#action").val() != "I") {
			currentPage = $("#currentPage").val();
		}

		if (data.result == "SUCCESS") {

			// 응답 메시지 출력
			alert(data.resultMsg);

			// 모달 닫기
			//gfCloseModal();

			// 목록 조회
			var lec_id = $("#tmp_lec").val();

			//flist_advice(currentPage, lec_id);

		} else {
			// 오류 응답 메시지 출력
			alert(data.resultMsg);
		}

		// 입력폼 초기화
		//fInit();
	}

	/** 계획서 폼 초기화 */
	function fInit(object) {

		if (object == "" || object == null || object == undefined) {
			$("#tutor_name,#tel,#mail,#lecrm,#lec_goal,#atd_plan").val('');
			$("#week_plan").empty();
			$("#lec_id option:eq(0)").prop("selected", true);

			
			

		} else {
			$("#lec_id").val(object.lec_id);
			$("#tutor_id").val(object.tutor_id);
			$("#tutor_name").val(object.name);
			$("#tel").val(object.tel);
			$("#mail").val(object.mail);
			$("#lecrm_id").val(object.lecrm_id);
			$("#lecrm").val(object.lecrm_name);
			$("#lec_goal").val(object.lec_goal);
			$("#atd_plan").val(object.atd_plan);
			$("#slec_id").val(object.lec_name);
			$("#slec_sort").val(object.lec_sort);

		}
	}
	//계획서 단건 조회 주차목록
	function fweek_plan(object) {
		var innerHtml = "";
		if (object == "" || object == null || object == undefined) {
			$("#week_plan").empty();

		} else {
			$("#week_plan").empty();
			$
					.each(
							object,
							function(index, item) {
								innerHtml += '<tr>';
								innerHtml += '    <td class="week">'
										+ item.week + '</td>';
								innerHtml += '    <td><input type="text" value="'+item.learn_goal+'" name="learn_goal" class="inputTxt p100 learn_goal"></td>';
								innerHtml += '    <td><input type="text" value="'+item.learn_con+'" name="learn_con" class="inputTxt p100 learn_con"></td>';
								innerHtml += '</tr>';

							})
			$('#week_table > tbody:last').append(innerHtml);
		}
	}

	/** 상담 단건 조회 */
	function fSelec(lec_id) {
		$("#tmp_lec").val(lec_id);
		var param = {
			lec_id : lec_id
		};

		var resultCallback = function(data) {
			fSelect_result(data);
		};

		callAjax("/tut/Pmlec_info.do", "post", "json", true, param,
				resultCallback);
	}

	/** 계획서 단건 조회 콜백 함수*/
	function fSelect_result(data) {

		if (data.result == "SUCCESS") {
			fInit();
			// 모달 팝업
			gfModalPop("#layer1");

			// 계획서 폼 데이터 설정
			fInit(data.lec_info);
			fweek_plan(data.week_plan);

		} else {
			alert(data.resultMsg);
		}
	}

	/** 모달 강의정보 조회 */
	function flec_info() {

		var lec_id = $("#lec_id").val();
		$("#tmp_lec").val(lec_id);
		var param = {
			lec_id : lec_id,
		}

		var resultCallback = function(data) {
			flec_info_result(data.lec_info,data.week_plan);
		};

		callAjax("/tut/Pmlec_info.do", "post", "json", true, param,
				resultCallback);
	}

	/** 강의정보 가져오기 */
	function flec_info_result(object,week) {
		$("#edit_table").find('input, textarea').empty();
		$("#tutor_id").val(object.tutor_id);
		$("#tutor_name").val(object.name);
		$("#tel").val(object.tel);
		$("#mail").val(object.mail);
		$("#lecrm_id").val(object.lecrm_id);
		$("#lecrm").val(object.lecrm_name);
		$("#lec_goal").val(object.lec_goal);
		$("#atd_plan").val(object.atd_plan);
		
		
	}

	/* 주차 칸 추가  */
	function fweek_add() {
		var trCnt = $('#week_table tr').length;

		var innerHtml = "";
		innerHtml += '<tr>';
		innerHtml += '    <td class="week">' + trCnt + "주차" + '</td>';
		innerHtml += '    <td><input type="text" name="learn_goal" class="inputTxt p100 learn_goal"></td>';
		innerHtml += '    <td><input type="text" name="learn_con" class="inputTxt p100 learn_con"></td>';
		innerHtml += '</tr>';

		$('#week_table > tbody:last').append(innerHtml);
	}

	//주간 계획 삭제
	function fweek_del() {
		var trCnt = $('#week_table tr').length;

		if ($("#action").val() != "I") {
			var lec_id = $("#tmp_lec").val();
			var week = $('#week_table > tbody:last > tr:last .week').text();

			console.log("week:"
					+ $('#week_table > tbody:last > tr:last .week').text());

			$.ajax({
				url : "week_plan_del.do",
				type : "post",
				data : {
					lec_id : lec_id,
					week : week
				},
				success : function(result) {
					alert(result.resultMsg);
				}

			});
			$('#week_table > tbody:last > tr:last').remove();
		} else {
			$('#week_table > tbody:last > tr:last').remove();
		}
	}

	function fweek_plan_insert() {
		var lec_id = $("#tmp_lec").val();
		var week = new Array();
		var learn_goal = new Array();
		var learn_con = new Array();

		$(".week").each(function() {
			week.push($(this).text());
		});

		$(".learn_goal").each(function() {
			learn_goal.push($(this).val());
		});
		$(".learn_con").each(function() {
			learn_con.push($(this).val());
		});

		console.log("week:" + week);
		console.log("learn_goal:" + learn_goal);
		console.log("learn_con:" + learn_con);

		$.ajax({
			url : "week_plan_insert.do",
			type : "post",
			data : {
				lec_id : lec_id,
				week : week,
				learn_goal : learn_goal,
				learn_con : learn_con
			},
			success : function(result) {
				alert(result.resultMsg);
			}

		});

	}
</script>


</head>
<body>
	<form id="myForm" action="" method="">
		<input type="hidden" id="currentPage" value="1"><input
			type="hidden" id="tmp_lec" value=""> <input type="hidden"
			id="tmp_adv" name="adv_id" value=""> <input type="hidden"
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
									class="btn_nav">학습 지원</a> <span class="btn_nav bold">강의계획서</span>
							</p>

							<!--상담목록  -->
							<p class="Location">
								<a href="lecturePlan.do" class="btn_set refresh">새로고침</a>
							</p>
							<p class="conTitle mt50">
								<span>강의계획서 관리</span><span class="fr">
								<strong> 강 의 명&nbsp;</strong>
								<input type="text" id="searchWord" name="searchWord"
									onKeyDown="if(event.keyCode == 13) flist_lec()"
									style="height: 28px;"> <a class="btnType blue"
									href="javascript:flist_lec()" name="search"><span
										id="searchEnter">검색</span></a> <a class="btnType blue"
									href="javascript:fPopModal();" name="modal"><span>계획서
											등록</span></a>
								</span>
							</p>


					<a href="javascript:flist_lec(1,'ing')" class="btnType blue"><span>진행중 강의</span></a> 
					<a href="javascript:flist_lec(1,'end')" class="btnType red"><span>종료된 강의</span></a>

							<!--강의 리스트  -->
							<div class="div_list_advice" id="div_list_advice">
								<table class="col">
									<caption>caption</caption>
									<colgroup>
										<col width="5%">
										<col width="20%">
										<col width="10%">
										<col width="10%">
									</colgroup>
									<thead>
										<tr>
											<th scope="col">분류</th>
											<th scope="col">강의명</th>
											<th scope="col">기간</th>
											<th scope="col">수강 인원</th>
										</tr>
									</thead>
									<tbody id="lec_list"></tbody>
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
		<div id="layer1" class="layerPop layerType2" style="width: 600px; overflow:scroll"; >
			<dl>
				<dt>
					<strong>강의 계획서</strong>
				</dt>
				<dd class="content">
					<table class="row" id="edit_table" name="edit_table">
						<caption>caption</caption>
						<colgroup>
							<col width="20%">
							<col width="10%">
							<col width="20%">
							<col width="10%">
						</colgroup>

						<tbody>
							<tr>
								<th scope="row">과목</th>
								<td><select id="lec_id" name="lec_id" value=""
									onchange="flec_info()">
										<option>과정명 선택</option>
										<c:forEach items="${mlist_lec}" var="list">
											<option value="${list.lec_id}">${list.lec_name}</option>
										</c:forEach>
								</select></td>
								<th scope="row">분류</th>
								<td><select name="lec_sort" id="lec_sort">
										<option value="실업자">실업자</option>
										<option value="직장인">직장인</option>
								</select></td>
							</tr>
							<tr>
								<th scope="row">강사명</th>
								<td><input type="text" name="tutor_name" id="tutor_name"
									class="inputTxt p100" readonly> <input type="hidden"
									name="tutor_id" id="tutor_id"></td>
									<th scope="row">강의실</th>
								<td><input type="text" name="lecrm" id="lecrm"
									class="inputTxt p100" readonly> <input type="hidden"
									name="lecrm_id" id="lecrm_id"></td>	
							</tr>
							<tr>
								<th scope="row">이메일</th>
								<td><input type="text" name="mail" id="mail"
									class="inputTxt p100"></td>
								<th scope="row">연락처</th>
								<td><input type="text" name="tel" id="tel"
									class="inputTxt p100"></td>
							</tr>
							<tr>
								<th scope="row">수업목표</th>
								<td colspan="3"><textarea name="lec_goal" id="lec_goal" style="resize:none"></textarea></td>
							</tr>
							<tr>
								<th scope="row">출석</th>
								<td colspan="3"><textarea name="atd_plan" id="atd_plan" style="resize:none"></textarea></td>
							</tr>
						</tbody>
					</table>
					<div class="btn_areaC mt30">
						<a href="" class="btnType blue" id="btnSave" name="btn"><span>저장</span></a>
						<a href="" class="btnType gray" id="btnClose" name="btn"><span>닫기</span></a>
					</div>
				</dd>
			</dl>
			<dl>
				<dd class="content">
					<a href="" class="btnType blue" id="btnWadd" name="btn"><span>주차
							추가</span></a> <a href="" class="btnType red" id="btnWdel" name="btn"><span>주차
							삭제</span></a>
					<table id="week_table" class="col2 mb10">
						<thead>
							<tr>
								<th scope="col">주차수</th>
								<th scope="col">학습목표</th>
								<th scope="col">학습내용</th>
							</tr>
						</thead>
						<tbody id="week_plan">
						</tbody>
					</table>
					<div class="btn_areaC mt30">
						<a href="" class="btnType blue" id="btnWSave" name="btn"><span>저장</span></a>
						<a href="" class="btnType gray" id="btnClose" name="btn"><span>닫기</span></a>
					</div>
					<a href="" class="closePop"><span class="hidden">닫기</span></a>
				</dd>
			</dl>
			<a href="" class="closePop"><span class="hidden">닫기</span></a>
		</div>
	</form>
</body>
</html>