<%@ page language='java' contentType='text/html; charset=utf-8' pageEncoding='utf-8'%>
<%@ taglib prefix='c' uri='http://java.sun.com/jsp/jstl/core' %>
<html>
	<!-- include: gnb -->
      <div class='col-3'>
         <div id='adminMenu' class='accordian mt-3'>
            <div class='card'>
               <div id='heading1' class='card-header'>
                  <h2 class='mb-0'>
                     <button class='btn btn-block text-left' type='button'
                     data-toggle='collapse' data-target='#body1'>회원</button>
                  </h2>
               </div>
               <div id='body1' class='collapse' data-parent='#adminMenu'>
                  <div class='card-body'>
                     <a href='../user/01.html'><span>-회원목록</span></a><br> 
                     <a href='../user/03.html'><span>-자동메일</span></a><br>
                     <a href='../user/04.html'><span>-탈퇴회원목록</span></a><br>
                     <a href='../user/05.html'><span>-이용약관</span></a><br>
                     <a href='../order/01.html'><span>-주문조회</span></a>
                  </div>
               </div>
            </div>
            <div class='card'>
               <div id='heading2' class='card-header'>
                  <h2 class='mb-0'>
                     <button class='btn btn-block text-left' type='button'
                        data-toggle='collapse' data-target='#body2'>상품</button>
                  </h2>
               </div>
               <div id='body2' class='collapse' data-parent='#adminMenu'>
                  <div class='card-body'>
                     <a href="<%=request.getContextPath() %>/admin/cloth/clothList"><span>-상품조회</span></a><br>
                     <a href="<%=request.getContextPath() %>/admin/cloth/insert"><span>-상품등록</span></a><br>
                  </div>
               </div>
            </div>
            <div class='card'>
               <div id='heading3' class='card-header'>
                  <h2 class='mb-0'>
                     <button class='btn btn-block text-left' type='button'
                        data-toggle='collapse' data-target='#body3'>게시판</button>
                  </h2>
               </div>
               <div id='body3' class='collapse' data-parent='#adminMenu'>
                  <div class='card-body'>
                     <a href="<%=request.getContextPath() %>/admin/notice/list">-공지사항</a><br>
                     <a href="<%=request.getContextPath() %>/admin/notice/faq"><span>-FAQ</span></a><br>
                     <a href="<%=request.getContextPath() %>/admin/question/list"><span>-문의</span></a><br>
                     <a href="<%=request.getContextPath() %>/admin/review/list"><span>-리뷰</span></a>
                  </div>
               </div>
            </div>
            <div class='card'>
               <div id='heading4' class='card-header'>
                  <h2 class='mb-0'>
                     <button class='btn btn-block text-left' type='button'
                        data-toggle='collapse' data-target='#body4'>홈페이지</button>
                  </h2>
               </div>
               <div id='body4' class='collapse' data-parent='#adminMenu'>
                  <div class='card-body'>
                     <a href="<%=request.getContextPath() %>/admin/logo/logo"><span>-로고</span></a><br>
                     <a href="<%=request.getContextPath() %>/admin/banner/banner"><span>-배너</span></a><br>
                  </div>
               </div>
            </div>
         </div>
      </div>
      <!-- /include: gnb -->
</html>
