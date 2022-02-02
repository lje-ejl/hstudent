<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<title>JobKorea</title>

<jsp:include page="/WEB-INF/view/common/common_include.jsp"></jsp:include>
<style type="text/css">
   .cursorArea{
      cursor: pointer;
   }

</style>
<script type="text/javascript">

	//등록된 학생 목록 페이징
	var pageSizeEmp = 5;
	var pageBlockSizeEmp = 5;
	
	//등록할 학생 목록 페이징
	var pageSizeStd = 5;
	var pageBlockSizeStd = 5;
	
	var sa; //서치값_취업정보 목록
	var sa2; //서치값_학생목록 
	var emp; //이력서등록된 학생 목록
	var std;//학생 목록
	var std_sel; //학생 프로필
	var in_emp; //이력서 등록
	var list_sel; //학생 강의 프로필

	$(document).ready(function() {
		
		$('#lec').hide();
		$('#lec_list').hide();
		$('#lec_list2').hide();
	
		init();
		// 이력서 목록 조회
		fListEmp();
		//등록할 학생 목록
		fListStd();
		// 버튼 이벤트 등록
		fRegisterButtonClickEvent();
		
	});
	
	function fRegisterButtonClickEvent() {
		$('a[name=btn]').click(function(e) {
			e.preventDefault();

			var btnId = $(this).attr('id');

			switch (btnId) {
				case 'btnSaveEmp' :
					fSaveEmp();
					break;
				case 'btnCloseEmp' :
					gfCloseModal();
					break;
			}
		});
	}
	
	//초기 함수
	function init(){
		
		sa = new Vue({
								el:'#searcharea',
								data:{
									 	searchKey: 'all'
										,searchWord : ''
										}
								});
		
		sa2 = new Vue({
								el:'#searcharea2',
								data:{
									 	searchKey2: 'all'
										,searchWord2 : ''
										}
			});
		
		emp = new Vue({
								el:'#div_emp_list',
								data:{
										items:[]
								},
								methods:{
									b_profile:function(loginID){
										fStdSel(loginID)
										/* fInitFormEmp(loginID); */
									},b_update_emp:function(employ_id){
											//단건 조회 함수
											fEmpSel(employ_id)
										},
									b_del_emp:function(employ_id){
											//단건 삭제 함수
											fEmpdel(employ_id)
										}
								}
		});	//emp 끝

		std = new Vue({
									el:'#div_std_list',
									data:{
											items:[]
										   ,	loginID:''
										   ,name:''
										   ,tel:''
										   
									}
									,methods:{
										b_profile:function(loginID){
											fStdSel(loginID)
										},b_insert_emp:function(loginID,tel,name){
											//alert(loginID);
											this.loginID = loginID;
											this.tel = tel;
											this.name = name;
											fInitFormEmp();
										}
									}
		}); //std 끝
		
		//이력서 등록 폼
		in_emp = new Vue({
										el:'#in_emp_form',
										data:{
										 name:''
										,std_id:''
										,employ_id:''
										,comp_name:''
										,employ_day:''
										,resign_day:''
										,tel:''
										,wp_state:''
										,loginID:''
										,comp_etc:''
										}
								});
		//날짜 함수
		$("#resign_day").datepicker({defaultDate: $.datepicker.formatDate('yyyy.mm.dd', new Date())});
		$("#employ_day").datepicker({ dateFormat: 'yyyy.mm.dd' }).bind("change",function(){
	      var minValue = $(this).val();
	      minValue = $.datepicker.parseDate("yyyy.mm.dd", minValue);
	      minValue.setDate(minValue.getDate()+1);
	      $("#resign_day").datepicker( "option", "minDate", minValue );
	  });
		//학생 프로필 조회
		std_sel = new Vue({
			 el: '#profile',
			  data: {
				  		items:[]
					   ,loginID:''
				       ,std_num: ''
				       ,name:''
					   ,birth: '' 
					   ,tel: '' 
					   ,sex: '' 
					   ,addr: ''
					   ,mail:''
					   ,state:''
					   ,total:''
			  }
		});
	};//init함수 끝	
	
	function fListEmp(currentPage){
		currentPage = currentPage || 1;
		
		var param = {
				currentPage : currentPage
			,	pageSize : pageSizeEmp
			,   searchKey : sa.searchKey
			,   searchWord : sa.searchWord
		}
		var resultCallback = function(data){
			fListEmpResult(data, currentPage);
		};
		callAjax("/adm/listEmp.do", "post", "json", true, param, resultCallback);
		
		}
	
	//이력서 학생 조회 콜백
	function fListEmpResult(data, currentPage){
		emp.items = [];
		emp.items = data.list_emp;

		var totalCntEmp = data.totalCount;
		var paginationHtml = getPaginationHtml(currentPage, totalCntEmp, pageSizeEmp, pageBlockSizeEmp, 'fListEmp');
		$("#empPagination").empty().append( paginationHtml );
		//$("#currentPageCourse").val(currentPage);  
	}
	//미등록 학생
	function fListStd(currentPage){
		currentPage = currentPage || 1;
		
		var param = {
				currentPage : currentPage
			,	pageSize : pageSizeStd
			,   searchKey2 : sa2.searchKey2
			,   searchWord2 : sa2.searchWord2
		}
		var resultCallback = function(data){
			fListStdResult(data, currentPage);
		};
		
		callAjax("/adm/listEmpStd.do", "post", "json", true, param, resultCallback);
		
		}
	
	//미등록 학생 콜백
	function fListStdResult(data, currentPage){
		std.items = [];
		std.items = data.list_std;
		console.log(std.items);
		
		var totalCntStd = data.totalCount;
		var paginationHtml = getPaginationHtml(currentPage, totalCntStd, pageSizeStd, pageBlockSizeStd, 'fListStd');
		
		console.log("paginationHtml : " + paginationHtml);
		
		$("#stdPagination").empty().append( paginationHtml );
		//$("#currentPageCourse").val(currentPage);  
		
	}
	
	//이력서 단건 조회
	function fEmpSel(employ_id){
		//console.log("이력서 id : " + employ_id + "std_num"+ std_num);
		var param = {
				 employ_id : employ_id
		}
		var resultCallback = function(data) {
			fEmpSelResult(data);
		};
		callAjax("/adm/SelEmp.do","post","json",true,param,resultCallback);
	}
	//이력서 단건 조회 콜백
	function fEmpSelResult(data){
		fInitFormEmp(data.sel_emp);
	} 
	
	//학생단건조회
	function fStdSel(loginID){
		
		var param = {
				loginID : loginID
		}
		var resultCallback = function(data) {
			fStdSelResult(data);
		};
		callAjax("/adm/SelStd.do","post","json",true,param,resultCallback);
	}
	

	function fStdSelResult(data){
			$('#lec').show();
			$('#lec_list').show();
			$('#lec_list2').show();
			fInitFormStd(data);
			console.log(data.total);
			$("#total").val(data.total);
			if(data.total == 0 ){
				$("#lec_div").show();
				$("#lec_div_2").hide();
			}else{
				$("#lec_div").hide();
				$("#lec_div_2").show();
			}
	} 

	function fSaveEmp(){
		var resultCallback = function(data) {
			fSaveEmpResult(data);
		};
		callAjax("/adm/saveEmp.do", "post", "json", true, $("#myForm").serialize(), resultCallback);
		
	}
	
	function fSaveEmpResult(data) {
		
		
		var currentPage = "1";
		if ($("#action").val() != "I") {
			currentPage = $("#currentPageCourse").val();
		}
		
		if (data.result == "SUCCESS") {
			
			// 응답 메시지 출력
			alert(data.resultMsg);
			
			// 입력폼 초기화
			fInitFormEmp();			
			
			/* $("#comp_etc").hide(); */
			
			// 모달 닫기
			gfCloseModal();
			
			emp.items=[];
			std.items=[];
			
			// 목록 조회
			fListEmp(currentPage);
			fListStd(currentPage);
			
		} else {
			// 오류 응답 메시지 출력
			alert(data.resultMsg);
		}
		
	}	
