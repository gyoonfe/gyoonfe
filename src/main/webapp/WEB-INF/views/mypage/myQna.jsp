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

	<!-- Mypage Carousel -->
	<%@ include file="../includes/mypageCarousel.jsp" %>

<div class="gyoon-sidebar-container">

<!-- Mypae Side Bar -->
<%@ include file="../includes/mypageSide.jsp" %>

<div class="container">
	
	<div class="row my-5 gyoon-link" align="center">
	  <p class="fs-1 gyoon-redressed">My QnA (1:1)</p>
	  
	  <div class="d-flex justify-content-end align-items-center mb-3">
		<form method="post" action="/product/productSearch.do" name="productSearchForm" class="me-3">
		  <input class="form-control border-dark " type="search" name="pname" placeholder="Search" aria-label="Search">
		</form>  
		<span class="p-1 px-3 button-hover" onClick="return submitSearch()">Search</span>	
	  </div>
	  
	  <hr>
	  
	  <div class="gyoon-pd-mg"> 

		  <!-- Mypae Nav Bar -->
		  <%@ include file="../includes/mypageNav.jsp" %>
		
		  <div class="row my-5">		  
			<div class="col-md-12">
			
			  <form method="post" action="myQna.do" name="qnaWrite">
			  <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
			  <div class="d-flex justify-content-center my-5"> 
			    <div>
			      <input class="form-control form-control-sm border-dark rounded-1 mb-2 w_500" type="text" placeholder="QnA Title" name="qtitle">
			      <textarea class="form-control border-dark scrollspy-example" placeholder="Write QnA here. We will answer your question on 1:1." name="qcontent"></textarea>
			      <input type="hidden" name="userid" value="${session_userid}">    
			    </div>
			    <div class="align-self-center ms-2">
			      <span class="p-1 px-3 button-hover" onClick="checkQnaWrite()">Write</span>  
			    </div>
			  </div>
			  </form>
  			  
  			  <div class="mt_100">
  			    <p class="fs-2 mt-5 gyoon-redressed">QnA List</p>
  			  </div>
  	  		  <hr>
  
  			  <c:if test="${qna_list[5] != null}">
			  <div class="d-flex flex-row-reverse mb-5">
			    <span class="p-1 px-4 mx-1 button-hover" id="btn-modal">More QnA</span>
			  </div>
			  </c:if>
			  
			  <div class="my-5 gyoon-link" align="center">
				<table class="table text-center align-middle gyoon-border-white">
				
				  <c:forEach var="qna" items="${qna_list}" begin="0" end="4">
			      <tr class="border_top_black">
			        <th>
			        	<span class="fs-4">Title</span><br>
			        	<fmt:formatDate pattern="yyyy-MM-dd" value="${qna.qregdate}"/>
			        </th>
			        <th><textarea class="form-control bg-transparent scrollspy-example" readonly>${qna.qtitle}</textarea></th>        
			      </tr>
			      <tr>
			        <th>Content</th>
			        <th><textarea class="form-control bg-transparent scrollspy-example" readonly>${qna.qcontent}</textarea></th>        
			      </tr>
			      <tr class="border_bottom_black">
			        <th>
			            <c:choose>
			              <c:when test="${qna.qresult == 0}">
				        	<i class="bi bi-x-lg text-danger"></i>
				        	Reply
			              </c:when>
			              <c:otherwise>
				        	<i class="bi bi-check-lg text-success"></i>
				        	Reply
			              </c:otherwise>
			            </c:choose>
			        </th>
			        <th><textarea class="form-control bg-transparent scrollspy-example" readonly>${qna.qreply}</textarea></th>        
			      </tr>
			      </c:forEach>
			      
			  	</table>
			  	
			  	<c:if test="${qna_list[0] == null}">
			  		<span class="gyoon-redressed fs-3">No QnA.</span>
			  	</c:if>
			  </div>
			  
