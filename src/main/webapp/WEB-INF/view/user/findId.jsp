<%@ page language='java' contentType='text/html; charset=utf-8' pageEncoding='utf-8'%>
<%@ taglib prefix='c' uri='http://java.sun.com/jsp/jstl/core' %>
<!DOCTYPE html>
<html>
<%@ include file="../include/lib.jsp" %>
<title>THEJOEUN ShoppingMall</title>
<script>
let searchDone = 0;
let emailChecked = 0;
function activateBtn(){
	$('#sendMail').prop('disabled',false);
}

function validateEmail(email){
	filter = /^([\w-\.]+)@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.)|(([\w-]+\.)+))([a-zA-Z]{2,4}|[0-9]{1,3})(\]?)$/;
	if(filter.test(email)){
		return true;
	} else {
		return true;
	}
}

function changeView(address){
	window.location.href=address;
	}

function init(){
	$("#userEmail").keyup(()=>{ 
		var email=$("#email").val(); 
		if(validateEmail(email)){
			emailChecked = 1;
		}
	});
	$('#sendMail').click(()=>{
		if(emailChecked == 1){
			$('#sendMail').text('인증메일 재발송');
			$('#sendMail').prop('disabled', true);
			$.ajax({
				type:'post',
				url:"${pageContext.request.contextPath}/user/sendMail",
				data:JSON.stringify({
					to:$('#userEmail').val(),
					subject:'이메일변경 인증메일 입니다.',
					textUp:`안녕하세요.<br>
							이메일 변경을 위한 인증번호 입니다.<br>
							다음 인증 번호를 이메일 인증번호 란에 입력해주세요.<br>
							인증번호: 
							`,
					textDown:`<br>
							항상 더 좋은 서비스로 보답하는 더조은쇼핑이 되겠습니다.<br>
							감사합니다.
							`
				}),
				contentType:'application/json'
			}).done(result=>{
				$('#msg').text('인증메일을 발송했습니다.');
				$('#commonModal').modal();
			}).fail(err =>{
				$('#msg').text('메일 발송에 실패했습니다. 메일주소를 확인해주세요.');
				$('#commonModal').modal();
			})
			setTimeout(activateBtn, 180000);
		} else{
			$('#msg').text('이메일 주소를 확인해주세요.');
			$('#commonModal').modal();
		}
	});
    
	$('#goToLogin').click(()=>{
		changeView('${pageContext.request.contextPath}/user/login');
	})
	
    $('#checkValid').click(()=>{
    	if(!$('#userEmail').val()){
    		$('#userEmail').focus();
    	}else{
			var valicode = $('#verificationCode').val();
			//세션에 저장된 인증번호와 입력값 비교
			$.ajax({
				type:'post',
				url:"${pageContext.request.contextPath}/user/compareCode",
				data:JSON.stringify({
					code:valicode
				}),
				contentType:'application/json'
			}).done(result => {
				if(result != ""){
					$.ajax({
            			type:'post',
            			url:"${pageContext.request.contextPath}/user/findId",
            			data:JSON.stringify({
            				to:$('#userEmail').val()
            			}),
            			contentType:'application/json'
            		}).done(result => {
            			if(result != ""){
            				searchDone = 1;
            				$('#msg').text('회원님의 아이디는 '+result+' 입니다.');
                			$('#commonModal').modal();
                			emailChecked = 0;
            			} else{
            				$('#msg').text('비정상적인 접근입니다.');
                			$('#commonModal').modal();
            			}
            		})
				}
			})
    	}
    })
    
    $('#okBtn').click(()=>{
    	$('#commonModal').modal('hide');
    	if(searchDone == 1){
    		changeView("${pageContext.request.contextPath}/user/login");
    	}
    })
}
$(init);
</script>

<style>
</style>

<body>
<div class='container'>
	<%@ include file='../include/header.jsp' %>
		<h4>아이디 찾기</h4><hr>
	<div class="mid">
		<div class='row m-3' style="width:50vw">
			<label for='email' class='form-label' style="width:70px">이메일: </label>
			<div class='col' style="width:300px">
				<input type='email' class='form-control' id='userEmail' name='userEmail' value=''/>
			</div>
			<div class='col-3' style="width:180px">
				<button type='button' class='btn btn-secondary btn-block' id='sendMail' style="width:120px; height:50px;">인증번호 발송</button>
			</div>	
		</div>
		<div class='row m-3' style="width:50vw">
			<label for='verification code' class='form-label' style="width:70px" >인증번호: </label>
			<div class='col'>
				<input type='text' class='form-control' id='verificationCode' name='verificationCode' value='' placeholder='인증번호를 입력하세요'/>
			</div>
			<div class='col-3'></div>
		</div>
			
	</div>
	<div class="row d-flex justify-content-center">
			<button type="button" class="btn btn-outline-secondary m-5" style="width:120px; height:50px;" id="goToLogin">로그인 페이지</button>
			<button type="button" class="btn btn-outline-secondary m-5" style="width:120px; height:50px;" id="checkValid">확인</button>
	</div>
	<div class='row' style='height:50px'></div>
		
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
					<p id='msg'></p>
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