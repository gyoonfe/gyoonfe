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

	<!-- Admin Carousel -->
	<%@ include file="../includes/adminCarousel.jsp" %>

<div class="container">
	
	<div class="row my-5 gyoon-link" align="center">
	  <p class="fs-1 gyoon-redressed">Admin</p>
	  
	  <form method="get" action="/admin/board.do" name="boardSearchForm" class="mx-2"> 
	  <div class="d-flex justify-content-end align-items-center mb-3">
	  	  <div>
		      <select name="type">
			    <option value="">Select</option>
			    <option value="T">Title</option>
			    <option value="C">Content</option>
			    <option value="W">Nickname</option>
			    <option value="TCW">All</option>
		      </select>
	  	  </div>
	  	  <div class="mx-2">
			  <input class="form-control border-dark" type="search" name="keyword" placeholder="Search" aria-label="Search">
	          <input type="hidden" name="pageNum" value="1">
	          <input type="hidden" name="amount" value="10"> 
          </div>
          <div>
			  <span class="p-1 px-3 button-hover" onClick="return submitSearch()">Search</span>	
		  </div>
	  </div>
	  </form> 
	  
	  <hr>

	  <div class="gyoon-pd-mg">

		  <!-- Admin Nav -->
		  <%@ include file="../includes/adminNav.jsp" %>
		
		  <div class="row my-5">		  
			<div class="col-md-12">
	  		  <p class="fs-2 mt-5 gyoon-redressed">Board List <span class="fs-4"> ( Total : <c:out value="${pageVO.total}"/> )</span></p>
	  		  <hr>
	  		  
	  		  <form method="get" action="/admin/boardDelete.do" name="boardForm">
			  <table class="table text-center">
			    <thead class="fs-4">
			    <tr>
			      <td>
			        Idx
			      </td>
			      <td>
			        Title
			      </td>
			      <td>
			        Writer
			      </td>
			      <td>
			        Hits
			      </td>
			      <td>
			        Date
			      </td>
			      <td>
			      	Del
			      </td>
			    </tr>
			    </thead>
			    
			    <c:set var="idx" value="${pageVO.total - ((pageVO.cri.pageNum - 1) * pageVO.cri.amount)}"/>
			    <c:forEach var="bVO" items="${board_list}">
			  	<tr class=" <c:if test="${bVO.noticeyn == 1}">table-danger</c:if> "> 
			      <td>
			        <c:out value="${idx}"/>
			      </td>
			      <td>
			        <a href="/admin/boardView.do?bno=${bVO.bno}&pageNum=${pageVO.cri.pageNum}&amount=${pageVO.cri.amount}"><c:out value="${bVO.title}"/></a>
			      </td>
			      <td>
			        <c:out value="${bVO.nickname}"/>
			      </td>
			      <td>
			        <c:out value="${bVO.hits}"/>
			      </td>
			      <td>
			        <fmt:formatDate pattern="yyyy-MM-dd" value="${bVO.regdate}"/>
			      </td>
			      <td>
			      	<input class="form-check-input" type="checkbox" name="bno" value="${bVO.bno}">
			      </td>
			  	</tr>
			  	<c:set var="idx" value="${idx - 1}"/>
			  	</c:forEach>
			  	
			  </table>
			  </form>
			  
			  <c:if test="${board_list[0] == null}">
			  	<p class="fs-3 my-5">No Result found for '${pageVO.cri.keyword}'</p>
			  </c:if>
			  
			  <div class="d-flex justify-content-center my-5">
			    <span class="p-1 px-4 button-hover" onClick="location.href='/admin/board.do'">List</span>
			  	<span class="p-1 px-4 mx-3 button-hover" onClick="return goWriteCheck()">Write</span>
				<span class="p-1 px-3 button-hover" onClick="return checkDelete()">Delete</span>
			  </div>
			  
			  <div class="d-flex justify-content-center my-5">
			    <div class=" fs-4">
				  
				  <c:if test="${pageVO.prev}">
				    <a href="board.do?type=${pageVO.cri.type}&keyword=${pageVO.cri.keyword}&pageNum=1&amount=${pageVO.cri.amount}"><i class="bi bi-chevron-double-left"></i></a> 
				    <a href="board.do?type=${pageVO.cri.type}&keyword=${pageVO.cri.keyword}&pageNum=${pageVO.startPage - 1}&amount=${pageVO.cri.amount}"><i class="bi bi-caret-left-square"></i></a> 
				  </c:if>
		
				  <c:forEach var="num" begin="${pageVO.startPage}" end="${pageVO.endPage}">
					<a href="board.do?type=${pageVO.cri.type}&keyword=${pageVO.cri.keyword}&pageNum=${num}&amount=${pageVO.cri.amount}" class="${pageVO.cri.pageNum == num ? 'border border-dark rounded-3 px-2' : ''}">${num}</a> 			
				  </c:forEach>
				  
				  <c:if test="${pageVO.next}">
				    <a href="board.do?type=${pageVO.cri.type}&keyword=${pageVO.cri.keyword}&pageNum=${pageVO.endPage + 1}&amount=${pageVO.cri.amount}"><i class="bi bi-caret-right-square"></i></a> 
				    <a href="board.do?type=${pageVO.cri.type}&keyword=${pageVO.cri.keyword}&pageNum=${pageVO.realEnd}&amount=${pageVO.cri.amount}"><i class="bi bi-chevron-double-right"></i></a> 
				  </c:if>
				  
			    </div>
			  </div>
			  
			</div>  <!-- /col -->	
		  </div> <!-- /row -->
	  	
	  </div><!-- / padding row -->

	</div><!-- /row -->
	
