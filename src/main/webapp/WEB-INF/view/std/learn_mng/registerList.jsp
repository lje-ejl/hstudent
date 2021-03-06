<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<title>학생수강목록</title>
<jsp:include page="/WEB-INF/view/common/common_include.jsp"></jsp:include>
<link rel="stylesheet" type="text/css" href="${CTX_PATH}/css/learn_mng/registerList.css" />
<style type="text/css">

</style>
<script type="text/javascript">

//과제목록페이지
var pageSize = 9;
var pageBlockSize = 5;
/* 2020.11.12 kyh 수강목록 페이지가 열리자마자 바로 실행될 함수
*  일단은  callAjax안에 이미 만들어둔  수강목록 data가져오기 .do
*  실행해서 데이터 불러오고 콘솔에 찍는 것 까지 함
*  jQuery에서 $()안에 함수를 넣으면 페이지 열리자마자 바로 실행되게 됨
*/
$( function(){
	var param;
	var resultCallback = function(data) {
		stdRegisterSel(data);
	};
	callAjax("/std/registerListSel.do", "post", "json", true, param, resultCallback);
});

/* 2020.11.12 kyh
   DB 및 서버단으로부터 수강목록 데이터를 가져오는데 성공할 경우 실행할 함수
*/
function stdRegisterSel(data){
	//console.log("stdRegisterSel : " + JSON.stringify(data));
	if (data.result == "SUCCESS") {
		var registermodel = data.registermodel;
		var registercount = data.registercount;
		var progress = Math.round(((registermodel.pre_day / registermodel.process_day)*100)) + "%";
		var atd_day = registercount.atd_cnt + registercount.late_cnt;
		var cur_progress = atd_day + "/" + registermodel.process_day ;
		var term = registermodel.c_st + " ~ " + registermodel.c_end;
		
		if(registermodel.apv =='Y'){
			$("#lec_name").text(registermodel.lec_name);
			$("#tutor_name").text(registermodel.tutor_name);
			$("#term").text(term);
			$("#lecrm_name").text(registermodel.lecrm_name);
			$("#atd_plan").text(registermodel.atd_plan);
			$("#lec_goal").text(registermodel.lec_goal);
			$("#progress").append(progress);
			$("#cur_progress").append(cur_progress);
			
			$("#atd_cnt").text(registercount.atd_cnt);
			$("#late_cnt").text(registercount.late_cnt);
			$("#absent_cnt").text(registercount.absent_cnt);
			$("#lec_id2").val(registermodel.lec_id);
			
				//진도 상태에 따른 설문조사 버튼 활성화
				if(((registermodel.pre_day/registermodel.process_day)*100) < '80'){
					$("#svybtn").hide();
					$("#svybtn2").hide();
				}
				else if(((registermodel.pre_day/registermodel.process_day)*100)>='80' && registermodel.srvy_chk =="N"){
					//활성화
					$("#svybtn").show();
					$("#svybtn2").hide();
				}
				else if(registermodel.srvy_chk == "Y"){
					$("#svybtn2").show();
					$("#svybtn").hide();
				}
		} 
		else if (registermodel.apv =='N'){
			 alert("수강 중인 강의가 없습니다.");
			 location.href="${CTX_PATH}/notice/aNotice.do";
		}
	}
	else{
		 alert("수강 중인 강의가 없습니다.");
		 location.href="${CTX_PATH}/notice/aNotice.do";
		}
}

//설문지 내용 callAjax 
function fstartSurvey(currentPage){
	currentPage = currentPage || 1;
	var param = {
			currentPage : currentPage,
			pageSize : pageSize
		};
	var resultCallback = function(data) {
		fsuyveyList(data, currentPage);
	};
	callAjax("/std/surveySubmit.do", "post", "text", true, param, resultCallback);
}

//설문지 모달에 data입력
function fsuyveyList(data){
	$('#surveyQue').empty().append(data);
	var totalCount = $("#totalCount").val();
	document.getElementById("lec_rv").value = null;
	gfModalPop("#survey_modal"); 
	
	// 페이지 네비게이션 생성
	/* var paginationHtml = getPaginationHtml(currentPage, totalCount, pageSize, pageBlockSize, 'fstartSurvey');
	$("#Pagination_svy").empty().append( paginationHtml ); */
} 
//라디오버튼 null값 체크
function fcheckvalue(){
  
    var returnval = true;
    var radioval;    
    
    var answer = $(":radio:nth-child(odd)");
    var chckcnt = 0;
    
    for(var i = 0 ; i < answer.length ; i++){
    	var $this = $(answer[i]);
    	
    	//console.log(i + " : " + $this.is(":checked"));
    	
        if(!$this.is(":checked")) { //선택되어있지 않다면
        	// returnval = false;
        } else {
        	chckcnt++;        	
        }
    }
    
    if(chckcnt == 9) {
    	returnval = true;    	
    } else {
    	returnval = false;  
    }
    //console.log(" returnval : " + returnval);
    
    return returnval;
}

//설문지 제출 필요값 lec_id
function fsubmitSvy(){
	if(fcheckvalue()){
		if(confirm("정말 제출하시겠습니까?")){
			var resultCallback = function(data) {
				submitSvyResult(data);
			};
		} else {
			return;
		}
	} else {
		alert("모든 항목에 답을 입력해주세요");
		return;		
	}
	
	callAjax("/std/surveyInsert.do", "post", "json", true, $("#modalForm").serialize(), resultCallback);
}
	
