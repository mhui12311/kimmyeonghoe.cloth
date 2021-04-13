<%@ page language='java' contentType='text/html; charset=utf-8' pageEncoding='utf-8'%>
<%@ taglib prefix='c' uri='http://java.sun.com/jsp/jstl/core' %>
<html>
<script>
function changeView(address){
	window.location.href=address;
}
function init(){
	
	$('#searchBtn').click(()=>{
		var target = $('#searchBar').val();
		console.log('검색할 키워드 : '+ target);
		$.ajax({
			type:'post',
			url: '<%=request.getContextPath() %>/cloth/saveKeyword',
			data: ({
				keyword:target
			})
		}).done(() => {
			changeView('<%=request.getContextPath() %>/cloth/searchCloth');
		});
	});
}
$(init);
</script>
	<!-- include: gnb -->
      <div id = "title">
         <div id = "nav">
            <div class='row'>
               <div class='col '>
                  <div class="gnb_lists">
                     <a href = "<%=request.getContextPath() %>/cloth/clothList"><span>상품 리스트</span></a>
                     <span>&#124;</span>
                     <a href = "<%=request.getContextPath() %>/question/list"><span>고객센터</span></a>
                 </div>   
               </div>
            </div>    
      
            
            <div class='row justify-content-center'>
               <div class='col-2'></div>
               <div class='col'>
                  <input type = "text" class = "form-control" name = "title" placeholder = "검색어를 입력하세요." id='searchBar'/>
               </div>
               <div class='col-2'>
                  <button type = "button" class = "btn btn-secondary" id='searchBtn'>검색</button>
               </div>
            </div>
         </div>   
      </div>
   <!-- /include: gnb -->
</html>
