<%@ page language='java' contentType='text/html; charset=utf-8'
	pageEncoding='utf-8'%>
<%@ taglib prefix='c' uri='http://java.sun.com/jsp/jstl/core'%>
<!DOCTYPE html>
<html>
<head>
<title>THEJOEUN ShoppingMall</title>
<%@ include file ="../include/lib.jsp"%>
<script>
function changeIframe(addr){
	$('#iframe').attr('src',addr);
}
function init(){
	$('#userDetail').click(()=>{
		changeIframe('<%=request.getContextPath() %>/user/userDetail');
	})
	$('#purchaseHistory').click(()=>{
		changeIframe('<%=request.getContextPath() %>/purchase/purchaseHistory');
	})
	$('#userDetail').click();
	
	//$('#iframe')[0].contentWindow.modalClose("#okBtn", "#commonModal");
}
$(init);
</script>
<style>
</style>
</head>
<body>
   <div class='container'>
		<%@ include file='../include/header.jsp' %>
   <div class='row'>
      <div class='col'>
         <hr>
      </div>
   </div>
   
   <div class='row' style='height:600px;'>
      <div class='col-3'>
         <table class='table table-bordered'>
            <thead class='thead-light text-center'>
               <tr>
                  <th colspan='3'>마이페이지</th>
               </tr>
            </thead>
            <tbody class='text-center'>
               <tr>
                  <td>
                  <a id='userDetail'><b>회원 상세</b></a>
                  </td>
               </tr>
               <tr>
                  <td><a id='purchaseHistory'>구매내역</a></td>
               </tr>
            </tbody>
         </table>
      </div>
      <div class='col-9'>
		<div class='row d-flex justify-content-center align-items-center'>
			<iframe name='childWindow' id='iframe' style='width:800px; height:800px' frameborder=0 framespacing=0 marginheight=0 marginwidth=0 scrolling=no vspace=0>
				<p>이 브라우저에서는 iframe을 지원하지 않습니다.</p>
			</iframe>
		</div>
		</div>
	</div>
</div>
<%@ include file="../include/footer.jsp" %>


<div id='secessionModal' class='modal fade' tabindex='-1'>
		<div class='modal-dialog'>
			<div class='modal-content'>
				<div class='modal-header'>
					<h5 class='modal-title'>회원탈퇴</h5>
					<button type='button' class='close' data-dismiss='modal'>
						<span>&times;</span>
					</button>
				</div>
				<div class='modal-body'>
					<p>회원 탈퇴를 하시겠습니까?</p>
				</div>
				<div class='modal-footer'>
					
					<button type='button' class='btn btn-outline-secondary' data-dismiss='modal' id='noBtn'>아니오</button>
					<button type='button' class='btn btn-outline-secondary' id='okBtn'>예</button>
				</div>
			</div>
		</div>
	</div>

</body>
</html>

