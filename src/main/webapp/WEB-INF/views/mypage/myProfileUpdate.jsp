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
	  <p class="fs-1 gyoon-redressed">Edit Profile</p>
	  
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
			  <form method="post" action="myProfileUpdate.do" enctype="multipart/form-data" name="updateForm">
			  <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}">
			  <input type="hidden" id="nickCheck" value="y"> <!-- Duplicate Check value -->
			  <input type="hidden" id="emailCheck"  value="y"> <!-- Email Code Check -->
			  <input type="hidden" name="userid" value="${mVO.userid}">
			  <input type="hidden" name="mprofile" value="${mVO.mprofile}">
			  <table class="my-5 align-middle h_70_td">
			  	<tr>
			  	  <td class="fs-3 gyoon-redressed myprofile-size">
			  	  	Profile Image
			  	  	<input type="hidden" name="profile" value="">
			  	  </td>
			  	  <td>
			  	  	<c:choose>
			  	  	  <c:when test="${mVO.mprofile != null && mVO.mprofile != ''}">
			  	  	  	<img class="mprofile myprofile-size-no" src="/upload_gyoontar/member/${mVO.mprofile}"><br>
			  	  	  	<input class="form-check-input" type="checkbox" name="imageCheck" value="y"> Delete Image
			  	  	  </c:when>
			  	  	  <c:otherwise>
			  	      	<img class="mprofile myprofile-size-no" src="/resources/images/non_profile.png">
			  	  	  </c:otherwise>
			  	  	</c:choose>
			  	  </td>
			  	</tr>
			  	<tr>
			  	  <td class="fs-3 gyoon-redressed">
			  	  	Profile Update
		  	  	  </td>
			      <td>
			        <input type="file" name="uploadfile" id="uploadfile" class="border_upload">
			      </td>
			  	</tr>
			  	<tr>
			  	  <td class="fs-3 gyoon-redressed">
			  	  	Member Since
		  	  	  </td>
			  	  <td>
			  	  	<fmt:formatDate pattern="yyyy-MM-dd" value="${mVO.regdate}"/>
			  	  	<input type="hidden" name="profile" value="${mVO.regdate}">
			  	  </td>
			  	</tr>
			  	<tr>
			  	  <td class="fs-3 gyoon-redressed">
			  	  	User Name
			  	  </td>
			  	  <td>
			  	  	<input class="form-control form-control-sm border-dark rounded-0" type="text" name="mname" id="mname" value="${mVO.mname}">
			  	  	( ${mVO.userid} )
			  	  </td>
			  	</tr>
			  	<tr>
			  	  <td class="fs-3 gyoon-redressed">
			  	  	Nickname
			  	  </td>
			  	  <td>
			  	  	<input class="form-control form-control-sm border-dark rounded-0" type="text" name="nickname" id="nickname" value="${mVO.nickname}">
			  	  </td>
			  	</tr>
		        <tr>
		          <td style="height: 30px;" colspan="3"><p class="text-center my-0" id="nickMsg"></p></td>
		        </tr>
			  	<tr>
			  	  <td class="fs-3 gyoon-redressed">
			  	  	Sex
			  	  </td>
			  	  <td>
		            <select class="form-select-sm border-dark rounded-0" name="sex">
				      <option value="0" <c:if test="${mVO.sex != null && mVO.sex == 0}">selected</c:if>>Female</option>
				      <option value="1" <c:if test="${mVO.sex != null && mVO.sex == 1}">selected</c:if>>Male</option>
				    </select>
			  	  </td>
			  	</tr>
			  	<tr>
			  	  <td class="fs-3 gyoon-redressed">
			  	  	E-mail
			  	  </td>
			  	  <td>
			  	  	<input class="form-control form-control-sm border-dark rounded-0 mb-1" type="text" name="email" id="email" value="${mVO.email}">
			  	  	<input type="text" class="form-control form-control-sm border-dark" placeholder="Please wait for a moment after sending" id="codeNum" disabled="disabled">
			  	  </td>
			  	  <td><span class="fs-5 px-2 mx-3 button-hover" id="btn-mail">Send</span></td>
			  	</tr>
			  	<tr>
			  	  <td class="fs-3 gyoon-redressed">
			  	  	Phone
			  	  </td>
			  	  <td>
			  	  	<input class="form-control form-control-sm border-dark rounded-0" type="text" name="phone" id="phone" value="${mVO.phone}">
			  	  </td>
			  	</tr>
			  	<tr>
			  	  <td class="fs-3 gyoon-redressed">
			  	  	Address
			  	  </td>
			  	  <td>
			  	  	<input class="form-control form-control-sm bg-white border-dark rounded-0" type="text" name="zipcode" id="sample2_postcode" value="${mVO.zipcode}" readonly>
			  	  	<input class="form-control form-control-sm bg-white border-dark rounded-0 my-1" type="text" name="address1" id="sample2_address" value="${mVO.address1}" readonly>
			  	  	<input class="form-control form-control-sm border-dark rounded-0" type="text" name="address2" id="sample2_detailAddress" value="${mVO.address2}">
			  	  </td>
			  	  <td><span class="fs-5 p-1 px-2 mx-3 button-hover" onClick="sample2_execDaumPostcode()">Search</span></td>
			  	</tr>
			  	<tr>
			  	  <td class="fs-3 gyoon-redressed">
			  	  	Password
			  	  </td>
			  	  <td>
			  	  	<input class="form-control form-control-sm border-dark rounded-0" type="password" name="password" id="password" placeholder="Authenticate yourself to update profile">
			  	  </td>
			  	</tr>
			  </table>
			  </form>
			  
			  <div class="d-flex justify-content-center">
				  <span class="p-1 px-3 mx-1 button-hover" onClick="return checkUpdate()">Update</span>  
			      <span class="p-1 px-4 mx-1 button-hover" onClick="location.href='/product/productCategory.do?kind=electric'">Shopping</span>
			  </div>
			  
			  <!-- Daum Post API -->
			  <%@ include file="../includes/daumPostApi.jsp" %>
			  
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
	var password_result = '<c:out value="${password_result}"/>';
	if( password_result != null && password_result != "" && !history.state ){
		alert( password_result );
	}
	history.replaceState({},null,null);
})
	
