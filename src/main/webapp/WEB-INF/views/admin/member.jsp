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
	  <p class="fs-1 gyoon-redressed">Member</p>
	  
	  <form method="post" action="/admin/member.do" name="userSearchForm" class="mx-2"> 
	  <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
	  <div class="d-flex justify-content-end align-items-center mb-3">
	  	  <div>
		      <select name="type">
			    <option value="">Select</option>
			    <option value="I">ID</option>
			    <option value="M">Name</option>
			    <option value="N">Nickname</option>
			    <option value="IMN">All</option>
		      </select>
	  	  </div>
	  	  <div class="mx-2">
			  <input class="form-control border-dark" type="search" name="keyword" placeholder="User Search" aria-label="Search">
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
	  		  <p class="fs-2 mt-5 gyoon-redressed">User List <span class="fs-4"> ( Total : <c:out value="${pageVO.total}"/> )</span></p>
	  		  <hr>
	  		  <form method="post" action="toDormant.do" name="memberForm">
	  		  <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
			  <table class="table text-center align-middle">
			    <thead class="fs-4">
			    <tr>
			      <td>
			        Idx
			      </td>
			      <td>
			        Date
			      </td>
			      <td>
			        ID
			      </td>
			      <td>
			        Name
			      </td>
			      <td>
			        Nickname
			      </td>
			      <td>
			        Sex
			      </td>
			      <td>
			        Phone
			      </td>
			      <td>
			      	Dormant
			      </td>
			    </tr>
			    </thead>
			    
			    <c:set var="idx" value="${pageVO.total - ((pageVO.cri.pageNum - 1) * pageVO.cri.amount)}"/>
			    <c:forEach var="member" items="${member_list}">
			  	<tr>
			      <td rowspan="2">
			        <c:out value="${idx}"/>
			        <c:choose>
			          <c:when test="${member.mprofile != null && member.mprofile != ''}">
			            <img src="/upload_gyoontar/member/${member.mprofile}" class="mprofile mprofile-size-cursor" alt="...">
			          </c:when>
			          <c:otherwise>
			            <img src="/resources/images/non_profile.png" class="mprofile mprofile-size-cursor" alt="...">
			          </c:otherwise>
			        </c:choose>
			      </td>
			      <td>
			        <fmt:formatDate pattern="yyyy-MM-dd" value="${member.regdate}"/>
			      </td> 
			      <td>
			        <c:out value="${member.userid}"/>
			      </td>
			      <td>
			        <c:out value="${member.mname}"/>
			      </td>
			      <td>
			        <c:out value="${member.nickname}"/>
			      </td>
			      <td>
			        <c:choose>
			        <c:when test="${member.sex == 0}">
			         Female
			        </c:when>
			        <c:otherwise>
			         Male
			        </c:otherwise>
			        </c:choose>
			      </td>
			      <td>
			      	<c:out value="${member.phone}"/>
			      </td>
			      <td>
			        <c:choose>
			        <c:when test="${member.status == 0}">
			         N
			        </c:when>
			        <c:otherwise>
			         <span class="text-danger">Y</span>
			        </c:otherwise>
			        </c:choose>
			        <input class="form-check-input" type="checkbox" name="userid" value="${member.userid}">
			      </td>
			  	</tr>
			  	
			  	<tr>
			  	  <th>
			  	    Email :
			  	  </th>
			  	  <td colspan="2">
			  	    <c:out value="${member.email}"/>
			  	  </td>
			  	  <th>
			  	    Address :
			  	  </th>
			  	  <td colspan="3">
			  	    ( <c:out value="${member.zipcode}"/> ) <c:out value="${member.address1}"/> <c:out value="${member.address2}"/> 
			  	  </td>
			  	</tr>
			  	<c:set var="idx" value="${idx - 1}"/>
			  	</c:forEach>
			  	
			  </table>
			  </form>

			  <c:if test="${member_list[0] == null}">
			  	<p class="fs-3 my-5">No Result found for '${pageVO.cri.keyword}'</p>
			  </c:if>
			  
			  <div class="d-flex justify-content-center my-5">
			  	<span class="p-1 px-4 ms-2 button-hover" onClick="return notDormant()">Dormant N</span>
				<span class="p-1 px-4 ms-2 button-hover" onClick="return toDormant()">Dormant Y</span>
			  </div>
			  
			  <div class="d-flex justify-content-center my-5">
			    <div class=" fs-4">
				  
				  <c:if test="${pageVO.prev}">
				    <a href="member.do?type=${pageVO.cri.type}&keyword=${pageVO.cri.keyword}&pageNum=1&amount=${pageVO.cri.amount}"><i class="bi bi-chevron-double-left"></i></a> 
				    <a href="member.do?type=${pageVO.cri.type}&keyword=${pageVO.cri.keyword}&pageNum=${pageVO.startPage - 1}&amount=${pageVO.cri.amount}"><i class="bi bi-caret-left-square"></i></a> 
				  </c:if>
		
				  <c:forEach var="num" begin="${pageVO.startPage}" end="${pageVO.endPage}">
					<a href="member.do?type=${pageVO.cri.type}&keyword=${pageVO.cri.keyword}&pageNum=${num}&amount=${pageVO.cri.amount}" class="${pageVO.cri.pageNum == num ? 'border border-dark rounded-3 px-2' : ''}">${num}</a> 			
				  </c:forEach>
				  
				  <c:if test="${pageVO.next}">
				    <a href="member.do?type=${pageVO.cri.type}&keyword=${pageVO.cri.keyword}&pageNum=${pageVO.endPage + 1}&amount=${pageVO.cri.amount}"><i class="bi bi-caret-right-square"></i></a> 
				    <a href="member.do?type=${pageVO.cri.type}&keyword=${pageVO.cri.keyword}&pageNum=${pageVO.realEnd}&amount=${pageVO.cri.amount}"><i class="bi bi-chevron-double-right"></i></a> 
				  </c:if>
				  
				  <div id="mprofile_modal">
				    <img src="/resources/images/non_profile.png" id="mprofile_modal_image" alt="...">
				  </div>
				  
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
	var y_result = '<c:out value="${y_result}"/>';
	if( y_result != null && y_result != "" && !history.state ){
		if( parseInt(y_result) == 1 ){
			alert('Dormant Change to Y Success !');
		}else{
			alert('Dormant Change Fail !');
		}
	}
	var n_result = '<c:out value="${n_result}"/>';
	if( n_result != null && n_result != "" && !history.state ){
		if( parseInt(n_result) == 1 ){
			alert('Dormant Change to N Success !');
		}else{
			alert('Dormant Change Fail !');
		}
	}
	history.replaceState({},null,null);
})