//설문조사 제출완료
function submitSvyResult(data){
		if(data.result=="SUCCESS"){
			gfCloseModal();
			location.reload();
			return "srvy_end";
		}else{
			alert("설문조사 에러");
			}
}

</script>
</head>
<body>
<form id="myForm" action=""  method="">
	<input type="hidden" name="registermodel" id="registermodel" value="${registermodel}">
	<input type="hidden" name="registercount" id="registercount" value="">
	<input type="hidden" id="currentPage" value="1">
	<!-- <input type="hidden" id="lec_id"> -->
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
							<a href="" class="btn_set home">메인으로</a> <a href=""
								class="btn_nav">학습 관리</a> <span class="btn_nav bold">수강 목록</span> <a href="" class="btn_set refresh">새로고침</a>
						</p>
						<p class="conTitle">
							<span>수강 목록</span>
						</p>
						<div class="registList" id="registList">
							<table class="col" id="title">
								<caption>caption</caption>
								<colgroup>
								    <col width="30%">
									<col width="20%">
									<col width="20%">
									<col width="10%">
								</colgroup>
	
								<thead>
									<tr>
									    <th scope="col">강의명</th>
										<th scope="col">강사</th>
										<th scope="col">강의 기간</th>
										<th scope="col">강의실</th>										
									</tr>
								</thead>
								<tbody>
									<tr>
										<td id="lec_name"></td>
										<td id="tutor_name"></td>
										<td id="term"></td>
										<td id="lecrm_name"></td>
									</tr>
								</tbody>							
							</table>
							<table class="col"> 
								<thead>
									<tr>
										<th class="left_content">출석 계획</th>
									</tr>
								</thead>
								<tbody>
									<tr>
										<td class="left_content" id="atd_plan">
											<textarea style="width:100%; border:0; resize:none;" readonly></textarea>
										</td>
									</tr>
								</tbody>
							</table>
							<table class="col"> 
								<thead>
									<tr>
										<th class="left_content">강의 목표</th>
									</tr>
								</thead>
								<tbody>
									<tr>
										<td class="left_content" id="lec_goal">
											<textarea style="width:100%; border:0; resize:none;" readonly></textarea>
										</td>
									</tr>
								</tbody>
							</table>
							
							<table class="col">
								<thead>
									<tr>
										<th class="left_content">진도</th>
									</tr>
								</thead>
								<tbody>
									<tr>
										<td class="left_content" id="progress">
<!-- 									<input type="button" id="svybtn2" value="설문 완료" style="float:right" class="hidden" disabled="disabled" />
 -->								 		<a class="btnType blue" href="javascript:fstartSurvey()" style="float:right" name="svybtn">
								 			<span id="svybtn" >설문 조사</span></a>
								 			<a class="btnType blue" href="" style="float:right" name="svybtn2">
								 			<span id="svybtn2">설문 완료</span></a> 
								 			
										</td>
									</tr>
								</tbody>
							</table>
							
							<table class="col" id=check>
								<thead>
									<tr>
									    <th scope="col">출석</th>
										<th scope="col">지각</th>
										<th scope="col">결석</th>
										<th scope="col">진행 상황</th>										
									</tr>
								</thead>
								<tbody>
									<tr>
									<td id="atd_cnt"></td>
									<td id="late_cnt"></td>
									<td id="absent_cnt"></td>
									<td id="cur_progress"></td>
									</tr>
								</tbody>								
							</table>
							
						</div>
					</div>
				<h3 class="hidden">풋터 영역</h3>
					<jsp:include page="/WEB-INF/view/common/footer.jsp"></jsp:include>
				</li>
			</ul>		
		</div>
	</div>
</form>

<!-- 모달팝업시작 -->
<form id="modalForm">
<input type="hidden" id="currentPage" value="1">
<input type="hidden" id="lec_id2" name="lec_id" value="${lec_id}"/>
  <div id="survey_modal" class="layerPop layerType2" style="width: 800px; ">
     <dl>
     	<dt>
			<strong>설문지</strong>
		</dt>
        <dd class="content" >
           <!-- s : 여기에 내용입력 -->
           <div class="sidescroll" style="height:700px; overflow: auto !important;">
           <table class="row" id="surveyQue">
           	<caption>caption</caption>
           	<tbody><!-- for문 --></tbody>
            </table>
           <table class="row" id="surveyRv">
          	<caption>caption</caption>
				<tr>
	             	<th scope="row" style="width: 357px;">Q10. 강의 리뷰(5자 이상) </th>
					<td colspan="6">
						<textarea class="inputTxt p100" name="lec_rv" id="lec_rv" placeholder="내용을 입력하세요" style="resize: none; padding: 5px;">
						</textarea>
					</td>
				</tr>
           </table>
		  </div>
          <!--  <div class="paging_area" id="Pagination_svy"></div> -->
           <!-- e : 여기에 내용입력 -->
           <div class="btn_areaC mt30">
              <a href="javascript:fsubmitSvy()" class="btnType blue" id="btnSaveSvy" name="btn"><span>제출</span></a> 
              <a href="" class="btnType gray" id="btnClose" name="btn"><span>닫기</span></a>
           </div>
        </dd>
     </dl>
     <a href="" class="closePop"><span class="hidden">닫기</span></a>
  </div>
  </form> 
<!-- 모달팝업끝 -->

</body>
</html>