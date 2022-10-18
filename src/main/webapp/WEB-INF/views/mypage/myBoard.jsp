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
	  <p class="fs-1 gyoon-redressed">My Board</p>
	  
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
			  
	  		  <p class="fs-3 gyoon-redressed mt-5 mb-0">My Post</p> <!-- -------------- My Post -------------- -->
	  		  <c:if test="${board_list[5] != null}">
			  <div class="d-flex flex-row-reverse ">
			    <span class="p-1 px-4 mx-1 button-hover" id="btn-modal">More Post</span>
			  </div>
			  </c:if>
	  		  <hr>
	  		  
			  <table class="table text-center">
			    <tbody class="fs-4">
			    <tr>
			      <td>
			        Date
			      </td>
			      <td>
			        Title
			      </td>
			      <td>
			        <i class="bi bi-search"></i>
			      </td>
			    </tr>
			    </tbody>

				<c:forEach var="board" items="${board_list}" begin="0" end="4">			    
			  	<tr> 
			  	  <td> 
					<fmt:formatDate pattern="yyyy-MM-dd" value="${board.regdate}"/>
			  	  </td>
			  	  <td>
					<a href="/board/boardView.do?bno=${board.bno}"><c:out value="${board.title}"/></a>
			  	  </td>
	  			  <td> 
	  			  	<c:out value="${board.hits}"/>
			  	  </td>
			  	</tr>
				</c:forEach>
				
			  </table>
	  		  
			  <c:if test="${board_list[0] == null}">
			    <span class="gyoon-redressed fs-4 my-5">No Post.</span>
			  </c:if> 
	  		  
	  		  <p class="fs-3 gyoon-redressed mt-5 mb-0">My Reply</p> <!-- -------------- My Reply -------------- -->
	  		  <c:if test="${reply_list[5] != null}">
			  <div class="d-flex flex-row-reverse">
			    <span class="p-1 px-4 mx-1 button-hover" id="btn-modal2">More Reply</span>
			  </div>
			  </c:if>
	  		  <hr>
			  
			  <table class="table text-center">
			    <tbody class="fs-4">
			    <tr>
			      <td>
			        Date
			      </td>
			      <td>
			        Post Title
			      </td>
			      <td>
			        Content
			      </td>
			    </tr>
			    </tbody>
			    
			    <c:forEach var="reply" items="${reply_list}" begin="0" end="4">
			  	<tr> 
			  	  <td> 
					<fmt:formatDate pattern="yyyy-MM-dd" value="${reply.repregdate}"/>
			  	  </td>
			  	  <td>
					<a href="/board/boardView.do?bno=${reply.bno}"><c:out value="${reply.title}"/></a>
			  	  </td>
	  			  <td> 
	  			  	<textarea class="form-control bg-transparent scrollspy-example" readonly><c:out value="${reply.repcontent}"/></textarea>
			  	  </td>
			  	</tr>
				</c:forEach>

			  </table>
			  
			  <c:if test="${reply_list[0] == null}">
			    <span class="gyoon-redressed fs-4 my-5">No Reply.</span>
			  </c:if>
			  
  	  		  <p class="fs-3 mt-5 gyoon-redressed">My Like</p> <!-- -------------- My Like -------------- -->
	  		  <hr>
			  <table class="table text-center">
			    <tbody class="fs-4">
			    <tr>
			      <td>
			        Date
			      </td>
			      <td>
			        Title
			      </td>
			      <td>
			        Like
			      </td>
			    </tr>
			    </tbody>
			    
			    <c:forEach var="like" items="${like_list}">
			  	<tr class="tr${like.bno}">
			  	  <td> 
					<fmt:formatDate pattern="yyyy-MM-dd" value="${like.regdate}"/>
			  	  </td>
			  	  <td>
					<a href="/board/boardView.do?bno=${like.bno}"><c:out value="${like.title}"/></a>
			  	  </td>
	  			  <td> 
				    <i class="gyoon-heart bi bi-heart-fill fs-3 ms-2 align-self-center" data-bno="${like.bno}"></i>
			  	  </td>
			  	</tr>
				</c:forEach>
			  </table>
			  
			  <c:if test="${like_list[0] == null}">
			    <span class="gyoon-redressed fs-4 my-5">No Like.</span>
			  </c:if>
			  
			  <c:if test="${like_list[0] != null}">
			  <div class="d-flex justify-content-center my-5">
				  <span class="p-1 px-4 button-hover" onClick="return checkDelete()">Delete All</span>
			  </div>
			  </c:if>

			</div>  <!-- /col -->	
		  </div> <!-- /row -->
	   	  
<!-- Modal (My Post) -------------------------------------------------------------------------------- -->
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
				    <tbody class="fs-4">
				    <tr>
				      <td>
				        Date
				      </td>
				      <td>
				        Title
				      </td>
				      <td>
				        <i class="bi bi-search"></i>
				      </td>
				    </tr>
				    </tbody>
				    
				    <c:forEach var="board" items="${board_list}">
				  	<tr> 
				  	  <td> 
						<fmt:formatDate pattern="yyyy-MM-dd" value="${board.regdate}"/>
				  	  </td>
				  	  <td>
						<a href="/board/boardView.do?bno=${board.bno}" class="text-white"><c:out value="${board.title}"/></a>
				  	  </td>
		  			  <td> 
		  			  	<c:out value="${board.hits}"/>
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
	   	  
<!-- Modal (My Reply) -------------------------------------------------------------------------------- -->
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
				    <tbody class="fs-4">
				    <tr>
				      <td>
				        Date
				      </td>
				      <td>
				        Post Title
				      </td>
				      <td>
				        Content
				      </td>
				    </tr>
				    </tbody>
				    
				    <c:forEach var="reply" items="${reply_list}">
				  	<tr> 
				  	  <td> 
						<fmt:formatDate pattern="yyyy-MM-dd" value="${reply.repregdate}"/>
				  	  </td>
				  	  <td style="width: 30%;">
						<a href="/board/boardView.do?bno=${reply.bno}" class="text-white"><c:out value="${reply.title}"/></a>
				  	  </td>
		  			  <td> 
		  			  	<textarea class="form-control text-white bg-transparent scrollspy-example" readonly><c:out value="${reply.repcontent}"/></textarea>
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
		var all_delete = '<c:out value="${all_delete}"/>';
		if( all_delete != null && all_delete != "" && !history.state ){
			if( parseInt(all_delete) > 0 ){
				alert('All Like deleted successfully !');
			}else{
				alert('Error - Delete All Like');
			}
		}
		history.replaceState({},null,null);
	})
	
	$(".bi-heart-fill").on("click", function(){
		var userid = '<c:out value="${session_userid}"/>';
		var bno = $(this).data("bno");
		if( confirm('You want to delete this post in Like list?') ){
			$.ajax({
				type:"get",
				url:"/board/deleteLike.do?bno=" + bno + "&userid=" + userid,
				success:function(data){
					console.log(data); // bno's count of Like
					$(".tr" + bno).detach();
					alert('Delete Like Success !');
				}, error:function(){
					alert("Error - Delete Like");
				}
			})	
		}
	})
	
	function checkDelete(){
		if( confirm('You sure to delete all Board-Like?') ){
			location.href="/mypage/deleteAllLike.do?userid=${session_userid}";
		}else{
			return false;
		}
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