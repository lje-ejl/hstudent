<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<title>JobKorea</title>
<link rel="stylesheet" type="text/css" href="${CTX_PATH}/css/admin/e_resumeControl.css">
<link rel="stylesheet" type="text/css" href="${CTX_PATH}/css/cmnt/surveyControl.css">
<jsp:include page="/WEB-INF/view/common/common_include.jsp"></jsp:include>
<!-- 차트 링크 -->
<link rel="stylesheet" type="text/css" href="https://cdn3.devexpress.com/jslib/20.2.3/css/dx.common.css" />
<link rel="stylesheet" type="text/css" href="https://cdn3.devexpress.com/jslib/20.2.3/css/dx.light.css" />
<script src="https://cdn3.devexpress.com/jslib/20.2.3/js/dx.all.js"></script>
<script type="text/javascript">

	var lec_pageSize = 5;
	var lec_pageBlockSize = 5;
	
	$(function() {
		first_Lec_Control();
	      $(".reply").hide();
	      
		// 학생 리스트  선택 체크박스 
 	    $("#checkall").click(function(){
	        if($("#checkall").prop("checked")){
	            $("input[name=check_E]").prop("checked",true);
	        }else{
	            $("input[name=check_E]").prop("checked",false);
	        }
	    });
		
	});
	// 기업 리스트 선택 체크박스 
	function check_All() {
        if($("#checkall_C").prop("checked")){
            $("input[name=check_C]").prop("checked",true);
        }else{
            $("input[name=check_C]").prop("checked",false);
        }
	}
	 // 강의 목록 1-1
	var search ="";
	function first_Lec_Control( currentPage ) {
	    currentPage = currentPage || 1;
	    var param = {
	       currentPage : currentPage,
	       pageSize    : lec_pageBlockSize,
	       search      : search
	       
	    }
	    var resultCallback = function(data) {
	    	Lec_List_Control(data, currentPage);
	    };
	    callAjax("/adm/c_resumeControl_Lec_List.do", "post", "text", true, param, resultCallback);
	}
	// 강의 목록 1-2
	function Lec_search() {
		search = $("#search").val();
		first_Lec_Control();
	}
	// 강의 목록 2
	function Lec_List_Control( data, currentPage ) {
	    $('#lec_List').empty().append(data);
	    var lec_Total = $("#lec_Total").val();
	    var paginationHtml = getPaginationHtml( currentPage, lec_Total, lec_pageSize, lec_pageBlockSize, 'first_Lec_Control');
	    $("#lec_List_Pagination").empty().append(paginationHtml);    
	 } 
	// 수강 학생 목록 1
	var lec_Id = "";
	var std_pageSize = 5;
	var std_pageBlockSize = 30;
	
	function std_List( lec_id , currentPage) {
		$(".reply").show();
		lec_Id      = lec_id;
	    currentPage = currentPage || 1;
	    std_page = currentPage
	    var param = {
	       currentPage : currentPage,
	       pageSize    : std_pageBlockSize,
	       lec_id      : lec_Id
	    }
	    var resultCallback = function(data) {
	    	std_List_Control(data, currentPage);
	    };
	    callAjax("/adm/c_resumeControl_Std_List.do", "post", "text", true, param, resultCallback);
	}	
	// 수강 학생 목록 1-2
	function std_List_Page( currentPage ) {
		std_List(lec_Id, currentPage);
	}
	
	// 수강 학생 목록 2
	function std_List_Control( data, currentPage ) {

	    if(data.length > 50){
		    $('#std_List').empty().append(data);
		    var std_List_btn = "<br><span class='fr'> <a class='btnType gray' href='javascript:email_rpstt_check()'><span id='searchEnter'>이메일 전송</span></a></span>";
		    $("#std_List_btn").empty().append(std_List_btn); 
		}else{
		    $('#std_List').empty();
		    $("#std_List_btn").empty();
	    }	    
	}
	// 학생 개인정보 1
	function std_Detail( stdId ) {
		
	    var param = {
	    		stdId : stdId
	 	    }
	    var resultCallback = function(data) {
			$('#layer1').empty().append(data);
			gfModalPop("#layer1");
	    };
	    callAjax("/adm/c_resumeControl_std_Detail.do", "post", "text", true, param, resultCallback);
	}	
	function popupclose() {		
		gfCloseModal();
	}
	// 기업 선택
	function email_rpstt_check(loginId){
	    var param = {
	    	loginId : loginId
	 	}
	    var resultCallback1 = function(data) {
	    	$('#layer2').empty().append(data);
			gfModalPop("#layer2");	    	
	    };
	    callAjax("/adm/c_email_rpstt_check.do", "post", "text", true, param, resultCallback1);
	}	
	// 이메일 전송 확인
	var std_Mail_List = [];
	var rps_Mail_List = [];
	
	function email_send_check(loginId){
		var std_mail_List = [];
		var rps_mail_List = [];
        $('input[name="check_E"]:checked').each(function(i){//체크된 리스트 저장
        	std_mail_List.push($(this).val());
        });
        $('input[name="check_C"]:checked').each(function(i){//체크된 리스트 저장
        	rps_mail_List.push($(this).val());
        });
        
        std_Mail_List = std_mail_List;
        rps_Mail_List = rps_mail_List;
	    var param = {
	    	std_mail_List   : std_mail_List,
	    	rps_mail_List   : rps_mail_List,
	    	lec_id          : lec_Id
	 	}
	    var resultCallback1 = function(data) {
	    	$('#layer1').empty().append(data);
			gfModalPop("#layer1");	    	
	    };
	    callAjax("/adm/c_resumeControl_Check.do", "post", "text", true, param, resultCallback1);
	}
	// 이메일 전송
	function email_send(loginId){
	    var param = {
	    	std_mail_List : std_Mail_List,
	    	rps_mail_List : rps_Mail_List,
	    	lec_id        : lec_Id
	 	}
	    var resultCallback1 = function(data) {
	    	 alert(data.msg);
	    	 popupclose();	    	
	    };
	    callAjax("/adm/c_email_send.do", "post", "json", true, param, resultCallback1);
	}	
	
	// 파일 다운로드
	function rs_download(rs_url) {
		var params = "";
		params += "<input type='hidden' name='rs_url' value='"+ rs_url +"' />";
		jQuery("<form action='/adm/c_download.do' method='post'>" + params+ "</form>").appendTo('body').submit().remove();
	}	
