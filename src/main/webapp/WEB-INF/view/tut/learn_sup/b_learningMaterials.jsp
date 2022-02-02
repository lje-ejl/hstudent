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

	// 페이징 설정
	var pageSize= 10;
	var pageBlockSize = 5;
	
	var mat; // 자료 목록
	var sa; // 검색
	var inMat;//등록 폼
	var mat_de; //자료 상세 
	
	$(document).ready(function() {
		
			init();
			// 목록 조회
			fListMat();		
			// 버튼 이벤트 등록
			fRegisterButtonClickEvent();
	});	

	/** 버튼 이벤트 등록 */
	function fRegisterButtonClickEvent() {
		$('a[name=btn]').click(function(e) {
			e.preventDefault();
	
			var btnId = $(this).attr('id');
			
			switch (btnId) {
				case 'btnUpdate' :
					fSave();
					break;
				case 'btnSave' :
					fSave();
					break;
				case 'btnDelete' :
					fDeleteMat();
			        break;
				case 'btnClose' :
					gfCloseModal();
					break;
			}
		});
	}

	function init() {
		sa = new Vue({
		                         el: '#searcharea' 
		                         ,data: {
		                        	      searchKey :''         	    
		                               }
		            });
	    
	//목록 뿌리기!!
	mat = new Vue({
								  el: '#divMatList',
								  components: {
								    'bootstrap-table': BootstrapTable
								  },
								  data: {
								    items: []
								  },
								  methods:{
									b_mat_list:function(learn_data_id,lec_id){
										  fMatSel(learn_data_id,lec_id);
									  }
								  }
		});	
	
	mat_de = new Vue({
									  el: '#mat_de',
									  data: {
								       learn_data_id: ''
								       ,learn_tit:''
									   ,learn_con: '' 
									   ,w_date: '' 
									   ,learn_fname: ''
									   ,learn_url:''
									   ,learn_fsize:''
									   ,lec_id:''
									  }
	});
	
	}; //init();

	//자료 목록
	function fListMat(currentPage) {
		currentPage = currentPage || 1;
		
		var param = {
					currentPage : currentPage
				,	pageSize : pageSize
				,   searchKey :$("#searchKey").val()      
		}
		
		var resultCallback = function(data) {
			fListMatResult(data, currentPage);
		};
		
		callAjax("/tut/listMat.do", "post", "json", true, param, resultCallback);
	}
	//자료 목록 콜백 함수
	function fListMatResult(data, currentPage) {
		
		mat.items=[];
		mat.items=data.list_mat;
		
		// 총 개수 추출
		var totalCntCourse = data.totalCount;

		// 페이지 네비게이션 생성
		var paginationHtml = getPaginationHtml(currentPage, totalCntCourse, pageSize, pageBlockSize, 'fListMat');
		
		console.log("paginationHtml : " + paginationHtml);
		
		$("#pagination").empty().append( paginationHtml );
		$("#currentPageCourse").val(currentPage);  
		
	}
	
	//단건 조회 함수
	function fMatSel(learn_data_id){
		
		var param  = {
				learn_data_id:learn_data_id
		};
		
		var resultCallBack = function(data){
			fMatSelResult(data);
		};
		
		callAjax("/tut/selMat.do ","post","json",true,param,resultCallBack);
	};
	
	//단건 조회 함수 콜백
	function fMatSelResult(data){
		fInitForm(data.sel_mat);
	};
	
	function fPopModalMat(data){
	  	fInitForm();  //데이터 넣기 
		}

	
	function fInitForm(object) {
		if(object == "" || object == null || object == undefined) {	

		mat_de.learn_data_id ="";
		mat_de.learn_tit = "";
		mat_de.learn_con = "";
		mat_de.w_date = "";
		mat_de.learn_fname = "";
		mat_de.learn_url = "";
		mat_de.learn_fsize= "";

		$("#action").val("I");
		
		$("#btnDelete").hide(); // 버튼
        $("#btnUpdate").hide(); 
        $("#btnSave").show();
        
        $("#wDate_1").hide();   // 날짜 th 숨기기
        $("#wDate_2").hide();   // 날짜 td 숨기기
        
        $("#disfilename") .empty(); //파일 다운로드 이름 비우기
        $("#bbs_files_1").val("");  //파일 이름 비우기
        
	}else {
		
		mat_de.learn_data_id =object.learn_data_id;
		mat_de.learn_tit = object.learn_tit;
		mat_de.learn_con = object.learn_con; 
		mat_de.w_date = object.w_date; 
		mat_de.learn_fname = object.learn_fname; 
		mat_de.learn_url = object.learn_url; 
		mat_de.learn_fsize= object.learn_fsize; 	

        $("#action").val("U");
    	
    /*     $("#title").text(object.learn_tit);
    	$("#con").text(object.learn_con);
    	$("#wDate_2").text(object.w_date);
         */
        
        $("#wDate_1").show();   // 날짜 th 보이기
        $("#wDate_2").show();   // 날짜 td 보이기
        
         $("#downloadFile").val(object.learn_url) ;//파일 다운로드url 넘기기
	     $("#downloadFileName").val(object.learn_fname);//파일 다운로드 이름 넘기기
	     
	     //null일경우 다운로드 숨기기
	     if(object.learn_fname != null){
	     $("#disfilename") .empty().append('<a href="javascript:download();" id="file_name" name="file_name" style=" color: black; font-size: 1.0em; font-weight: bold;">'+object.learn_fname+'</a>'); 
	     }

        $("#btnDelete").show(); //버튼
        $("#btnUpdate").show(); 
        $("#btnSave").hide();   

        $("#learn_data_id").val(object.learn_data_id);//.learn_data_id  넘기기
		console.log(object.learn_data_id);
	}		
	gfModalPop("#mat_de");
}

	function fsaveinfo(){
		   //submit_con 유무로 저장/수정 판단하기
		   if($("#action").val() == 'I'){
		      if(confirm('저장 하시겠습니까?') == false){
		         return false;
		      } else {
		         return true;
		      }
		   }else if($("#action").val() == 'U'){
		      if(confirm('내용을 수정 하시겠습니까?') == false){
		         return false;
		      } else {
		         return true;
		      }
		   }
		}


	function fSave(){
	   if(fsaveinfo(true)) {
		   fSaveMat();
	   }
	}

