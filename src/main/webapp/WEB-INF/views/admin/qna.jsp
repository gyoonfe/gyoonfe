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
	  
	  <form method="get" action="/admin/qna.do" name="qnaSearchForm" class="mx-2"> 
	  <div class="d-flex justify-content-end align-items-center mb-3">
	  	  <div>
		      <select name="type">
			    <option value="">Select</option>
			    <option value="N">Name</option>
			    <option value="I">User ID</option>
			    <option value="T">Title</option>
			    <option value="C">Content</option>
			    <option value="R">Reply</option>
			    <option value="NITCR">All</option>
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
	  		  <p class="fs-2 mt-5 gyoon-redressed">QnA List <span class="fs-4"> ( Total : <c:out value="${pageVO.total}"/> )</span></p>
	  		  <hr>
	  		  
	  		  <form method="get" action="/admin/qnaCheck.do" name="qnaCheckForm">
	  		  <input type="hidden" name="pageNum" value="${pageVO.cri.pageNum}">
	  		  <input type="hidden" name="amount" value="${pageVO.cri.amount}">
			  <table class="table align-middle text-center">
			    <thead class="fs-4">
			    <tr>
			      <td>
			        Idx
			      </td>
			      <td>
			        Reply
			      </td>
			      <td>
			        Title
			      </td>
			      <td>
			        Writer
			      </td>
			      <td>
			        Date
			      </td>
			    </tr>
			    </thead>
			    
			    <c:set var="idx" value="${pageVO.total - ((pageVO.cri.pageNum - 1) * pageVO.cri.amount)}"/>
			    <c:forEach var="qna" items="${qna_list}">
			  	<tr> 
			  	  <td>
			        <c:out value="${idx}"/>
			  	  </td>
			      <td class="change-td${qna.qseq}">
			        <c:choose>
			          <c:when test="${qna.qresult == 0}">
			            <span class="text-danger">No</span><br>
			            <input class="form-check-input" type="checkbox" name="qseq" value="${qna.qseq}">
			          </c:when>
			          <c:when test="${qna.qresult == 1}">
			            <span class="text-success">Yes</span><br>
			            <input class="form-check-input" type="checkbox" name="qseq" value="${qna.qseq}">
			          </c:when>
			          <c:otherwise>
			            Error
			          </c:otherwise>
			        </c:choose>
			      </td>
			      <td>
			        <a href="" class="qna_view" data-qseq="${qna.qseq}"><c:out value="${qna.qtitle}"/></a>
			      </td>
			      <td>
			        <c:out value="${qna.mname}"/><br>
			        ( <c:out value="${qna.userid}"/> )
			      </td>
			      <td>
			        <fmt:formatDate pattern="yyyy-MM-dd" value="${qna.qregdate}"/>
			      </td>
			  	</tr>
			  	<c:set var="idx" value="${idx - 1}"/>
			  	</c:forEach>
			  	
			  </table>
			  
			  
			  <c:if test="${qna_list[0] == null}">
			  	<p class="gyoon-redressed fs-3 my-5">No Result found for '${pageVO.cri.keyword}'</p>
			  </c:if>
			  
			  <div class="d-flex justify-content-center my-5">
			    <select name="qresult">
				  <option value="1">No -> Yes</option>
				  <option value="0">Yes -> No</option>
			    </select>
				<span class="p-1 px-3 button-hover" onClick="return checkNY()">Check</span>
				<span class="p-1 px-3 mx-3 button-hover" onClick="return checkDelete()">Delete</span>
				<span class="p-1 px-2 button-hover" onClick="location.href='/admin/qna.do'">Show All</span>
			  </div>
			  </form>
			  
			  <div class="d-flex justify-content-center my-5">
			    <div class=" fs-4">
				  
				  <c:if test="${pageVO.prev}">
				    <a href="qna.do?type=${pageVO.cri.type}&keyword=${pageVO.cri.keyword}&pageNum=1&amount=${pageVO.cri.amount}"><i class="bi bi-chevron-double-left"></i></a> 
				    <a href="qna.do?type=${pageVO.cri.type}&keyword=${pageVO.cri.keyword}&pageNum=${pageVO.startPage - 1}&amount=${pageVO.cri.amount}"><i class="bi bi-caret-left-square"></i></a> 
				  </c:if>
		
				  <c:forEach var="num" begin="${pageVO.startPage}" end="${pageVO.endPage}">
					<a href="qna.do?type=${pageVO.cri.type}&keyword=${pageVO.cri.keyword}&pageNum=${num}&amount=${pageVO.cri.amount}" class="${pageVO.cri.pageNum == num ? 'border border-dark rounded-3 px-2' : ''}">${num}</a> 			
				  </c:forEach>
				  
				  <c:if test="${pageVO.next}">
				    <a href="qna.do?type=${pageVO.cri.type}&keyword=${pageVO.cri.keyword}&pageNum=${pageVO.endPage + 1}&amount=${pageVO.cri.amount}"><i class="bi bi-caret-right-square"></i></a> 
				    <a href="qna.do?type=${pageVO.cri.type}&keyword=${pageVO.cri.keyword}&pageNum=${pageVO.realEnd}&amount=${pageVO.cri.amount}"><i class="bi bi-chevron-double-right"></i></a> 
				  </c:if>
				  
			    </div>
			  </div>
			  
 <!-- Modal (Reply Update) -->
 <div id="repUpdate-modal">
   <div id="repUpdate-context">
     <p class="gyoon-redressed text-center text-white fs-2">Reply Update</p>
     <table class="align-middle" style="width: 100%">
       <tr>
         <td class="gyoon-redressed text-white fs-3">Question</td>
         <td><textarea rows="4" class="form-control border-dark border-2 bg-white scrollspy-example" id="repUpdate-question" readonly></textarea></td>
       </tr>
       <tr>
         <td class="gyoon-redressed text-white fs-3">Reply</td>
         <td><textarea rows="5" class="form-control border-dark border-2 bg-white scrollspy-example" id="repUpdate-content"></textarea></td>
       </tr>
     </table>
     <button class="btn btn-repUpdate float-end mt-3 px-3 ms-3" id="repUpdate-write" data-qseq="">Write</button>
     <button class="btn btn-repUpdate float-end mt-3" id="repUpdate-cancel">Cancel</button>
   </div>
 </div>
 <!-- /Modal (Reply Update) -->
			  
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
	var check_result = '${check_result}';
	if( check_result != null && check_result != '' && !history.state ){
		if( parseInt(check_result) == 0 ){
			alert('Error - Check Update Fail.');
		}else{
			alert('Check Update Success ! ( ' + check_result + ' )');
		}
	}
	var delete_result = '${delete_result}';
	if( delete_result != null && delete_result != '' && !history.state ){
		if( parseInt(delete_result) == 0 ){
			alert('Error - QnA Delete Fail.');
		}else{
			alert('QnA Delete Success ! ( ' + delete_result + ' )');
		}
	}
	history.replaceState({},null,null);
})

