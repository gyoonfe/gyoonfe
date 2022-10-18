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
	  <p class="fs-1 gyoon-redressed">Cart</p>
	  
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
			
			  <form method="post" action="/mypage/cartRegister.do" name="cartForm"> <!-- cartForm ----------------------------- -->
			  <input type="hidden" name="userid" value="${session_userid}" />
			  <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
			  
			  <table class="table text-center mt-5">
			  	<thead>
			  	<tr>
			  	  <td class="fs-4" colspan="3">
			  	    Address 
			  	  </td>
			  	</tr>
			  	<tr>
			  	  <td style="width: 20%;">ZipCode</td>
			  	  <td>Address</td>
			  	  <td>Detail</td>
			  	</tr>
			  	</thead>
			  	<tr>
			  	  <td><input class="form-control bg-white box" type="text" name="ozipcode" id="sample2_postcode" value="${mVO.zipcode}" readonly></td>
			  	  <td><input class="form-control bg-white box" type="text" name="oaddress1" id="sample2_address" value="${mVO.address1}" readonly></td>
			  	  <td><input class="form-control box" type="text" name="oaddress2" id="sample2_detailAddress" value="${mVO.address2}"></td>
			  	</tr>
			  </table>
			
			  <div class="mb-5">
			    <span class="fs-5 p-1 px-3 mx-3 button-hover " onClick="sample2_execDaumPostcode()">Address Edit</span>
			  </div>
			
			  <table class="table text-center mt-5">
			    <thead class="fs-4">
			    <tr>
			      <td>
			        Product
			      </td>
			      <td>
			        Price
			      </td>
			      <td>
			        Quantity
			      </td>
			      <td>
			        Date
			      </td>
			    </tr>
			    </thead>
			    
			    <c:forEach var="cVO" items="${cart_list}">
			  	<tr> 
			  	  <td> 
					<a href="/product/productView.do?pseq=${cVO.pseq}"><c:out value="${cVO.pname}"/></a>
			  	  </td>
			  	  <td> 
					<fmt:setLocale value="ko_kr"/><fmt:formatNumber type="currency" maxFractionDigits="3" value="${cVO.price2}"/>
			  	  </td>
			  	  <td> 
					<c:out value="${cVO.cquantity}"/>
			  	  </td>
			  	  <td> 
			  	    <fmt:formatDate pattern="yyyy-MM-dd" value="${cVO.cregdate}"/>
					<input class="form-check-input" type="checkbox" name="cseq" value="${cVO.cseq}">
			  	  </td>
			  	</tr>
			  	</c:forEach>
			  	
			  	<tr class="fs-5"> 
			  	  <td> 
					Total
			  	  </td>
			  	  <td colspan="2"> 
					<fmt:setLocale value="ko_kr"/><fmt:formatNumber type="currency" maxFractionDigits="3" value="${total_price}"/>
					<input type="hidden" id="totalPrice" value="${total_price}">
			  	  </td>
			  	  <td> 
					<span class="p-1 px-3 button-hover" onClick="return checkDelete()">Delete</span> 
			  	  </td>
			  	</tr>
			  </table>
			  
			  <c:if test="${cart_list[0] == null}">
			  	<p class="my-5 fs-3 gyoon-redressed">'No products in Cart'</p>
			  </c:if>
			  
			  <div class="d-flex justify-content-center fs-5 my-5">
				  <span class="p-1 px-4 mx-1 button-hover" onClick="return checkOrder()">Order</span>  
			      <span class="p-1 px-3 mx-1 button-hover" onClick="location.href='/product/productCategory.do?category=electric'">Shopping</span>
			  </div>
			  </form>
			  
<!-- Daum post API -->
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
		var delete_result = '<c:out value="${delete_result}"/>';
		if( delete_result != null && delete_result != "" && !history.state ){
			if( parseInt(delete_result) > 0 ){
				alert('Cart Delete Success ! ( ' + delete_result + ' )');
			}else{
				alert('Error - Cart Delete !');
			}
		}
		var no_cart = '<c:out value="${no_cart}"/>';
		if( no_cart != null && no_cart != "" && !history.state ){
			alert(no_cart);
		}
		history.replaceState({},null,null);
	})	
	
	function checkDelete(){
		var count = 0;
		if( document.cartForm.cseq.length == undefined ){
			if( document.cartForm.cseq.checked == true ){
				count++;
			}
		}else{
			for( var i=0; i<document.cartForm.cseq.length; i++ ){
				if( document.cartForm.cseq[i].checked == true ){
					count++;
				}
			}
		}
		if( count == 0 ){
			alert("Please check products you want to delete from cart list.");
			document.cartForm.focus();
		}else{
			if( confirm("You sure to delete "+count+" items from cart list?") ){
				document.cartForm.action = "/mypage/cartDelete.do";
				document.cartForm.submit();
			} else{
			 return false;	
			}
		}
	}
	
	function checkOrder(){
		if( $("#sample2_postcode").val()=='' ||  $("#sample2_address").val()=='' || $("#sample2_detailAddress").val()=='' ){
			alert('Please check your Address.');
			$("#sample2_detailAddress").focus();
			return false;
		}
		var total = document.getElementById("totalPrice").value;
		if( confirm('You sure to order items in cart? ( ' +total+ ' )') ){
			document.cartForm.submit();
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