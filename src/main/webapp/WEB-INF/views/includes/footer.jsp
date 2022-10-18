<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>


<div class="container my-5">

  <div class="row mt_200">
    <div class="row col-md-4 border border-dark border-start-0">
      <div class="col-md-6">
		<i class="bi bi-instagram fs-2 onInsta"></i> <span class="gyoon-redressed fs-3 onInsta">Instagram</span> <br>
		<i class="bi bi-facebook fs-2 onFace"></i> <span class="gyoon-redressed fs-3 onFace">Facebook</span> <br>
		<i class="bi bi-twitter fs-2 onTwit"></i> <span class="gyoon-redressed fs-3 onTwit">Twitter</span> <br>
		<i class="bi bi-youtube fs-2 onYou"></i> <span class="gyoon-redressed fs-3 onYou">Youtube</span> <br>
      </div>
      <div class="col-md-6">
        <img src="/resources/images/gyoontar_gyoontar.jpg" alt="..." class="p-0 m-0 mt-5" style="width: 100%; height: 110px;">
      </div>
		<span class="gyoon-redressed fs-5">
		  Gyoonontar promise to provide customers high-quality service with honest at all times.<br>
		</span>
		<span class="gyoon-redressed fs-5">
		  All brand products sold in Gyoontar are 100% genuine products that are officially manufactured and distributed through official revenue sources.
		</span>
    </div>
    <div class="col-md-4 border-dark border-top border-bottom">
	    <table class="table table-striped gyoon-redressed text-center fs-5 align-middle my-3" style="width: 100%;height: 350px; margin-left: 7px;">
	      <tr>
	        <td colspan="2"><p class="gyoon-redressed fs-3">Contact Us</p></td>
	      </tr>
	      <tr>
	        <td><label for="contact_name">Name</label></td>
	        <td><input class="form-control border-dark" type="text" name="contact_name" id="contact_name"></td>
	      </tr>
	      <tr>
	        <td><label for="contact_email">E-mail</label></td>
	        <td><input class="form-control border-dark" type="text" name="contact_email" id="contact_email"></td>
	      </tr>
	      <tr>
	        <td><label for="contact_content">Content</label></td>
	        <td><textarea class="form-control border-dark scrollspy-example" name="contact_content" id="contact_content"></textarea></td>
	      </tr>
	      <tr>
	        <td colspan="2"><span class="p-1 px-3 button-hover" onClick="return checkContact()">Send</span></td>
	      </tr>
	    </table>
    </div>
    <div class="col-md-4 border border-dark border-end-0">
        <p class="gyoon-redressed text-center fs-3 mt-2 mb-0">Where is HQ</p>
		<div class="my-2" id="map_ma" style="width: 100%;height: 300px; z-index: 0;"></div>
		<span class="gyoon-link"><a href="/index/map.do" class="gyoon-redressed float-end mb-1">Click here to see all store</a></span>
    </div>
  </div> <!-- /row -->

  <div class="text-center my-5">
    <span class="fs-5">HQ : (Zip)34856, Huiyoung Building 5-6F, 825, Gyeryong-ro, Jung-gu, Daejeon, Republic of Korea</span><br>
    Business registration number : 000-00-00000<br>
    <i class="bi bi-telephone"></i>  042-000-0000 / <i class="bi bi-envelope"></i>  gyoonproject@gmail.com<br>
    <p>Copyright &copy Gyoontar. All rights reserved.</p>
  </div>

</div><!-- /container -->



</body>
</html>

<script type="text/javascript">

//SNS Link
$(".onInsta").on("click", function(){
	location.href="#";
})
$(".onFace").on("click", function(){
	location.href="#";
})
$(".onTwit").on("click", function(){
	location.href="#";
})
$(".onYou").on("click", function(){
	location.href="#";
})

// Contact Us 메일 보내기
function checkContact(){
	if( $("#contact_name").val() == '' ){
		alert('Please input your name.');
		$("#contact_name").focus();
		return false;
	}
	if( $("#contact_content").val() == '' ){
		alert('Please input your content.');
		$("#contact_content").focus();
		return false;
	}
	var regEmail=/^[A-Za-z0-9_\.\-]+@[A-Za-z0-9\-]+\.[a-zA-Z0-9\-]+/;
	if( !regEmail.test($("#contact_email").val()) ){
		alert('Email format is incorrect.');
		$("#contact_email").focus();
		return false;
	}
	// 비동기 메일 보내기
	var contact_name = $("#contact_name").val();
	var contact_email = $("#contact_email").val();
	var contact_content = $("#contact_content").val();
	var token = $("meta[name='_csrf']").attr("content");
	var header = $("meta[name='_csrf_header']").attr("content");
	$.ajax({
		type:"post",
		url:"/index/contact.do",
		dataType:"json",
		data:{
			name : contact_name,
			email : contact_email,
			content : contact_content
		},
		beforeSend : function(xhr)
		{   /*데이터를 전송하기 전에 헤더에 csrf값을 설정한다*/
			xhr.setRequestHeader(header, token);
		},
		success:function(data){
			$("#contact_name").val(""); $("#contact_email").val(""); $("#contact_content").val("");
			if( parseInt(data) == 1 ){
				alert(contact_name + "\'s Mail has been sent successfully !");
			}else{
				alert('Error - Contact Mail. Please try again.');
			}
		}, error:function(){
			alert("Error - Contact Mail... Please try again...");
		}
	})
}

// Google Map API
$(document).ready(function() {
//     var myLatlng = new google.maps.LatLng(36.3268821,127.4078567);
    var Y_point            = 36.3268821;        // Y 좌표
    var X_point            = 127.4078567;        // X 좌표
    var zoomLevel        = 17;                // 지도의 확대 레벨 : 숫자가 클수록 확대정도가 큼
    var markerTitle        = "Gyoontar HQ";        // 현재 위치 마커에 마우스를 오버을때 나타나는 정보
    var markerMaxWidth    = 300;                // 마커를 클릭했을때 나타나는 말풍선의 최대 크기

	// 말풍선 내용
    var contentString    = '<div>' +
	    '<p class="gyoon-redressed text-center fs-5">Gyoontar HQ</p>'+
	    '<p class="m-0">82) 042-000-0000</p>' +
	    '<p class="m-0">gyoonproject@gmail.com</p>' +
    	'</div>';
    var myLatlng = new google.maps.LatLng(Y_point, X_point);
    var mapOptions = {
	    zoom: zoomLevel,
	    center: myLatlng,
	    mapTypeId: google.maps.MapTypeId.ROADMAP
   	}
    var map = new google.maps.Map(document.getElementById('map_ma'), mapOptions);
    var marker = new google.maps.Marker({
	    position: myLatlng,
	    map: map,
	    title: markerTitle
    });
    var infowindow = new google.maps.InfoWindow({
	        content: contentString,
	        maxWizzzdth: markerMaxWidth
	});
    google.maps.event.addListener(marker, 'click', function() {
        infowindow.open(map, marker);
    });
});
</script>

<!-- Google Map API -->
<script src="https://maps.googleapis.com/maps/api/js?key=AIzaSyBiuNYqlKJxhHI9CsxfEURFDZ3bF8OXjRM"></script>
