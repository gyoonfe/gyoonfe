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
	  
	  <form method="get" action="/admin/board.do" name="boardSearchForm" class="mx-2"> 
	  <div class="d-flex justify-content-end align-items-center mb-3">
	  	  <div>
		      <select name="type">
			    <option value="">Select</option>
			    <option value="T">Title</option>
			    <option value="C">Content</option>
			    <option value="W">Nickname</option>
			    <option value="TCW">All</option>
		      </select>
	  	  </div>
	  	  <div class="mx-2">
			  <input class="form-control border-dark" type="search" name="keyword" placeholder="Search" aria-label="Search">
	          <input type="hidden" name="pageNum" value="1">
	          <input type="hidden" name="amount" value="10"> 
          </div>
          <div>
			  <span class="p-1 px-3 button-hover" onClick="return submitSearch()">Search</span>	
		  </div>
	  </div>
	  </form> 
	  
	  <hr>

	  <div class="gyoon-pd-mg">

		  <!-- Admin Nav -->
		  <%@ include file="../includes/adminNav.jsp" %>
		
		  <div class="row my-5">		  
			<div class="col-md-12">

			   <p class="fs-1 mt-5 gyoon-redressed">Board Update</p>

			  <form method="post" action="/admin/boardUpdate.do" enctype="multipart/form-data" name="updateForm">
			  <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
			  <input type="hidden" name="bno" value="${boardVO.bno}">
			  <input type="hidden" name="userid" value="${session_userid}">
			  <input type="hidden" name="hits" value="${boardVO.hits}">
			  <input type="hidden" name="pageNum" value="${cri.pageNum}">
			  <input type="hidden" name="amount" value="${cri.amount}">
			  
			  <div class="d-flex justify-content-center">
			  	<p>Date : <fmt:formatDate pattern="yyyy-MM-dd" value="${boardVO.regdate}"/></p>
			  	<p class="mx-3"></p>
			  	<p>Writer : <c:out value="${boardVO.nickname}"/></p>
			  </div>
			  
			  <hr>
			  
				<table class="table text-center border_white my-5 align-middle">
				    <tr>
				      <th>Title</th>
				      <th><input type="text" class="form-control border-dark" aria-describedby="addon-wrapping" name="title" value="${boardVO.title}"></th>
				    </tr>
				    <tr>
				      <th>Content</th>
				      <th><textarea class="gyoon-content" name="content" id="summernote">${boardVO.content}</textarea></th>
				    </tr>
				</table>

			  <hr>
			  
			  <div class="d-flex justify-content-center mt-5 mb-5">
			    <div class="">
				  <span class="p-1 px-3 button-hover" onClick="checkUpdate()">Update</span> 
				  <span class="p-1 px-3 button-hover" onClick="checkReset()">Reset</span>    
			      <span class="p-1 px-4 button-hover" onClick="location.href='/admin/board.do'">List</span>
			    </div>
			  </div>
			  </form> <!-- Form ------------------------------------------- -->

			</div>  <!-- /col -->	
		  </div> <!-- /row -->
	  	
	  </div><!-- / padding row -->

	</div><!-- /row -->
	
</div>

</div><!-- /제일 바깥 container -->

</body>
</html>

<script type="text/javascript">
function checkUpdate(){
	if(document.updateForm.title.value.length == 0){
		document.updateForm.title.focus();
		alert("Check your Title.");
		return false;
	}
	if(document.updateForm.content.value.length == 0){
		document.updateForm.content.focus();
		alert("Check your Content.");
		return false;
	}
	if(confirm('Are you sure to upload this post?')){
		document.updateForm.submit();
	}else{
		return false;
	}
}

var reset_content = '${boardVO.content}';
function checkReset(){
	if(confirm('You really want to Reset this form?')){
		document.updateForm.reset();
		$('#summernote').summernote('code', reset_content);
		document.updateForm.title.focus();
	}else{
		return false;
	}
}

$('#summernote').summernote({
	height: 300,
	tabsize: 2,
	minHeight: null,         
	maxHeight: null,           
	focus: true,
	 toolbar: [
	    // 글꼴 설정
	    ['fontname', ['fontname']],
	    // 글자 크기 설정
	    ['fontsize', ['fontsize']],
	    // 굵기, 기울임꼴, 밑줄,취소 선, 서식지우기
	    ['style', ['bold', 'italic', 'underline','strikethrough', 'clear']],
	    // 글자색
	    ['color', ['forecolor','color']],
	    // 표만들기
	    ['table', ['table']],
	    // 글머리 기호, 번호매기기, 문단정렬
	    ['para', ['ul', 'ol', 'paragraph']],
	    // 줄간격
	    ['height', ['height']],
	    // 그림첨부, 링크만들기, 동영상첨부
	    ['insert',['picture','link','video']],
	    // 코드보기, 확대해서보기, 도움말
	    ['view', ['codeview','fullscreen', 'help']]
	  ],
	  // 추가한 글꼴
	fontNames: ['Arial', 'Arial Black', 'Comic Sans MS', 'Courier New','맑은 고딕','궁서','굴림체','굴림','돋음체','바탕체'],
	 // 추가한 폰트사이즈
	fontSizes: ['8','9','10','11','12','14','16','18','20','22','24','28','30','36','50']
});
</script>


<%@ include file="../includes/footer.jsp" %>