/** 과정 폼 초기화 */
function fInitFormStd(object) {
	$("#std_id").focus();
	   var sel_std = object.sel_std;
	  /*  var list_std_lec = object.list_std_lec; */
	   var list_lec = object.total; 
	   console.log(list_lec);
		std_sel.loginID= sel_std.loginID;
		std_sel.std_num =sel_std.std_num;
		std_sel.name = sel_std.name;
		std_sel.birth = sel_std.birth; 
		std_sel.tel = sel_std.tel; 
		std_sel.sex = sel_std.sex; 
		std_sel.addr = sel_std.addr; 
		std_sel.mail= sel_std.mail; 
		std_sel.state= sel_std.state; 
		
		$("#loginID_3").text(sel_std.loginID);
		$("#std_num_3").text(sel_std.std_num);
		$("#name_3").text(sel_std.name);
		$("#birth_3").text(sel_std.birth);
		$("#tel_3").text(sel_std.tel);
		$("#sex_3").text(sel_std.sex);
		$("#addr_3").text(sel_std.addr.replace(/,/gi, " "));
		$("#mail_3").text(sel_std.mail);
		$("#state_3").text(sel_std.state);
		
		std_sel .items = [];
		std_sel .items =object.list_std_lec;
		
	// 모달 팝업
	gfModalPop("#profile");
}


