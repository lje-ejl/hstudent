<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<title>JobKorea</title>

<jsp:include page="/WEB-INF/view/common/common_include.jsp"></jsp:include>
<style type="text/css">
/* 	#listComnGrpCod td{
		cursor: pointer;
	} */
	
	input[type='radio']:checked{
		/* background: red;
		color: red; */
          width: 15px;
        height: 15px;
        border-radius: 15px;
        top: -2px;
        left: -1px;
        position: relative;
        background-color: #d1d3d1;
        content: '';
        display: inline-block;
        visibility: visible;
        border: 2px solid white;
	}
	
	#test_que{
		font-weight: bold; 
		font-size: 12px;
		background-color: rgba(187,194,205,0.6);
		color: #333333;
	}
</style>

<script type="text/javascript">
	var pageSizeCourse = 5;
	
	// 그룹코드 페이징 설정
	var pageSizeComnGrpCod = 5;
	var pageBlockSizeComnGrpCod = 5;
	
	// 상세코드 페이징 설정
	var pageSizeComnDtlCod = 5;
	var pageBlockSizeComnDtlCod = 10;

	/** OnLoad event */ 
	$(function() {
		// 전체 목록 조회
		fListComnGrpCod();

	});
	
	/** 시험조회 목록 조회 */
	function fListComnGrpCod(currentPage) {
		currentPage = currentPage || 1;
		
		var searchKey = $("#searchKey").val();
		
		var param = {
				currentPage : currentPage
			,	pageSize : pageSizeCourse // 페이지당 보여질 개수
			,	searchKey : searchKey
		}
		
		var resultCallback = function(data) {
			flistGrpCodResult(data, currentPage);
		};
		
		callAjax("/std/selectMyTest.do", "post", "text", true, param, resultCallback);
	}
	
	
	/** 시험조회 콜백 함수 */
	function flistGrpCodResult(data, currentPage) {
		
		// 기존 목록 삭제
		$('#listComnGrpCod').empty();
		//$('#listComnGrpCod').find("tr").remove() 
		
		var $data = $( $(data).html() );
		
		// 신규 목록 생성
		var $listComnGrpCod = $data.find("#listComnGrpCod");		
		$("#listComnGrpCod").append($listComnGrpCod.children());
		
		// 총 개수 추출
		var $totalCntComnGrpCod = $data.find("#totalCntComnGrpCod");
		var totalCntComnGrpCod = $totalCntComnGrpCod.text();
		
		// 페이지 네비게이션 생성
		var paginationHtml = getPaginationHtml(currentPage, totalCntComnGrpCod, pageSizeComnGrpCod, pageBlockSizeComnGrpCod, 'fListComnGrpCod');
		//console.log("paginationHtml : " + paginationHtml);
		//alert(paginationHtml);
		$("#comnGrpCodPagination").empty().append( paginationHtml );
		
		// 현재 페이지 설정
		$("#currentPageComnGrpCod").val(currentPage);
	}
	
	
	// 시험응시 확인 + 시험 내용 select
	function applyTest(test_id){
		if(confirm("시험에 응시하겠습니까?")){
			gfModalPop("#layer2");
		}
			
		param = {test_id : test_id};
		
		var resultCallback = function(data) {
			applyTestResult(data);
		};
		
		//Ajax실행 방식 -> 여기서 text로 받으면 안꺼내짐... why?? -> json으로 변경함
		callAjax("/std/applyTest.do", "post", "text", true, param, resultCallback);
	}
	
	
	/** 시험조회 콜백 함수 */
	function applyTestResult(data) {
		//console.log(JSON.stringify(data.testList));
		
		//console.log("zzzzzzzzzzz 111 : " + Object.keys(data.testList[i]));   
		//console.log("zzzzzzzzzzz 222 : " + Object.getOwnPropertyNames(data.testList[i]));   
		
		/* test.each(function(i){
			console.log("11111111111 : " + test.eq(i));
           }); */
		
		// 이거는 값 넣을때만 사용가능... 
		//var keyname = 'my';
		//var postfix = 'Age'
		//var value = 27;
		//var something = {};
		//something[keyname + postfix] = value;
		//console.log : {myAge : 27}
		
		/*  for(var i=0; i<data.testList.length; i++){
			var test_que = data.testList[i].test_que;
			var que_ex1 = data.testList[i].que_ex1;
			var que_ex2 = data.testList[i].que_ex2;
			var que_ex3 = data.testList[i].que_ex3;
			var que_ex4 = data.testList[i].que_ex4;
			
			// 내용들어갈 영역
			var textArea = $("#testArea");
			var tr = $("<tr>");
			var div = $("<div>");
			
			// 체크박스
			var checkbox1 = ("<input type='radio' name='test")+(i+1)+("' value='") + 1 + ("'>");
			var checkbox2 = ("<input type='radio' name='test")+(i+1)+("' value='") + 2 + ("'>");
			var checkbox3 = ("<input type='radio' name='test")+(i+1)+("' value='") + 3 + ("'>");
			var checkbox4 = ("<input type='radio' name='test")+(i+1)+("' value='") + 4 + ("'>");
			
			// 보기
			var title = data.testList[i].test_que;
			var example1 = (data.testList[i].que_ex1);
			var example2 = (data.testList[i].que_ex2);
			var example3 = (data.testList[i].que_ex3);
			var example4 = (data.testList[i].que_ex4);
			
			var titleArea = div.append(title);
				
			textArea.append(titleArea).append(checkbox1).append(example1+" ")
			.append(checkbox2).append(example2+" ")
			.append(checkbox3).append(example3+" ")
			.append(checkbox4).append(example4+" ").append("<br><br>");

		}   */
		
		// ------------------------------------------------------------------------------
		// 콜백된 시험문제 화면에 추가
		//alert(data);
		
		// 기존 목록 삭제
		$("#testExam").empty();
		
		var $data = $( $(data).html() );
		
		// 신규 목록 생성
		var $testExam = $data.find("#testExam");		
		$("#testExam").append($testExam.children());

	
	}
	
	// 시험 취소시 확인
	function confirmClose(){
			if(confirm("정말 시험 응시를 취소하시겠습니까?")){
				gfCloseModal();
			}
		};
	
	// 시험 제출 
	function submitTest(){
		if(confirm("정말 제출하시겠습니까?")){
			var resultCallback = function(data) {
				submitTestResult(data);
			};
			
		}
		//Ajax실행 방식 -> 여기서 text로 받으면 안꺼내짐... why?? -> json으로 변경함
		callAjax("/std/submitTest.do", "post", "json", true, $("#testApplyArea").serialize(), resultCallback);
	}
																			
	// 시험 제출 콜백
	function submitTestResult(data){
		alert("시험 문제가 제출되었습니다.");
		
		if(data.result == 'SUCCESS'){
			var test_id = data.test_id;
			var lec_id = data.lec_id;
			
			gfCloseModal();
			
			checkResult(test_id,lec_id);
		}
	}
	
	
	// 시험 결과 확인
	function checkResult(test_id,lec_id){
		gfModalPop("#layer3");
		//alert("테스트아이디"+test_id);
		//alert("강의아이디"+lec_id);
		
		var param = {	test_id : test_id
							,lec_id : lec_id}
		
		var resultCallback = function(data) {
			checkResultCallback(data);
		};
		
		callAjax("/std/checkResult.do", "post", "text", true, param, resultCallback);
		
	}
	
	// 시험 결과 확인용 콜백
	function checkResultCallback(data){
		
		$("#testResultArea").empty();
		
		var $data = $($(data).html());
		
		// 신규 목록 생성
		var $testResultCheck = $data.find("#testResult");		
		$("#testResultArea").append($testResultCheck.children());
		
		
	}
	
	
	// select box 변경시 화면 다시 조회
	$(document).on('change', '#searchKey', function(e) {
			fListComnGrpCod();
	});
	
	
	$(document).on('click', '#popupReload', function(e) {
		window.location.reload();
});
	
