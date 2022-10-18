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
	
	<form method="post" action="join.do" enctype="multipart/form-data" name="joinForm" id="joinForm">
    <input type="hidden" id="idCheck" value="n"> <!-- Duplicate Check value -->
    <input type="hidden" id="nickCheck" value="n"> <!-- Duplicate Check value -->
    <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
	
	<div class="row my-5" align="center">
	  <p class="fs-1 gyoon-redressed">Join</p>	
	  <hr>
	  <div class="col-md-12 mt-3"> <!-- col -->
	    <table class="fs-4 label-mg boxes align-middle">
	      <tr>
	        <td><label for="userid" class="mx-5">ID  </label></td>
	        <td><input class="form-control form-control-sm box" type="text" placeholder="lower Eng~)(5~20)(Eng,Num)" name="userid" id="userid"></td>
	      </tr>
	      <tr>
	        <td colspan="3"><p class="text-center my-0" id="idMsg"></p></td>
	      </tr>
	      <tr>
	        <td><label for="pass" class="mx-5">Password</label></td>
	        <td><input class="form-control form-control-sm box" type="password" placeholder="(6~20) Eng+Num+ ~!@\#$%<>^&*" name="pass" id="pass"></td>
	      </tr>
	      <tr>
	        <td><label for="pass2" class="mx-5">PW Check</label></td>
	        <td><input class="form-control form-control-sm box" type="password" placeholder="password check" name="pass2" id="pass2"></td>
	      </tr>
	      <tr>
	        <td><label for="mname" class="mx-5">Name</label></td>
	        <td><input class="form-control form-control-sm box" type="text" placeholder="Name" name="mname" id="mname"></td>
	      </tr>
	      <tr>
	        <td><label for="nickname" class="mx-5">Nickname</label></td>
	        <td><input class="form-control form-control-sm box" type="text" placeholder="Nickname" name="nickname" id="nickname"></td>
	      </tr>
	      <tr>
	        <td colspan="3"><p class="text-center my-0" id="nickMsg"></p></td>
	      </tr>
	      <tr>
	        <td><label for="sex" class="mx-5">Sex</label></td>
	        <td>
	          <select class="form-select-sm box" name="sex" id="sex">
			    <option value="0">Female</option>
			    <option value="1">Male</option>
			  </select>
	        </td>
	      </tr>
	      
	      <tr>
	        <td rowspan="2"><label for="email" class="mx-5">E-mail</label></td>
	        <td><input class="form-control form-control-sm box" type="text" placeholder="gyoon@gmail.com" name="email" id="email"></td>
	        <td><span class="fs-5 px-3 ms-5 button-hover" id="btn-mail">Send</span></td>
	      </tr>
	      <tr>
	        <td><input type="text" class="form-control form-control-sm box" id="codeNum" disabled="disabled"></td>
	      </tr>
	      <tr>
	        <td><label for="phone" class="mx-5">Phone</label></td>
	        <td><input class="form-control form-control-sm box" type="text" placeholder="010-1234-5678" name="phone" id="phone"></td>
	      </tr>
	      <tr>
	        <td><label for="zipcode" class="mx-5">Zip Code</label></td>
	        <td><input class="form-control form-control-sm bg-white box" type="text" name="zipcode" id="sample2_postcode" readonly></td>
	        <td><span class="fs-5 px-2 ms-5 button-hover" onClick="sample2_execDaumPostcode()">Search</span></td>
	      </tr>
	      <tr>
	        <td rowspan="2"><label for="sample2_detailAddress" class="mx-5">Address</label></td>
	        <td><input class="form-control form-control-sm bg-white box" type="text" name="address1" id="sample2_address" readonly></td>
	      </tr>
	      <tr>
	        <td><input class="form-control form-control-sm box" type="text" name="address2" id="sample2_detailAddress"></td>
	      </tr>
	      <tr>
	        <td><label for="uploadfile" class="mx-5">Image</label></td>
	        <td><input class="form-control form-control-sm box" type="file" name="uploadfile" id="uploadfile"></td>
	      </tr>
	    </table> 
	  </div><!-- /col -->
	
	  <div class="d-flex justify-content-center mt-5 mb-5">
	    <div class="">
		  <span class="p-1 px-4 button-hover" id="join">Join</span>    
	      <span class="p-1 px-3 button-hover" onClick="location.href='login.do'">Log In</span>
	      <span class="p-1 px-3 button-hover" onClick="location.href='/index/index.do'">Home</span>
	    </div>
	  </div>