</div>

</div><!-- /제일 바깥 container -->

</body>
</html>

<script type="text/javascript">

$(document).ready(function() {
	var insert_result = '${insert_result}';
	if( insert_result != null && insert_result != '' && !history.state ){
		if( parseInt(insert_result) == 1 ){
			alert('Post Upload Success !');
		}else{
			alert('Post Upload Fail !');
		}
	}
	var delete_result = '${delete_result}';
	if( delete_result != null && delete_result != "" && !history.state ){
		if( parseInt(delete_result) > 0 ){
			alert('Post Delete Success ( ' +delete_result+ ' )');
		}else{
			alert('Post Delete Fail !');
		}
	}
	var update_result = '${update_result}';
	if( update_result != null && update_result != "" && !history.state ){
		if( parseInt(update_result) == 1 ){
			alert('Post Update Success !');
		}else{
			alert('Post Update Fail !');
		}
	}
	history.replaceState({},null,null);
})

function submitSearch(){
	if(document.boardSearchForm.keyword.value.length < 2){
		alert('Please input keyword at least 2 letters for searching.');
		document.boardSearchForm.keyword.focus();
		return false;
	}
	document.boardSearchForm.submit();
}

function goWriteCheck(){
	if( confirm('Click yes to write notice, or click cancel to write normal post.') ){
		location.href="/admin/boardWrite.do";
	}else{
		location.href="/board/boardWrite.do";
	}
}

function checkDelete(){
	var count = 0;
	if( document.boardForm.bno.length == undefined ){
		if( document.boardForm.bno.checked == true ){
			count++;
		}
	}else{
		for( var i=0; i<document.boardForm.bno.length; i++ ){
			if( document.boardForm.bno[i].checked == true ){
				count++;
			}
		}
	}
	if( count == 0 ){
		alert("Please check posts you want to delete.");
		document.boardForm.focus();
		return false;
	}else{
		if( confirm("You sure to delete "+count+" posts from List?") ){
			document.boardForm.submit();
		} else{
		 return false;	
		}
	}
}
</script>


<%@ include file="../includes/footer.jsp" %>