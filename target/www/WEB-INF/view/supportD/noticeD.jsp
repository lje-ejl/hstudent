<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html>
<head>
<title> 강사가 보는 공지사항  </title>

<jsp:include page="/WEB-INF/view/common/common_include.jsp"></jsp:include>

<script type="text/javascript">

	// 페이징 설정 
	var noticePageSize = 10;    	// 화면에 뿌릴 데이터 수 
	var noticePageBlock = 5;		// 블럭으로 잡히는 페이징처리 수
	
	/* onload 이벤트  */
	$(function(){
		// 자유게시판 리스트 뿌리기 함수 
		selectNoticeList();
		
		// 버튼 이벤트 등록 (저장, 수정, 삭제, 모달창 닫기)
		fButtonClickEvent();
	});
	
	/* 버튼 이벤트 등록 - 저장, 수정, 삭제  */
	function fButtonClickEvent(){
		$('a[name=btn]').click(function(e){
			e.preventDefault(); // ?? 
					
			var btnId = $(this).attr('id');
			
			//alert("btnId : " + btnId);
			
			switch(btnId){
			case 'btnSaveNotice' : 
				fSaveNotice(); // save 안에 저장,수정
				break;
				
			case 'btnDeleteNotice' : 
				fDeleteNotice();	// 만들자 	
				break;
				
			case 'btnClose' :
				gfCloseModal();  // 모달닫기 
			    selectNoticeList(); // 첫페이지 다시 로딩 
				break;
			
			case 'btnUpdateNotice' : 
				fUpdateNotice();  // 수정하기
				break;
				
			case 'searchBtn' : 
				board_search();  // 검색하기
				//selectNoticeList();
			    break;
			
				
			//case 'commentWrite' : fCommentInsert();   // 댓글--> 답변글로 변경 // 저장 
				//break;
			}
		});
	}
	
	/*유효성 체크 함수*/
	function fValidateCheck(){
		
	   var chk = checkNotEmpty(
	              [
	            	  ["title","제목을 입력해주세요."]
	            	 ,["from_date","조회기간을 설정해주세요."]
	            	 ,["to_date","조회기간을 설정해주세요."]
	              ]		   
	   );
	   
	   if(!chk){
		   return;
	   }
	   
	   return true;
		
	}//fValidateCheck
	
	/* 공지사항 리스트 불러오기  */
	function selectNoticeList(currentPage){
		
		currentPage = currentPage || 1;   
		
		     var title = $('#title');
	         var from_date = $('#from_date');
	         var to_date = $('#to_date');

		var param = {
				       title : title.val()
	               ,   from_date : from_date.val()
	               ,   to_date : to_date.val()
				   ,   currentPage : currentPage 
				   ,   pageSize : noticePageSize 
		}
		
		var resultCallback = function(data){  // 데이터를 이 함수로 넘깁시다. 
			noticeListResult(data, currentPage); 
		}
		
		callAjax("/supportD/noticeList.do","post","text", true, param, resultCallback);
		
	}

	 /* 공지사항 리스트 data를 콜백함수를 통해 뿌려봅시당   */
	 function noticeListResult(data, currentPage){
		 
		 // 일단 기존 목록을 삭제합니다. (변경시 재부팅 용)
		 $("#noticeList").empty();
		 //alert("데이터!!! " + data);
		 //console.log("data !!!! " +  data);
		 
		 //var $data = $( $(data).html() ); // data의 .html()통해서 html구문을 끌어온다.
		 //alert("데이터 찍어보자!!!! " +  $data); // object
		 
		 $("#noticeList").append(data);
	
		
		 
		 // 리스트의 총 개수를 추출합니다. 
		 //var totalCnt = $data.find("#totalCnt").text();
		 var totalCnt = $("#totalCnt").val();  // qnaRealList() 에서보낸값 
	     //alert("totalCnt 찍어봄!! " + totalCnt);
		 
		 
         if(totalCnt==null || totalCnt==0){
			 alert("데이터가 없습니다.");
			 return;
		 }
         
         
		 
		 // * 페이지 네비게이션 생성 (만들어져있는 함수를 사용한다 -common.js)
		 // function getPaginationHtml(currentPage, totalCount, pageRow, blockPage, pageFunc, exParams)
		 // 파라미터를 참조합시다. 
	     var list = $("#tmpList").val();
		 //var listnum = $("#tmpListNum").val();
	     var pagingnavi = getPaginationHtml(currentPage, totalCnt, noticePageSize,noticePageBlock, 'selectNoticeList',[list]);
		 
	     console.log("pagingnavi : " + pagingnavi);
		 // 비운다음에 다시 append 
	     $("#pagingnavi").empty().append(pagingnavi); // 위에꺼를 첨부합니다. 
		 
		 // 현재 페이지 설정 
	    $("#currentPage").val(currentPage);
		 
	 }
	 
     //검색  
	 function board_search(currentPage) {
	      
	         //유효성 체크함수 불러오기
		     if( ! fValidateCheck() ){
		 		 return;
		 	 }
	         
	         var title = $('#title');
	         var from_date = $('#from_date');
	         var to_date = $('#to_date');
	         
	         currentPage = currentPage || 1;
	         
	         var param = {
	                   title : title.val()
	               ,   from_date : from_date.val()
	               ,   to_date : to_date.val()
	               ,   currentPage : currentPage
	               ,   pageSize : noticePageSize
	         }
	         
	         var resultCallback = function(data) {
	        	 noticeListResult(data, currentPage); 
	         };
	         
	         callAjax("/supportD/noticeList.do", "post", "text", true, param, resultCallback);
	         
	         alert("검색되었습니다.");
	   } 
	 
	 
	 /* 공지사항 모달창(팝업) 실행  */
	 function fNoticeModal(nt_no) {
		 
		 // 신규저장 하기 버튼 클릭시 (값이 null)
		 if(nt_no == null || nt_no==""){
			// Tranjection type 설정
			//alert("넘을 찍어보자!!!!!!" + nt_no);
			
			$("#action").val("I"); // insert 
			frealPopModal(nt_no); // 공지사항 초기화 
			
			//모달 팝업 모양 오픈! (빈거) _ 있는 함수 쓰는거임. 
			gfModalPop("#notice");
			
		 }else{
			// Tranjection type 설정
			$("#action").val("U");  // update
			fdetailModal(nt_no); //번호로 -> 공지사항 상세 조회 팝업 띄우기
		 }

	 }
	 
	 
	 /*공지사항 상세 조회*/
	 function fdetailModal(nt_no){
		 //alert("공지사항 상세 조회  ");
		 
		 var param = {nt_no : nt_no};
		 var resultCallback2 = function(data){
			 fdetailResult(data);
		 };
		 
		 callAjax("/supportD/detailNoticeList.do", "post", "json", true, param, resultCallback2);
		 //alert("공지사항 상세 조회  22");
	 }
	 
	 /*  공지사항 상세 조회 -> 콜백함수   */
	 function fdetailResult(data){

		 //alert("공지사항 상세 조회  33");
		 if(data.resultMsg == "SUCCESS"){
			 //모달 띄우기 
			 gfModalPop("#notice");
			 
			// 모달에 정보 넣기 
			frealPopModal(data.result);
		 
		 }else{
			 alert(data.resultMsg);
		 }
	 }
	 
	 /* 팝업 _ 초기화 페이지(신규) 혹은 내용뿌리기  */
	 function frealPopModal(object){
		 
		 if(object == "" || object == null || object == undefined){
			 var writer = $("#swriter").val();
			 //var Now = new Date();
			 
			 $("#loginID").val(writer);
			 $("#loginID").attr("readonly", true);
			 
			 $("#write_date").val();
			 
			 $("#nt_title").val("");
			 $("#nt_note").val("");
			 
			 $("#btnDeleteNotice").hide(); // 삭제버튼 숨기기
			 $("#btnUpdateNotice").hide();
			 $("#btnSaveNotice").hide(); 
			
			 
		 }else{
			 
			 //alert("숫자찍어보세 : " + object.wno);// 페이징 처리가 제대로 안되서 
			 $("#loginID").val(object.loginID);
			 $("#loginID").attr("readonly", true); // 작성자 수정불가 
			 
			 $("#write_date").val(object.write_date);
			 $("#write_date").attr("readonly", true); // 처음 작성된 날짜 수정불가 
			 
			 $("#nt_title").val(object.nt_title);
			 $("#nt_title").attr("readonly", true);
			 
			 $("#nt_note").val(object.nt_note);
			 $("#nt_note").attr("readonly", true);

			 
			 $("#nt_no").val(object.nt_no); // 중요한 num 값도 숨겨서 받아온다. 
			 
			 $("#btnDeleteNotice").hide();  // 삭제버튼 보이기 
			 $("#btnSaveNotice").hide();
			 //$("#btnUpdateNotice").css("display","");
			 //if문써서 로그인 아이디 == 작성자 아이디 일치시  --- 추가하기 
			 //$("#grp_cod").attr("readonly", false);  // false, true(읽기만)로 수정
			
			 
		 }
	 }
	 
	 
	 /* 팝업내 수정, 저장 validation */
	 function fValidatePopup(){
		 var chk = checkNotEmpty(
				 [
					 ["subject", "제목을 입력해주세요!"],
					 ["content", "내용을 입력해주세요!"]
				 ]
		 );
	 
	 	if(!chk){return;}
	 	return true;
	 }
	 
	 /* 공지사항 등록(저장) */
	 function fSaveNotice(){
		 
		 //alert("저장 함수 타는지!!!!!?? ");
		 // validation 체크 
		 if(!(fValidatePopup())){ return; }
		 
		 var resultCallback3 = function(data){
			 fSaveNoticeResult(data);
		 };
		 
		 $("#action").val("I");  // insert
		 
		 callAjax("/system/noticeSave.do", "post", "json", true, $("#myNotice").serialize(), resultCallback3);
	 	// $("#myNotice").serialize() => 직렬화해서 name 값들을 그냥 넘김.
	 }
	 
	 
	 /* 저장 ,수정, 삭제 콜백 함수 처리  */   
	 function fSaveNoticeResult(data){
		 var currentPage = currentPage || 1; 
		 
		 if($("#action").val() != "I"){
			 currentPage = $("#currentPage").val();
		 }
		 
		 if(data.resultMsg == "SUCCESS"){
			 //alert(data.resultMsg);	// 받은 메세지 출력 
			 alert("저장 되었습니다.");
		 }else if(data.resultMsg == "UPDATE") {
			 alert("수정 되었습니다.");
		 }else if(data.resultMsg == "DELETE") {
			 alert("삭제 되었습니다.");
		 }else{
			 alert(data.resultMsg); //실패시 이거 탄다. 
			 alert("실패 했습니다.");
		 }
		 
		 gfCloseModal();	// 모달 닫기
		 selectNoticeList(currentPage); // 목록조회 함수 다시 출력 
		 frealPopModal();// 입력폼 초기화
	 }
	 
	 /* 공지사항 등록(수정) */
	 function fUpdateNotice(){
		 
		 //alert("수정  함수 타는지!!!!!?? ");
		 // validation 체크 
		 if(!(fValidatePopup())){ return; }
		 
		 var resultCallback3 = function(data){
			 fSaveNoticeResult(data);
		 };
		 
		 $("#action").val("U");  // update
		 
		 callAjax("/system/noticeSave.do", "post", "json", true, $("#myNotice").serialize(), resultCallback3);
	 	// $("#myQna").serialize() => 직렬화해서 name 값들을 그냥 넘김.
	 }
	 
	 /* 공지사항 게시판 1건 삭제 */
	 function fDeleteNotice(){
		 var con = confirm("정말 삭제하겠습니까? \n 삭제시 복구불가합니다."); 
		 if(con){
			 var resultCallback3 = function(data){
				 fSaveNoticeResult(data);
			 }
			 $("#action").val("D");  // delete
			 callAjax("/system/noticeSave.do", "post", "json", true, $("#myNotice").serialize(), resultCallback3);
			 // num만 넘겨도되지만 그냥 귀찮으니깐...^^... 
		 }else{
			 gfCloseModal();	// 모달 닫기
			 selectNoticeList(currentPage); // 목록조회 함수 다시 출력 
			 frealPopModal();// 입력폼 초기화
		 }
	 }
	 
	 
	