<!-- Daum post API -->
<%@ include file="../includes/daumPostApi.jsp" %>

	</div><!-- /row -->
	</form>  

	
</div> <!-- /container -->


</body>
</html>



<script type="text/javascript">
	
$("#userid").blur(function(){
	var userid = $("#userid").val();
	$.ajax({
		type:"get",
		url:"/member/checkUserId.do?userid=" + userid,
		dataType:"json", 
		success:function(data){ 
			console.log(data);
			if( data == 0 && $("#userid").val() != "" ){
					$("#idMsg").html("Duplicate Check OK !"); $("#idMsg").css("color","green");
					$("#idCheck").val("y");
			}else{ 
					$("#idMsg").html("Unavailable ID !"); $("#idMsg").css("color","red");
					$("#userid").val(""); 
					$("#idCheck").val("n");
			}
		}, error:function(){
			alert("ID duplication check ERROR");
		}
	})
})

$("#nickname").blur(function(){
	var nickname = $("#nickname").val();
	$.ajax({
		type:"get",
		url:"/member/checkNickname.do?nickname=" + nickname,
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
var code="";
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
			$("#codeNum").css("background","#fff");
		}
	})
})

//최종 create 버튼 클릭 시
$("#join").on("click", function() {
	if( $("#idCheck").val() == "n" ){
		alert('Please check ID. It is not available ID.');
		$("#adminid").focus();
		return false;
	}
	var idExp = /^[a-z]+[a-z0-9]{4,19}$/g;
	if( !idExp.test($("#userid").val()) ){
		alert('ID must start with lower English letter and be at least 5 characters long (special character X).');
		$("#userid").val("");
		$("#userid").focus();
		return false;
	}
	if( $("#pass").val().length == 0 ){
		alert('please input Password.');
		 $("#pass").focus();
		return false;
	}
	var pattern1=/[0-9]/;
	var pattern2=/[a-zA-Z]/;
	var pattern3=/[~!@\#$%<>^&*]/;
	var pw = $("#pass").val();
	if(!pattern1.test(pw) || !pattern2.test(pw) || !pattern3.test(pw) || pw.length<6 || pw.length>20){
	     alert('You can only use password between 6~20 and have to contain lower or upper-case letters, numbers, and special characters ~!@\#$%<>^&*');
	     $("#pass").focus(); $("#pass").val("");
	     return false;
	}
	if( $("#pass").val() != $("#pass2").val() ){
		alert('Confirm your Password.');
		$("#pass2").focus();
		return false;
	}
	if( $("#nickname").val().length == 0 ){
		alert('Please input Nickname.');
		 $("#nickname").focus();
		return false;
	}
	if( code != $("#codeNum").val() || $("#codeNum").val().length == 0 ){
		alert('Please check E-mail code');
		$("#codeNum").focus();
		return false;
	}
	if( $("#sample2_postcode").val().length == 0 || $("#sample2_address").val().length == 0 || $("#sample2_detailAddress").val().length == 0 ){
		alert('Please check adrress.');
		$("#sample2_detailAddress").focus();
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
	if( confirm('You sure to create New Account?') ){
		$("#joinForm").submit();
	}else{ return false; }
});
	
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
                
                // 사용자가 선택한 주소가 도로명 타입일때 참고항목을 조합한다.
                //if(data.userSelectedType === 'R'){
                    // 법정동명이 있을 경우 추가한다. (법정리는 제외)
                    // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
                    //if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
                        //extraAddr += data.bname;
                    //}
                    // 건물명이 있고, 공동주택일 경우 추가한다.
                    //if(data.buildingName !== '' && data.apartment === 'Y'){
                        //extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
                    //}
                    // 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
                    //if(extraAddr !== ''){
                        //extraAddr = ' (' + extraAddr + ')';
                    //}
                    // 조합된 참고항목을 해당 필드에 넣는다.
                    //document.getElementById("sample2_extraAddress").value = extraAddr;
                
                //} else {
                    //document.getElementById("sample2_extraAddress").value = '';
                //}

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