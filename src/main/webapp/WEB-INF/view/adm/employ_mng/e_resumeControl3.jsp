<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

		<dl>
            <dt>
               <strong>학생 정보</strong>
            </dt>
            <dd class="content">
               <table class="row" id="adv_info">
                  <caption>caption</caption>
                  <colgroup>
                     <col width="120px">
                     <col width="*">
                     <col width="120px">
                     <col width="*">
                  </colgroup>
                  <tbody>
                     <tr>
                        <th scope="row">학 번</th>
                        <td>${Std_Detail.std_num}</td>
                        <th scope="row">이 름</th>
                        <td>${Std_Detail.name}</td>
                     </tr>                  
                     <tr>
                        <th scope="row">ID</th>
                        <td>${Std_Detail.loginId}</td>
                        <th scope="row">성별</th>
                        <td>${Std_Detail.sex}</td>
                     </tr>
                     <tr class="tr_info">
                        <th scope="row">연락처</th>
                        <td>${Std_Detail.tel}</td>
                        <th scope="row">생일</th>
                        <td>${Std_Detail.birth}</td>
                     </tr>
                     <tr>
                        <th scope="row" colspan="1">메일</th>
                        <td colspan="3">${Std_Detail.mail}</td>
                     </tr>
                  </tbody>
               </table>
				<div class="btn_areaC mt30">
					<a href="javascript:popupclose()" class="btnType gray" id="btnClose" name="btn"><span>취소</span></a>
				</div>
               
            </dd>
         </dl>
         <a href="" class="closePop"><span class="hidden">닫기</span></a>

