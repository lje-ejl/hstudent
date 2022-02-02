<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<title>JobKorea</title>
<link rel="stylesheet" type="text/css" href="${CTX_PATH}/css/cmnt/surveyControl.css">
<jsp:include page="/WEB-INF/view/common/common_include.jsp"></jsp:include>
<!-- 차트 링크 -->
<link rel="stylesheet" type="text/css" href="https://cdn3.devexpress.com/jslib/20.2.3/css/dx.common.css" />
<link rel="stylesheet" type="text/css" href="https://cdn3.devexpress.com/jslib/20.2.3/css/dx.light.css" />
<script src="https://cdn3.devexpress.com/jslib/20.2.3/js/dx.all.js"></script>
<style type="text/css">
.searchWord_lec{
	height: 28px;
}
</style>
<script type="text/javascript">
   
   var pageSize = 5;
   var pageBlockSize = 5;
   
   $(function() {
      first_TutList();
      $(".reply1").hide();
      $(".reply2").hide();
   });
   

   // 강사  검색 
    var search ="";
	function Lec_search() {
		search = $("#search").val();
		first_TutList();
	}

   // 강사 리스트	   
   function first_TutList(currentPage) {
      currentPage = currentPage || 1;
      var param = {
    	 searchWord  : search,
         currentPage : currentPage,
         pageSize    : pageSize
      }
      var resultCallback = function(data) {
         first_tut_List(data, currentPage);
      };
      callAjax("/adm/c_surveyControl1.do", "post", "text", true, param, resultCallback);
   }
   
   function first_tut_List(data, currentPage) {
      $('#tutor_List').empty().append(data);
      var tut_Total = $("#tut_Total").val();
      var paginationHtml = getPaginationHtml(currentPage, tut_Total, pageSize, pageBlockSize, 'first_TutList');
      $("#tut_List_Pagination").empty().append( paginationHtml );
   }
   
   
   // 강의 리스트
   var lec_pageSize = 5;
   var lec_pageBlockSize = 5;
   var tutor_Id;
   
   function tut_Lec_List(tutor_id, currentPage) {
	
	  $(".reply1").show();
	   
	  // 새로운 강의 눌렀을 때 기존 차트 지워주기
	  for( var i=1; i<10; i++ ){ $("#chart"+i).empty(); }	   
	  $('#survery_Detail10').empty()
	  $("#survery10_Pagination").empty()
	
      tutor_Id = tutor_id;
      currentPage = currentPage || 1;
      var param = {
         currentPage : currentPage,
         pageSize    : pageSize,
         tutor_id    : tutor_id
      }
      var resultCallback = function(data) {
         tut_Lec_List1(data, currentPage);
      };
      callAjax("/adm/c_lecList.do", "post", "text", true, param, resultCallback);
   }
   
   function Tut_Lec_List(currentPage) {
      tut_Lec_List(tutor_Id, currentPage);
   }
   
   function tut_Lec_List1(data, currentPage) {
      $('#lec_List').empty();
      $('#lec_List').append(data);
      var lec_Total = $("#lec_Total").val();
      var paginationHtml = getPaginationHtml(currentPage, lec_Total, lec_pageSize, lec_pageBlockSize, 'Tut_Lec_List');
      $("#lec_List_Pagination").empty().append( paginationHtml );
   }
   
   
	// 1번 문항
	function c_surveryDetail(lec_id, i) {
		$(".reply2").show();
		var param = {
			lec_id  : lec_id,
			que_num : i
		}
		var resultCallback = function(data) {
			$("#chart"+i).dxChart({
		        dataSource   : data.result,
		        palette      : "Material",
		        title: {
		            text     : " [ "+ i + "번 문항 ]",
		            subtitle : data.que
		        },
		        commonSeriesSettings: { 
		            type             : "bar",
		            valueField       : "ivalue",
		            argumentField    : "svalue",
		            ignoreEmptyPoints: true
		        },
		        seriesTemplate: {
		            nameField : "svalue"
		        }
		    });
		};
		callAjax("/adm/c_survey.do", "post", "json", true, param, resultCallback);
	}

	function c_surveryDetail_1(lec_id) {
		for( var i=1; i<10; i++ ){
			c_surveryDetail(lec_id,i);
		}
		c_surveryDetail_10(lec_id,1);
	}   
  
	// 10번 
	var survery_PageBlockSize = 5;
	var survery_Page          = 5;
	var lec_Id;
	
	function c_surveryDetail_10(lec_id, currentPage) {
		currentPage = currentPage || 1;
		lec_Id = lec_id;
		var param = {
			lec_id      : lec_id,
			currentPage : currentPage,
			pageSize    : survery_PageBlockSize
			
		}
		var resultCallback = function(data) {
			SurveryDetail_10( currentPage, data );
		};
		callAjax("/adm/c_survery_Detail10.do", "post", "text", true, param, resultCallback);
	}	
	
	function SurveryDetail_10(currentPage, data) {
		$('#survery_Detail10').empty().append(data);
		var survery10_Total = $("#survery10_Total").val();
		var paginationHtml  = getPaginationHtml(currentPage, survery10_Total, survery_Page, survery_PageBlockSize, 'c_SurVeryDetail_10');
		$("#survery10_Pagination").empty().append(paginationHtml);
	}
	
	function c_SurVeryDetail_10(currentPage) {
		c_surveryDetail_10(lec_Id, currentPage);
	}
	