function fInitFormEmp(object) {
	
	if( object == "" || object == null || object == undefined) {	
		/* in_emp.name= std.name;	 */
		in_emp.employ_id = '';
		in_emp.comp_name = '';      
		in_emp.employ_day = '';
		in_emp.resign_day = '';
	/* 	in_emp.tel= std.tel; */
		in_emp.wp_state= '';
		in_emp.comp_etc = '';
		
		$("#name_2").text(std.name);
		$("#tel_2").text(std.tel);
		$("#std_id").css("background", "#FFFFFF");
		$("#std_id").focus();
		$("#btnDeleteCourse").hide();
		$("#loginID").val(std.loginID);
		$("#employ_id").val("");
		$("#action").val("I");
			
	}else {
	//여기
		
		/* $('#comp_name').val(object.comp_name);  */
		//in_emp.name= object.name;
		in_emp.employ_id = object.employ_id;
		in_emp.comp_name = object.comp_name; 
		in_emp.employ_day = object.employ_day; 
		in_emp.resign_day = object.resign_day; 
		in_emp.tel = object.tel; 
		in_emp.comp_etc =object.comp_etc;
		$("#loginID").val(std.loginID);
		$("#tel_2").text(object.tel);
		$("#name_2").text(object.name);
	
		console.log(object.comp_etc);
		
		if(object.resign_day != null){
			in_emp.wp_state='Y'; 
		}
		
		$("#std_id").css("background", "#F5F5F5");
		$("#std_id").focus();
		$("#btnDeleteCourse").show();
		$("#employ_id").val(object.employ_id);
		$("#action").val("U");
		
		
	}		
	// 모달 팝업
	gfModalPop("#in_emp_form");
}

function fPopModalProfile() {
		gfModalPop("#profile");	
	}

//제이쿼리로 엔터처리
$(document).on('keydown', '#searchWord', function(e) {
		   if(e.keyCode == 13){
		      fListEmp();
		   }
		});
		
$(document).on('keydown', '#searchWord2', function(e) {
	   if(e.keyCode == 13){
		   fListStd();
	   }
	});

