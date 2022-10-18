<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<!doctype html>
<html lang="ko">
<head>
<title>Gyoontar</title>
<meta name="_csrf" content="${_csrf.token}"/>
<meta name="_csrf_header" content="${_csrf.headerName}"/>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p" crossorigin="anonymous"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<!-- <script type="text/javascript" src="https://code.jquery.com/jquery-1.12.4.min.js" ></script> -->

<!-- google fonts -->
<link rel="preconnect" href="https://fonts.googleapis.com"> 
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Redressed&display=swap" rel="stylesheet">
<!-- bootstrap icon -->
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.8.3/font/bootstrap-icons.css"> 
<!-- mystyle.css -->
<link rel="stylesheet" href="/resources/mystyle.css" >
<!-- include summernote css/js -->
<link href="/resources/summer/summernote-lite.css" rel="stylesheet">
<script src="/resources/summer/summernote-lite.js"></script>

</head>

 <body>
 <!-- 
 웹문서 만들기 기본 공식
 1. 요소를 어떻게 묶을 것인가? 그룹만들기
 2. 그룹안에 적절한 태그 사용
 3. class 이름 붙이고 css 적용
 -->
<div class="container">

	<h1 class="bg-dark text-white text-center mt-3 mb-0 gyoon-redressed">
		<span class="fs-5">Welcome to </span>
		<span class="mx-3 top_gyoontar">
		  <a href="/index/index.do">Gyoontar</a>
		</span>
		<span class="fs-5">Music is our life</span> 
	</h1>
	
	<div class="text-center my-2">
	  <a href="/index/index.do" class="align-middle">
	  <img src="/resources/images/gyoontar_logo.jpg" style="width: 300px; height:100px;">  
	  </a>
	</div>
	
    <nav class="gyoon-nav border-top border-bottom border-dark mb-4 p-0"> <!-- gyoon-nav START ~~~~~~~~~~~~~~~ -->
      
      <form method="get" action="/product/productSearch.do" name="headSearch" class="gyoon-nav-search d-flex justify-content-center my-3">
		<select name="type">
			<option value="">Select</option>
			<option value="N">Name</option>
			<option value="C">Content</option>
			<option value="NC">Both</option>
		</select> 
        <input class="form-control border-dark mx-2" type="search" name="keyword" placeholder="Product Serch" aria-label="Search">
        <input type="hidden" name="pageNum" value="1">
        <input type="hidden" name="amount" value="12">
        <button class="btn btn-sm btn-outline-dark" type="submit">Search</button>
      </form>

      <ul class="gyoon-nav-menu">
        <li class="nav-item">
          <a class="nav-link" aria-current="page" href="/index/index.do">Home</a>
        </li>
        <li class="nav-item dropdown">
          <a class="nav-link dropdown-toggle" href="#" id="navbarDropdown" role="button" data-bs-toggle="dropdown" aria-expanded="false">
            Shop
          </a>
          <ul class="dropdown-menu" aria-labelledby="navbarDropdown">
            <li><a class="dropdown-item" href="/product/productCategory.do?category=electric"><img src="/resources/icon/elecGuitar.png"> Electric guitar</a></li>
            <li><a class="dropdown-item" href="/product/productCategory.do?category=acoustic"><img src="/resources/icon/acousticGuitar.png"> Acoustic Guitar</a></li>
            <li><hr class="dropdown-divider"></li>
            <li><a class="dropdown-item" href="/product/productCategory.do?category=amp"><img src="/resources/icon/amp.png"> Amplifier</a></li>
            <li><a class="dropdown-item" href="/product/productCategory.do?category=acc"><img src="/resources/icon/accessories.png"> Accessory</a></li>
          </ul>
        </li>
        <li class="nav-item dropdown">
          <a class="nav-link dropdown-toggle" href="#" id="navbarDropdown" role="button" data-bs-toggle="dropdown" aria-expanded="false">
            Community
          </a>
          <ul class="dropdown-menu" aria-labelledby="navbarDropdown">
            <li><a class="dropdown-item" href="/board/board.do"><i class="bi bi-clipboard"></i> Board</a></li>
            <li><hr class="dropdown-divider"></li>
            <li><a class="dropdown-item" href="/index/faq.do"><i class="bi bi-question-square"></i> FAQ</a></li>
            <li><a class="dropdown-item" href="/index/map.do"><i class="bi bi-map"></i> Offline Store</a></li>
          </ul>
        </li>
      </ul>

      <ul class="gyoon-nav-icons flex-wrap">
      
        <sec:authorize access="isAnonymous()">
        <li class="nav-item">
          <a class="nav-link" href="/member/login.do">Log In</a>
        </li>
        <li class="nav-item">
          <a class="nav-link"  href="/member/contract.do">Sign Up</a>
        </li>
        </sec:authorize>
        
        <sec:authorize access="isAuthenticated()">
        <li class="nav-item">
          <a class="nav-link"  href="/mypage/myProfile.do?userid=${session_userid}">[ ${session_userid} ]</a>
        </li>
        <li class="nav-item">
          <form method="post" action="/member/logout.do" name="logoutForm" onsubmit="return confirm('You really want to Log out?')">
          	<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}">
          	<input class="gyoon-logout" type="submit" value="Log Out">
          </form>
        </li>
        </sec:authorize>
        
        <sec:authorize access="hasRole('ROLE_MEMBER')">
        <li class="nav-item dropdown">
          <a class="nav-link dropdown-toggle" href="#" id="navbarDropdown" role="button" data-bs-toggle="dropdown" aria-expanded="false">
            My Page
          </a>
          <ul class="dropdown-menu" aria-labelledby="navbarDropdown">
            <li><a class="dropdown-item" href="/mypage/myProfile.do?userid=${session_userid}"><i class="bi bi-person-circle"></i> Profile</a></li>
            <li><hr class="dropdown-divider"></li>
            <li><a class="dropdown-item" href="/mypage/myCart.do?userid=${session_userid}"><i class="bi bi-cart4"></i> Cart</a></li>
            <li><a class="dropdown-item" href="/mypage/myWish.do?userid=${session_userid}"><i class="bi bi-bag-heart"></i> Wish List</a></li>
            <li><a class="dropdown-item" href="/mypage/myOrderAll.do?userid=${session_userid}"><i class="bi bi-cart-check-fill"></i> My Order</a></li>
            <li><hr class="dropdown-divider"></li>
            <li><a class="dropdown-item" href="/mypage/myBoard.do?userid=${session_userid}"><i class="bi bi-clipboard2-check"></i> My Board</a></li>
            <li><a class="dropdown-item" href="/mypage/myQna.do?userid=${session_userid}"><i class="bi bi-question-circle"></i> QnA(1:1)</a></li>
          </ul>
        </li>
        </sec:authorize>
        
         <sec:authorize access="hasRole('ROLE_ADMIN')">
         <li class="nav-item dropdown">
          <a class="nav-link dropdown-toggle" href="#" id="navbarDropdown" role="button" data-bs-toggle="dropdown" aria-expanded="false">
            Admin
          </a>
          <ul class="dropdown-menu" aria-labelledby="navbarDropdown">
            <li><a class="dropdown-item" href="/admin/order.do"><img src="/resources/icon/myOrderIng.png"> Order</a></li>
            <li><a class="dropdown-item" href="/admin/product.do"><img src="/resources/icon/elecGuitar.png"> Product</a></li>
            <li><a class="dropdown-item" href="/admin/board.do"><i class="bi bi-clipboard2-check"></i> Board</a></li>
            <li><hr class="dropdown-divider"></li>
            <li><a class="dropdown-item" href="/admin/member.do"><i class="bi bi-person-circle"></i> Member</a></li>
            <li><a class="dropdown-item" href="/admin/admin.do"><i class="bi bi-person-badge"></i> Admin</a></li>
            <li><a class="dropdown-item" href="/admin/qna.do"><i class="bi bi-question-circle"></i> QnA(1:1)</a></li>
            <li><hr class="dropdown-divider"></li>
            <li><a class="dropdown-item" href="/admin/map.do"><i class="bi bi-map"></i>Offline Store</a></li>
            <li><a class="dropdown-item" href="/admin/statistics.do"><i class="bi bi-graph-up-arrow"></i>Statistics</a></li>
          </ul>
        </li>
        </sec:authorize>
        
      </ul>
      
    </nav>



</div> <!-- /container -->


	