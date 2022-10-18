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
	
	<div class="row mt-5" align="center">
	  <p class="fs-1 gyoon-redressed">Board</p>
	  
	  <div class="d-flex justify-content-center fs-5">
	  	<p><i class="bi bi-calendar4-week"></i>   <fmt:formatDate pattern="yyyy-MM-dd" value="${bVO.regdate}"/></p>
	  	<p class="mx-3"></p>
	  	<p><i class="bi bi-person-circle"></i>   <c:out value="${bVO.nickname}"/></p>
	  	<p class="mx-3"></p>
	  	<p><i class="bi bi-search"></i>   <c:out value="${bVO.hits}"/></p>
	  	<p class="mx-3"></p>
	  	<p><i class="bi bi-heart"></i>   <span id="like-count"><c:out value="${like_count}"/></span></p>
	  </div>
	  
	  <hr>
	  
	  <div class="gyoon-content gyoon-big-pd-mg">
	    <p class="fs-1">&#60; <c:out value="${bVO.title}"/> &#62;</p>
	    <div class="scrollspy-example mt_150 mb_150">${bVO.content}</div>
	  </div>

	  
	  <hr>
	</div><!-- /row -->
	  
	  <div class="d-flex justify-content-between mt-3 mb-5 gyoon-link">
	  	<c:choose>
	  	<c:when test="${prevBvo != null}">
	      <div class="fs-4">
	        <a href="boardView.do?bno=<c:out value="${prevBvo.bno}"/>&pageNum=${cri.pageNum}&amount=${cri.amount}"><i class="bi bi-caret-left-square"></i> Prev</a>
	      </div>
	    </c:when>
	    <c:otherwise>
	      <div class="fs-4 text-white">
	        <i class="bi bi-caret-left-square"></i> Prev
	      </div>
	    </c:otherwise>
	    </c:choose>
	  
	    <div class="d-flex justify-content-center my-5">
	      <c:if test="${bVO.userid eq session_userid}">
		  <span class="p-1 px-3 mx-1 button-hover" onClick="return checkBoardUpdate()">Update</span>    
		  <span class="p-1 px-3 mx-1 button-hover" onClick="return checkBoardDelete()">Delete</span>
	      </c:if>
	      <span class="p-1 px-4 mx-1 button-hover" onClick="location.href='board.do'">List</span>
	      <!-- Like User List -->
	      <c:set var="contain" value="n"/>
	      <c:forEach var="like" items="${like_list}">
	        <c:if test="${like.userid eq session_userid}">
	          <c:set var="contain" value="y"/>
	        </c:if>
	      </c:forEach>
	      <!-- Heart Status -->
	      <c:choose>
	        <c:when test="${contain eq 'y'}">
	          <i class="gyoon-heart bi bi-heart-fill fs-3 ms-2 align-self-center" id="btn-heart" data-status="fill"></i>
	        </c:when>
	        <c:otherwise>
	          <i class="gyoon-heart bi bi-heart fs-3 ms-2 align-self-center" id="btn-heart" data-status="empty"></i> 
	        </c:otherwise>
	      </c:choose>
	    </div>
	    
	    <c:choose>
	    <c:when test="${nextBvo != null}">
		  <div class="fs-4">
		    <a href="boardView.do?bno=<c:out value="${nextBvo.bno}"/>&pageNum=${cri.pageNum}&amount=${cri.amount}">Next <i class="bi bi-caret-right-square"></i></a>		
		  </div>
		</c:when>
	    <c:otherwise>
	      <div class="fs-4 text-white">
	        <i class="bi bi-caret-right-square"></i> Next
	      </div>
	    </c:otherwise>
		</c:choose>
	  </div>
	  
	  <form method="post" action="boardRepWrite.do" name="repWrite">
	  <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
	  <div class="d-flex justify-content-center my-5"> <!-- Reply Write---------------------------------- -->
	    <div>
	      <textarea rows="5" class="form-control border-dark scrollspy-example w_500" placeholder="Write comment for this post" name="repcontent"></textarea>
	      <input type="hidden" name="pageNum" value="${cri.pageNum}">
	  	  <input type="hidden" name="amount" value="${cri.amount}"> 
	      <input type="hidden" name="bno" value="${bVO.bno}">
	      <input type="hidden" name="userid" value="${session_userid}">	    
	    </div>
	    <div class="align-self-center ms-2">
	      <span class="p-1 px-3 button-hover" onClick="checkRepWrite()">Write</span>  
	    </div>
	  </div>
	  </form>

	    <div class="d-flex flex-row-reverse mb-5">
	      <span class="p-1 px-4 mx-1 button-hover" id="btn-modal">More Reply</span>
	    </div>