</script>

</head>
<body>
<form id="myForm" action=""  method="">
	<input type="hidden" id="currentPageComnGrpCod" value="1">
	<input type="hidden" id="currentPageComnDtlCod" value="1">
	<input type="hidden" id="tmpGrpCod" value="">
	<input type="hidden" id="tmpGrpCodNm" value="">
	<input type="hidden" name="action" id="action" value="">
	<!-- 글번호 저장 HIDDEN -->
	<input type="hidden" id="qa_num" class="qa_num" value="">
	<!-- 모달 배경 -->
	<div id="mask"></div>

	<div id="wrap_area">

		<h2 class="hidden">header 영역</h2>
		<jsp:include page="/WEB-INF/view/common/header.jsp"></jsp:include>

		<h2 class="hidden">컨텐츠 영역</h2>
		<div id="container">
			<ul>
				<li class="lnb">
					<!-- lnb 영역 --> 
					<jsp:include page="/WEB-INF/view/common/lnbMenu.jsp"></jsp:include>
				</li>
				
				<li class="contents">
					<!-- contents -->
					<h3 class="hidden">contents 영역</h3>
					<div class="content">

						<p class="Location">
							<a href="#" class="btn_set home">메인으로</a> 
							<a href="#" class="btn_nav">학습관리</a>
							<span class="btn_nav bold">시험응시</span>
							<a href="javascript:location.reload();" class="btn_set refresh">새로고침</a>
						</p>

						<p class="conTitle">
							<span>시험 응시</span> 
							<span class="fr">
							 	<span class="fr"> 
									<select id="searchKey" name="searchKey" style="width: 130px;">
									    <option value="ProceedingTest" id="option1" selected="selected">진행중 시험</option>
										<option value="LastTest" id="option1">지난 지험</option>
									</select> 
								</span>
							</span>
						</p>
						
						<div class="divComGrpCodList">
							<table class="col">
								<caption>caption</caption>
								<colgroup>
									<col width="15%">
									<col width="15%">
									<col width="10%">
									<col width="8%">
									<col width="5%">
									<col width="5%">
								</colgroup>
	
								<thead>
									<tr>
										<th scope="col">과정명</th>
										<th scope="col">시험명</th>
										<th scope="col">응시기간</th>
										<th scope="col">강사명</th>
										<th scope="col">결과</th>
										<th scope="col">시험응시</th>
									</tr>
								</thead>
								<tbody id="listComnGrpCod">
								</tbody>
							</table>
						</div>
	
						<div class="paging_area"  id="comnGrpCodPagination"> </div>
					
						
					</div> <!--// content -->

					<h3 class="hidden">풋터 영역</h3>
						<jsp:include page="/WEB-INF/view/common/footer.jsp"></jsp:include>
				</li>
			</ul>
		</div>
	</div>