//현재 userid를 제외한 레코드 중에 중복되는 nickname 체크
$("#nickname").blur(function(){
	var nickname = $("#nickname").val();
	var userid = '${session_userid}';
	$.ajax({
		type:"get",
		url:"/mypage/checkUpdateNickname.do?nickname="+nickname+"&userid="+userid,
		dataType:"json", 
		success:function(data){ 
			console.log(data);
			if( data == 0 && $("#nickname").val() != "" ){
					$("#nickMsg").html("Duplicate Check OK !"); $("#nickMsg").css("color","green");
					$("#nickCheck").val("y");
			}else{ 
					$("#nickMsg").html("Unavailable Nickname !"); $("#nickMsg").css("color","red");
					$("#nickname").val(""); 
					$("#nickCheck").val("n");
			}
		}, error:function(){
			alert("Nickname duplication check ERROR");
		}
	})
})
	
//메일 보내기
var code="-1";
$("#btn-mail").on("click", function(){
	var regEmail=/^[A-Za-z0-9_\.\-]+@[A-Za-z0-9\-]+\.[a-zA-Z0-9\-]+/;
	if( !regEmail.test($("#email").val()) ){
		alert('Email format is incorrect.');
		$("#email").focus();
		return false;
	}
	
	var email = $("#email").val();
	$.ajax({
		type:"get",
		url:"/member/mailCheck.do?email=" + email,
		success:function(data){
			code = data;
			$("#codeNum").attr("disabled", false);
			$("#codeNum").attr("placeholder", "");
			$("#codeNum").css("background","#fff");
		}
	})
})

// 이메일 변경 시, emailCheck를 n으로 변경
$("#email").change(function(){
	$("#emailCheck").val('n');
})
// 인증코드 입력 후, code와 비교해서 emailCheck 변경
$("#codeNum").blur(function(){
	if( code == $("#codeNum").val() ){
		$("#emailCheck").val('y');
	}else{
		$("#emailCheck").val('n');
	}
})