<!-- Modal -------------------------------------------------------------------------------- -->
<div id="modal" class="modal-overlay">
	<div class="container gyoon-container d-flex justify-content-center">
	    <div class="modal-window scrollspy-example container">
	        <div class="title">
	            <h2 class="gyoon-redressed">Reply</h2>
	        </div>
	        <div class="close-area">X</div>
	        <div class="content">
			  <div class="gyoon-link gyoon-rep" align="center">
				<table class="table mt-5 text-center text-white align-middle">
				
				<c:forEach var="repVO" items="${reply_list}">
			      <tr>
			        <th><c:out value="${repVO.nickname}"/><br><fmt:formatDate pattern="yyyy-MM-dd" value="${repVO.repregdate}"/></th>
			        <th><textarea rows="5" class="form-control text-white bg-transparent border_trans scrollspy-example content${repVO.repno}" readonly><c:out value="${repVO.repcontent}"/></textarea></th>
			        <th>
			          <c:if test="${repVO.userid eq session_userid}">
			          <a href="" class="text-white repUpdate" data-repno="${repVO.repno}">Update</a>
			          <br>
			          <a class="text-white" href="boardRepDelete.do?repno=${repVO.repno}&userid=${session_userid}&bno=${bVO.bno}&pageNum=${cri.pageNum}&amount=${cri.amount}" onClick="return confirm('You sure to delete this Reply?')">Delete</a>
			          </c:if>
			        </th>	        
			      </tr>
			    </c:forEach>
			      
			  	</table>
			  </div>
	        </div>
	    </div>	
	</div>
</div>

 <!-- Modal (Reply Update) -->
 <div id="repUpdate-modal">
   <div id="repUpdate-context">
     <p class="gyoon-redressed text-center text-white fs-2">Reply Update</p>
     <textarea rows="5" class="form-control border-white bg-white scrollspy-example" id="repUpdate-content"></textarea>
     <button class="btn btn-repUpdate float-end mt-3 px-3 ms-3" id="repUpdate-write" data-repno="" data-id="">Write</button>
     <button class="btn btn-repUpdate float-end mt-3" id="repUpdate-cancel">Cancel</button>
   </div>
 </div>
 <!-- /Modal (Reply Update) -->

<!-- /Modal -------------------------------------------------------------------------------- --> 

	  
	  <div class="mb-5 gyoon-link" align="center">
		<table class="table text-center align-middle">
		
		<c:choose>
		<c:when test="${reply_list[0] != null}">
			<c:forEach var="repVO" items="${reply_list}" begin="0" end="9">
		      <tr>
		        <th><c:out value="${repVO.nickname}"/><br><fmt:formatDate pattern="yyyy-MM-dd" value="${repVO.repregdate}"/></th>
		        <th><textarea rows="5" class="form-control border-white bg-white scrollspy-example content${repVO.repno}" readonly><c:out value="${repVO.repcontent}"/></textarea></th>
		        <th>
		          <c:if test="${repVO.userid eq session_userid}">
		          <a href="" class="repUpdate" data-repno="${repVO.repno}">Update</a>
		          <br>
		          <a href="boardRepDelete.do?repno=${repVO.repno}&userid=${session_userid}&bno=${bVO.bno}&pageNum=${cri.pageNum}&amount=${cri.amount}" onClick="return confirm('You sure to delete this Reply?')">Delete</a>
		          </c:if>
		        </th>	        
		      </tr>
		    </c:forEach>
		</c:when>
		<c:otherwise>
			<span class="fs-3 p-5 gyoon-redressed">No Reply Yet</span>
		</c:otherwise>
		</c:choose>

	  	</table>
	  </div>
	  
</div> <!-- /container -->


</body>
</html>