</form>
	<!-- --------------------------------------------------------------------------------------------------------- -->
	<!-- 모달팝업 -->
	<div id="layer1" class="layerPop layerType2" style="width: 600px;">
		
		<div class="hidden"></div>
		<dl>
			<dt>
				<strong>TEST APPLY</strong>
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
							<th scope="row">글제목</th>
							<td colspan="3"><span  class="inputTxt p100 qa_bod_tit" id="bod_tit" ></span></td>
						</tr>
						<tr>
							<th scope="row">작성자</th>
							<td><span  class="inputTxt p100" id="bod_name" ></span></td>
							<th scope="row">등록일</th>
							<td><span  class="inputTxt p100" id="regdate" ></span></td>
						</tr>
						<tr>
							<td colspan="4">
								<div  class="inputTxt p100 qa_bod_con" id="bod_con"></div>
							</td>
						</tr>
						
						<!-- 글 작성자 일때 버튼 생성 -->
						<tr id="changeArea">
							<td colspan="4" align="center" >
								<a href="" class="btnType blue"  id="btnUpdate" name="btn"><span>수정</span></a> 
								<a href="" class="btnType blue" id="btnDeleteDtlCod" name="btn"><span>삭제</span></a>
							</td>
						</tr>
					</tbody>
				</table>
				
				
				<input type="text"  id="qnaRv" style="height: 28px; width: 430px;">
				<a href="" class="btnType blue" id="btnSaveDtlCod" name="btn" ><span>작성</span></a>
				
				<!-- e : 여기에 내용입력 -->
			</dd>
		</dl>
		<a href="" class="closePop"><span class="hidden">닫기</span></a>
	</div>
		<!-- --------------------------------------------------------------------------------------------------------- -->

	<!-- 시험응시 팝업창 -->
