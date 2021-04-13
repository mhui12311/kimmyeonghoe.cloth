<%@ page language='java' contentType='text/html; charset=utf-8'
	pageEncoding='utf-8'%>
<%@ taglib prefix='c' uri='http://java.sun.com/jsp/jstl/core'%>
<!DOCTYPE html>
<html>
<head>
<title>THEJOEUN ShoppingMall</title>
<%@ include file ="../include/lib.jsp"%>
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>

<script>
let changeSuccess = 0;
let changeFunction = 0;
function activateBtn(){
	$('#sendMail').prop('disabled',false);
}

function searchAddr(){
	 new daum.Postcode({
	        oncomplete: function(data) {
	        	$('#postCode').val(data.zonecode); 
				$('#address1').val(data.address);
				$('#address2').val(data.buildingName);
        }
    }).open();
	
	 $('#address2').attr('disabled',false);
}

function changeView(address){
	window.location.href=address;
}
function validateContact(contact){
	var pattern = /^0\d{2}\d{3,4}\d{4}$/
	if(pattern.test(contact) && contact.length ==11 || contact.length == 10){
		return true;
	} else{
		return false;
	}
}
function validateEmail(email){
	filter = /^([\w-\.]+)@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.)|(([\w-]+\.)+))([a-zA-Z]{2,4}|[0-9]{1,3})(\]?)$/;
	if(filter.test(email)){
		return true;
	} else {
		return false;
	}
}

function loadUserData(){
	$('#details').empty();
	$.ajax({
		method:'post',
		url:"<%=request.getContextPath() %>/user/userDetail"
	}).done(userData => {
		if(userData) {
			let splitUser = [];
			
			splitUser.unshift(
				`<tr>
					<th>아이디</th>
					<td>\${userData.userId}</td>
				</tr>
				<tr>
					<th>비밀번호</th>
					<td><button type = "button" class = "btn btn-outline-secondary" id='changePw' onclick='window.top.location.href="${pageContext.request.contextPath}/user/changePw"'>비밀번호 변경</button></td>
				</tr>
				<tr>
					<th>이름</th>
					<td>\${userData.userName}</td>
				</tr>
				<tr>
					<th>생년월일</th>
					<td>\${userData.birthday}</td>
				</tr>
				<tr>
					<th>이메일</th>
					<td>\${userData.email} <button type = "button" id="changeMailBtn" class = "btn btn-outline-secondary" data-toggle='modal', data-target='#emailModal' >이메일 변경</button></td>
				</tr>
				<tr>
					<th>연락처</th>
					<td>
						\${userData.contact} <button type='button' class='btn btn-outline-secondary btn-sm' data-toggle='modal', data-target='#contactModal'>연락처 변경</button>
					</td>
				</tr>
				<tr>
					<th><label for="post"> 우편번호<span></span></label></th>
						<td>
							<input type="text" name="addr"  id='postCode' style="width:80px; height:26px;" value='\${userData.postcode}' disabled/>
							<button type='button' class='btn btn-outline-secondary btn-sm' id='addrBtn' onclick='changeAddress()'>주소검색</button>
						</td>
					</tr>
					<tr>
						<th><label for="address"> 주소</label></th>
					<td>
						<input type="text" name="addr" id='address1' style="width:300px; height:30px;" value='\${userData.address}' disabled/>
						<input type="text" name="addr" id='address2' style="width:300px; height:30px;" value='\${userData.addressDetail}'/>
					</td>
				</tr>`
			);
			
			$('#details').append(splitUser.join(''));
		} else {
			$('#details').append('<tr><td colspan=4 class=text-center>x.</td></tr>');
		}
	});
}
function changeContact(){
	var contact = $('#contact').val();
	if(validateContact(contact)){
		$.ajax({
			type:'post',
			url:"${pageContext.request.contextPath}/user/changeContact",
			data:JSON.stringify({
				contact : contact
			}),
			contentType:'application/json'
		}).done(() => {
			$('#bodyMsg').text('전화번호가 변경되었습니다.');
			$('#commonModal').modal();
			changeSuccess=1;
		})
	} else {
		$('#bodyMsg').text('유효하지 않은 전화번호 입니다.');
		$('#commonModal').modal();
	}
}