<script type="text/javascript">

	$(document).ready(function() {
		var insertReply_result = '<c:out value="${insertReply_result}"/>';
		if( insertReply_result != null && insertReply_result != "" && !history.state ){
			if( parseInt(insertReply_result) == 1 ){
				alert('Reply upload Success !');
			}else{
				alert('Reply upload Fail !');
			}
		}
		var deleteReply_result = '<c:out value="${deleteReply_result}"/>';
		if( deleteReply_result != null && deleteReply_result != "" && !history.state ){
			if( parseInt(deleteReply_result) == 1 ){
				alert('Reply delete Success !');
			}else{
				alert('Reply delete Fail !');
			}
		}
		history.replaceState({},null,null);
	})

	function checkBoardUpdate(){
		if(confirm('Are you sure update this post?')){
			location.href="boardUpdate.do?bno=<c:out value="${bVO.bno}"/>&pageNum=${cri.pageNum}&amount=${cri.amount}&userid=${bVO.userid}";
		}else{
			return false;
		}
	}

	function checkBoardDelete(){
		if(confirm('Are you sure delete this post?')){
			location.href="boardDelete.do?bno=<c:out value="${bVO.bno}"/>&pageNum=${cri.pageNum}&amount=${cri.amount}&userid=${bVO.userid}";
		}else{
			return false;
		}
	}

	function checkRepWrite(){
		if(document.repWrite.repcontent.value.length == 0){
			document.repWrite.repcontent.focus();
			alert("Check your Content.");
			return false;
		}
		
		if(confirm('You sure write this Reply?')){
			document.repWrite.submit();
		}else{
			return false;	
		}
	}
	
	$("#btn-heart").on("click", function(){
		var userid = '<c:out value="${session_userid}"/>';
		var bno = '<c:out value="${bVO.bno}"/>';
		if( $(this).data("status") == 'empty' ){
			$.ajax({
				type:"get",
				url:"/board/addLike.do?bno=" + bno + "&userid=" + userid,
				success:function(data){
					console.log(data);
					$("#like-count").html(data);
					$("#btn-heart").removeClass("bi-heart");
					$("#btn-heart").addClass("bi-heart-fill");
					$("#btn-heart").data('status', 'fill');
					alert('Add Like Success !');
				}, error:function(){
					alert("Error - Like Update");
				}
			})
		}else{
			$.ajax({
				type:"get",
				url:"/board/deleteLike.do?bno=" + bno + "&userid=" + userid,
				success:function(data){
					console.log(data);
					$("#like-count").html(data);
					$("#btn-heart").removeClass("bi-heart-fill");
					$("#btn-heart").addClass("bi-heart");
					$("#btn-heart").data('status', 'empty');
					alert('Delete Like Success !');
				}, error:function(){
					alert("Error - Like Update");
				}
			})
		}//else
	})
</script>

<!-- Modal Script -->
<script>
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
	
	/* Reply Update */
	$(".repUpdate").on("click", function(e){
		var repno = $(this).data("repno");
		e.preventDefault();
		$.ajax({
			type:"get",
			url:"/board/boardRepUpdate.do?repno=" + repno,
			dataType:"json",
			success:function(data){
				var repcontent = data.repcontent;
				$("#repUpdate-content").val(repcontent);
				$("#repUpdate-write").data("repno", repno);
				$("#repUpdate-modal").css('display', 'block');
			}, error:function(){
				alert("Error - Reply Update");
			}
		})
	})

	$("#repUpdate-write").on("click", function(e){
		if( confirm('You really want to update this Reply?') ){
			e.preventDefault();
			var repcontent = $("#repUpdate-content").val();
			var repno = $(this).data("repno");
			var token = $("meta[name='_csrf']").attr("content");
			var header = $("meta[name='_csrf_header']").attr("content");
			$.ajax({
				type:"post",
				url:"/board/boardRepUpdatePost.do",
				dataType:"json",
				data:{
					repno : repno,
					repcontent : repcontent
				},
				beforeSend : function(xhr)
				{   /*데이터를 전송하기 전에 헤더에 csrf값을 설정한다*/
					xhr.setRequestHeader(header, token);
				},
				success:function(data){
					$("#repUpdate-modal").css("display", "none");
					if( parseInt(data) == 1 ){
						$('.content' + repno).val( repcontent );
						alert('Reply Update Success !');
					}else{
						alert('Error - Reply Update');
					}
				}, error:function(){
					alert("Error - Reply Update");
				}
			})
		}
	})
	
	$("#repUpdate-cancel").on("click", function(e){
		e.preventDefault();
		$("#repUpdate-modal").css('display', 'none');
	})
	/* /Reply Update */
	
</script>


<%@ include file="../includes/footer.jsp" %>