<%@ page language='java' contentType='text/html; charset=utf-8' pageEncoding='utf-8'%>
<%@ taglib prefix='c' uri='http://java.sun.com/jsp/jstl/core' %>
<!DOCTYPE html>
<html>
<%@ include file="../include/lib.jsp" %>
<title>THEJOEUN ShoppingMall</title>
<script>
let pwOk = 0;
function validatePw(str) {
	if(str.length >= 4 ) {
		$('#pw-danger').text("");
		$('#pw-success').text("사용가능한 비밀번호 입니다.");
	}
	else {
		$('#pw-success').text("");
		$('#pw-danger').text("비밀번호는 4글자 이상 입력해야 합니다.");
	}
}

function changeView(address){

	window.location.href=address;
	
	}
	
function init(){
	$("#password1").keyup(()=>{ 
		var pwd1=$("#password1").val(); 
		validatePw(pwd1);
	});
	$("#password2").keyup(()=>{ 
		var pwd1=$("#password1").val(); 
		var pwd2=$("#password2").val(); 
		if(pwd1 != "" || pwd2 != ""){ 
			if(pwd1 == pwd2){ 
				pwOk =1;
				$('#pw2-danger').text("");
				$('#pw2-success').text("비밀번호가 일치합니다.")
			}else{ 
				$('#pw2-danger').text("비밀번호가 일치하지 않습니다.")
				$('#pw2-success').text("")
			} 
		}
	});
	
	$("#done").click(()=>{
		if(pwOk == 1){
			$.ajax({
				type:'post',
				url:"${pageContext.request.contextPath}/user/changePw2",
				data:({
					userPw:$('#password2').val()
				})
			}).done(result =>{
				$('#bodyMsg').text('비밀번호가 변경되었습니다.');
				$('#noBtn').hide();
				$('#commonModal').modal();
			}).fail(err =>{
				pwOk = 0; 
				$('#bodyMsg').text('비밀번호 변경에 실패했습니다.');
				$('#noBtn').hide();
				$('#commonModal').modal();
			});
		} else {
			pwOk = 0;
			$('#password1').val('');
			$('#password2').val('');
			$('#bodyMsg').text('비밀번호가 일치하지 않습니다.');
			$('#commonModal').modal();
		}
		
	})
	$('#okBtn').click(()=>{
		if(pwOk == 1){
			changeView("${pageContext.request.contextPath}/user/login");
		}
		else $('#commonModal').modal("hide");
	})
	
	$('#goToLogin').click(()=>{
		changeView("${pageContext.request.contextPath}/user/login");
	})
}
$(init);
</script>
<style>
</style>

<body>
<div class='container'>
	<%@ include file='../include/header.jsp' %>
		<h4>비밀번호 변경</h4><hr>
		
	<div class='content' style="height:400px">
		<div class='row' style="height:30px"></div>
		<div class='row' >
			<div class='col-3'>
				<label for="password2" class='d-flex justify-content-end' ><span class="req"></span>새 비밀번호</label>
			</div>
			<div class='col'>
			
				<input type="password" name="password1" id="password1" class="form-control"  />
				<div class="inputDeco">
		    		<span class="text-success" id="pw-success"></span>
					<span style="color:#a94442;" class="text-danger" id="pw-danger"></span>
		    	</div>
			</div>
		</div>
		<div class='row' style="height:30px"></div>
		<div class='row' >
			<div class='col-3'>
				<label for="password2" class='d-flex justify-content-end'><span class="req"></span> 새 비밀번호 확인</label>
			</div>
			<div class='col'>
			
				<input type="password" name="password2" id="password2" class="form-control"  />
				<div class="inputDeco">
		    		<span class="text-success" id="pw2-success"></span>
					<span style="color:#a94442;" class="text-danger" id="pw2-danger"></span>
		    	</div>
			</div>
		</div>
		<div class="midBottom" align="center">
			<div class='row' style="height:30px"></div>
			<div class='row' >
				<div class='col' align="right">
					<button type="button" class="btn btn-outline-secondary" style="width:120px; height:50px;" id="goToLogin">로그인 페이지</button>
				</div>
				<div class='col' align="left">
					<button type="button" class="btn btn-outline-secondary" style="width:120px; height:50px;" id="done">확인</button>
				</div>
			</div>
				
		</div>
	</div>
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
					<button type='button' class='btn btn-outline-secondary' id='okBtn'>확인</button>
				</div>
			</div>
		</div>
	</div>  
	<%@ include file='../include/footer.jsp' %>
</body>
</html>