<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="/common/header.jsp"%>
<script src="https://www.google.com/recaptcha/api.js" async defer></script>

<div class="col-xl-10" style="float:left; width:100%; padding-top:25px;">
<div class="container"> 
  <br>
  <!-- Nav pills -->
  <ul class="nav nav-pills" role="tablist">
  	<li class="nav-item">
      <a class="nav-link"><b>마이페이지</b></a>
    </li>
    <li class="nav-item">
      <a class="nav-link active" data-toggle="pill" href="#home">홈</a>
    </li>
    <li class="nav-item">
      <a id="infoMenu" class="nav-link" data-toggle="pill" href="#infomodify">회원정보수정</a>
    </li>
    <li class="nav-item">
      <a class="nav-link" data-toggle="pill" href="#menu2">비밀번호 변경</a>
    </li>
    <li class="nav-item">
      <a class="nav-link" data-toggle="pill" href="#menu3">통계?</a>
    </li>
  </ul>

   <!-- Tab panes -->
   <div class="tab-content" style="margin-top:  60px;">
    <div id="home" class="container tab-pane active card" style="border:  0px;">
     	<div class="container-fluid bg-3 text-center" style="border:3px solid black">    
		  <div class="row">
		    <div class="col-sm-3">
		      <p>내가 쓴 글</p>
		      <!-- <img src="https://placehold.it/150x80?text=IMAGE" class="img-responsive" style="width:100%" alt="Image"> -->
		      <span>0건</span>
		    </div>
		    <div class="col-sm-3"> 
		      <p>내가 쓴 댓글</p>
		      <span>0건</span>
		    </div>
		    <div class="col-sm-3"> 
		      <p>Some text..</p>
		      
		    </div>
		    <div class="col-sm-3">
		      <p>Some text..</p>
		      
		    </div>
		  </div>
		</div>
		
		<div style="margin-top:20px;">
			 <span class="badge badge-pill badge-primary" style="width: 10%;font-size:  100%;">E-Mail</span>
			 <span class="offset-1">${userInfo.mem_email1} @ ${userInfo.mem_email2}</span>
			 <div style="margin-top:20px;">
				 <span class="badge badge-pill badge-primary" style="width: 10%;font-size:  100%;">전화번호</span>
				 <span class="offset-1">${userInfo.mem_tel1} - 	${userInfo.mem_tel2} - ${userInfo.mem_tel3}</span>
			 </div>
			 <div style="margin-top:20px;">
				 <span class="badge badge-pill badge-primary" style="width: 10%;font-size:  100%;">생년월일</span>
				 <span class="offset-1">${userInfo.mem_birth}</span>
			 </div>
			 <div style="margin-top:20px;">
				 <span class="badge badge-pill badge-primary" style="width: 10%;font-size:  100%;">가입일</span>
				 <span class="offset-1">${userInfo.mem_join_date}</span>
			 </div>
			 <div style="margin-top:20px;">
			 	<span class="badge badge-pill badge-primary" style="width: 10%;font-size:  100%;">주소</span>
			 	<span class="offset-1">[${userInfo.mem_zipcode1}] &nbsp; ${userInfo.mem_address1} &nbsp; ${userInfo.mem_address2}</span>
			 </div>
			 <div style="margin-top:20px;">
			 	<span class="badge badge-pill badge-primary" style="width: 10%;font-size:  100%;">회원상태</span>
			 	<span class="offset-1"></span>
			 </div>
		</div>
    </div>
    
<script type="text/javascript">

$(document).ready(function(){
	
	$("#infoMenu").click(function() {
		var mem_no = '${userInfo.mem_no}';
		$.ajax({
			type : 'POST',
			dataType : 'json',
			url : '${root}/user/modifyPass.tfarm',
			data : {'mem_no' : mem_no},
			success : function(data){
				if(data.pass != ""){
					$("#mem_pw").val(data.pass);
					$("#passcheck").val(data.pass);
				}
			}
		});
	});
	
	function chkCaptcha(){
		if(typeof(grecaptcha) != 'undefined') {
		       if (grecaptcha.getResponse() == "") {
		           return false;
		       }
		     }
		     else {
		    	 return true;
		     }
	}
	$("#passcheck").keyup(function() {
		if($("#passcheck").val() == $("#pass").val()){
			$("#passchecked").empty();
			$("#passchecked").append("비밀번호가 일치합니다");
		}else{
			$("#passchecked").empty();
			$("#passchecked").append("비밀번호를 확인해 주세요");
		}
	});
	
	$("#email3").change(function() {
		$("#mem_email2").val($("#email3").val());
	});
	
	$("#modifyBtn").click(function() {
		if($("#mem_pw").val() == "") {
			alert("비밀번호를 입력하세요!!!!");
			return;
		} else if($("#mem_pw").val() != $("#passcheck").val()) {
			alert("비밀번호를 확인하세요!!!!");
			return;
		} else if(chkCaptcha() == false){
			console.log(chkCaptcha());
			alert("스팸방지코드를 확인해 주세요.");
		} else {
			$("#infomodify").attr("action","${root}/user/infomodify.tfarm").submit();
		}
	});
});
function juso(){
	var pop = window.open("${root}/user/jusopopup.tfarm","pop","width=570,height=420, scrollbars=yes, resizable=yes"); 
}
function jusoCallBack(roadFullAddr,roadAddrPart1,addrDetail,roadAddrPart2,engAddr, jibunAddr, zipNo, admCd, rnMgtSn, bdMgtSn
		, detBdNmList, bdNm, bdKdcd, siNm, sggNm, emdNm, liNm, rn, udrtYn, buldMnnm, buldSlno, mtYn, lnbrMnnm, lnbrSlno, emdNo)
		{
			// 팝업페이지에서 주소입력한 정보를 받아서, 현 페이지에 정보를 등록합니다.
			$("#mem_zipcode1").val(zipNo);
			$("#mem_zipcode2").val(zipNo);
			$("#mem_address1").val(roadAddrPart1);
			$("#mem_address2").val(addrDetail);
		}		
