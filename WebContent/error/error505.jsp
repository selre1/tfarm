<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="EUC-KR"%>
<%
	String root = request.getContextPath();
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.6/umd/popper.min.js"></script>
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0-beta.2/js/bootstrap.min.js"></script> 
	<link rel="stylesheet" href="<%= root %>/css/bootstrap.min.css">
	<link rel="stylesheet" href="<%=root%>/css/footer.css">
<title>Insert title here</title>
</head>
<body>
	<center>
		<div style="padding-bottom: 50px;">
		  		<img alt="505" src="<%=root%>/img/main_img.png" class="" style="width:200px; height:150px; margin-bottom: 70px;">		
		  <div style="border: 3px solid darkkhaki; width:80%;"> 
			<%--   <h4>
			  	<Strong>
			 	 	<img alt="404" src="<%=root%>/img/error404.jpg" class="" style="width:200px; height:200px">
			 	 	TFARM ���񽺿� ��ְ� ������ϴ�.
			  	</Strong><br>			  	
			  </h4>
			  <h5> 
			  	���񽺿� ������ ��� ����� �˼��մϴ�.
			  	����ġ ���� ������ָ� �ż��� �����ϰڽ��ϴ�.
			  </h5>
			  <div style="color:red;">	  	
			  	<p>���ѹα� No.1 Ƽ�� TFARM</p>
			  </div> --%>
			<img alt="505" src="<%=root%>/img/error505.jpg" class="" style="width:100%; height:400px">
		  </div>
		</div>
		<p class="lead" style=" text-align: center;">
			<a class="btn btn-primary btn-lg" role="button" href="#">��������</a>
		</p> 
	</center>
</body>
</html>