//파일 업로드
	function fSaveMat() {

		   var frm = document.getElementById("myForm");
		   frm.enctype = 'multipart/form-data';
		   var fileData = new FormData(frm);

		// vaildation 체크
		var resultCallback = function(data) {
			fSaveMatResult(data);
		};
		callAjaxFileUploadSetFormData("/tut/saveMat.do", "post", "json", true, fileData, resultCallback);
	}
	

	
	/** 데이터 저장 콜백 함수 */
	function fSaveDataResult(data) {
	   if (data.result == "SUCCESS") {
	      $("#bbs_files_1").val("");   // 첨부파일
	      gfCloseModal();
	      fListMat(currentPage);
	   } else {
	      // 오류 응답 메시지 출력
	      alert(data.resultMsg);
	   }
	}
	//업로드시 input 태그 이름생성
	$(document).ready(function(){
	     var fileTarget = $('.filebox .upload-hidden');

	       fileTarget.on('change', function(){
	           if(window.FileReader){
	               var filename = $(this)[0].files[0].name;
	           } else {
	               var filename = $(this).val().split('/').pop().split('\\').pop();
	           }
	           $(this).siblings('.upload-name').val(filename);
	       });
	   }); 
	/* 파일 업로드 end */

	/** 게시글 삭제 */
	function fDeleteMat(learn_data) {
	   learn_data_id =  $('#learn_data_id').val();
	   console.log("id" +learn_data_id);
	   var param = { learn_data_id : learn_data_id};
	   
	   var resultCallback = function(data) {
	      fDeleteDataResult(data);
	   };
	   
	   callAjax("/tut/deleteMat.do", "post", "json", true, param, resultCallback);
	}

	function fDeleteDataResult(data){
		//페이지 돌아가기
		//currentPage = $("#currentPageCourse").val();
	   
		if (data.result == "SUCCESS") {
	      // 응답 메시지 출력
	      alert(data.resultMsg);
	      // 목록 조회
	      gfCloseModal();
	      fListMat();
	   } else {
	      alert(data.resultMsg);
	   }   
	}
	   // 파일 다운
   function download(){
        var url = $("#downloadFile").val();
      var urlName = $("#downloadFileName").val();
        
             console.log("url : " + url)
              var params = "";
              params += "<input type='hidden' name='learn_url' value='"+ url +"' />";
              params += "<input type='hidden' name='learn_fname' value='"+ urlName +"' />";
              jQuery("<form action='/tut/downloadMat.do' method='post'>" + params+ "</form>").appendTo('body').submit().remove();
              alert("다운로드 성공");
           }
	    