//기타 값 입력받기

	function fEmpdel(employ_id){
	
	console.log ("이력서 정보 삭제"+ employ_id);
	
	var param = {
			employ_id : employ_id
	}
	var resultCallback = function(data){
		fSaveEmpResult(data);
	};
	
	callAjax("/adm/delEmp.do", "post", "json", true, param, resultCallback);
	}

 $(function(){
				$("#comp_etc").hide();
				$("#comp_name").change(function(){
					if($("#comp_name").val()=="기타"){
						$('#comp_name').val(''); 
						$("#comp_etc").show();
					}else{
						$("#comp_etc").hide();
					}
				});
			}); 

</script>
</head>
<body>
	<form id="myForm" action=""  method="">
		<input type="hidden" name="action" id="action" value="">
		<input type="hidden" name="currentPageCourse" id="currentPageCourse" value="">
		<input type="hidden" name="loginID" id="loginID" value="">
		<input type="hidden" name="total" id="total" value="">
		<input type="hidden" name="employ_id" id="employ_id" />
		
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
							<a href="#" class="btn_set home">메인으로</a> <a href="#"
								class="btn_nav">취업 관리</a> <span class="btn_nav bold">취업 정보 관리</span> <a href="javascript:location.reload();" class="btn_set refresh">새로고침</a>
						</p>
						
							<p class="conTitle" id="searcharea">
							<span>취업 정보</span> 
							 <span class="fr"> 
								<select id="searchKey" name="searchKey" style="width: 80px;" v-model="searchKey">
								    <option value="all" id="option1" selected="selected">전체</option>
									<option value="sName" id="option1">학생명</option>
									<option value="comName" id="option2">회사명</option>
								</select> 
								<input type="text" id="searchWord" name="searchWord" v-model="searchWord"
									placeholder="" style="height: 28px;"> <a
									class="btnType blue" href="javascript:fListEmp()"
									onkeydown="enterKey()" name="search"><span id="searchEnter">검색</span></a>							 
							</span>
						</p>	
						<!-- 학생 목록 -->	
							<div class="div_emp_list" id="div_emp_list">
							<table class="col">
								<caption>caption</caption>
								<colgroup>
									<col width="5%">
									<col width="10%">
									<col width="15%">
									<col width="15%">
									<col width="15%">
									<col width="10%">
									<col width="10%">
									<col width="20%">
								</colgroup>
								<thead>
									<tr>
									    <th scope="col">학번</th>
										<th scope="col">학생명</th>
										<th scope="col">연락처</th>
										<th scope="col">입사일</th>
										<th scope="col">퇴사일</th>
										<th scope="col">업체명</th>
										<th scope="col">재직여부</th>
										<th scope="col">수정/삭제</th>
									</tr>
								</thead>
								<tbody id="liststudent">
									<template v-for="(row, index) in items"  v-if="items.length">
										<tr>
											<td>{{ row.std_num }}</td>
											<td class="cursorArea"><a @click="b_profile(row.loginID)" ><strong>{{ row.name }}</strong></td>
											<td>{{ row.tel }}</td>
											<td>{{ row.employ_day }}</td>
											<td>{{ row.resign_day }}</td>
											<td>{{ row.comp_name }}</td>
											<td>{{ row.wp_state }}</td>
											<td align="center">
											    <table align="center" border=0>
											       <tr>
											          <p style="display: inline-block" class="btnType3 color1" @click="b_update_emp(row.employ_id)"><a class="btnType3 color1"><span id="searchEnter">수정</span></a></p>
											          <p style="display: inline-block; margin-left:5px;" class="btnType3 color1" @click="b_del_emp(row.employ_id)"><a class="btnType3 color1"><span id="searchEnter">삭제</span></a></p>
											       </tr>
											    </table>
											</td>
										</tr>
									</template>
								</tbody>
							</table>
						</div><!-- div_std_list -->
						
						<div class="paging_area"  id="empPagination"> </div>
							<p class="conTitle" id="searcharea2" style = "margin-top:3%" >
							<span>취업 정보 등록</span> 
							 <span class="fr"> 
								<select id="searchKey2" name="searchKey2" style="width: 80px;" v-model="searchKey2">
								    <option value="all" id="option1" selected="selected">전체</option>
									<option value="s_nm" id="option1">학생명</option>
									<option value="lec_nm" id="option2">강의명</option>
								</select> 
								<input type="text" id="searchWord2" name="searchWord2" v-model="searchWord2"
									placeholder="" style="height: 28px;"> <a
									class="btnType blue" href="javascript:fListStd()"
									onkeydown="enterKey()" name="search"><span id="searchEnter">검색</span></a>				
							</span>
						</p>	
						
						<!-- 미등록 학생 목록 // 추가 등록 가능하므로 등록 관계없이 모든 리스트 뽑기-->	
							<div class="div_std_list" id="div_std_list">
							<table class="col">
								<caption>caption</caption>
								<colgroup>
									<col width="10%">
									<col width="15%">
									<col width="30%">
									<col width="15%">
									<col width="15%">
									<col width="20%">
								</colgroup>
								<thead>
									<tr>
									    <th scope="col">학번</th>
										<th scope="col">학생명</th>
										<th scope="col">연락처</th>
										<th scope="col">강의명</th>
										<th scope="col">가입일자</th>
										<th scope="col">등록</th>
									</tr>
								</thead>
								<tbody id="liststudent">
									<template v-for="(row, index) in items"  v-if="items.length">
										<tr>
											<td>{{ row.std_num }}</td>
											<td class="cursorArea"><a @click="b_profile(row.loginID)" ><strong>{{ row.name }}</strong></a></td>
											<td>{{ row.tel}}</td>
											<td>{{ row.lec_name }}</td>
											<td>{{ row.join_date }}</td>
											<td align="center">
										    <table align="center" border=0>
										       <tr>
										          <p><a class="btnType3 color1"  @click="b_insert_emp(row.loginID,row.tel,row.name)" ><span>등록</span></a></p>
										       </tr>
										    </table>
											</td>
										</tr>
									</template>
								</tbody>
							</table>
						</div><!-- div_std_list -->
						
						<div class="paging_area"  id="stdPagination"> </div>

				</div><!-- content -->
			</li><!-- contents -->
		</ul>
	</div><!-- container -->
