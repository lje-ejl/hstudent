<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script src="http://cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.js"></script>
    
<link rel="stylesheet" type="text/css" href="${CTX_PATH}/css/admin/basic.css" />
<link rel="stylesheet" type="text/css" href="${CTX_PATH}/css/jh_css/style.css" />
<link rel="stylesheet" type="text/css" href="${CTX_PATH}/js/jquery-ui/jquery-ui-1.11.4/jquery-ui.css" />
<link rel="stylesheet" type="text/css" href="${CTX_PATH}/js/jquery-ui/jquery-ui-1.11.4/jquery-ui.min.css" />
<link rel="stylesheet" type="text/css" href="${CTX_PATH}/js/bootstrap/custom_bootstrap.css" />

<script type="text/javascript" charset="utf-8" src="${CTX_PATH}/js/jquery-1.11.2.min.js"></script>
<script type="text/javascript" charset="utf-8" src="${CTX_PATH}/js/underscore-min.js"></script>	
<script type="text/javascript" charset="utf-8" src="${CTX_PATH}/js/jquery-ui/jquery-ui-1.11.4/jquery-ui.js"></script>
<script type="text/javascript" charset="utf-8" src="${CTX_PATH}/js/jquery-ui/jquery-ui-1.11.4/jquery-ui.min.js"></script>
<script type="text/javascript" charset="utf-8" src="${CTX_PATH}/js/jquery.form.min.js"></script>
<!-- 모달팝업 -->
<script type="text/javascript" charset="utf-8" src="${CTX_PATH}/js/jquery.model.js"></script>
<!-- IE 8 이하에서 HTML5 태그 지원 -->
<script type="text/javascript" charset="utf-8" src="${CTX_PATH}/js/html5shiv.js"></script>
<!-- 공통 스크립트 -->
<script type="text/javascript" charset="utf-8" src="${CTX_PATH}/js/common.js"></script>
<script type="text/javascript" charset="utf-8" src="${CTX_PATH}/js/commonAjax.js"></script>

<script type="text/javascript" charset="utf-8" src="${CTX_PATH}/js/stringBuffer.js"></script>
<script type="text/javascript" charset="utf-8" src="${CTX_PATH}/js/map.js"></script>
<script type="text/javascript" charset="utf-8" src="${CTX_PATH}/js/jquery.blockUI.js"></script>

<script type="text/javascript" src="//maxcdn.bootstrapcdn.com/bootstrap/3.2.0/js/bootstrap.min.js"></script>
<script type="text/javascript" src="//unpkg.com/vue@latest/dist/vue.js"></script>    
<script type="text/javascript" src="//rawgit.com/wenzhixin/vue-bootstrap-table/develop/docs/static/dist/vue-bootstrap-table.js"></script>

