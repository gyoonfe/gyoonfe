<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>


<div class="gyoon-sidebar shadow-sm">
    <div class="container mt-4">
	<div class="d-flex flex-column   gyoon-link gyoon-redressed fs-5">
	  <div class="p-2 text-center"><a class="nav-link" aria-current="page" href="/index/index.do">Home</a></div>
	  <hr>
	  <div class="p-2 text-center"><a class="nav-link" href="/board/board.do"><i class="bi bi-clipboard"></i>Board</a></div>
	  <sec:authorize access="isAuthenticated()">
	    <div class="p-2 text-center"><a class="nav-link" href="/mypage/myProfile.do?userid=${session_userid}"><i class="bi bi-person-circle"></i>Profile</a></div>
	  </sec:authorize>
	  <hr>
	  <div class="py-2 text-center"><a class="nav-link" href="/product/productSale.do"><img src="/resources/icon/sale.png">Sale</a></div>
	  <div class="py-2 text-center"><a class="nav-link" href="/product/productCategory.do?category=electric"><img src="/resources/icon/elecGuitar.png">Electric</a></div>
	  <div class="py-2 text-center"><a class="nav-link" href="/product/productCategory.do?category=acoustic"><img src="/resources/icon/acousticGuitar.png">Acoustic</a></div>
	  <div class="py-2 text-center"><a class="nav-link" href="/product/productCategory.do?category=amp"><img src="/resources/icon/amp.png">Amplifier</a></div>
	  <div class="py-2 text-center"><a class="nav-link" href="/product/productCategory.do?category=acc"><img src="/resources/icon/accessories.png">Accessory</a></div>
	</div>    
    </div>
</div><!-- /gyoon-sidebar -->
