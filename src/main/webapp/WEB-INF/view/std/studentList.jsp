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

<script type="text/javascript">

	// 과정 페이징 설정
	var pageSizeStudent = 15;
	var pageBlockSizeStudent = 5;
	
	var svm;
	var vm;
	var cvm;
	var scvm;
	var livm;
	var crvm;
	var edvm;
	var skvm;
	
	var unstsearch = true;;
	
	/** OnLoad event */ 
	$(document).ready(function() {
		init();
		
		// 강의목록 조회
		fListstudent();
		
		// 버튼 이벤트 등록
		fRegisterButtonClickEvent();
	});
	
	/** 버튼 이벤트 등록 */
	function fRegisterButtonClickEvent() {
		$('a[name=btn]').click(function(e) {
			e.preventDefault();

			var btnId = $(this).attr('id');

			switch (btnId) {
				case 'btnSaveStudent' :
					fSaveStudent();
					break;
				case 'btnDeleteStudent' :
					fstudentformdel();
					break;
				case 'btnCloseStudent' :
					gfCloseModal();
					break;
			}
		});
	}
	
	function init() {
		
		//변수에 넣어서 가져다 쓰기 위해서 변수를 사용한거다.
		svm = new Vue({
		                           el: '#searcharea',  
		                         data: {
		                        	      searchKey : 'all'
		                        	     ,searchWord : ''		                        	    
		                               }
		            });
	    
		vm = new Vue({
			  el: '#divStudentList',
			  components: {
			    'bootstrap-table': BootstrapTable
			  },
			  data: {
			    items: []
			   ,loginid: ''
			  },
			  methods:{					
				  rowClicked:function(row){
					  
					  var tdArr = new Array(); // 배열
						
					  //현재 클릭된 Row(<tr>)
					  var tr = $(row);
					  var td = tr.children();
					
					  td.each(function(i){
						tdArr.push(td.eq(i).text());
					  });
					
					  console.log(tdArr);
					  
					  //console.log("tdArr[0] : " + tdArr[0]);
					  
					  this.loginid = tdArr[0];
					  
					  fselectstudent();
					  
					  
	                  //console.log(" 값 : "+this.loginid);	 
				  },  			  
				  coursemod:function(no){					  
					  fcoursesel(no);	
				  },
				  coursedel:function(no,scnt){					  
					  if(scnt > 0 || stvm.items.length > 0) {
						  alert("수강중인 학생이 있어  삭제 불가 합니다.");
					  } else {
						  // fcoursedel(no); 
					  }
				  }
			  }
			});	  		
		
		cvm = new Vue({
			  el: '#studentinfo',
			  data: {
				loginID : '' 
			   ,user_type : '' 
			   ,name : '' 
			   ,password : '' 
			   ,sex : '' 
			   ,age : ''
			   ,hp : '' 
			   ,tel1 : '' 
			   ,tel2 : '' 
			   ,tel3 : '' 
			   ,email : '' 
			   ,zipcd : '' 
			   ,addr : '' 
			   ,dtladdr : '' 
			   ,joinDate : '' 
			   ,file_name : '' 
			   ,file_path : '' 
			   ,file_size : 0
			   ,marride : ''
			   ,milservice : ''
			   ,anarm : ''
			   ,mil_str_date : ''
			   ,mil_end_date : ''
			   ,img_path : ''
			   ,newimg : ''
			  },
			  methods:{					
				  changeimg:function(event){
					  var file = event.target.files[0];
					  //alert(file.name);
					  this.img_path = window.URL.createObjectURL(file);
				  }
			  }
		
			});	

		scvm = new Vue({
			  el: '#schoolinfo',
			  components: {
			    'bootstrap-table': BootstrapTable
			  },
			  data: {
			    items: []
			  },
			  methods:{					
				  deletesc:function(id,seq){
					  alert(id = " : " + seq);
					  
					  //fselectstudent();
				  },
				  addsc:function(id){
					  alert(id = " : " + seq);
					  
					  //fselectstudent();
				  }
			  }
			});	 
		
		livm = new Vue({
			  el: '#licenseinfo',
			  components: {
			    'bootstrap-table': BootstrapTable
			  },
			  data: {
			    items: []
			  },
			  methods:{					
				  deleteli:function(id,seq){
					  alert(id = " : " + seq);
					  
					  //fselectstudent();
				  },
				  addli:function(id){
					  alert(id = " : " + seq);
					  
					  //fselectstudent();
				  }
			  }
			});	 
		
		crvm = new Vue({
			  el: '#carrerinfo',
			  components: {
			    'bootstrap-table': BootstrapTable
			  },
			  data: {
			    items: []
			  },
			  methods:{					
				  deletecr:function(id,seq){
					  alert(id = " : " + seq);
					  
					  //fselectstudent();
				  },
				  addcr:function(id){
					  alert(id = " : " + seq);
					  
					  //fselectstudent();
				  }
			  }
			});	 
		
		edvm = new Vue({
			  el: '#eduinfo',
			  components: {
			    'bootstrap-table': BootstrapTable
			  },
			  data: {
			    items: []
			  },
			  methods:{					
				  deleteed:function(id,seq){
					  alert(id = " : " + seq);
					  
					  //fselectstudent();
				  },
				  added:function(id){
					  alert(id = " : " + seq);
					  
					  //fselectstudent();
				  }
			  }
			});	 		
		
		
		skvm = new Vue({
			  el: '#skillinfo',
			  components: {
			    'bootstrap-table': BootstrapTable
			  },
			  data: {
			    items: []
			  },
			  methods:{					
				  deletesk:function(id,seq){
					  alert(id = " : " + seq);
					  
					  //fselectstudent();
				  },
				  addsk:function(id){
					  alert(id = " : " + seq);
					  
					  //fselectstudent();
				  }
			  }
			});	
		
		//$("#startdate").datepicker({defaultDate: $.datepicker.formatDate('yyyy.mm.dd', new Date())});
		$("#enddate").datepicker({defaultDate: $.datepicker.formatDate('yyyy.mm.dd', new Date())});
		$("#startdate").datepicker({ dateFormat: 'yyyy.mm.dd' }).bind("change",function(){
            var minValue = $(this).val();
            minValue = $.datepicker.parseDate("yyyy.mm.dd", minValue);
            minValue.setDate(minValue.getDate()+1);
            $("#enddate").datepicker( "option", "minDate", minValue );
        });
		
		
	};	
	
	
	/** 학생 조회 */
	function fListstudent(currentPage) {
		
		currentPage = currentPage || 1;
		
		console.log("currentPage : " + currentPage + " svm.searchKey : " + svm.searchKey + " svm.searchWord : " + svm.searchWord);
		
		var param = {
					currentPage : currentPage
				,	pageSize : pageSizeStudent
				,   searchKey : svm.searchKey
				,   searchWord : svm.searchWord
		}
		
		var resultCallback = function(data) {
			flistStudentResult(data, currentPage);
		};
		//Ajax실행 방식
		//callAjax("Url",type,return,async or sync방식,넘겨준거,값,Callback함수 이름)
		callAjax("/std/liststudent.do", "post", "json", true, param, resultCallback);
	}
	
	
	/** 학생 조회 콜백 함수 */
	function flistStudentResult(data, currentPage) {
		
		//alert(data);
		console.log(data);
		
		vm.items=[];
		vm.items=data.listStudent;		
		
		// 총 개수 추출
		var totalCntCourse = data.totalCount;

		// 페이지 네비게이션 생성
		var paginationHtml = getPaginationHtml(currentPage, totalCntCourse, pageSizeStudent, pageBlockSizeStudent, 'fListstudent');
		
		console.log("paginationHtml : " + paginationHtml);
		//alert(paginationHtml);
		$("#studentPagination").empty().append( paginationHtml );
		
		$("#currentPagestudent").val(currentPage);
		
	}
	
	/** 학생 한명 이력서  조회 */
	function fselectstudent() {		
		
		var param = {
					loginid : vm.loginid
		}
		
		var resultCallback = function(data) {
			fstudentselResult(data);
		};
		//Ajax실행 방식
		callAjax("/std/studentsel.do", "post", "json", true, param, resultCallback);
	}
	
	/** 학생  한건  조회 콜백 함수 */
	function fstudentselResult(data) {
		
		console.log("11111111111111 : " + JSON.stringify(data));
		//console.log("22222222222222 : " + JSON.stringify(data.courseinfo));
		//fInitFormCourse(data.studentinfo);
	}	
	
	/** 이력서 한건 버튼 */
	function fPopModalstudent() {
		$("#action").val("I");
		
		//$("#btnDeleteStudent").hide();
		
		//gfModalPop("#layer1");
		fInitFormStudent();
	}
	
	/** 학생 폼 초기화 */
	function fInitFormStudent(object) {
		$("#loginID").focus();
		
		if( object == "" || object == null || object == undefined) {			
			cvm.loginID = "";
			cvm.user_type = "";
			cvm.name = "";
			cvm.password = "";
			cvm.sex = "";
			cvm.age = "";
			cvm.hp = "";
			cvm.tel1 = "";
			cvm.tel2 = "";
			cvm.tel3 = "";
			cvm.email = "";
			cvm.zipcd = "";
			cvm.addr = "";
			cvm.dtladdr = "";
			cvm.joinDate = "";
			cvm.file_name = "";
			cvm.file_path = "";
			cvm.file_size = "";
			cvm.marride = "";
			cvm.milservice = "";
			cvm.anarm = "";
			cvm.mil_str_date = "";
			cvm.mil_end_date = "";	
			cvm.img_path = "/images/admin/comm/left_myImg.jpg";
			
			scvm.items = [];
			livm.items = [];
			crvm.items = [];
			edvm.items = [];
			skvm.items = [];
			
			$("#loginID").css("background", "#FFFFFF");
			$("#loginID").focus();
			$("#btnDeletStudent").hide();
			$("#action").val("I");
			
		} else {
			/* 
			cvm.no = object.no;
			cvm.title = object.title;
			cvm.teacher = object.teacher; 
			cvm.room = object.room; 
			cvm.startdate = object.startdate; 
			cvm.enddate = object.enddate;
			
			$("#title").css("background", "#F5F5F5");
			$("#title").focus();
			$("#btnDeleteCourse").show();
			
			$("#delCourseno").val(object.no);
			$("#Coursestudent").val(object.scnt);
			
			$("#action").val("U");
			 */
			
		}		
		// 모달 팝업
		gfModalPop("#layer1");
	}	
	
	/** 학생 저장         수정, 저장 그리드 팝업  *****************************************************/
	function fSaveStudent() {

		// vaildation 체크
		if ( ! fValidateStudent() ) {
			return;
		}
		
		var resultCallback = function(data) {
			fSaveStudentResult(data);
		};
		
		callAjax("/std/saveStudent.do", "post", "json", true, $("#myForm").serialize(), resultCallback);
	}
	

	/** 과정 삭제, 저장 콜백 함수 */
	function fSaveCourseResult(data) {
		
		// 목록 조회 페이지 번호
		var currentPage = "1";
		if ($("#action").val() != "I") {
			currentPage = $("#currentPageCourse").val();
		}
		
		if (data.result == "SUCCESS") {
			
			// 응답 메시지 출력
			alert(data.resultMsg);
			
			// 입력폼 초기화
			fInitFormCourse();			
			
			// 모달 닫기
			gfCloseModal();
			
			stvm.items=[];
			
			// 목록 조회
			fListcourse(currentPage);
			
		} else {
			// 오류 응답 메시지 출력
			alert(data.resultMsg);
		}
		
	}	
	
	/** 과정 저장 validation */
	function fValidateStudent() {

		var chk = checkNotEmpty(
				[
					    [ "loginID", "loginID를 입력해 주세요." ]
					,	[ "password", "비밀번호를 입력해 주세요." ]
					,	[ "name", "이름를 입력해 주세요." ]
					,	[ "age", "연령를 입력해 주세요." ] 	
					,	[ "sex", "설별를 입력해 주세요." ] 
					,	[ "hp", "연락처를 입력해 주세요." ] 					    
					,	[ "email", "이베일를 입력해 주세요." ] 	
					,	[ "addr", "주소를 입력해 주세요." ] 	   
				]
		);
		
		if (!chk) {
			return;
		}

		return true;
	}
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	

	
	function fPopModalcourse() {
		fInitFormCourse();		
	}
	

	
	/** 과정 한건  삭제 */
	function fcoursedel(no) {
		
		console.log("fcoursesel  no : " + no);
		
		var param = {
					no : no
		}
		
		var resultCallback = function(data) {
			fSaveCourseResult(data);
		};
		//Ajax실행 방식
		callAjax("/cur/coursedel.do", "post", "json", true, param, resultCallback);
	}
	
	/** 과정 폼 한건  삭제 */
	function fcourseformdel(no) {
		
		var delno = $("#delCourseno").val();
		var scnt = $("#Coursestudent").val();
		
		//console.log("delno " + delno + "scnt " + scnt)
		
		//if(scnt > 0) {
		if(scnt > 0 || stvm.items.length > 0) {
		   alert("수강중인 학생이 있어  삭제 불가 합니다.");
		} else {
		    fcoursedel(delno); 
		}	
		
	}



	
	/** 학생 추가 */
	function fstudentadd(loginid) {
		var no = $("#delCourseno").val();	
		
		var param = {
				no : no
			   ,loginid : loginid	
	    }
	
	    var resultCallback = function(data) {
		    	faddStudentResult(data);
		        };
		        //Ajax실행 방식
	    callAjax("/cur/addstudent.do", "post", "json", true, param, resultCallback);
		
	}

	/** 학생 추가 Callback */
	function faddStudentResult(data) {
		
		if (data.result == "SUCCESS") {
			
			// 응답 메시지 출력
			alert(data.resultMsg);
            
			unstsearch = true;
			
			// 목록 조회
			//fListstudent();
			
		} else {
			// 오류 응답 메시지 출력
			alert(data.resultMsg);
		}
		
	}		
	
	/** 학생 삭제 */
	function fstudentdel(loginid) {
		var no = $("#delCourseno").val();	
		
		var param = {
				no : no
			   ,loginid : loginid	
	    }
	
	    var resultCallback = function(data) {
		    	fdelStudentResult(data);
		        };
		        //Ajax실행 방식
	    callAjax("/cur/delstudent.do", "post", "json", true, param, resultCallback);
		
	}

	/** 학생 추가 Callback */
	function fdelStudentResult(data) {
		
		if (data.result == "SUCCESS") {
			
			// 응답 메시지 출력
			alert(data.resultMsg);
            
			unstsearch = true;
			
			// 목록 조회
			//fListstudent();
			
		} else {
			// 오류 응답 메시지 출력
			alert(data.resultMsg);
		}
		
	}		