<script type="text/javascript" src="https://cdn.jsdelivr.net/npm/es6-promise@4/dist/es6-promise.min.js"></script>
<script type="text/javascript" src="https://cdn.jsdelivr.net/npm/es6-promise@4/dist/es6-promise.auto.min.js"></script> 
<title>시험 문제 등록</title>
<script>
$(document).ready(function() {
	// LNB 메뉴
	$('ul.lnbMenu li dl dd').hide(); // 이미 없애놓음

	$('ul.lnbMenu a.lnbBtn').click(function(e) {
		e.preventDefault();
		
		if ($("ul.lnbMenu a.lnbBtn").hasClass("on")) {
			$("ul.lnbMenu a.lnbBtn").removeClass("on")
			$("ul.lnbMenu a.lnbBtn").parents("dl").children("dd").slideUp();
		};
		
		$(this).parents("dl").children("dd").slideDown();
		$(this).addClass("on");
	});
	
	//qna table
	$("table.qna tr.view").hide();
	$("#tab01").show();
	$('table.qna td a.viewOpen').click(function(e) {
		e.preventDefault();

		$('table.qna tr.view').hide();
		$(this).parents("tr").next("tr.view").show();
	});
});
/*여기까지 공통 코드------------------------------------------------------------------------------------------------ */
	$(document).ready(function(){
		$("#updCom").hide();
	});

	function modalGo(){
		init();
		console.log("모달 확인");
		gfModalPop("#layer1");
		$("#updCom").hide();
		$("#regCom").show();
	} 
	
	
	function init(){
		
		var qnum = document.getElementById("que_num").value=null;
		var que = document.getElementById("test_que").value=null;
		var ans = document.getElementById("que_ans").value=null;
		var ex1 = document.getElementById("que_ex1").value=null;
		var ex2 = document.getElementById("que_ex2").value=null;
		var ex3 = document.getElementById("que_ex3").value=null;
		var ex4 = document.getElementById("que_ex4").value=null;
	}
	
	function cancelAll(){
		var que = document.getElementById("test_que").value=null;
		var ans = document.getElementById("que_ans").value=null;
		var ex1 = document.getElementById("que_ex1").value=null;
		var ex2 = document.getElementById("que_ex2").value=null;
		var ex3 = document.getElementById("que_ex3").value=null;
		var ex4 = document.getElementById("que_ex4").value=null;
	}
	
	function deleteQue1(num){
		console.log(num);
		var TestId = document.getElementById("test_id1").value;	
		
		 $.ajax({
			url : "deleteQue",
			type : "get",
			data : {'que_num':num,'test_id':TestId},
			success : function(resp){
				alert("삭제성공");
				history.go(0);
			},
	        error : function() {
		        alert("[ 삭제 실패 ]");
		     }
		})  
	 }
	
	 function updateQue1(num){
		var TestId = document.getElementById("test_id").value;
		gfModalPop("#layer1");
		$.ajax({
			url : "setUpdate",
			type : "get",
			async : false,
			data : {'que_num':num, 'test_id':TestId},
			success : function(resp){
				console.log(resp.test_que);
				document.getElementById("que_num").value = resp.que_num;
				$("#que_num").attr("disabled",true);
				document.getElementById("test_que").value = resp.test_que;
				document.getElementById("que_ans").value = resp.que_ans;
				document.getElementById("que_ex1").value = resp.que_ex1;
				document.getElementById("que_ex2").value = resp.que_ex2;
				document.getElementById("que_ex3").value = resp.que_ex3;
				document.getElementById("que_ex4").value = resp.que_ex4;
			}
		})
		$("#updCom").show();
		$("#regCom").hide();
	}
	
	function upd(){
		var TestId = document.getElementById("test_id");
		var qnum = document.getElementById("que_num");
		var que = document.getElementById("test_que");
		var ans = document.getElementById("que_ans");
		var ex1 = document.getElementById("que_ex1");
		var ex2 = document.getElementById("que_ex2");
		var ex3 = document.getElementById("que_ex3");
		var ex4 = document.getElementById("que_ex4");
		
		if(ans.value=="" || null || isNaN(ans.value)){
			alert("답을 입력 혹은 숫자형태로 입력 해주세요");
			ans.focus();
			return;
		}
		if(que.value=="" || null){
			alert("문제를 입력해주세요");
			que.focus();
			return;
		}
		if(ex1.value=="" || null){
			alert("보기1번을 입력해주세요");
			ex1.focus();
			return;
		}
		if(ex2.value=="" || null){
			alert("보기2번을 입력해주세요");
			ex2.focus();
			return;
		}
		if(ex3.value=="" || null){
			alert("보기3번을 입력해주세요");
			ex3.focus();
			return;
		}
		if(ex4.value=="" || null){
			alert("보기4번을 입력해주세요");
			ex4.focus();
			return;
		}
		
		$.ajax({
			url : "updQue",
			type : "get",
			data : {'que_num':qnum.value, 'test_id':TestId.value,'test_que':que.value
				,'que_ans':ans.value,'que_ex1':ex1.value,'que_ex2':ex2.value,'que_ex3':ex3.value,'que_ex4':ex4.value},
			success : function(resp){
				init();
			}
		})
		history.go(0);
	}
	
	function reg(){
		var TestId = document.getElementById("test_id");
		var qnum = document.getElementById("que_num");
		var que = document.getElementById("test_que");
		var ans = document.getElementById("que_ans");
		var ex1 = document.getElementById("que_ex1");
		var ex2 = document.getElementById("que_ex2");
		var ex3 = document.getElementById("que_ex3");
		var ex4 = document.getElementById("que_ex4");
		
		if(qnum.value=="" || null){
			alert("문제번호를 입력해주세요");
			qnum.focus();
			return;
		}
		if(ans.value=="" || null || isNaN(ans.value)){
			alert("답을 입력 혹은 숫자형태로 입력 해주세요");
			ans.focus();
			return;
		}
		if(que.value=="" || null){
			alert("문제를 입력해주세요");
			que.focus();
			return;
		}
		if(ex1.value=="" || null){
			alert("보기1번을 입력해주세요");
			ex1.focus();
			return;
		}
		if(ex2.value=="" || null){
			alert("보기2번을 입력해주세요");
			ex2.focus();
			return;
		}
		if(ex3.value=="" || null){
			alert("보기3번을 입력해주세요");
			ex3.focus();
			return;
		}
		if(ex4.value=="" || null){
			alert("보기4번을 입력해주세요");
			ex4.focus();
			return;
		}
		
		$.ajax({
	        url : "queReg",
	        type : "POST",
	        data : $('#frm').serialize(),
	        success : function(resp) {
	        	if(resp=='success'){
	        	alert("문제가 등록 되었습니다");
	        	init();
	        	return;
	        	}else
	        	alert("문제번호가 중복됩니다");
	        	return;
	        },
	        error : function() {
	        	alert("문제등록 실패");
	        }
	     });
		
	}
	
	function clpop(){
		gfCloseModal();
		history.go(0);
	}
	
	/*  function search1(){
		var Tid = $("#select option:selected").val();
		 $.ajax({
			method : 'get'
			,url : 'listQue'
			,data : {'test_id':Tid}
			,success : function(resp){
					var d = "";
					$("#lec_List").html("");
					$.each(resp,function(index,item){
						d+= "<tr>"+"<td>"+item.que_num+"</td>";
						d+= "<td>"+item.test_que+"</td>";
						d+= "<td>"+item.que_ans+"</td>";
						d+= "<td>"+item.que_ex1+"</td>";
						d+= "<td>"+item.que_ex2+"</td>";
						d+= "<td>"+item.que_ex3+"</td>";
						d+= "<td>"+item.que_ex4+"</td>"+"</tr>";
						d+= "<td>"+"<input type='button' onclick="updateQue1(item.que_num)"value='수정'>"+"</td>"
						d+= "<td>"+"<input type='button' onclick="deleteQue1(item.que_num)"value='삭제'>"+"</td>"+"</tr>"; 
					})
					$("#lec_List").html(d);
				}
		})
		$("#lec_List").html("");
	}  */