<!-- Modal -------------------------------------------------------------------------------- -->
<div id="modal" class="modal-overlay">
	<div class="container gyoon-container d-flex justify-content-center">
	    <div class="modal-window scrollspy-example container">
	        <div class="title">
	            <h2 class="gyoon-redressed">QnA</h2>
	        </div>
	        <div class="close-area">X</div>
	        <div class="content">
			  <div class="gyoon-link gyoon-rep" align="center">
				<table class="table mt-5 text-center text-white align-middle gyoon-border-white">
				
				  <c:forEach var="qna" items="${qna_list}">
			      <tr class="border_top_white">
			        <th>
			        	<span class="fs-4">Title</span><br>
			        	<fmt:formatDate pattern="yyyy-MM-dd" value="${qna.qregdate}"/>
			        </th>
			        <th><textarea class="form-control text-white bg-transparent scrollspy-example" readonly>${qna.qtitle}</textarea></th>        
			      </tr>
			      <tr>
			        <th>Content</th>
			        <th><textarea class="form-control text-white bg-transparent scrollspy-example" readonly>${qna.qcontent}</textarea></th>        
			      </tr>
			      <tr class="border_bottom_white">
			        <th>
			            <c:choose>
			              <c:when test="${qna.qresult == 0}">
				        	<i class="bi bi-x-lg"></i>
				        	Reply
			              </c:when>
			              <c:otherwise>
				        	<i class="bi bi-check-lg"></i>
				        	Reply
			              </c:otherwise>
			            </c:choose>
			        </th>
			        <th><textarea class="form-control text-white bg-transparent scrollspy-example" readonly>${qna.qreply}</textarea></th>        
			      </tr>
				  </c:forEach>

			  	</table>
			  </div>
	        </div>
	    </div>	
	</div>
</div>
<!-- /Modal -------------------------------------------------------------------------------- --> 
			  
			</div>  <!-- /col -->	
		  </div> <!-- /row -->

	  </div><!-- / padding row -->

	</div><!-- /row -->
	
</div> <!-- /container with sidebar -->
    
</div><!-- /gyoon-sidebar-container -->

</div><!-- /제일 바깥 container -->

</body>
</html>

<script type="text/javascript">
	function submitSearch(){
		if(document.productSearchForm.pname.value.length == 0){
			alert('Please input product name for searching.');
			document.productSearchForm.pname.focus();
			return false;
		}
		document.productSearchForm.submit();
	}
	
	$(document).ready(function() {
		var insert_result = '${insert_result}';
		if( insert_result != null && insert_result != '' && !history.state ){
			if( parseInt(insert_result) == 1 ){
				alert('Thank you for your Question !');
			}else{
				alert('Error - QnA Writing. Please try again.');
			}
		}
		history.replaceState({},null,null);
	})
	
	function checkQnaWrite(){
		if( document.qnaWrite.qtitle.value.length == 0 ){
			alert('Please check QnA title.');
			document.qnaWrite.qtitle.focus();
			return false;
		}
		if( document.qnaWrite.qcontent.value.length == 0 ){
			alert('Please check QnA content.');
			document.qnaWrite.qcontent.focus();
			return false;
		}
		if(confirm('Sure to submit this QnA?')){
			document.qnaWrite.submit();
		}else{
			return false;
		}
	}
</script>

<script>
	/* REVIEW script */
	const modal = document.getElementById("modal")
	function modalOn() {
	    modal.style.display = "flex"
	}
	function isModalOn() {
	    return modal.style.display === "flex"
	}
	function modalOff() {
	    modal.style.display = "none"
	}
	const btnModal = document.getElementById("btn-modal")
	btnModal.addEventListener("click", e => {
	    modalOn()
	})
	const closeBtn = modal.querySelector(".close-area")
	closeBtn.addEventListener("click", e => {
	    modalOff()
	})
	modal.addEventListener("click", e => {
	    const evTarget = e.target
	    if(evTarget.classList.contains("modal-overlay") || evTarget.classList.contains("gyoon-container")) {
	        modalOff()
	    }
	})
	window.addEventListener("keyup", e => {
	    if(isModalOn() && e.key === "Escape") {
	        modalOff()
	    }
	})
</script>

<%@ include file="../includes/footer.jsp" %>