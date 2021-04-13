<%@ page language='java' contentType='text/html; charset=utf-8' pageEncoding='utf-8'%>
<%@ taglib prefix='c' uri='http://java.sun.com/jsp/jstl/core' %>
<!DOCTYPE html>
<html>
<%@ include file="../include/lib.jsp" %>
<title>THEJOEUN ShoppingMall</title>
<script>

function changeView(address){
	window.location.href=address;
}
function purchaseDetails(){
	
}
function loadHistory(){
	$('#details').empty();
	
	$.ajax({
		method:'post',
		url:"<%=request.getContextPath() %>/purchase/clothNames"
	}).done(cloths => {
		if(cloths.length) {
			var names = "";
			var count = 0;
			
			$.each(cloths, (idx, cloth) => {
				if(count != 0){
					names = names + ' 외 ' + count;
				} else {
					names = names + cloth.clothName;
					count = count + 1;
				}
			})
			
			$.ajax({
				method:'post',
				url:"<%=request.getContextPath() %>/purchase/purchaseHistory"
			}).done(userData => {
				if(userData) {
					let splitUser = [];
						splitUser.unshift(
								`<tr>
									<td><input type='checkbox'>\${userData.purchaseNum}</td>
									<td>\${userData.purchaseDate}</td>
									<td><a onclick='purchaseDetails()'>\${names}</a></td>
									<td>\${userData.price}</td>
									<td>\${userData.deliveryState}</td>
								</tr>`
							);
					
					$('#details').append(splitUser.join(''));
				} else {
					$('#details').append('<tr><td colspan=4 class=text-center>구매내역이 없습니다.</td></tr>');
				}
			});
		}
	});
	/*
	
	*/
}

function init(){
	loadHistory();
  
}
$(init);

</script>
<style>
table.type10 {
    width: 100%;
    border-collapse: collapse;
    border-bottom: 1px solid #444444;
    border-top: 1px solid #444444;
}
table.type10 th {
  padding: 15px;
  font-weight: bold;
  vertical-align: top;
  justify-content:center;
}
</style>

<body>
<div class='container'>

	<div class='row'>
		<h5><b>| 구매내역</b></h5>
	</div>
	<div class='row'>
		<table class='type10'>
					<thead>
					   	<tr>
						   	<th style='width:50px'></th>
						    <th style='width:100px'>구매일</th>
						    <th style='width:150px'>내용</th>
						    <th>금액</th>
						    <th>상태</th>
					   </tr>
					</thead>
					<tbody id='details'>
					</tbody>
				</table>
				
	</div>
			<div class='row' id='space' style='height:30px'></div>
			<div class='row d-flex justify-content-end'>
				<button type = button class='btn btn-outline-secondary'id='cancelSubmit'>취소</button>
			</div>
			<div class='row d-flex justify-content-end'>
				<button type = button class='btn btn-outline-secondary'id='refundSubmit'>환불</button>
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
</body>
</html>