</div><!-- wrap_area -->
		
	<!-- 모달팝업 -->
<div id="in_emp_form" class="layerPop layerType2" style="width: 600px;">
		<dl>
			<dt>
				<strong>취업 등록</strong>
			</dt>
			<dd class="content">
				<!-- s : 여기에 내용입력 -->
				<table class="row">
					<caption>caption</caption>
					<colgroup>
						<col width="*">
						<col width="*">
						<col width="100px">
						<col width="*">
						<col width="*">
					</colgroup>

					<tbody>
						<tr>
						<th scope="row">학생명</th>
						<td id ="name_2"><input type="text" class="inputTxt p100" v-model="name" name="name" id="name" readonly />
								<input type="hidden" class="inputTxt p100" v-model="loginID" name="loginID" id="loginID" /> 
								<input type="hidden" class="inputTxt p100" v-model="wp_state" name="wp_state" id="wp_state" /></td>
						</tr>
						<tr>
							<th scope="row">회사명 <span class="font_red">*</span></th>
							<td id = "comp_name_2">
						
						<select id="comp_name"  name="comp_name"  class="inputTxt p100" v-model="comp_name" >
									<c:forEach items="${comp}" var="comp">
									<c:if test ="${comp.comp_name ne null}" >
									<option value="${comp.comp_name}">${comp.comp_name}</option>
									<%-- <option value="${comp.comp_etc}">${comp.comp_etc}</option> --%>
									</c:if>
									</c:forEach> 
									<option value="기타" >기타</option>
							</select>
				
						</td>
						</tr>
				
						<tr>  
							<th scope="row">연락처<span class="font_red">*</span></th>
							<td id = "tel_2">
								 <input type="text" class="inputTxt p100"  v-model="tel" name="tel" id="tel" readonly/>
							</td>				
						</tr>
						<tr>
							<th scope="row">입사일<span class="font_red">*</span></th>
							<td  id = "employ_day_2">
								 <input type="text" class="inputTxt p100" data-date-format='yyyy.mm.dd' v-model="employ_day" name="employ_day" id="employ_day" />
							</td>
							</tr>
							<tr>
							<th scope="row">퇴사일<span class="font_red">*</span></th>
							<td id ="resign_day_2">
							     <input type="text" class="inputTxt p100" data-date-format='yyyy.mm.dd' v-model="resign_day" name="resign_day" id="resign_day" />
							</td>					
						</tr>
					</tbody>
				</table>

				<div class="btn_areaC mt30">
					<a href="" class="btnType blue" id="btnSaveEmp" name="btn"><span>저장</span></a> 
					<a href=""	class="btnType gray"  id="btnCloseCourse" name="btn"><span>취소</span></a>
				</div>
			</dd>
		</dl>
		<a href="" class="closePop" id="btnCloseEmp" name="btn"><span class="hidden">닫기</span></a>
	</div>

	<!--// 모달팝업 -->							
						

	
