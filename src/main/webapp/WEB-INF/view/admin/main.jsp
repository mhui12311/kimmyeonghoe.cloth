<%@ page language='java' contentType='text/html; charset=utf-8' pageEncoding='utf-8'%>
<%@ taglib prefix='c' uri='http://java.sun.com/jsp/jstl/core' %>
<!DOCTYPE html>
<html>
<head>
<title>THEJOEUN ShoppingMall</title>
<%@ include file ="../include/lib.jsp"%>
<style>
</style>
</head>
<body>
	<div class='container'>
	<%@ include file="../include/adminHeader.jsp" %>

	<div class='row'>
		<%@ include file="../include/adminGnb.jsp" %>	

		<div class='col-9'> 
					<div class='row' >
						<div class='col' id="adminOrder">
							<h5>주문 현황</h5>
							<table class='table table-bordered mt-3 text-center'>
								<thead class='thead-light'>
									<tr>
										<th>결제 완료</th>
										<th>상품 준비중</th>
										<th>배송중</th>
										<th>배송완료</th>
									</tr>
								</thead>
								<tbody id='OrderStatus' class='table-bordered'>
									<tr>
										<td>10</td>
										<td>5</td>
										<td>3</td>
										<td>8</td>
									</tr>
								</tbody>
							</table>
						</div>
						
					</div>
					<div class='row justify-content-center' style='height:400px'>
							<div class='col mt-5' id="adminBorder">
								<h5>게시판 현황</h5>
								<table class='table table-hover table-bordered mt-3 text-center'>
									<thead class='thead-light'>
										<tr>
											<th>상품 후기</th>
											<th>상품 문의</th>
											<th>1:1문의</th>
										</tr>
									</thead>
									<tbody id='borderStatus' class='table-bordered'>
										<tr>
											<td>50</td>
											<td>15</td>
											<td>3</td>
										</tr>
									</tbody>
								</table>
							</div>
						</div>
		</div>
	</div>
</div>
	
</div>
<!-- include: footer -->
	<%@ include file ="../include/footer.jsp"%>
<!-- /include: footer -->
</body>
</html>