<form id="testApplyArea">
	<div id="layer2" class="layerPop layerType2" style="width: 800px;">
		<dl>
			<dt>
				<strong>시험 응시</strong>
			</dt>
			<dd class="content" style="height: 600px !important; overflow: auto !important;">

				<!-- s : 여기에 내용입력 -->

				<table class="row">
					<caption>caption</caption>
					<colgroup>
						<col width="80px">
						<col width="*">
						<col width="80px">
						<col width="*">
					</colgroup>
				
					<tbody id="testExam">
						<tr>
							<th scope="row">시험명</th>
							<td colspan="3"></td>
						</tr>
						<tr>
							<th scope="row">강의이름</th>
							<td></td>
							<th scope="row">강사명</th>
							<td></td>
						</tr>
						<tr>
							<th colspan="4">시험문제영역</th>
						</tr>
						
						<!-- 문제 for문 돌릴영역 -->
						<tr>
						</tr>
						
					</tbody>
				</table>

				<!-- e : 여기에 내용입력 -->
				<div class="btn_areaC mt30">
					<a href="javascript:submitTest()" class="btnType blue" id="submitTest"><span>제출</span></a>
					<a href="javascript:confirmClose();" class="btnType gray" id="closeConfirmBtn"><span>취소</span></a>
				</div>
			</dd>
		</dl>
		<a href="" class="closePop"><span class="hidden">닫기</span></a>
	</div>
</form>
	<!--// 모달팝업 end -->
	<!-- --------------------------------------------------------------------------------------------------------- -->
	
	<!-- 시험결과 확인 팝업창 -->
	<div id="layer3" class="layerPop layerType2" style="width: 650px; top: 100px !important;">
		<dl>
			<dt>
				<strong>시험 결과 확인</strong>
			</dt>
			<dd class="content" style="height: 600px !important; overflow: auto !important;">

				<!-- s : 여기에 내용입력 -->

				<table class="row" >
					<caption>caption</caption>
					<colgroup>
						<col width="80px">
						<col width="*">
						<col width="80px">
						<col width="*">
					</colgroup>
				
					<tbody id="testResultArea">
						<tr>
							<th scope="row">시험명</th>
							<td colspan="3"></td>
						</tr>
						<tr>
							<th scope="row">강의이름</th>
							<td></td>
							<th scope="row">강사명</th>
							<td></td>
						</tr>
						<tr>
							<th colspan="4">시험문제영역</th>
						</tr>
						
						<!-- 문제 for문 돌릴영역 -->
						<tr></tr>
						
					</tbody>
				</table>

				<!-- e : 여기에 내용입력 -->
				<div class="btn_areaC mt30">
					<a href="javascript:gfCloseModal();" class="btnType gray" id=""><span id="popupReload">취소</span></a>
				</div>
			</dd>
		</dl>
		<a href="" class="closePop"><span class="hidden">닫기</span></a>
	</div>
	<!--// 모달팝업 end -->


</body>
</html>