$(".mprofile").on("click", function(){
	var image = $(this).attr("src");
	$("#mprofile_modal_image").attr("src", image);
	$("#mprofile_modal").css("display", "block");
})
$(document).mouseup(function (e){
  var modal = $("#mprofile_modal");
  if(modal.has(e.target).length === 0){
    modal.css("display", "none");
  }
});

function submitSearch(){
	if(document.userSearchForm.keyword.value.length == 0){
		alert('Please input user information for searching.');
		document.userSearchForm.keyword.focus();
		return false;
	}
	document.userSearchForm.submit();
}

function toDormant(){
	var count = 0;
	if( document.memberForm.userid.length == undefined ){
		if( document.memberForm.userid.checked == true ){
			count++;
		}
	}else{
		for( var i=0; i<document.memberForm.userid.length; i++ ){
			if( document.memberForm.userid[i].checked == true ){
				count++;
			}
		}
	}
	if( count == 0 ){
		alert("Please check members to change Dormant status to Y.");
		document.memberForm.focus();
		return false;
	}else{
		if( confirm("You sure to change "+count+" members to Y?") ){
			document.memberForm.submit();
		} else{
		 return false;	
		}
	}
}

function notDormant(){
	var count = 0;
	if( document.memberForm.userid.length == undefined ){
		if( document.memberForm.userid.checked == true ){
			count++;
		}
	}else{
		for( var i=0; i<document.memberForm.userid.length; i++ ){
			if( document.memberForm.userid[i].checked == true ){
				count++;
			}
		}
	}
	if( count == 0 ){
		alert("Please check members to change Dormant status to N.");
		document.memberForm.focus();
		return false;
	}else{
		if( confirm("You sure to change "+count+" members to N?") ){
			document.memberForm.action = "/admin/notDormant.do";
			document.memberForm.submit();
		} else{
		 return false;	
		}
	}
}

</script>


<%@ include file="../includes/footer.jsp" %>