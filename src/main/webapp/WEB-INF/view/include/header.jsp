<%@ page language='java' contentType='text/html; charset=utf-8' pageEncoding='utf-8'%>
<%@ taglib prefix='c' uri='http://java.sun.com/jsp/jstl/core' %>
<script>
function loadLogo(){
	$.ajax({
        method: 'post',
        url:"${pageContext.request.contextPath}/admin/logo/load",
        success: result => {
           if(result != "") {
           	$('#logoImg').show();
           	var filePlace = "/res/"+result;
           	var srcValue = `<c:url value="/res/\${result}"/>`
           	$('#logoImg').attr('src', srcValue);
           } else {
           	$('#logoImg').hide();
           }
        },
        error: err => {
        }
     })
}
function init(){
	loadLogo()
}
$(init);
</script>
<style>
#logoImg{
	width:50px;
	height:50px;
}
</style>
<html>
	<div class='header'>
	   <c:if test="${empty login}">
		      <div class='row'>
		         <div class='col'>
		            <div><a href = "<%=request.getContextPath() %>/"><img id='logoImg'/></a></div>
		         </div>
		         <div class='col-8'>
		               <div id = 'rightBar'>
		                  <a href = "<%=request.getContextPath() %>/user/login"> LOGIN </a><span>|</span>
		                  <a href = "<%=request.getContextPath() %>/user/join"><span> JOIN </span></a><span>|</span>
		                  <a href = "#"><span> CART </span></a><span>|</span>
		               </div>
		         </div>
		      </div>
		</c:if>
		
		<c:if test="${not empty login}">
			<div class='row'>
		         <div class='col'>
		            <div><a href = "<%=request.getContextPath() %>/"><img id='logoImg'/></a></div>
		         </div>
		         <div class='col-8'>
		               <div id = 'rightBar'>
		                  <a href = "<%=request.getContextPath() %>/myPage"> MY PAGE </a><span>|</span>
		                  <a href = "#"><span> CART </span></a><span>|</span>
		                  <a href = "<%=request.getContextPath() %>/user/logout"><span> LOGOUT </span></a><span>|</span>
		               </div>
		         </div>
		      </div>
		</c:if>
		
		<%@ include file ="./gnb.jsp"%>
		<div class='row'>
         <div class='col mt-3'>
            <div id = "banner"><br><p>배너 이미지</p></div>
         </div>
      </div><br><br>
   </div>
</html>