</script>
<style type="text/css">
.rev{
	text-align: left !important;
}
</style>
</head>
   <form id="myForm">
	<div id="mask"></div>
      <div id="wrap_area">
         <jsp:include page="/WEB-INF/view/common/header.jsp"></jsp:include>
         <div id="container">
            <ul>
               <li class="lnb"><jsp:include
                     page="/WEB-INF/view/common/lnbMenu.jsp"></jsp:include></li>
               <li class="contents">
                  <h3 class="hidden">contents 영역</h3>
                  <div class="content">
                     <p class="Location">
                        <a href="#" class="btn_set home">메인으로</a> 
                        <a href="#" class="btn_nav">커뮤니티</a> 
                        <span class="btn_nav bold">설문조사 관리</span>
                        <a href="#" class="btn_set refresh">새로고침</a>
                     </p>
                      <!-- 강사 내역  -->
                     <div class="divComGrpCodList">
                     <p class="conTitle">
                        <span>설문조사 관리 </span>
 						<span class="fr"> 
 							 <span><b>강 사 명</b>&nbsp&nbsp </span> 
 							 <input type="text" id="search" name="searchWord_lec" class="searchWord_lec">
 						 	 <a class="btnType blue" href="javascript:Lec_search()" name="">
 								 <span id="searchEnter">검색</span>
 							 </a>
 						</span>                     
                     </p>
                        <table class="col">
                           <caption>caption</caption>
                           <colgroup>
                              <col width="10%">
                              <col width="10%">
                              <col width="10%">
                              <col width="10%">
                              <col width="10%">
                           </colgroup>
                           <thead>
                              <tr>
                                 <th scope="col">강사 ID</th>
                                 <th scope="col">강사명</th>
                                 <th scope="col">강사 전화번호</th>
                                 <th scope="col">강사 이메일 </th>
                                 <th scope="col">강의 가입일</th>
                              </tr>
                           </thead>
                           <tbody id="tutor_List"></tbody>
                        </table>
                        
                     </div>
                     <div class="paging_area" id="tut_List_Pagination"></div>
                     <br><br><br>
                     <!-- 강의 내역  -->
                     <div class="divComGrpCodList reply1">
                        <table class="col">
                           <caption>caption</caption>
                           <colgroup>
                              <col width="10%">
                              <col width="10%">
                              <col width="10%">
                              <col width="10%">
                              <col width="10%">
                           </colgroup>
                           <thead>
                              <tr>
                                 <th scope="col">과목</th>
                                 <th scope="col">강사명</th>
                                 <th scope="col">강의 시작일</th>
                                 <th scope="col">강의 종료일</th>
                                 <th scope="col">설문 인원 / 수강 인원</th>
                              </tr>
                           </thead>
                           <tbody id="lec_List"></tbody>
                        </table>
                        <div class="paging_area" id="lec_List_Pagination"></div>
                     </div>
                    
					<div class="demo-container"><br><br><br><div id="chart1"></div></div>
					<div class="demo-container"><br><br><br><div id="chart2"></div></div>
					<div class="demo-container"><br><br><br><div id="chart3"></div></div>
					<div class="demo-container"><br><br><br><div id="chart4"></div></div>
					<div class="demo-container"><br><br><br><div id="chart5"></div></div>
					<div class="demo-container"><br><br><br><div id="chart6"></div></div>
					<div class="demo-container"><br><br><br><div id="chart7"></div></div>
					<div class="demo-container"><br><br><br><div id="chart8"></div></div>
					<div class="demo-container"><br><br><br><div id="chart9"></div></div>
							
					<!-- 설문 조사 10번 -->
					<br><br><br>
						<div class="reply2"> 
							<p class="conTitle">              
								<span>본 교육을 통해 유익했던 점이나 개선할 점</span>
							</p>
							<table class="col">
								<caption>caption</caption>
								<colgroup>
									<col width="40%">
								</colgroup>
								<thead>
								</thead>
								<tbody id="survery_Detail10"></tbody>
							</table>
							<div class="paging_area" id="survery10_Pagination"></div>
					</div>  
					
				</div> 
				<h3 class="hidden">풋터 영역</h3> 
				<jsp:include page="/WEB-INF/view/common/footer.jsp"></jsp:include>
			</li>
		</ul> 
	   </div>
	 </div>
   </form>
</body>
</body>
</html>