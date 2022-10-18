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
	  <p class="fs-1 gyoon-redressed">My Review & Comment</p>
	  
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
			
	  		  <p class="fs-3 mt-5 gyoon-redressed">My Review</p> <!-- -------------- My Review -------------- -->
	  		  <c:if test="${review_list[5] != null}">
			  <div class="d-flex flex-row-reverse ">
			    <span class="p-1 px-3 mx-1 button-hover" id="btn-modal">More Review</span>
			  </div>
			  </c:if>
	  		  <hr>
	  		  
			  <table class="table text-center">
			    <thead class="fs-4">
			    <tr>
			      <td>
			        Product
			      </td>
			      <td>
			        Content
			      </td>
			      <td>
			        Date
			      </td>
			    </tr>
			    </thead>
				
				<c:forEach var="review" items="${review_list}" begin="0" end="4">
			  	<tr> 
			  	  <td> 
					<a href="/product/productView.do?pseq=${review.pseq}">${review.pname}</a>
			  	  </td>
			  	  <td> 
					<textarea class="form-control border-white bg-white scrollspy-example" readonly><c:out value="${review.revcontent}"/></textarea>
			  	  </td>
			  	  <td> 
					<fmt:formatDate pattern="yyyy-MM-dd" value="${review.revregdate}"/>
			  	  </td>
			  	</tr>
				</c:forEach>
				
			  </table>
			  
			  <c:if test="${review_list[0] == null}">
			    <span class="fs-4 gyoon-redressed my-5">No Review.</span>
			  </c:if>
			  
			  
	  		  <p class="fs-3 gyoon-redressed mt-5 mb-0">My Comment</p> <!-- -------------- My Comment -------------- -->
	  		  <c:if test="${comment_list[5] != null}">
			  <div class="d-flex flex-row-reverse ">
			    <span class="p-1 px-4 mx-1 button-hover" id="btn-modal2">More Comment</span>
			  </div>
			  </c:if>
	  		  <hr>
	  		  
			  <table class="table text-center">
			    <thead class="fs-4">
			    <tr>
			      <td>
			        Product
			      </td>
			      <td>
			        Content
			      </td>
			      <td>
			        Date
			      </td>
			    </tr>
			    </thead>
			    
			    <c:forEach var="comment" items="${comment_list}" begin="0" end="4">
			    <tr>
			      <td>
			        <a href="/product/productView.do?pseq=${comment.pseq}">${comment.pname}</a>
			      </td>
			      <td>
			        <textarea class="form-control border-white bg-white scrollspy-example" readonly><c:out value="${comment.comcontent}"/></textarea>
			      </td>
			      <td>
			        <fmt:formatDate pattern="yyyy-MM-dd" value="${comment.comregdate}"/>
			      </td>
			    </tr>
			    <c:if test="${comment.comreply != null  &&  comment.comreply != ''}">
		        <tr>
		          <th><i class="bi bi-arrow-return-right fs-3"></i></th>
		          <th><textarea class="form-control border-white bg-white scrollspy-example" readonly><c:out value="${comment.comreply}"/></textarea></th>  
		          <th><i class="bi bi-check-lg fs-3"></i></th>
		        </tr>
		        </c:if>
		        </c:forEach>

			  </table>
			  
  			  <c:if test="${comment_list[0] == null}">
			    <span class="fs-4 gyoon-redressed my-5">No Comment.</span>
			  </c:if>
			  
			</div>  <!-- /col -->	
		  </div> <!-- /row -->
	   	  