</script>
</head>
<body>
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
                        <a href="#" class="btn_nav">학습 관리</a> 
                        <span class="btn_nav bold">시험 관리</span>
                        <a href="#" class="btn_set refresh">새로고침</a>
                        <br>
                     </p>
                     <!-- !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!! -->
                     <br>
                     <div class="">
                     <p class="conTitle">              
                      <span>시험 문제 관리</span>
                      <span class="fr">
                       <a class="btnType blue" href="javascript:modalGo();" name="modal"><span>문제등록</span></a>
                      </span>
					 </p>
                        <table class="col">
                           <thead>
                              <tr>
                                 <th scope="col" colspan="9">문제 목록</th>
                              </tr>
                           </thead>
                           <caption>caption</caption>
                           <colgroup>
                              <col width="3%">
                              <col width="15%">
                              <col width="3%">
                              <col width="10%">
                              <col width="10%">
                              <col width="10%">
                              <col width="10%">
                              <col width="3%">
                              <col width="3%">
                           </colgroup>
                           <thead>
                              <tr>
                                 <th scope="col">문제번호</th>
                                 <th scope="col">문제</th>
                                 <th scope="col">정답</th>
                                 <th scope="col">보기1</th>
                                 <th scope="col">보기2</th>
                                 <th scope="col">보기3</th>
                                 <th scope="col">보기4</th>
                                 <th></th>
                                 <th></th>
                              </tr>
                           </thead>
                           <tbody id="lec_List">
                            <c:forEach var="list" items="${queList}">
                            <input type="hidden" id="test_id1" name="test_id1" value="${test_id}">
		      				  <tr>
		   						<td>${list.que_num}</td>
		       					<td>${list.test_que}</td>
		        				<td>${list.que_ans}</td>
		       					<td>${list.que_ex1}</td>
		        				<td>${list.que_ex2}</td>
		        				<td>${list.que_ex3}</td>
		        				<td>${list.que_ex4}</td>
		        				<td><a href="javascript:updateQue1(${list.que_num});"  id="updateQue" name="btn"><strong>수정</strong></a></td>
		        				<td><a href="javascript:deleteQue1(${list.que_num});"  id="deleteQue" name="btn"><strong>삭제</strong></a></td>
		   					  </tr>
		   </c:forEach>
                           </tbody>
                        </table>
                     </div>
                     <div class="paging_area" id="surveyList_Pagination"></div>
                     <br><br><br>
                     
                  </div> <!--// content -->
                  <h3 class="hidden">풋터 영역</h3> 
                  <jsp:include page="/WEB-INF/view/common/footer.jsp"></jsp:include>
               </li>
            </ul> 
         </div>
      </div>
   </form>
   	<form id="frm">
   	<div id="layer1" class="layerPop layerType2" style="width: 600px;">
		<dl>
			<dt>
				<strong style="width:400px; height:100px;">시험문제 등록</strong>
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
							<th scope="row">문제번호 </th>
							<td>
							<input type="hidden" id="test_id" name="test_id" value="${test_id}">
							<input type="text" class="inputTxt p100" id="que_num" name="que_num" /></td>
							<th scope="row">정답</th>
							<td><input type="text" class="inputTxt p100" id="que_ans" name="que_ans" /></td>
						</tr>
						<tr>
							<th scope="row">문제</th>
							<td colspan="3"><input type="text" class="inputTxt p100"
								id="test_que" name="test_que" /></td>
						</tr>
						<tr>
							<th scope="row">보기1</th>
							<td colspan="3"><input type="text" class="inputTxt p100"
								id="que_ex1" name="que_ex1"/></td>
						</tr>
						<tr>
							<th scope="row">보기2</th>
							<td colspan="3"><input type="text" class="inputTxt p100"
								id="que_ex2" name="que_ex2"/></td>
						</tr>
						<tr>
							<th scope="row">보기3</th>
							<td colspan="3"><input type="text" class="inputTxt p100"
								id="que_ex3" name="que_ex3"/></td>
						</tr>
						<tr>
							<th scope="row">보기4</th>
							<td colspan="3"><input type="text" class="inputTxt p100"
								id="que_ex4" name="que_ex4"/></td>
						</tr>
					</tbody>
				</table>

				<!-- e : 여기에 내용입력 -->

				<div class="btn_areaC mt30">
					<a href="javascript:reg();" class="btnType blue" id="RegisterCom" name="btn"><span id="regCom">문제 추가</span></a> 
					<a href="javascript:upd();" class="btnType blue" id="updCom" name="btn"><span id="updCom">수정 완료</span></a> 
					<a href="javascript:cancelAll();"	class="btnType gray"  id="btnCloseGrpCod" name="btn"><span>내용 전부 삭제</span></a>
				</div>
			</dd>
		</dl>
		<a href="" onclick="clpop()" class="closePop"><span class="hidden">닫기</span></a>
	</div>
		</form>
</body>
</html>