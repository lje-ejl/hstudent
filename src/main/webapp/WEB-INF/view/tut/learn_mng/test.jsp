<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>JobKorea</title>
<script src="http://cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.js"></script>
<script src="https://code.jquery.com/jquery-latest.js"></script> 
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.0.0/jquery.min.js"></script>
<link rel="stylesheet" href="http://code.jquery.com/ui/1.8.18/themes/base/jquery-ui.css" type="text/css" />  
<script src="http://ajax.googleapis.com/ajax/libs/jquery/1.7.1/jquery.min.js"></script>  
<script src="http://code.jquery.com/ui/1.8.18/jquery-ui.min.js"></script>
<jsp:include page="/WEB-INF/view/common/common_include.jsp"></jsp:include>

<script>

	$(document).ready(function(){
	$( function() { $( "#test_start" ).datepicker({dateFormat:"yymmdd"}); }).val();	
	$( function() { $( "#test_end" ).datepicker({dateFormat:"yymmdd"}); }).val();	
	});
	
	function modalGo(){
		var tb = document.getElementById("select");
		var tbIndex = document.getElementById("select").options.selectedIndex;
		var selval = tb.options[tbIndex].value;
		if(selval==""){
			alert("시험을 등록 할 강의를 선택해주세요");
			return;
		}
		console.log("모달 확인");
		gfModalPop("#layer1");
	} 
	
	function init(){

		var name = document.getElementById("test_name").value = null;
		var sort = document.getElementById("selectSort").value = "";
		var start = document.getElementById("test_start").value=null;
		var end = document.getElementById("test_end").value=null;
	}
	

	function search() {
		var tb = document.getElementById("select");
		var tbIndex = document.getElementById("select").options.selectedIndex;
		var selval = tb.options[tbIndex].value;
		var SendId = document.getElementById('send_lecId');
		var test = document.getElementById('test_name');
		var result = "";	
		SendId.value=selval;
		
				$.ajax({
					method : 'get'
					,url : 'listTest'
					,data : {'lec_id':selval}
					,success : function(resp){
							var d = "";
							$.each(resp,function(index,item){
								d+= "<tr>"+"<td>"+(index+1)+"</td>";
								d+= "<td>"+'<a href="examRegist?test_id='+item.test_id+'"><strong>'+item.test_name+'</strong></a>'+"</td>";
								d+= "<td>"+item.test_sort+"</td>";
								d+= "<td>"+item.test_start+"</td>";
								d+= "<td>"+item.test_end+"</td>"+"</tr>";
							})
							$("#lec_List").html(d);
						}
				})  
	}
	
	
	 function SendInfo(){
		 
     	var target = document.getElementById("select");
     	var res = target.options[target.selectedIndex].value;
		var tb = document.getElementById("selectSort");
		var tbIndex = document.getElementById("selectSort").options.selectedIndex;
		var selval = tb.options[tbIndex].value;
		var ID = document.getElementById("send_lecId").value;
		var tname = document.getElementById("test_name").value;
		var tstart = document.getElementById("test_start").value;
		var tend = document.getElementById("test_end").value;
		
		var staArr = tstart.split('.');
		var endArr = tend.split('.');
		var tst = staArr[1]+"-"+staArr[2]+"-"+staArr[0];
		var ted = endArr[1]+"-"+endArr[2]+"-"+endArr[0];
		
		if(selval==''){
			alert("시험 분류를 선택해 주세요");
			return;
		}
		if(tname == '' || null){
			alert("시험명을 입력해 주세요");
			document.getElementById("test_name").focus();
			return;
		}
		if(tstart == '' || null){
			alert("시험 시작날짜를 입력해 주세요");
			return;
		}
		if(tend == '' || null){
			alert("시험 종료날짜를 입력해 주세요");
			return;
		}
     $.ajax({
        url : "testEnroll",
        type : "POST",
        data : {'lec_id':res,
			'test_name':tname,
			'test_sort':selval,
			'test_start':tst,
			'test_end':ted},
        success : function(data) {
           alert("시험이 등록되었습니다");
           search();
           init();
        },
        error : function() {
           alert("등록에 실패했습니다");
        }
     }); 
	}
	 function cancelAll(){
			init();
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
               <li class="lnb"><jsp:include
                     page="/WEB-INF/view/common/lnbMenu.jsp"></jsp:include></li>
               <li class="contents">
                  <h3 class="hidden">contents 영역</h3>
                  <div class="content">
                     <p class="Location">
                      <a href="#" class="btn_set home">메인으로</a> 
                        <a href="#" class="btn_nav">학습 관리</a> 
                        <span class="btn_nav bold">시험관리</span>
                        <a href="#" class="btn_set refresh">새로고침</a>
                        <br>
                     </p>
                     <!-- !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!! -->
                     <p class="lecture_list" align="right">
                     </p>
                     <div class="">
                     <br>
                     <p class="conTitle">              
                      <span>시험 등록</span>
                      <span class="fr">
                      <select id="select" name="select" style="width: 100px;">
                           <option value="" id="option1" selected="selected">강의목록</option>
                           <c:forEach var="dto" items="${lecture_List}" varStatus="status">
                              <option id="" value="${dto.lec_id}" name="lec_id">${dto.lec_name}</option>
                           </c:forEach>
                        </select>
                       <a class="btnType blue" href="javascript:search();" name="modal"><span>검색</span></a>
                       <a class="btnType blue" href="javascript:modalGo();" name="modal"><span>시험등록</span></a>
                      </span>
					 </p>
                        <table class="col">
                           <thead>
                              <tr>
                                 <th scope="col" colspan="5">시험 목록</th>
                              </tr>
                           </thead>
                           <caption>caption</caption>
                           <colgroup>
                              <col width="3%">
                              <col width="10%">
                              <col width="10%">
                              <col width="10%">
                              <col width="10%">
                           </colgroup>
                           <thead>
                              <tr>
                                 <th scope="col">번호</th>
                                 <th scope="col">시험이름</th>
                                 <th scope="col">시험구분</th>
                                 <th scope="col">시험 시작일</th>
                                 <th scope="col">시험 종료일</th>
                              </tr>
                           </thead>
                           <tbody id="lec_List">
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
   <form id=frm>
   <div id="layer1" class="layerPop layerType2" style="width: 450px;">
   <input type="hidden" id="send_lecId" name="lec_id" value="">
		<dl>
			<dt>
				<strong style="width:400px; height:100px;">시험 등록</strong>
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
							<th scope="row">시험명 <span class="font_red">*</span></th>
							<td><input type="text" class="inputTxt p100" name="test_name" id="test_name" /></td>
						</tr>
						<tr>
							<th scope="row">시험 분류 <span class="font_red">*</span></th>
							<td colspan="3">
							<!-- <input type="text" class="inputTxt p100"name="test_sort" id="test_sort" /> -->
							<select id="selectSort" name="selectSort" style="width: 150px;">
                           <option value="" id="option1" selected="selected">시험분류</option>
                           <option id="" value="본시험" name="test_sort">본시험</option>
                           <option id="" value="재시험" name="test_sort">재시험</option>
                        </select>
							</td>
						</tr>
						<tr>
							<th scope="row">시작날짜 <span class="font_red">*</span></th>
							<td colspan="3"><input type="text" class="inputTxt p100"
								name="test_start" id="test_start" data-date-format='yyyy.mm.dd' readonly/></td>
						</tr>
						<tr>
							<th scope="row">마감날짜<span class="font_red">*</span></th>
							<td colspan="3"><input type="text" class="inputTxt p100"
								name="test_end" id="test_end" data-date-format='yyyy.mm.dd' readonly/></td>
						</tr>
					</tbody>
				</table>
				<div class="btn_areaC mt30">
					<a href="javascript:SendInfo();" class="btnType blue" id="RegisterCom" name="btn"><span>등록</span></a> 
					<a href="javascript:cancelAll();"	class="btnType gray"  id="btnCloseGrpCod" name="btn"><span>모든 내용 삭제</span></a>
				</div>
			</dd>
		</dl>
		<a href="" class="closePop"><span class="hidden">닫기</span></a>
	</div>
		</form>
   
</body>
</html>