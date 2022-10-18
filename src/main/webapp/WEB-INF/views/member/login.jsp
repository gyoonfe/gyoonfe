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

	<!-- Join Carousel -->
	<%@ include file="../includes/joinCarousel.jsp" %>
	
	
	<form method="post" action="/login" name="loginForm">
	<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
	<div class="row my-5" align="center">
	  <p class="fs-1 gyoon-redressed">Log in</p>
	  <hr>
	  <div class="gyoon-pd-mg">
	    <table class="fs-2">
	      <tr>
	        <td><p class="mx-5">ID</p></td>
	        <td><input class="form-control form-control-lg border-dark rounded-0" type="text" placeholder="id" name="username" id="username"></td>
	      </tr>
	      <tr>
	        <td><p class="mx-5">PW</p></td>
	        <td><input class="form-control form-control-lg border-dark rounded-0" type="password" placeholder="password" name="password" id="password"></td>
	      </tr>
	      <tr>
	      	<td colspan="2" class="fs-5 text-center">
	      	 <span>Remember Me</span> 
	      	 <input class="form-check-input" type="checkbox" name="remember-me">
	      	</td>
	      </tr>
	    </table>  
	  </div>
	  <div class="d-flex justify-content-center mt-5 mb-5">
	    <div class="">
		  <span class="p-1 px-3 border border-2 border-dark button-hover" onClick="return checkLogin()">Log in</span>    
	      <span class="p-1 px-4 border border-2 border-dark button-hover" onClick="location.href='contract.do'">Join</span>
	      <span class="p-1 px-3 border border-2 border-dark button-hover" onClick="location.href='/index/index.do'">Home</span>
	    </div>
	  </div>
	</div><!-- /row -->
	</form>  

	
</div> <!-- /container -->


</body>
</html>

<script type="text/javascript">
//Check input
function checkLogin(){
	if(document.loginForm.username.value.length == 0){
		document.loginForm.username.focus();
		alert('Input your ID.');
		return false;
	}
	if(document.loginForm.password.value.length == 0){
		document.loginForm.password.focus();
		alert('Input your PW.');
		return false;
	}
	document.loginForm.submit();
}

//Enter Key = Submit
$("#password,#username").on("keyup",function(key){
    if(key.keyCode==13) {
          checkLogin();    
	}     
});

//Message Check
$(document).ready(function() {
	var errorMsg = '<c:out value="${errorMsg}"/>'; 
	var logoutMsg = '<c:out value="${logoutMsg}"/>';
	console.log(errorMsg); console.log(logoutMsg);
	if( errorMsg != null && errorMsg != "" && !history.state ){
		alert(errorMsg);
		$("#username").focus();
	}
	if( logoutMsg != null && logoutMsg != "" && !history.state ){
		alert(logoutMsg);
		$("#username").focus();
	}

	var insert_result = '<c:out value="${insert_result}"/>';
	if( insert_result != null && insert_result != "" && !history.state ){
		if( parseInt(insert_result) == 1 ){
			alert('Join Success ! Welcome ! ');
		}else{
			alert('Error - Join Fail');
		}
	}

	history.replaceState({},null,null);
});
	
</script>

<%@ include file="../includes/footer.jsp" %>