</script>


</head>
<body>
	<!-- ///////////////////// html 페이지  ///////////////////////////// -->

<form id="myNotice" action="" method="">
	
	<input type="hidden" id="currentPage" value="1">  <!-- 현재페이지는 처음에 항상 1로 설정하여 넘김  -->
	<input type="hidden" id="tmpList" value=""> <!-- ★ 이거뭐임??? -->
	<input type="hidden" id="tmpListNum" value=""> <!-- 스크립트에서 값을 설정해서 넘길거임 / 임시 리스트 넘버 -->
	<input type="hidden" name="action" id="action" value=""> 
	<input type="hidden" id="swriter" value="${writer}"> <!-- 작성자 session에서 java에서 넘어온값 -->

	<div id="wrap_area">

		<h2 class="hidden">header 영역</h2>
		<jsp:include page="/WEB-INF/view/common/header.jsp"></jsp:include>

		<h2 class="hidden">컨텐츠 영역</h2>
		<div id="container">
			<ul>
				<li class="lnb">
					<!-- lnb 영역 --> 
					<jsp:include page="/WEB-INF/view/common/lnbMenu.jsp"></jsp:include> <!--// lnb 영역 -->
				</li>
				<li class="contents">
					<!-- contents -->
					<h3 class="hidden">contents 영역</h3> <!-- content -->
					<div class="content">

						<p class="Location">
							<a href="#" class="btn_set home">메인으로</a> 
							<a href="#" class="btn_nav">학습지원</a> 
								<span class="btn_nav bold">공지 사항</span> 
								<a href="#" class="btn_set refresh">새로고침</a>
						</p>

						<p class="conTitle">
							<span>공지 사항 </span> <span class="fr"> 
								<%-- <c:set var="nullNum" value=""></c:set>
								<a class="btnType blue" href="javascript:fNoticeModal(${nullNum});" name="modal">
								<span>신규등록</span></a> --%>
							</span>
						</p>
						
					<!--검색창  -->
					<table width="100%" cellpadding="5" cellspacing="0" border="1"
                        align="left"
                        style="border-collapse: collapse; border: 1px #50bcdf;">
                        <tr style="border: 0px; border-color: blue">
                           <td width="100" height="25" style="font-size: 120%">&nbsp;&nbsp;</td>

                           <td width="50" height="25" style="font-size: 100%">제목</td>
                           <td width="50" height="25" style="font-size: 100%">
                            <input type="text" style="width: 120px" id="title" name="title"></td>                     
                           <td width="50" height="25" style="font-size: 100%">작성일</td>
                           <td width="50" height="25" style="font-size: 100%">
                            <input type="date" style="width: 120px" id="from_date" name="from_date"></td>
                           <td width="50" height="25" style="font-size: 100%">
                            <input type="date" style="width: 120px" id="to_date" name="to_date"></td>
                           <td width="110" height="60" style="font-size: 120%">
                           <a href="" class="btnType blue" id="searchBtn" name="btn"><span>검  색</span></a></td> 
                            <!-- <input type="button" value="검  색  " id="searchBtn" name="btn" class="test_btn1" 
                              style="border-collapse: collapse; border: 0px gray solid; background-color: #50bcdf; width: 70px; color: white"/> -->
                        </tr>
                     </table>    
						
						
						<div class="divComGrpCodList">
							<table class="col">
								<caption>caption</caption>
	
		                            <colgroup>
						                   <col width="50px">
						                   <col width="200px">
						                    <col width="60px">
						                   <col width="50px">
					                 </colgroup>
								<thead>
									<tr>
							              <th scope="col">공지 번호</th>
							              <th scope="col">공지 제목</th>
							              <th scope="col">공지 날짜</th>
							              <th scope="col">작성자</th>
							              
									</tr>
								</thead>
								<tbody id="noticeList"></tbody>
							</table>
							
							<!-- 페이징 처리  -->
							<div class="paging_area" id="pagingnavi">
								<div class="paging">
									<a class="first" href="javascript:selectNoticeList(1)">
									<span class="hidden">맨앞</span></a>
									<a class="pre" href="javascript:selectNoticeList(1)">
									<span class="hidden">이전</span></a>
									<strong>1</strong> 
									<a href="javascript:selectNoticeList(2)">2</a> 
									<a href="javascript:selectNoticeList(3)">3</a> 
									<a href="javascript:selectNoticeList(4)">4</a>
									<a href="javascript:selectNoticeList(5)">5</a>
									<a class="next" href="javascript:selectNoticeList(5)">
									<span class="hidden">다음</span></a>
									<a class="last" href="javascript:selectNoticeList(5)">
									<span class="hidden">맨뒤</span></a>
								</div>
							</div>
											
						</div>

		
					</div> <!--// content -->

					<h3 class="hidden">풋터 영역</h3>
						<jsp:include page="/WEB-INF/view/common/footer.jsp"></jsp:include>
				</li>
			</ul>
		</div>
	</div>


	<!-- 모달팝업 -->
	<div id="notice" class="layerPop layerType2" style="width: 600px;">
		<input type="hidden" id="nt_no" name="nt_no"> <!-- 수정시 필요한 num 값을 넘김  -->
		
		<dl>
			<dt>
				<strong>공지사항</strong>
			</dt>
			<dd class="content">
				<!-- s : 여기에 내용입력 -->
				<table class="row">
					<caption>caption</caption>

					<tbody>
						<tr>
							<th scope="row">작성자 <span class="font_red">*</span></th>
							<td><input type="text" class="inputTxt p100" name="loginID" id="loginID" /></td>
							<!-- <th scope="row">작성일<span class="font_red">*</span></th>
							<td><input type="text" class="inputTxt p100" name="write_date" id="write_date" /></td> -->
						</tr>
						<tr>
							<th scope="row">제목 <span class="font_red">*</span></th>
							<td colspan="3"><input type="text" class="inputTxt p100"
								name="nt_title" id="nt_title" /></td>
						</tr>
						<tr>
							<th scope="row">내용</th>
							<td colspan="3">
								<textarea class="inputTxt p100" name="nt_note" id="nt_note">
								</textarea>
							</td>
						</tr>
						
					</tbody>
				</table>

				<!-- e : 여기에 내용입력 -->

				<div class="btn_areaC mt30">
					<a href="" class="btnType blue" id="btnSaveNotice" name="btn"><span>저장</span></a> 
					<a href="" class="btnType blue" id="btnUpdateNotice" name="btn" style="display:none"><span>수정</span></a> 
					<a href="" class="btnType blue" id="btnDeleteNotice" name="btn"><span>삭제</span></a> 
					<a href=""	class="btnType gray"  id="btnClose" name="btn"><span>닫기</span></a>
				</div>
			</dd>

		</dl>
		<a href="" class="closePop"><span class="hidden">닫기</span></a>
	</div>
	
	


</form>

</body>
</html>
