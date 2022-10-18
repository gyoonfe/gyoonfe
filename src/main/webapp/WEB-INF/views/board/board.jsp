<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../includes/header.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

<div class="container">

	<!-- Board Carousel -->
	<%@ include file="../includes/boardCarousel.jsp" %>
	
	<div class="row my-5 gyoon-link" align="center">
	  <p class="fs-1 gyoon-redressed">Board</p>
	  
	  <div class="d-flex justify-content-between mb-3"> <!-- 검색, 전체 목록, 글쓰기 버튼 -->
	    <div class="">
	      <form name="myform" method="get" action="board.do">
			<select name="type">
				<option value="">Select</option>
				<option value="T">Title</option>
				<option value="C">Content</option>
				<option value="W">Writer</option>
				<option value="TC">Title+Content</option>
			</select> 
	        <input type="text" name="keyword" placeholder="Search">
			<input type="hidden" name="pageNum" value="1">
			<input type="hidden" name="amount" value="${pageVO.cri.amount}">
	        <span class="p-1 px-3 button-hover" onClick="return checkSearch()">Search</span>
	      </form>	    
	    </div>
		<div>
		  <span class="p-1 px-4 button-hover" onClick="location.href='board.do'">List</span>
	      <span class="p-1 px-3 button-hover" onClick="location.href='boardWrite.do'">Write</span>		
		</div>
	  </div>
	  
	  <hr>	
	  
	    <div class="gyoon-pd-mg">
	    
	    <c:set var="cnt" value="${pageVO.total}"/>
	    <div class="d-flex justify-content-start mb-3">
	      <p class="fs-4 gyoon-redressed">Total : ${cnt}</p>
	    </div>
	    
		<table class="table table-hover">
		  <thead class="fs-5" align="center">
		    <tr>
		      <th scope="col">Num</th>
		      <th scope="col">Title</th>
		      <th scope="col">Writer</th>
		      <th scope="col">Hits</th>
		      <th scope="col">Date</th>
		    </tr>
		  </thead>
		  <tbody align="center">
		  
		  	<c:forEach var="nVO" items="${notice_list}">
		    <tr class="table-danger">
		      <th scope="row">Notice</th>
		      <td><a href="boardView.do?bno=<c:out value="${nVO.bno}"/>&pageNum=${pageVO.cri.pageNum}&amount=${pageVO.cri.amount}"><c:out value="${nVO.title}"/></a></td>
		      <td><c:out value="${nVO.nickname}"/></td>
		      <td><c:out value="${nVO.hits}"/></td>
		      <td><fmt:formatDate pattern="yyyy-MM-dd" value="${nVO.regdate}"/></td>
		    </tr>
		   	</c:forEach>
		   
		    <c:set var="idx" value="${pageVO.total - ((pageVO.cri.pageNum - 1) * pageVO.cri.amount)}"/>
		    
		    <c:forEach var="bVO" items="${board_list}">
			    <tr>
			      <th scope="row">${idx}</th>
			      <td><a href="boardView.do?bno=<c:out value="${bVO.bno}"/>&pageNum=${pageVO.cri.pageNum}&amount=${pageVO.cri.amount}"><c:out value="${bVO.title}"/></a></td>
			      <td><c:out value="${bVO.nickname}"/></td>
			      <td><c:out value="${bVO.hits}"/></td>
			      <td><fmt:formatDate pattern="yyyy-MM-dd" value="${bVO.regdate}"/></td>
			    </tr>
		    	<c:set var="idx" value="${idx - 1}"/>
		    </c:forEach>

		  </tbody>
		</table>
		
		    <c:if test="${board_list[0] == null}">
		  	  <p class="my-5 fs-3 gyoon-redressed">No Results found for '${pageVO.cri.keyword}'</p>
		    </c:if>
		
	    </div>
		
	  <div class="d-flex justify-content-center mb-3">
	    <div class=" fs-4">
		  
		  <c:if test="${pageVO.prev}">
		    <a href="board.do?pageNum=1&amount=${pageVO.cri.amount}&type=${pageVO.cri.type}&keyword=${pageVO.cri.keyword}"><i class="bi bi-chevron-double-left"></i></a> 
		    <a href="board.do?pageNum=${pageVO.startPage - 1}&amount=${pageVO.cri.amount}&type=${pageVO.cri.type}&keyword=${pageVO.cri.keyword}"><i class="bi bi-caret-left-square"></i></a> 
		  </c:if>

		  <c:forEach var="num" begin="${pageVO.startPage}" end="${pageVO.endPage}">
			<a href="board.do?pageNum=${num}&amount=${pageVO.cri.amount}&type=${pageVO.cri.type}&keyword=${pageVO.cri.keyword}" class="${pageVO.cri.pageNum == num ? 'border border-dark rounded-3 px-2' : ''}">${num}</a> 			
		  </c:forEach>
		  
		  <c:if test="${pageVO.next}">
		    <a href="board.do?pageNum=${pageVO.endPage + 1}&amount=${pageVO.cri.amount}&type=${pageVO.cri.type}&keyword=${pageVO.cri.keyword}"><i class="bi bi-caret-right-square"></i></a> 
		    <a href="board.do?pageNum=${pageVO.realEnd}&amount=${pageVO.cri.amount}&type=${pageVO.cri.type}&keyword=${pageVO.cri.keyword}"><i class="bi bi-chevron-double-right"></i></a> 
		  </c:if>
		  
	    </div>
	  </div>			
		
	</div><!-- /row -->
	  

	
</div> <!-- /container -->


</body>
</html>

<script>
	function checkSearch(){
		if(document.myform.keyword.value.length < 2){
			alert('Please input at least 2 letters for searching');
			document.myform.keyword.focus();
			return false;
		}
		document.myform.submit();
	}
	
	$(document).ready(function() {
		var insert_result = '<c:out value="${insert_result}"/>';
		if( insert_result != null && insert_result != "" && !history.state ){
			if( parseInt(insert_result) == 1 ){
				alert('Post Write Success !');
			}else{
				alert('Post Write Fail !');
			}
		}
		var update_result = '<c:out value="${update_result}"/>';
		if( update_result != null && update_result != "" && !history.state ){
			if( parseInt(update_result) == 1 ){
				alert('Post Update Success !');
			}else{
				alert('Post Update Fail !');
			}
		}
		var delete_result = '<c:out value="${delete_result}"/>';
		if( delete_result != null && delete_result != "" && !history.state ){
			if( parseInt(delete_result) == 1 ){
				alert('Post Delete Success !');
			}else{
				alert('Post Delete Fail !');
			}
		}
		history.replaceState({},null,null);
	})
</script>

<%@ include file="../includes/footer.jsp" %>