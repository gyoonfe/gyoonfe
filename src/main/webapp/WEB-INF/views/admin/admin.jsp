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
	  
	  <hr>

	  <div class="gyoon-pd-mg">
		  
		  <!-- Admin Nav -->
		  <%@ include file="../includes/adminNav.jsp" %>
		
		  <div class="row my-5">		  
			<div class="col-md-12">
	  		  <p class="fs-2 mt-5 gyoon-redressed">Admin List <span class="fs-4"> ( Total : <c:out value="${count}"/> )</span></p>
	  		  <hr>
	  		  <form method="post" action="adminDelete.do" name="adminForm">
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
			      	Delete
			      </td>
			    </tr>
			    </thead>
			    
			    <c:set var="idx" value="${count}"/>
			    <c:forEach var="member" items="${admin_list}">
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
			        <a href="/admin/adminUpdate.do?userid=${member.userid}"><c:out value="${member.mname}"/></a>
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

			  <c:if test="${admin_list[0] == null}">
			  	<p class="fs-3 my-5">No Result</p>
			  </c:if>
			   
			  <div class="d-flex justify-content-center my-5">
			  	<span class="p-1 px-4 me-2 button-hover" onClick="return checkCreate()">Create</span>
				<span class="p-1 px-4 ms-2 button-hover" onClick="return checkDelete()">Delete</span>
			  </div>
			  
			  <!-- Modal (profile) -->
			  <div id="mprofile_modal">
			    <img src="/resources/images/non_profile.png" id="mprofile_modal_image" alt="...">
			  </div>
			  <!-- /Modal (profile) -->
			  
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
	var insert_result = '<c:out value="${insert_result}"/>';
	if( insert_result != null && insert_result != "" && !history.state ){
		if( parseInt(insert_result) == 1 ){
			alert('Account Create Success !');
		}else{
			alert('Account Create Fail !');
		}
	}
	var delete_result = '<c:out value="${delete_result}"/>';
	if( delete_result != null && delete_result != "" && !history.state ){
		if( parseInt(delete_result) == 1 ){
			alert('Account Delete Success !');
		}else{
			alert('Account Delete Fail !');
		}
	}
	var update_result = '<c:out value="${update_result}"/>';
	if( update_result != null && update_result != "" && !history.state ){
		if( parseInt(update_result) == 1 ){
			alert('Account Update Success !');
		}else{
			alert('Account Update Fail !');
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
})

function checkCreate(){
	if( confirm('Go to create admin account.') ){
		location.href="/admin/adminWrite.do";
	}
}

function checkDelete(){
	var count = 0;
	if( document.adminForm.userid.length == undefined ){
		if( document.adminForm.userid.checked == true ){
			count++;
		}
	}else{
		for( var i=0; i<document.adminForm.userid.length; i++ ){
			if( document.adminForm.userid[i].checked == true ){
				count++;
			}
		}
	}
	if( count == 0 ){
		alert("Please check admin accounts you want to delete.");
		document.adminForm.focus();
		return false;
	}else{
		if( confirm("You sure to delete "+count+" accounts?") ){
			document.adminForm.submit();
		} else{
		 return false;	
		}
	}
}

</script>


<%@ include file="../includes/footer.jsp" %>