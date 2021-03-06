<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="root" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.6/umd/popper.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0-beta.2/js/bootstrap.min.js"></script> 
<link rel="stylesheet" href="${root}/css/bootstrap.min.css">
<link rel="stylesheet" href="${root}/css/footer.css">


<title>Insert title here</title>

<nav class="navbar navbar-expand-lg navbar-dark bg-primary">
  <a class="navbar-brand" href="${root}/user/home.tfarm">TIFARM</a>
  <button class="navbar-toggler collapsed " type="button" data-toggle="collapse" data-target="#navbarColor01" aria-controls="navbarColor01" aria-expanded="false" aria-label="Toggle navigation" style="">
    <span class="navbar-toggler-icon"></span>
  </button>

  <div class="navbar-collapse collapse" id="navbarColor01" style="">
  
    <c:if test="${userInfo != null}">
    	 <ul class="navbar-nav mr-auto navbar-right" >
	      <li class="nav-item active">
	        <a class="nav-link" href="#">${userInfo.mem_id}님 안녕하세요</a>
	      </li>
	      <li class="nav-item">
	        <a class="nav-link" href="">마이페이지</a>
	      </li>  
	      <li class="nav-item">
	        <a class="nav-link" href="${root}/user/logout.tfarm">로그아웃</a>
	      </li>
	         
	    </ul>
    </c:if>
    
    <c:if test="${userInfo == null}"> 
	    <ul class="navbar-nav mr-auto navbar-right" >
	      <li class="nav-item active">
	        <a class="nav-link" href="${root}/user/login.tfarm">로그인</a>
	      </li>
	      <li class="nav-item">
	        <a class="nav-link" href="${root}/user/join.tfarm">회원가입</a>
	      </li>     
	    </ul>
    </c:if>
    <form class="form-inline my-2 my-lg-0">
      <input class="form-control mr-sm-2" type="text" placeholder="Search">
      <button class="btn btn-secondary my-2 my-sm-0" type="submit">Search</button>
    </form>
  </div>
</nav>
</head>

<body>
<!-- ************************왼쪽 목록**************************** -->
<div class="row" style="margin-bottom:200px">
	<div class="list-group col-xl-2" style="float:left; padding-top:25px;" >
	  <a href="" class="list-group-item list-group-item-action" style="border-radius:0px;">공지사항</a>	
	  <a href="#" class="list-group-item list-group-item-action" style="border-radius:0px;">FAQ</a>
	  <a href="#" class="list-group-item list-group-item-action">Q&A</a>
	  <a href="#"  style="height:3px; background-color:black;"></a>
	  <a href="#" class="list-group-item list-group-item-action ">뮤직컬</a>
	  <a href="#" class="list-group-item list-group-item-action ">콘서트</a>
	  <a href="#" class="list-group-item list-group-item-action ">연극</a>
	  <a href="#" class="list-group-item list-group-item-action ">클래식/무용</a>
	  <a href="#" class="list-group-item list-group-item-action ">스포츠/레저</a>
	  <a href="#" class="list-group-item list-group-item-action ">전시/행사</a>
	  <a href="#" class="list-group-item list-group-item-action ">아동/가족</a>
	  <a href="#"  style="height:3px; background-color:black;"></a>
	  <a href="" class="list-group-item list-group-item-action">신고게시판</a>
	  <a href="#" class="list-group-item list-group-item-action " style="border-radius:0px;">블랙리스트</a>
	</div>