</script>
    <form id="infomodify" name="infomodify" class="container tab-pane fade" action="" method="post">
	 <fieldset>
	  	<div style="width:600px; margin-top:20px; margin-left:250px; margin-bottom: 200px">
		    <legend style="font-weight:bold">회원정보수정</legend>
			<div class="form-group">
		      <label>이름</label>
		      <input type="text" class="form-control" id="mem_name" name="mem_name" placeholder="Enter name" value="${userInfo.mem_name}" readonly="readonly">
		    </div>
		    <div class="form-group">
		      <label>생년월일</label>
		      <input type="text" class="form-control" id="mem_birth" name="mem_birth" placeholder="ex)911129" value="${userInfo.mem_birth}" readonly="readonly">
		    </div>
			<div class="form-group">
		      <label>아이디</label>
		      <input type="text" class="form-control" id="mem_id" name="mem_id" value="${userInfo.mem_id}" placeholder="Enter ID" onkeyup="javascript:idcheck();">
		      <small id="idinfo" class="form-text text-muted">아이디는 8자이상 20자 이하입니다</small>
		    </div>
		    <div class="form-group">
		      <label>패스워드</label>
		      <input type="password" class="form-control" id="mem_pw" name="mem_pw" placeholder="Enter PASS" onkeypress="javascript:if(event.keyCode==13){chkPwd();};">
		      <small id="passok" class="form-text text-muted">비밀번호는 8자이상 20자 이하입니다</small>
		    </div>
		    <div class="form-group">
		      <label>패스워드확인</label>
		      <input type="password" class="form-control" id="passcheck" name="passcheck" placeholder="Once more input PASS">
		      <small id="passchecked" class="form-text text-muted">비밀번호를 입력하세요</small>
		    </div>
		    <div class="form-group">
		      <label for="exampleInputEmail1">이메일</label>
		      <div class="form-inline">
			      <input type="text" class="form-control" id="mem_email1" name="mem_email1" value="${userInfo.mem_email1}" placeholder="Enter email" style="width:210px">
				  <span style="margin:10px; font-weight:bold">@</span>
				  <input type="text" class="form-control" id="mem_email2" name="mem_email2" value="${userInfo.mem_email2}" style="width:210px">
			      <select class="form-control" id="email3" name="email3" style="margin-left: 15px">
			        <option selected="selected">직접입력</option>
			        <option>naver.com</option>
			        <option>hanmail.com</option>
			        <option>gmail.com</option>
			        <option>nate.com</option>
			      </select>
		      </div>
		    </div>
		    <div class="form-group">
		      <label>전화번호</label>
		      <div class="form-inline">
			      <input type="text" class="form-control" id="mem_tel1" name="mem_tel1" value="${userInfo.mem_tel1}" style="width:116px" maxlength="3">
			      <span style="margin:10px; font-weight:bold">-</span>
			      <input type="text" class="form-control" id="mem_tel2" name="mem_tel2" value="${userInfo.mem_tel2}" style="width:116px" maxlength="4">
			      <span style="margin:10px; font-weight:bold">-</span>
			      <input type="text" class="form-control" id="mem_tel3" name="mem_tel3" value="${userInfo.mem_tel3}" style="width:116px" maxlength="4">
		  	  </div>
		    </div>
		    <div class="form-group">
		      <label>주소</label>
		      <div class="form-inline" style="margin-bottom:10px">
		      <input type="text" class="form-control" readonly="readonly" id="mem_zipcode1" name="mem_zipcode1" value="${userInfo.mem_zipcode1}" style="width:200px; margin-right:10px">
		      <input type="hidden" class="form-control" readonly="readonly" id="mem_zipcode2" name="mem_zipcode2" value="${userInfo.mem_zipcode2}" style="width:200px; margin-right:10px">
			  <button type="button" class="btn btn-primary" id="zipsearchBtn" onclick="javascript:juso();">우편번호검색</button>
		      </div>
		      <input type="text" class="form-control" readonly="readonly" id="mem_address1" name="mem_address1" value="${userInfo.mem_address1}" style="margin-bottom:10px">
		      <label>상세주소</label>
		      <input type="text" class="form-control" readonly="readonly" id="mem_address2" name="mem_address2" value="${userInfo.mem_address2}">
		    </div>   
		  
		    <div class="g-recaptcha" data-sitekey="6LfDVEEUAAAAALwm3xwWfCO2rv5S6zE0sXbrTqPg">
		    </div><br>
			
		  	<div style="text-align:center">
		    <button type="button" id="modifyBtn" class="btn btn-primary">수정완료</button>
		    </div>
	    </div>
	 </fieldset>
	</form>
    
    
    <!--  <div id="menu1" class="container tab-pane fade"><br>
      <h3>회원정보수정</h3>
      
    </div>
    <div id="menu2" class="container tab-pane fade"><br>
      <h3>비밀번호 변경</h3>
      <p>Sed ut perspiciatis unde omnis iste natus error sit voluptatem accusantium doloremque laudantium, totam rem aperiam.</p>
    </div>
    <div id="menu3" class="container tab-pane fade"><br>
      <h3></h3>
      <p>Sed ut perspiciatis unde omnis iste natus error sit voluptatem accusantium doloremque laudantium, totam rem aperiam.</p>
    </div> -->
	</div>
</div>
</div>

<%@include file="/common/footer.jsp"%>