</script>

</head>
<body>
<form id="myForm" action=""  method="">
	<input type="hidden" name="action" id="action" value="">
	<input type="hidden" name="currentPagestudent" id="currentPageCourse" value="">
	<input type="hidden" name="delCourseno" id="delCourseno" value="">
	<input type="hidden" name="Coursestudent" id="Coursestudent" value="">
	
	
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
								class="btn_nav">정보관리</a> <span class="btn_nav bold">이력서 관리</span> <a href="#" class="btn_set refresh">새로고침</a>
						</p>
						<p class="search">

						</p>
						<p class="conTitle" id="searcharea">
							<span>이력서 관리</span> 
							 <span class="fr"> 
								<select id="searchKey" name="searchKey" style="width: 80px;" v-model="searchKey">
								    <option value="all" id="option1" selected="selected">전체</option>
									<option value="lec_nm" id="option1">과정명</option>
									<option value="stuent_nm" id="option2">학생명</option>
								</select> 
								<input type="text" id="searchWord" name="searchWord" v-model="searchWord"
									placeholder="" style="height: 28px;"> <a
									class="btnType blue" href="javascript:fListstudent()"
									onkeydown="enterKey()" name="search"><span id="searchEnter">검색</span></a>							 
								 
							    <a	class="btnType blue" href="javascript:fPopModalstudent();" name="modal"><span>이력서 등록</span></a>
							</span>
						</p>
						
						<div class="divStudentList" id="divStudentList">
							<table class="col">
								<caption>caption</caption>
								<colgroup>
								    <col width="20%">
									<col width="15%">
									<col width="40%">
									<col width="5%">
									<col width="20%">
								</colgroup>
	
								<thead>
									<tr>
									    <th scope="col">ID</th>
										<th scope="col">성명</th>
										<th scope="col">참여과정명</th>
										<th scope="col">연령</th>										
										<th scope="col">지역</th>
									</tr>
								</thead>
								<tbody id="listCourse">
									<template v-for="(row, index) in items" v-if="items.length">
									<tr onclick="vm.rowClicked(this)">
									    <td>{{ row.loginID }}</td>
										<td>{{ row.name }}</td>
										<td>{{ row.course }}</td>
										<td>{{ row.age }}</td>
										<td>{{ row.addr }}</td>
									</tr>
									</template>
								</tbody>
							</table>
						</div>
	
						<div class="paging_area"  id="studentPagination"> </div>

					</div> <!--// content -->

					<h3 class="hidden">풋터 영역</h3>
						<jsp:include page="/WEB-INF/view/common/footer.jsp"></jsp:include>
				</li>
			</ul>
		</div>
	</div>

	<!-- 모달팝업 -->
	<div id="layer1" class="layerPop layerType2" style="width: 1200px;">
		<dl>
			<dt>
				<strong>개인 이력서</strong>
			</dt>
			<dd class="content">
				<!-- s : 여기에 내용입력 -->
				<table class="row" id="studentinfo">
					<caption>caption</caption>
					<colgroup>
						<col width="150px">
						<col width="100px">
						<col width="200px">
						<col width="100px">
						<col width="200px">
						<col width="100px">
						<col width="200px">
					</colgroup>
					<tbody>
					    <tr>
							<th scope="row" colspan=2 class="font16">Login ID<span class="font_red">*</span></th>
							<td><input type="text" class="inputTxt p100" v-model="loginID" name="loginID" id="loginID" /></td>
							<th scope="row" class="font16">비밀번호<span class="font_red">*</span></th>
							<td><input type="text" class="inputTxt p100" v-model="password" name="password" id="password" /></td>
							<th scope="row" class="font16"></th>
							<td></td>
						</tr>
						<tr>
							<th scope="row" rowspan=3>
							    <div align="center" style="height: 200px; width: 150px; ">
							        <img style="height: 100%; width: 100%; object-fit: contain" v-bind:src="img_path" class="Img" alt="사진" />
							    </div>
							</th>
							<th scope="row" class="font16">성명<span class="font_red">*</span></th>
							<td><input type="text" class="inputTxt p100" v-model="name" name="name" id="name" /></td>
							<th scope="row" class="font16">연령<span class="font_red">*</span></th>
							<td><input type="text" class="inputTxt p100" v-model="age" name="age" id="age" /></td>
							<th scope="row" class="font16">성별<span class="font_red">*</span></th>
							<td><input type="text" class="inputTxt p100" v-model="sex" name="sex" id="sex" /></td>
						</tr>
						<tr>
						    <th scope="row" class="font16">연락처<span class="font_red">*</span></th>
							<td><input type="text" class="inputTxt p100" v-model="hp" name="hp" id="hp" /></td>
						    <th scope="row" class="font16">이메일<span class="font_red">*</span></th>
							<td><input type="text" class="inputTxt p100" v-model="email" name="email" id="email" /></td>
							<th scope="row" class="font16">결혼 유무</th>
							<td><input type="text" class="inputTxt p100" v-model="marride" name="marride" id="marride" /></td>
						</tr>
						<tr>
						    <th scope="row" class="font16">주소<span class="font_red">*</span></th>
							<td colspan=5>
							      <input type="hidden" v-model="zipcd" name="zipcd" id="zipcd" />
							      <input type="text" class="inputTxt p45" v-model="addr" name="addr" id="addr" />
							      <input type="button" value="우편번호 찾기" onclick="roomListVue()">
							      <input type="text" class="inputTxt p60" v-model="dtladdr" name="dtladdr" id="dtladdr" />
							</td>
						</tr>
						<tr>		
							<th scope="row">
							    <input type="file"  v-on:change="changeimg($event)" name="newimg" id="newimg" />
							</th>											
							<th scope="row" class="font16">병역</th>
							<td><input type="text" class="inputTxt p100" v-model="milservice" name="milservice" id="milservice" /></td>
							<th scope="row" class="font16">역종,병과</th>
							<td><input type="text" class="inputTxt p100" v-model="anarm" name="anarm" id="anarm" /></td>
							<th scope="row" class="font16">복무기간</th>
							<td><input type="text" class="inputTxt p100" v-model="mil_str_date" name="mil_str_date" id="mil_str_date" /></td>
						</tr>
					</tbody>
				</table>

                <table class="row">
					<caption>caption</caption>
					<colgroup>
						<col width="500px">
						<col width="300px">
					</colgroup>
					<tbody>
						<tr>
							<td>
							     <table class="row" id="schoolinfo">
					                 <caption>caption</caption>
					                 <colgroup>
						                 <col width="400px">
						                 <col width="50px">
					                 </colgroup>
					                 <tbody>
					                     <tr>
					                         <th scope="row" class="font16" colspan=2>  
					                             <div class="Rserch_btn">					                                
							                                                            학력 사항 &nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp
							                               &nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp     &nbsp&nbsp&nbsp&nbsp
							                               <input type="button" value="등록" @click="scvm.addsc(row.loginID)">
							                                                              
						                         </div>
					                          </th>
					                     </tr>  
										 <template v-for="(row, index) in items" v-if="items.length">
											<tr>
												<td>{{ row.subject}}</td>
												<td><input type="button" value="삭제" @click="scvm.deletesc(row.loginID,row.loginID,row.seq)"> </td>
											</tr>
										 </template>
					                 </tbody>
					             </table>
							</td>
							<td>
							     <table class="row" id="licenseinfo">
					                 <caption>caption</caption>
					                 <colgroup>
						                 <col width="200px">
						                 <col width="100px">
						                 <col width="50px">
					                 </colgroup>
					                 <tbody>
					                     <tr>					                     
					                         <th scope="row" colspan=3 class="font16">   
					                             <div class="Rserch_btn">					                                
							                                                            자격 사항 &nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp
							                               &nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp   &nbsp&nbsp&nbsp&nbsp
							                               <input type="button" value="등록" @click="livm.addli(row.loginID)">				                               
							                     </div>                                                   
					                         </th>
					                     </tr> 
										 <template v-for="(row, index) in items" v-if="items.length">
											<tr>
												<td>{{ row.name }}</td>
												<td>{{ row.gdate }}</td>
												<td><input type="button" value="삭제" @click="livm.deleteli(row.loginID,row.loginID,row.seq)"> </td>
											</tr>
										 </template>
					                 </tbody>
					             </table>
							</td>
						</tr>
					</tbody>
				</table>

                <table class="row" id="carrerinfo">
					<caption>caption</caption>
					<colgroup>
						<col width="800px">
					</colgroup>
					<tbody>
						<tr>
							<td>
							     <table class="row">
					                 <caption>caption</caption>
					                 <colgroup>
						                 <col width="200px">
						                 <col width="100px">
						                 <col width="100px">
						                 <col width="100px">
						                 <col width="300px">
						                 <col width="50px">
					                 </colgroup>
					                 <tbody>
					                     <tr>
					                         <th scope="row" colspan=6 class="font16">   
					                              <div class="Rserch_btn">					                                
							                                                            경력 사항 &nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp
							                               &nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp
							                               <input type="button" value="등록" @click="crvm.addcr(row.loginID)">
						                         </div>                                           
					                         </th>
					                     </tr> 
					                     <tr>
					                         <th scope="row" rowspan=2>회사명</th>
					                         <th scope="row" colspan=2>기간</th>
					                         <th scope="row" rowspan=2>직위</th>
					                         <th scope="row" rowspan=2 colspan=2>담당업무</th>
					                     </tr>    
					                     <tr>
					                         <th scope="row">시작일</th>
					                         <th scope="row">종료일</th>
					                     </tr>    
										 <template v-for="(row, index) in items" v-if="items.length">
											<tr>
												<td>{{ row.cop_name }}</td>
												<td>{{ row.entry_date }}</td>
												<td>{{ row.out_date }}</td>
												<td>{{ row.grade }}</td>
												<td>{{ row.work }}</td>
												<td><input type="button" value="삭제" @click="crvm.deletecr(row.loginID,row.loginID,row.seq)"> </td>
											</tr>
										 </template>
					                 </tbody>
					             </table>
							</td>
						</tr>
					</tbody>
				</table>


                <table class="row" id="eduinfo">
					<caption>caption</caption>
					<colgroup>
						<col width="500px">
						<col width="300px">
					</colgroup>
					<tbody>
						<tr>
							<td>
							     <table class="row">
					                 <caption>caption</caption>
					                 <colgroup>
						                 <col width="200px">
						                 <col width="100px">
						                 <col width="100px">
						                 <col width="100px">
						                 <col width="50px">
					                 </colgroup>
					                 <tbody>
					                     <tr>
					                         <th scope="row" colspan=5 class="font16">      
					                             <div class="Rserch_btn">					                                
							                                                            교육 사항 &nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp
							                               &nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp
							                               <input type="button" value="등록" @click="edvm.added(row.loginID)">                      
						                         </div>					                                                                        
					                         </th>
					                     </tr>   
					                     <tr>
					                         <th scope="row">교육명</th>
					                         <th scope="row">시작일</th>
					                         <th scope="row">종료일</th>
					                         <th scope="row" colspan=2>기관명</th>
					                     </tr>  
										 <template v-for="(row, index) in items" v-if="items.length">
											<tr>
												<td>{{ row.edu_name }}</td>
												<td>{{ row.start_date }}</td>
												<td>{{ row.end_date }}</td>
												<td>{{ row.edu_center }}</td>
												<td><input type="button" value="삭제" @click="edvm.deleteed(row.loginID,row.loginID,row.seq)"> </td>
											</tr>
										 </template>
					                 </tbody>
					             </table>
							</td>
							<td>
							     <table class="row" id="skillinfo">
					                 <caption>caption</caption>
					                 <colgroup>
						                 <col width="200px">
						                 <col width="100px">
						                 <col width="50px">
					                 </colgroup>
					                 <tbody>
					                     <tr>
					                         <th scope="row" colspan=3 class="font16"> 
					                             <div class="Rserch_btn">					                                
							                                                            보유 기술 &nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp
							                               &nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp
							                               <input type="button" value="등록" @click="skvm.addsk(row.loginID)">  			                               
							                     </div>                                             
					                         </th>
					                     </tr> 
					                     <tr>
					                         <th scope="row">보유기술 및 외국어</th>
					                         <th scope="row" colspan=2>숙련도(A,B,C)</th>
					                     </tr>    
										 <template v-for="(row, index) in items" v-if="items.length">
											<tr>
												<td>{{ row.skillcd }}</td>
												<td>{{ row.skill_level }}</td>
												<td><input type="button" value="삭제" @click="skvm.deletesk(row.loginID,row.loginID,row.skillcd)"> </td>
											</tr>
										 </template>
					                 </tbody>
					             </table>
							</td>
						</tr>
					</tbody>
				</table>

				<!-- e : 여기에 내용입력 -->

				<div class="btn_areaC mt30">
					<a href="" class="btnType blue" id="btnSaveStudent" name="btn"><span>저장</span></a> 
					<a href="" class="btnType blue" id="btnDeleteStudent" name="btn"><span>삭제</span></a> 
					<a href=""	class="btnType gray"  id="btnCloseStudent" name="btn"><span>취소</span></a>
				</div>
			</dd>
		</dl>
		<a href="" class="closePop"><span class="hidden">닫기</span></a>
	</div>

	<!--// 모달팝업 -->
</form>
</body>
</html>