function fSaveMatResult(data) {
	var currentPage = "1";
	if ($("#action").val() != "I") {
		currentPage = $("#currentPageCourse").val();
	}
	
	if (data.result == "SUCCESS") {
		
		// 응답 메시지 출력
		alert(data.resultMsg);
		
		// 입력폼 초기화
		fInitForm();			
		
		// 모달 닫기
		gfCloseModal();
		
		//stvm.items=[];
	
		 fListMat(currentPage);
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
	<input type="hidden" name="currentPageCourse" id="currentPageCourse" value="">
	<input type="hidden" name="delCourseno" id="delCourseno" value="">

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
								class="btn_nav">학습 관리</a> <span class="btn_nav bold">학습 자료</span> <a href="#" class="btn_set refresh">새로고침</a>
						</p>
						<p class="conTitle" id="searcharea">
							<span>학습 자료</span> 
							 <span class="fr"> 
								<select id="searchKey" name="searchKey" style="width: 80px;" >
								 	<c:forEach items="${list_lec}" var="lec" >
									<c:if test ="${lec.lec_name ne null}" >
									<option value="${lec.lec_id}">${lec.lec_name}</option>
									</c:if>
									</c:forEach> 
								</select> 
			 				<a class="btnType blue" href="javascript:fListMat()"
									onkeydown="enterKey()" name="search"><span id="searchEnter">검색</span></a>							 
							
							    <a class="btnType blue" href="javascript:fPopModalMat();" name="modal"><span>학습 자료 등록</span></a>
							</span>
						</p>
						
						<div class="divMatList" id="divMatList">
							<table class="col">
								<caption>caption</caption>
								<colgroup>
								    <col width="15%">
									<col width="45%">
									<col width="40%">
								</colgroup>
	
								<thead>
									<tr>
									    <th scope="col">NO</th>
										<th scope="col">제목</th>
										<th scope="col">등록일</th>
									</tr>
								</thead>
								<tbody id="listMat">
									<template v-for="(row, index) in items" v-if="items.length">
									<tr @click="b_mat_list(row.learn_data_id, row.lec_id)" > 
									    <td>{{ row.rm }}</td>
										<td >{{ row.learn_tit }}</td>
										<td>{{ row.w_date }}</td>
									</tr>
									</template>
								</tbody>
							</table>
						</div>
	
						<div class="paging_area"  id="pagination"> </div>
					<h3 class="hidden">풋터 영역</h3>
						<jsp:include page="/WEB-INF/view/common/footer.jsp"></jsp:include>
				</li>
			</ul>
		</div>
	</div>
	
	<div id="mat_de" class="layerPop layerType2" style="width: 600px;">
         <dl>
            <dt>
               <strong>학습자료</strong>
            </dt>
            <dd class="content" >
                  <table class="row">
              <caption>caption</caption>
            <tbody>
             <tr>
                <th scope="row">제목 </th>
               <td id="title" colspan="3" >
               <input type ="hidden"  id="learn_data_id"   name ="learn_data_id" >
               <input type ="hidden"  id="lec_id "  v-model="lec_id "  name ="lec_id " value= "lec_id" >
               <input type ="text"  id="learn_tit"   v-model="learn_tit"  name ="learn_tit"  class="inputTxt p100"></td>
              
               <th id = "wDate_1"scope="row">등록일자 </th>
               <td id = "wDate_2" colspan="3" > <input type ="text"  id="w_date"  v-model="w_date"  name ="w_date" class="inputTxt p100" readonly></td>
            </tr>
            <tr>
               <th scope="row">자료내용 </th>
               <td  id="con" colspan="6">
                  <textarea class="inputTxt p100" id="learn_con"  v-model="learn_con"  name ="learn_con" style="width:100%; border:0; resize:none;"></textarea>
               </td>
            </tr>
            <tr>
               <th scope="row">첨부파일</th>
               <td colspan="6">
                    <div class="filebox bs3-primary">
                            <input type="file" id="bbs_files_1"  name="bbs_files_1" class="upload-hidden">
							<div style="margin: 5px ;" id="disfilename"  name="disfilename"></div>
                              <input type="hidden" id="downloadFile"> 
                              <input type="hidden" id="downloadFileName">                                        
                        </div>
               </td>
            </tr>
             </tbody> 
          </table>
       			<div class="btn_areaC mt30">
					<a href="" class="btnType blue" id="btnSave" name="btn"><span>저장</span></a> 
					<a href="" class="btnType blue" id="btnUpdate" name="btn"><span>수정</span></a> 
					<a href="" class="btnType blue" id="btnDelete" name="btn"><span>삭제</span></a> 
					<a href=""	class="btnType gray"  id="btnClose" name="btn"><span>취소</span></a>
				</div>
               </dd>
			</dl>
		<a href="" class="closePop" id="btnClose" name="btn"><span class="hidden">닫기</span></a>
	</div>
</form>
</body>
</html>