</script>
</head>
<body>
   <form id="myForm">
      <div id="mask"></div>
      <div id="wrap_area">
         <jsp:include page="/WEB-INF/view/common/header.jsp"></jsp:include>
         <div id="container">
            <ul>
               <li class="lnb"><jsp:include page="/WEB-INF/view/common/lnbMenu.jsp"></jsp:include></li>
               <li class="contents">
                  <h3 class="hidden">contents 영역</h3>
                  <div class="content">
                     <p class="Location">
                        <a href="#" class="btn_set home">메인으로</a> 
                        <a href="#" class="btn_nav">취업 관리</a> 
                        <span class="btn_nav bold">이력서 관리</span>
                        <a href="#" class="btn_set refresh">새로고침</a>
                     </p>
                     <div class="divComGrpCodList">
					  <p class="conTitle">               
						<span>이력서 관리</span>
 						<span class="fr"> 
 							 <span><b>강 의 명</b>&nbsp&nbsp </span> 
 							 <input type="text" id="search" name="searchWord_lec" class="searchWord_lec">
 						 	 <a class="btnType blue" href="javascript:Lec_search()" name="">
 								 <span id="searchEnter">검색</span>
 							 </a>
 						</span>
					  </p>                     
                        <table class="col">
                           <thead>
                              <tr>
                                 <th scope="col" colspan="5">강의 목록</th>
                              </tr>
                           </thead>
                           <caption>caption</caption>
                           <colgroup>
                              <col width="5%">
                              <col width="15%">
                              <col width="8%">
                              <col width="8%">
                              <col width="14%">
                           </colgroup>
                           <thead>
                              <tr>
                                 <th scope="col">강의 번호</th>
                                 <th scope="col">강의명</th>
                                 <th scope="col">담당 교수</th>
                                 <th scope="col">수강 인원</th>
                                 <th scope="col">개강일  / 종강일</th>
                              </tr>
                           </thead>
                           <tbody id="lec_List"></tbody>
                        </table>
                     </div>
                     <div class="paging_area" id="lec_List_Pagination"></div>
                     <br><br><br>
 
					<!-- 학생 목록  -->
                     <div class="divComGrpCodList reply">                   
                        <table class="col">
                           <thead>
                              <tr>
                                 <th scope="col" colspan="7">수강 학생 목록</th>                       
                              </tr>
                           </thead>
                           <caption>caption</caption>
                           <colgroup>
                              <col width="5%">
                              <col width="5%">
                              <col width="10%">
                              <col width="8%">
                              <col width="8%">
                              <col width="14%">
                              <col width="14%">
                           </colgroup>
                           <thead>
                              <tr>
                                 <th scope="col"><input type="checkbox" id="checkall" checked /></th>
                                 <th scope="col">학생 이름</th>
                                 <th scope="col">학생  id</th>
                                 <th scope="col">학생 전화번호</th>
                                 <th scope="col">이메일</th>
                                 <th scope="col">취업 여부</th>
                                 <th scope="col">이력서</th>
                              </tr>
                           </thead>
                           <tbody id="std_List"></tbody>
                        </table>
                        <div class="std_List_btn" id="std_List_btn" style="height: 58px">
                     </div>
                     </div>                     
                     <br><br><br>                                                              
                  </div> <!--// content -->
                  <h3 class="hidden">풋터 영역</h3> 
                  <jsp:include page="/WEB-INF/view/common/footer.jsp"></jsp:include>
               </li>
            </ul> 
         </div>
      </div>
   </form>
   <form>
      <div id="layer1" class="layerPop layerType2" style="width: 600px;"></div>
   </form>
   <form>
      <div id="layer2" class="layerPop layerType2" style="width: 1500px;"></div>
   </form>
</body>
</html>