<!-- Modal (My Review) -------------------------------------------------------------------------------- -->
<div id="modal" class="modal-overlay">
	<div class="container gyoon-container d-flex justify-content-center">
	    <div class="modal-window scrollspy-example container">
	        <div class="title">
	            <h2 class="gyoon-redressed">My Post</h2>
	        </div>
	        <div class="close-area">X</div>
	        <div class="content">
			  <div class="gyoon-link gyoon-rep" align="center">
			  
				  <table class="table text-center my-5 text-white">
				    <thead class="fs-4">
				    <tr>
				      <td>
				        Product
				      </td>
				      <td>
				        Content
				      </td>
				      <td>
				        Date
				      </td>
				    </tr>
				    </thead>
					
					<c:forEach var="review" items="${review_list}">
				  	<tr> 
				  	  <td> 
						<a href="/product/productView.do?pseq=${review.pseq}" class="text-white">${review.pname}</a>
				  	  </td>
				  	  <td> 
						<textarea class="form-control text-white bg-transparent border_trans scrollspy-example" readonly><c:out value="${review.revcontent}"/></textarea>
				  	  </td>
				  	  <td> 
						<fmt:formatDate pattern="yyyy-MM-dd" value="${review.revregdate}"/>
				  	  </td>
				  	</tr>
					</c:forEach>

				  </table>
				  
			  </div>
	        </div>
	    </div>	
	</div>
</div>
<!-- /Modal -------------------------------------------------------------------------------- --> 
	   	  
<!-- Modal (My Comment) -------------------------------------------------------------------------------- -->
<div id="modal2" class="modal-overlay2">
	<div class="container gyoon-container2 d-flex justify-content-center">
	    <div class="modal-window2 scrollspy-example container">
	        <div class="title2">
	            <h2 class="gyoon-redressed">My Reply</h2>
	        </div>
	        <div class="close-area2">X</div>
	        <div class="content2">
			  <div class="gyoon-link gyoon-rep" align="center">
			  
				  <table class="table text-center my-5 text-white">
				    <thead class="fs-4">
				    <tr>
				      <td>
				        Product
				      </td>
				      <td>
				        Content
				      </td>
				      <td>
				        Date
				      </td>
				    </tr>
				    </thead>
				    
				    <c:forEach var="comment" items="${comment_list}">
				    <tr>
				      <td>
				        <a href="/product/productView.do?pseq=${comment.pseq}" class="text-white">${comment.pname}</a>
				      </td>
				      <td>
				        <textarea class="form-control text-white bg-transparent border_trans scrollspy-example" readonly><c:out value="${comment.comcontent}"/></textarea>
				      </td>
				      <td>
				        <fmt:formatDate pattern="yyyy-MM-dd" value="${comment.comregdate}"/>
				      </td>
				    </tr>
				    <c:if test="${comment.comreply != null  &&  comment.comreply != ''}">
			        <tr>
			          <th><i class="bi bi-arrow-return-right fs-3"></i></th>
			          <th><textarea class="form-control text-white bg-transparent border_trans scrollspy-example" readonly><c:out value="${comment.comreply}"/></textarea></th>  
			          <th><i class="bi bi-check-lg fs-3"></i></th>
			        </tr>
			        </c:if>
					</c:forEach>

				  </table>
				  
			  </div>
	        </div>
	    </div>	
	</div>
</div>

<!-- /Modal -------------------------------------------------------------------------------- --> 
	  	
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

</script>

<script>
	/* My Post script */
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

<script>
	/* My Reply script */
	const modal2 = document.getElementById("modal2")
	function modalOn2() {
	    modal2.style.display = "flex"
	}
	function isModalOn2() {
	    return modal2.style.display === "flex"
	}
	function modalOff2() {
	    modal2.style.display = "none"
	}
	const btnModal2 = document.getElementById("btn-modal2")
	btnModal2.addEventListener("click", e => {
	    modalOn2()
	})
	const closeBtn2 = modal2.querySelector(".close-area2")
	closeBtn2.addEventListener("click", e => {
	    modalOff2()
	})
	modal2.addEventListener("click", e => {
	    const evTarget = e.target
	    if(evTarget.classList.contains("modal-overlay2") || evTarget.classList.contains("gyoon-container2")) {
	        modalOff2()
	    }
	})
	window.addEventListener("keyup", e => {
	    if(isModalOn2() && e.key === "Escape") {
	        modalOff2()
	    }
	})
</script>



<%@ include file="../includes/footer.jsp" %>