function changeAddress(){
	var postcode = $('#postCode').val();
	var address1 = $('#address1').val();
	var address2 = $('#address2').val();
	if(changeFunction == 0){
		$('#addrBtn').text('주소변경');
		changeFunction = 1;
		searchAddr();
	} else {
		$('#addrBtn').text('주소검색');
		changeFunction = 0;
		$.ajax({
			type:'post',
			url:"${pageContext.request.contextPath}/user/changeAddress",
			data:JSON.stringify({
				postcode:postcode,
				address:address1,
				addressDetail:address2
			}),
			contentType:'application/json'
		}).done(() => {
			$('#bodyMsg').text('주소가 변경되었습니다.');
			$('#commonModal').modal();
			changeSuccess=1;
		})
	}
}
function init(){
	
	loadUserData();
	$('#contact').keyup(()=>{
		var num = $('#contact').val();
		if(validateContact(num)){
			$('#contact-danger').text("");
			$('#contact-success').text("사용가능한 전화번호 입니다.");
		} else{
			$('#contact-danger').text("예시와 같이 숫자만 입력해주세요 ex 01012345678");
			$('#contact-success').text("");
		}
	})
	
	$('#sendMail').click(()=>{
    	var email = $('#userEmail').val();
    	if(validateEmail(email)){
			$('#email-danger').text("");
			
			$.ajax({
				type:'post',
				url:"${pageContext.request.contextPath}/user/compareEmail",
				data:JSON.stringify({
					email:email
				}),
				contentType:'application/json'
			}).done(result=>{
				if(result != "success"){
					$('#bodyMsg').text('이미 사용중인 이메일 입니다.');
					$('#commonModal').modal();
				} else {
					$('#sendMail').text('인증메일 재발송');
					$('#sendMail').prop('disabled', true);
					var valicode = $('#verificationCode').val();
					$.ajax({
						type:'post',
						url:"${pageContext.request.contextPath}/user/findId",
						data:JSON.stringify({
							to:$('#userEmail').val(),
							userId:""
						}),
						contentType:'application/json'
					}).done(result => {
						if(result == ""){
							$.ajax({
								type:'post',
								url:"${pageContext.request.contextPath}/user/sendMail",
								data:JSON.stringify({
									to:$('#userEmail').val(),
									subject:'이메일 변경 인증메일 입니다.',
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
							}).done(result =>{
								$('#bodyMsg').text('인증메일을 발송했습니다.');
								$('#commonModal').modal();
								emailChecked = 1;
							}).fail(err =>{
								$('#bodyMsg').html('<p>메일 발송에 실패했습니다.<br> 이메일주소를 해주세요.</p>');
								$('#sendMail').text('인증메일 발송');
								activateBtn();
								$('#commonModal').modal();
							})
						} else{
							$('#bodyMsg').html('<p>사용중인 이메일 입니다.<br> 다른 이메일 주소를 입력해주세요.</p>');
							$('#sendMail').text('인증메일 발송');
							activateBtn();
			    			$('#commonModal').modal();
						}
					})
					setTimeout(activateBtn, 180000);
				}
			})
		}
		
	});
	
	$('#done').click(()=>{
		var email = $('#userEmail').val();
		var valicode = $('#verificationCode').val();
		
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
					url:"${pageContext.request.contextPath}/user/changeEmail",
					data:JSON.stringify({
						email:email
					}),
					contentType:'application/json'
				}).done(()=>{
					$('#bodyMsg').text('이메일이 변경되었습니다.');
					$('#commonModal').modal();	
					changeSuccess = 1;
					$('#userMail').val('');
					$('#verificationCode').val('');
				})
			} else {
				$('#bodyMsg').text('인증번호가 올바르지 않습니다.');
				$('#commonModal').modal();
			}
		})
	});
  
    $('#okBtn').click(()=>{
    	$('#commonModal').modal('hide');
    	$('#noBtn').hide();
    	if(changeSuccess == 1){
    		changeSuccess = 0;
    		$('#emailModal').modal('hide');
    		$('#contactModal').modal('hide');
    		loadUserData();
    	}
    })
}
$(init);

