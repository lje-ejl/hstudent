<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>성적 조회</title>
<script src="http://cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.js"></script>
<jsp:include page="/WEB-INF/view/common/common_include.jsp"></jsp:include>
<script>

$(document).ready(function(){
	$('#grd').hide();
})

function search() {
	var tb = document.getElementById("select");
	var tbIndex = document.getElementById("select").options.selectedIndex;
	var selval = tb.options[tbIndex].value;
	var SendId = document.getElementById('send_lecId');
	var test = document.getElementById('test_name');
	var result = "";		
	
			$.ajax({
				method : 'get'
				,url : 'listTest'
				,data : {'lec_id':selval}
				,success : function(resp){
						var d = "";
						$.each(resp,function(index,item){
							d+= "<tr>"+"<td>"+(index+1)+"</td>";
							d+= "<td>"+'<a href="javascript:stdInfo('+item.test_id+')"><strong>'+item.test_name+'</strong></a>'+"</td>";
							d+= "<td>"+item.test_sort+"</td>";
							d+= "<td>"+item.test_start+"</td>";
							d+= "<td>"+item.test_end+"</td>"+"</tr>";
						})
						$("#lec_List").html(d);
					}
			})  
}
	function stdInfo(id){
			$.ajax({
				method : 'post'
				,url : "listStu"
				,data : {'test_id':id}
				,success : function(resp){
					if(resp==''){
						$('#grd').hide();	
					}else
					$('#grd').show();
					var d = "";
					$.each(resp,function(index,item){
						d+= "<tr>"+"<td>"+item.std_id+"</td>";
						d+= "<td>"+item.name+"</td>";
						d+= "<td>"+item.test_sco+"</td>";
						d+= "<td>"+item.pass+"</td>";
						d+= "<td>"+item.sc+"</td>"+"</tr>";
					})
					$("#atd_List").html(d);
				}
		
			})
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
                        <a href="#" class="btn_set refresh">새로고침</a><br>
                     </p>
                     <!-- !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!! -->
                     <p class="lecture_list" align="right">
                     </p>
                     <div class="">
                     <br>
                     <p class="conTitle">              
                      <span>성적 조회</span>
                      <span class="fr">
                      <select id="select" name="select" style="width: 100px;">
                           <option value="all" id="option1" selected="selected">강의목록</option>
                           <c:forEach var="dto" items="${lecture_List}" varStatus="status">
                              <option id="" value="${dto.lec_id}" name="lec_id">${dto.lec_name}</option>
                           </c:forEach>
                        </select>
                        <a class="btnType blue" href="javascript:search();" name="modal"><span>검색</span></a>
                      </span>
					 </p>
                        <table class="col">
                           <thead>
                              <tr>
                                 <th scope="col" colspan="5">성적 조회</th>
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
                                 <th scope="col">시험 구분</th>
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
                     
                     <div class="" id="grd">
                        <table class="col">
                           <thead>
                              <tr>
                                 <th scope="col" colspan="5">
                             	    시험 응시 상황
                                 </th>
                              </tr>
                           </thead>
                           <caption>caption</caption>
                           <br><br><br><br>
                           <colgroup>
                              <col width="10%">
                              <col width="10%">
                              <col width="5%">
                              <col width="10%">
                              <col width="10%">
                           </colgroup>
                           <thead>
                              <tr>
                                 <th scope="col">학생ID</th>
                                 <th scope="col">학생 이름</th>
                                 <th scope="col">점수</th>
                                 <th scope="col">응시상태</th>
                                 <th scope="col">합격여부</th>
                              </tr>
                           </thead>
                           <tbody id="atd_List">
                           </tbody>
                           </table>
                     </div>
                     
                     
                  </div> <!--// content -->
                  <h3 class="hidden">풋터 영역</h3> 
                  <jsp:include page="/WEB-INF/view/common/footer.jsp"></jsp:include>
               </li>
            </ul> 
         </div>
      </div>
   </form>
</body>
</html>