<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>


<div class="gyoon-mypage-nav border border-dark shadow shadow-md">
<div class="d-flex flex-column  gyoon-link gyoon-redressed fs-5">
  <div class="d-flex justify-content-center">
	<div class="p-2 my-0 text-center gyoon-divUP-hover"><a class="nav-link" href="/mypage/myProfile.do?userid=${session_userid}"><i class="bi bi-person-circle"></i>Profile</a></div>
	<div class="p-2 text-center gyoon-divUP-hover"><a class="nav-link" href="/mypage/myQna.do?userid=${session_userid}"><img src="/resources/icon/myQna.png">QnA</a></div>
	<div class="p-2 text-center gyoon-divUP-hover"><a class="nav-link" href="/mypage/myBoard.do?userid=${session_userid}"><i class="bi bi-clipboard2-check"></i>My.Board</a></div>
	<div class="p-2 text-center gyoon-divUP-hover"><a class="nav-link" href="/mypage/myReview.do?userid=${session_userid}"><img src="/resources/icon/myComment.png">My.Review</a></div>
  </div>
  <hr class="m-0 p-0">
  <div class="d-flex justify-content-center">
	<div class="p-2 text-center gyoon-divUP-hover"><a class="nav-link" href="/mypage/myCart.do?userid=${session_userid}"><i class="bi bi-cart4"></i>Cart</a></div>
	<div class="p-2 my-0 text-center gyoon-divUP-hover"><a class="nav-link" href="/mypage/myWish.do?userid=${session_userid}"><i class="bi bi-bag-heart"></i>Wish.List</a></div>
	<div class="p-2 text-center gyoon-divUP-hover"><a class="nav-link" href="/mypage/myOrderIng.do?userid=${session_userid}"><img src="/resources/icon/myOrderIng.png">Ordered</a></div>
	<div class="p-2 text-center gyoon-divUP-hover"><a class="nav-link" href="/mypage/myOrderAll.do?userid=${session_userid}"><i class="bi bi-cart-check-fill"></i>Order.List</a></div>
  </div>
</div>
</div> <!-- /gyoon-mypage-nav -->