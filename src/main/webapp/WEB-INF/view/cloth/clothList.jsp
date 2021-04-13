<%@ page language='java' contentType='text/html; charset=utf-8'	pageEncoding='utf-8'%>
<%@ taglib prefix='c' uri='http://java.sun.com/jsp/jstl/core'%>
<!DOCTYPE html>
<html>
<head>
<title>THEJOEUN ShoppingMall</title>
<%@ include file="../include/lib.jsp"%>
<script>
function isVal(field) {
	let check = false;
	let fieldName;
	
	if(field.length)
		if(field.val()) check = true;
	return check;
}

function changeView(address){
	window.location.href=address;
}

function listCloths() {
	$('#clothList').empty();
	$.ajax('list')
	.done(cloths => {
		if(cloths.length) {
			let clothList = [];
			
			$.each(cloths, (idx, cloth) => {
				clothList.unshift(
					`<tr>
						<th>
							<a href='<%=request.getContextPath() %>/cloth/clothDetail/\${cloth.clothNum}'>
								<button value='\${cloth.clothNum}' class='btn btn-outline-dark' type='button'>
									<p>\${cloth.clothName}</p>
								</button>
							</a>
						</th>
						<td>상품 이미지\${cloth.imageName}</td>
						<td>\${cloth.price}</td>
					</tr>`
				);
			});
			
			$('#clothList').append(clothList.join(''));
		} else {
			$('#clothList').append('<tr><td colspan=3 class=text-center>옷이 없습니다.</td></tr>');
		}
	}).fail(err => {
		$('#clothList').append('<tr><td colspan=3 class=text-center>목록 불러오기 실패.</td></tr>');
	});
}

function init() {
	listCloths();

}

$(init);
</script>
<style>
</style>
</head>
<body>
	<div class='container'>
	<%@ include file ="../include/header.jsp"%>
		<div class='form-group row justify-content-center'>
			<div class='col'>
				<table class='table table-bordered'>
					<thead class='thead-light'>
						<tr>
							<th>상품명</th>
							<th>이미지</th>
							<th>판매가</th>
						</tr>
					</thead>
					<tbody id='clothList'>
					</tbody>
				</table>
			</div>
		</div>
	</div>
	<%@ include file ="../include/footer.jsp"%>
</body>
</html>