function submitSearch(){
	if(document.qnaSearchForm.keyword.value.length < 2){
		alert('Please input keyword at least 2 letters for searching.');
		document.qnaSearchForm.keyword.focus();
		return false;
	}
	document.qnaSearchForm.submit();
}

/* Reply Update */
$(".qna_view").on("click", function(e){
	var qseq = $(this).data("qseq");
	e.preventDefault();
	$.ajax({
		type:"get",
		url:"/admin/qnaUpdate.do?qseq=" + qseq,
		dataType:"json",
		success:function(data){
			var qtitle = data.qcontent;
			var qcontent = data.qcontent;
			var qreply = data.qreply;
			$("#repUpdate-question").val(qcontent);
			$("#repUpdate-content").val(qreply);
			$("#repUpdate-write").data("qseq", qseq);
			$("#repUpdate-modal").css('display', 'block');
		}, error:function(){
			alert("Error - Reply Update");
		}
	})
})

$("#repUpdate-write").on("click", function(e){
	if( confirm('You really want to update this Reply?') ){
		e.preventDefault();
		var qreply = $("#repUpdate-content").val();
		var qseq = $(this).data("qseq");
		var token = $("meta[name='_csrf']").attr("content");
		var header = $("meta[name='_csrf_header']").attr("content");
		$.ajax({
			type:"post",
			url:"/admin/qnaUpdatePost.do",
			dataType:"json",
			data:{
				qseq : qseq,
				qreply : qreply,
				qresult : 1
			},
			beforeSend : function(xhr)
			{   /*데이터를 전송하기 전에 헤더에 csrf값을 설정한다*/
				xhr.setRequestHeader(header, token);
			},
			success:function(data){
				$("#repUpdate-modal").css("display", "none");
				if( parseInt(data) == 1 ){
					$('.change-td'+qseq).html(
				    	  '<span class="text-success">Yes</span><br>'
				    	+ '<input class="form-check-input" type="checkbox" name="qseq" value="'+qseq+'">'
					);
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


function checkNY(){
	var count = 0;
	if( document.qnaCheckForm.qseq.length == undefined ){
		if( document.qnaCheckForm.qseq.checked == true ){
			count++;
		}
	}else{
		for( var i=0; i<document.qnaCheckForm.qseq.length; i++ ){
			if( document.qnaCheckForm.qseq[i].checked == true ){
				count++;
			}
		}
	}
	if( count == 0 ){
		alert("Please check QnA you want to make change.");
		document.qnaCheckForm.focus();
		return false;
	}else{
		if( confirm("You sure to make "+count+" change?") ){
			document.qnaCheckForm.submit();
		} else{
		 return false;	
		}
	}
}

function checkDelete(){
	var count = 0;
	if( document.qnaCheckForm.qseq.length == undefined ){
		if( document.qnaCheckForm.qseq.checked == true ){
			count++;
		}
	}else{
		for( var i=0; i<document.qnaCheckForm.qseq.length; i++ ){
			if( document.qnaCheckForm.qseq[i].checked == true ){
				count++;
			}
		}
	}
	if( count == 0 ){
		alert("Please check QnA you want to delete change.");
		document.qnaCheckForm.focus();
		return false;
	}else{
		if( confirm("You sure to delete "+count+" change?") ){
			document.qnaCheckForm.action = '/admin/qnaDelete.do';
			document.qnaCheckForm.submit();
		} else{
		 return false;	
		}
	}
}
</script>


<%@ include file="../includes/footer.jsp" %>