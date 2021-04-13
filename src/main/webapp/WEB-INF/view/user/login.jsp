<%@ page language='java' contentType='text/html; charset=utf-8'
	pageEncoding='utf-8'%>
<%@ taglib prefix='c' uri='http://java.sun.com/jsp/jstl/core'%>
<%@ taglib prefix='f' uri='http://www.springframework.org/tags/form' %>
<!DOCTYPE html>
<html>
<head>
<title>THEJOEUN ShoppingMall</title>

<%@ include file ="../include/lib.jsp"%>

<script>
function init(){
	$('#loginBtn').click(()=>{
		var userId = $('#userId').val();
		var userPw = $('#userPw').val();
		var rememberId = $('#rememberId:checked').val();
		if(userId == ""){
			$('#userId').focus();
			return;
		}
		if(userPw == ""){
			$('#userPw').focus();
			return;
		}
		console.log("로그인시도");
		$.ajax({
			type:'post',
			url:"${pageContext.request.contextPath}/user/login",
			data:{
				userId:userId,
				userPw:userPw,
				rememberId:rememberId
			}
		}).done(result=> {
			if(userId == "admin" && userPw =="admin"){
				location.href="${pageContext.request.contextPath}/admin";
			}else{
				location.href="${pageContext.request.contextPath}/";	
			}
		}).fail(err => {
			$("#bodyMsg").text('아이디나 비밀번호를 확인해주세요.');
			$('#commonModal').modal();
			$('#noBtn').hide();
			
		});
	});
	$('#okBtn').click(()=>{
		$('#commonModal').modal('hide');
		location.href="${pageContext.request.contextPath}/user/login";
	});
}

$(init);
</script>	
</head>
<body>
	<div class='container'>
<!-- include: header -->
	<%@ include file ="../include/header.jsp"%>
	<h4>로그인</h4><hr>
   <f:form modelAttribute='user' id='loginForm' method='post'>
		<div class='form-group row'>
			<label for='userId' class='col-2 col-form-label'>아이디: </label>
			<div class='col'>
				<input type='text' class='form-control' id='userId' name='userId' value='${cookie.loginCookie.value}'/>
			</div>
		</div>
		<div class='form-group row'>
			<label for='userPw' class='col-2 col-form-label'>암호: </label>
			<div class='col'>
				<input type='password' class='form-control' id='userPw' name='userPw'/>
			</div>
		</div>
		 <div class='form-row align-items-center'>
 			<div class='col-2'></div>
			<div class='col'>
				<div class='form-check form-check-inline'>
					<input type='checkbox' class='form-check-input' id='rememberId' name='rememberId' ${checked}/>
					<label class='form-check-label' for='rememberId' >아이디 저장</label>
				</div>	
			</div>
			<div class='col-4 justify-content-end' >
				<button type='button' class='btn btn-secondary btn-block' id='loginBtn'>로그인</button>
			</div>
		</div>
	</f:form>	
	<div class='row'>
		<div class='col-2'></div>
	   	<div class='col'>
	   		<a href = "<%=request.getContextPath() %>/user/findId">아이디 찾기</a>
			<span>|</span>
			<a href = "<%=request.getContextPath() %>/user/findPw"><span>비밀번호 찾기</span></a>
			<span>|</span>
			<a href = "<%=request.getContextPath() %>/user/join"><span>회원 가입</span></a>
			<span>|</span>
	   	</div>
	</div>
	<div class='row' style='height:200px'></div>
</div>
<div id='commonModal' class='modal fade' tabindex='-1'>
		<div class='modal-dialog'>
			<div class='modal-content'>
				<div class='modal-header'>
					<h5 class='modal-title'></h5>
					<button type='button' class='close' data-dismiss='modal'>
						<span>&times;</span>
					</button>
				</div>
				<div class='modal-body'>
					<p id='bodyMsg'></p>
				</div>
				<div class='modal-footer'>
					
					<button type='button' class='btn btn-secondary' data-dismiss='modal' id='noBtn'>아니오</button>
					<button type='button' class='btn btn-outline-secondary' data-dismiss='modal' id='okBtn'>예</button>
				</div>
			</div>
		</div>
	</div>

<!-- include: footer -->
<%@ include file ="../include/footer.jsp"%>
<!-- /include: footer -->
</body>
</html>