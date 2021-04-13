<%@ page language='java' contentType='text/html; charset=utf-8' pageEncoding='utf-8'%>
<%@ taglib prefix='c' uri='http://java.sun.com/jsp/jstl/core' %>
<html>
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
	<header>
		<div class='row'>
			<div class='col'>
				<div id="logoTop">
					<div><a href = "<%=request.getContextPath() %>/"><img id='logoImg'/></a></div>
				</div>
			</div>
			<div class='col-8'>
				<div id="nav">
					<div id="rightBar">
						<a href="<%=request.getContextPath() %>/">사용자 페이지 이동</a> <span>|</span> <a
							href="<%=request.getContextPath() %>/user/logout"><span>ADMIN LOGOUT</span></a> <span>|</span>
					</div>
				</div>
			</div>
		</div>
	</header>
	<hr>
	<!-- /include: header -->
</html>
