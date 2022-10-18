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
	  <p class="fs-1 gyoon-redressed">My Profile</p>
	  
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
			  <table class="my-5 h_70_td">
			  	<tr>
			  	  <td class="fs-3 gyoon-redressed myprofile-size">
			  	  	Profile Image
			  	  </td>
			  	  <td>
			  	  	<c:choose>
			  	  	  <c:when test="${mVO.mprofile != null && mVO.mprofile != ''}">
			  	  	  	<img class="mprofile myprofile-size-cursor" src="/upload_gyoontar/member/${mVO.mprofile}">
			  	  	  </c:when>
			  	  	  <c:otherwise>
			  	      	<img class="mprofile myprofile-size-cursor" src="/resources/images/non_profile.png">
			  	  	  </c:otherwise>
			  	  	</c:choose>
			  	  </td>
			  	</tr>
			  	<tr>
			  	  <td class="fs-3 gyoon-redressed">
			  	  	Member Since
		  	  	  </td>
			  	  <td><fmt:formatDate pattern="yyyy-MM-dd" value="${mVO.regdate}"/></td>
			  	</tr>
			  	<tr>
			  	  <td class="fs-3 gyoon-redressed">
			  	  	User Name ( ID )
			  	  </td>
			  	  <td><c:out value="${mVO.mname}"/> ( <c:out value="${mVO.userid}"/> )</td>
			  	</tr>
			  	<tr>
			  	  <td class="fs-3 gyoon-redressed">
			  	  	Nickname
			  	  </td>
			  	  <td><c:out value="${mVO.nickname}"/></td>
			  	</tr>
			  	<tr>
			  	  <td class="fs-3 gyoon-redressed">
			  	  	Sex
			  	  </td>
			  	  <td>
			  	  	<c:choose>
			  	  	  <c:when test="${mVO.sex == 0}">
			  	  	    Female
			  	  	  </c:when>
			  	  	  <c:when test="${mVO.sex == 1}">
			  	  	    Male
			  	  	  </c:when>
			  	  	  <c:otherwise>
			  	  	    Error
			  	  	  </c:otherwise>
			  	  	</c:choose>
			  	  </td>
			  	</tr>
			  	<tr>
			  	  <td class="fs-3 gyoon-redressed">
			  	  	E-mail
			  	  </td>
			  	  <td><c:out value="${mVO.email}"/></td>
			  	</tr>
			  	<tr>
			  	  <td class="fs-3 gyoon-redressed">
			  	  	Phone
			  	  </td>
			  	  <td><c:out value="${mVO.phone}"/></td>
			  	</tr>
			  	<tr>
			  	  <td class="fs-3 gyoon-redressed">
			  	  	Address
			  	  </td>
			  	  <td>
			  	  	<c:out value="${mVO.address1}"/> <br>
			  	  	<c:out value="${mVO.address2}"/>
			  	  </td>
			  	</tr>
			  </table>
			  
			  <div class="d-flex justify-content-center">
				  <span class="p-1 px-3 mx-2 button-hover" onClick="return checkUpdate()">Update</span>  
			      <span class="p-1 px-2 mx-2 button-hover" id="changePW">Change PW</span>
			  </div>
			  
			 <!-- Modal (profile) -->
			 <div id="mprofile_modal">
			   <img src="/resources/images/non_profile.png" id="mprofile_modal_image" alt="...">
			 </div>
			 <!-- /Modal (profile) -->
			  
			 <!-- Modal (Change PW) -->
			 <div id="repUpdate-modal">
			   <div id="repUpdate-context">
			     <p class="gyoon-redressed text-center text-white fs-2">Password Update</p>
			     <form method="post" action="/mypage/changePW.do" id="changePwForm">
			     <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}">
			     <input type="hidden" name="userid" value="${session_userid}">
			     <table class="table border_trans text-center align-middle">
			       <tr>
			         <td><label for="originPW" class="text-white fs-5">Password</label></td>
			         <td><input type="password" class="form-control border-white bg-white" id="originPW" name="originPW"></td>
			       </tr>
			       <tr>
			         <td><label for="newPW" class="text-white fs-3">New PW</label></td>
			         <td><input type="password" class="form-control border-white bg-white" id="newPW" name="newPW" placeholder="(6~20) Eng+Num+ ~!@\#$%<>^&*"></td>
			       </tr>
			       <tr>
			         <td><label for="newPW2" class="text-white fs-3">Confirm</label></td>
			         <td><input type="password" class="form-control border-white bg-white" id="newPW2" placeholder="Please re-enter your new password"></td>
			       </tr>
			     </table>
			     </form>
			     <button class="btn btn-repUpdate float-end mt-3 px-3 ms-3" id="btn-change">Update</button>
			     <button class="btn btn-repUpdate float-end mt-3" id="btn-cancel">Cancel</button>
			   </div>
			 </div>
			 <!-- /Modal (Change PW) -->
			  
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
		var update_result = '<c:out value="${update_result}"/>';
		if( update_result != null && update_result != "" && !history.state ){
			if( parseInt(update_result) == 1 ){
				alert('Profile Update Success !');
			}else{
				alert('Profile Update Fail !');
			}
		}
		var password_result = '<c:out value="${password_result}"/>'; /* originPW 불일치 알림 */
		if( password_result != null && password_result != "" && !history.state ){
			alert( password_result );
		}
		var changePW_result = '<c:out value="${changePW_result}"/>'; /* newPW 업데이트 성공 여부 알림 */
		if( changePW_result != null && changePW_result != "" && !history.state ){
			if( parseInt(changePW_result) == 1 ){
				alert('Password Update Success !');
			}else{
				alert('Password Update Fail !');
			}
		}
		history.replaceState({},null,null);
	})
	
	function checkUpdate(){
		if(confirm('Go to edit your Profile?')){
			location.href="/mypage/myProfileUpdate.do?userid=${session_userid}";
		}else{
			return false;
		}
	}

	$(".mprofile").on("click", function(){
		var image = $(this).attr("src");
		$("#mprofile_modal_image").attr("src", image);
		$("#mprofile_modal").css("display", "block");
	})
	
	/* Modal Down by mouseup */
	$(document).mouseup(function (e){
	  var modal1 = $("#mprofile_modal");
	  if(modal1.has(e.target).length === 0){
	    modal1.css("display", "none");
	  }
	  var modal2 = $("#repUpdate-modal");
	  if(modal2.has(e.target).length === 0){
		$("#originPW").val("");
		$("#newPW").val("");
		$("#newPW2").val("");
	    modal2.css("display", "none");
	  }
	})
	
	/* Change Password */
	$("#changePW").on("click", function(e){
		e.preventDefault();
		$("#repUpdate-modal").css('display', 'block');
	})
	
	$("#btn-change").on("click", function(){
		if( $("#originPW").val() == '' ){
			alert('Please enter your password.');
			$("#originPW").focus();
			return false;
		}
		var pattern1=/[0-9]/;
		var pattern2=/[a-zA-Z]/;
		var pattern3=/[~!@\#$%<>^&*]/;
		var tpw = $("#newPW").val();
		if(!pattern1.test(tpw) || !pattern2.test(tpw) || !pattern3.test(tpw) || tpw.length<6 || tpw.length>20){
		     alert('You can only use password between 6~20 and have to contain lower or upper-case letters, numbers, and special characters ~!@\#$%<>^&*');
		     $("#newPW").focus(); $("#newPW").val("");
		     return false;
		}
		if( $("#newPW").val() != $("#newPW2").val() ){
			alert('Please check your new password.');
			$("#newPW2").focus();
			return false;
		}
		if( confirm('You sure to update your PASSWORD ?') ){
			$("#changePwForm").submit();
		}
	})
	
	$("#btn-cancel").on("click", function(){
		$("#originPW").val("");
		$("#newPW").val("");
		$("#newPW2").val("");
		$("#repUpdate-modal").css("display", "none");
	})
	
</script>



<%@ include file="../includes/footer.jsp" %>