</script>
<style>
table.type10 {
    width: 100%;
    border-collapse: collapse;
    text-align: left;
    border-bottom: 1px solid #444444;
    border-top: 1px solid #444444;
}
table.type10 th {
  padding: 15px;
  font-weight: bold;
  vertical-align: top;
}
  table.type10 th {
  width: 150px;
  padding: 15px;
}
</style>
</head>
<body>
   <div class='container'>
   <div class='row'></div>
   <div class='row'>
      <div class='col'>
      	<h5><b>회원 상세</b></h5><hr>
		<div class='row'>
				<table class='type10'><!-- <table class='table-borderless'> -->
					<thead></thead>
					<tbody id='details'></tbody>
				</table>
			</div>
			<div class='row mt-2'>
				<div class='col'>
					<button type='button' class='btn btn-outline-secondary' data-toggle='modal' data-target='#secessionModal'>회원 탈퇴</button>
				</div>
			</div>
		</div>
	</div>
</div>

<div id='emailModal' class='modal fade' tabindex='-1'>
		<div class='modal-dialog'>
			<div class='modal-content'>
				<div class='modal-header'>
					<h5 class='modal-title'>이메일 변경</h5>
					<button type='button' class='close' data-dismiss='modal'>
						<span>&times;</span>
					</button>
				</div>
				<div class='modal-body'>
					<table>
						<tr>
							<th scope="row"><label><span class="req" ></span> 이메일</label></th>
							<td>
								<input name="userEmail" id="userEmail" type="text" title="이메일 아이디" class="form-control" />
								<span class="text-success" id="email-success"></span>
								<span style="color:#a94442;" class="text-danger" id="email-danger"></span>
							</td>
						</tr>
						<tr>
							<th scope="row" ><label for='email' class='form-label' style="width:70px">인증번호: </label></th>
							<td>
								<input type='email' class='form-control' id='verificationCode' name='verificationCode'/>
							</td>
							<td>
								<button type='button' class='btn btn-outline-secondary' id='sendMail'>인증메일 발송</button>
							</td>
						</tr>
						<tr>
							<th scope="row"></th>
						<td></td>
						<td>
							<button type='button' class='btn btn-outline-secondary' id='done'>확인</button>
						</td>
						</tr>
					</table>
				</div>
			</div>
		</div>
</div>

<div id='contactModal' class='modal fade' tabindex='-1'>
		<div class='modal-dialog'>
			<div class='modal-content'>
				<div class='modal-header'>
					<h5 class='modal-title'>연락처 변경</h5>
					<button type='button' class='close' data-dismiss='modal'>
						<span>&times;</span>
					</button>
				</div>
				<div class='modal-body'>
					<table>
						<tr>
							<th scope="row"><label>연락처 &nbsp;</label></th>
							<td>
								<input name="userEmail" id="contact" type="text" title="연락처" class="form-control" style='width:200px'/>
								<span class="text-success" id="contact-success"></span>
								<span style="color:#a94442;" class="text-danger" id="contact-danger"></span>
								<span style="color:#a94442;" class="text-danger" id="contact-danger2"></span>
							</td>
						</tr>
						<tr>
							<th scope="row"></th>
						<td></td>
						<td>
							<button type='button' class='btn btn-outline-secondary' onclick='changeContact()'>확인</button>
						</td>
						</tr>
					</table>
				</div>
			</div>
		</div>
</div>

<div id='commonModal' class='modal fade' tabindex='-1'>
		<div class='modal-dialog'>
			<div class='modal-content'>
				<div class='modal-header'>
					<h5 class='modal-title'>인증확인</h5>
					<button type='button' class='close' data-dismiss='modal'>
						<span>&times;</span>
					</button>
				</div>
				<div class='modal-body'>
					<p id='bodyMsg'></p>
				</div>
				<div class='modal-footer'>
					<button type='button' class='btn btn-outline-secondary' id='okBtn'>예</button>
				</div>
			</div>
		</div>
</div>



</body>
</html>