<div id="profile" class="layerPop layerType2" style="width: 600px;">
         <dl>
            <dt>
               <strong>학생 정보</strong>
            </dt>
            <dd class="content" >
               <!-- s : 여기에 내용입력 -->
               <table class="row">
                  <caption>caption</caption>
                  <tbody>
                     <tr>
                        <th scope="row">ID</th>
                        <td id="loginID_3"><input type="text" class="inputTxt p100" id="loginID"  v-model="loginID" readonly /></td>
                        <th scope="row">학번</th>
                        <td id="std_num_3"><input type="text" class="inputTxt p100" id="std_num"  v-model="std_num" readonly /></td>
                     </tr>
                     <tr>
                        <th scope="row">이름</th>
                        <td id="name_3"><input type="text" class="inputTxt p100" id="name"  v-model="name" readonly /></td>
                        <th scope="row">생년월일</th>
                        <td id="birth_3">><input type="text" class="inputTxt p100" id="birth"  v-model="birth" readonly /></td>
                     </tr>
                     <tr>
                        <th scope="row">전화 번호</th>
                        <td  id="tel_3"><input type="text" class="inputTxt p100" id="tel"  v-model="tel" readonly /></td>
                        <th scope="row">성별</th>
                        <td id="sex_3"><input type="text" class="inputTxt p100" id="sex"  v-model="sex" readonly /></td>
                     </tr>
                     <tr>
                        <th scope="row">주소</th>
                        <td id="addr_3"><input type="text" class="inputTxt p100" id="addr"  v-model="addr" readonly /></td>
                        <th scope="row">이메일</th>
                        <td id = "mail_3"><input type="text" class="inputTxt p100" id="mail"  v-model="mail" readonly /></td>
                     </tr>
                 <tr>
                        <td colspan="6">
                           <p class="conTitle mt50">
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
                              <tbody id="listLec">
							<tr id = "lec_div"><td colspan="6">수강정보가 없습니다</td></tr>
								<template v-for="(row, index) in items"  v-if="items.length"> 
								   <tr id = "lec_div2"> 
								      <td>{{ row.lec_id }}</td>
								      <td>{{ row.lec_name }}</td>
								      <td>{{ row.c_st }} - {{ row.c_end }}</td>
								      <td>{{ row.state }}</td>
								 	 </tr>
								</template>
						 	</tbody>        
                           </table>
                        </td>
                     </tr>
                  </tbody>
               </table>
				
            </dd>
         </dl>
		<a href="" class="closePop" id="btnCloseEmp" name="btn"><span class="hidden">닫기</span></a>
	  
	</div>
	</form>
</body>
</html>