// 최종 Update 버튼 클릭 
function checkUpdate(){
	if( $("#nickCheck").val() != 'y' ){
		alert('Please Check Nickname duplication.');
		$("#nickname").focus();
		return false;
	}
	if( $("#emailCheck").val() != 'y' ){
		alert('Pleaes check email code.');
		$("#email").focus();
		return false;
	}
	if( $("#mname").val() == "" ){
		alert('Please input your Name.');
		$("#mname").focus();
		return false;
	}
	if( $("#nickname").val() == '' ){
		alert('Please check Nickname.');
		$("#nickname").focus();
		return false;
	}
	if( $("#phone").val() == '' ){
		alert('Please input your Phone number.');
		$("#phone").focus();
		return false;
	}
	if( $("#sample2_postcode").val()=='' || $("#sample2_address").val()=='' || $("#sample2_detailAddress").val()=='' ){
		alert('Please check your Address.');
		$("#sample2_detailAddress").focus();
		return false;
	}
	if( $("#password").val() == '' ){
		alert('You have to enter PW to update profile info.');
		$("#password").focus();
		return false;
	}
	if($("#uploadfile").val() != ""){
		var ext=$("#uploadfile").val().split('.').pop().toLowerCase();
		if($.inArray(ext,['gif','jpg','png','jpeg']) == -1) { /*하나라도 같으면 0이상의 값을 뱉는다.*/
			alert('Only Image file can be uploaded (gif,jpg,png,jpeg)');
			$("#uploadfile").val("");
			return false;
		}
	}
	if(document.getElementById("uploadfile").value != ""){
		var fileSize = document.getElementById("uploadfile").files[0].size;
		var maxSize = 3 * 1024 * 1024; //3mb
		if(fileSize > maxSize){
			alert('Image file can be upload max 3MB.');
			document.getElementById("uploadfile").value = "";
			return false;
		}
	}
	
	if( confirm('You sure to edit your profile?') ){
		document.updateForm.submit();
	}else{
		return false;
	}
}
	
</script>

<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script>
    // 우편번호 찾기 화면을 넣을 element
    var element_layer = document.getElementById('layer');

    function closeDaumPostcode() {
        // iframe을 넣은 element를 안보이게 한다.
        element_layer.style.display = 'none';
    }

    function sample2_execDaumPostcode() {
        new daum.Postcode({
            oncomplete: function(data) {
                // 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

                // 각 주소의 노출 규칙에 따라 주소를 조합한다.
                // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
                var addr = ''; // 주소 변수
                var extraAddr = ''; // 참고항목 변수

                //사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
                if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
                    addr = data.roadAddress;
                } else { // 사용자가 지번 주소를 선택했을 경우(J)
                    addr = data.jibunAddress;
                }

        /* 참고항목 함수 있던 곳 !!! */
                
                // 우편번호와 주소 정보를 해당 필드에 넣는다.
                document.getElementById('sample2_postcode').value = data.zonecode;
                document.getElementById("sample2_address").value = addr;
                // 커서를 상세주소 필드로 이동한다.
                document.getElementById("sample2_detailAddress").focus();

                // iframe을 넣은 element를 안보이게 한다.
                // (autoClose:false 기능을 이용한다면, 아래 코드를 제거해야 화면에서 사라지지 않는다.)
                element_layer.style.display = 'none';
            },
            width : '100%',
            height : '100%',
            maxSuggestItems : 5
        }).embed(element_layer);

        // iframe을 넣은 element를 보이게 한다.
        element_layer.style.display = 'block';

        // iframe을 넣은 element의 위치를 화면의 가운데로 이동시킨다.
        initLayerPosition();
    }

    // 브라우저의 크기 변경에 따라 레이어를 가운데로 이동시키고자 하실때에는
    // resize이벤트나, orientationchange이벤트를 이용하여 값이 변경될때마다 아래 함수를 실행 시켜 주시거나,
    // 직접 element_layer의 top,left값을 수정해 주시면 됩니다.
    function initLayerPosition(){
        var width = 500; //우편번호서비스가 들어갈 element의 width
        var height = 600; //우편번호서비스가 들어갈 element의 height
        var borderWidth = 5; //샘플에서 사용하는 border의 두께

        // 위에서 선언한 값들을 실제 element에 넣는다.
        element_layer.style.width = width + 'px';
        element_layer.style.height = height + 'px';
        element_layer.style.border = borderWidth + 'px solid';
        // 실행되는 순간의 화면 너비와 높이 값을 가져와서 중앙에 뜰 수 있도록 위치를 계산한다.
        element_layer.style.left = (((window.innerWidth || document.documentElement.clientWidth) - width)/2 - borderWidth) + 'px';
        element_layer.style.top = (((window.innerHeight || document.documentElement.clientHeight) - height)/2 - borderWidth) + 'px';
    }
</script>

<%@ include file="../includes/footer.jsp" %>