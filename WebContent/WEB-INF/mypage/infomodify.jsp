<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<script src="https://www.google.com/recaptcha/api.js" async defer></script>
<script type="text/javascript">
$(document).ready(function(){
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
		alert($("#email3").val());
		$("#email2").val = $("#email3").val();
		$("#email2").append($("#email3").val());
	});
	
	$("#modifyBtn").click(function() {
		if($("#pass").val() == "") {
			alert("비밀번호를 입력하세요!!!!");
			return;
		} else if($("#pass").val() != $("#passcheck").val()) {
			alert("비밀번호를 확인하세요!!!!");
			return;
		} else {
			document.modifyForm.action = "${root}/";
			document.modifyForm.submit();
		}
	});
});
</script>
