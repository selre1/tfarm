<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ include file="/common/header.jsp" %>
<script src="//code.jquery.com/jquery-1.10.2.js"></script>
<script type="text/javascript" src="${root}/js/httpRequest.js"></script>
<!-- ******************우리가 코딩해야하는 부분 시작  col-xl-10********************** -->
<!---------------------------------  최신 앨범-------------------------------    -->
<script>
control = "/main";
</script>
<style>
img {
    border: 1px solid #ddd; /* Gray border */
    border-radius: 4px;  /* Rounded border */
    padding: 5px; /* Some padding */
    width: 150px; /* Set a small width */
}

/* Add a hover effect (blue shadow) */
img:hover {
    box-shadow: 0 0 2px 1px rgba(0, 140, 186, 0.5);
}
</style>

<!-- ******************우리가 코딩해야하는 부분 시작  col-xl-10********************** -->
<!---------------------------------  최신 앨범-------------------------------    -->

<script type="text/javascript">

//최신공지 ajax

   $(document).ready(function() {
      $.ajax({
      type: 'POST',
      dataType: 'json',
      url: '${root}/main/totallist.tfarm',
      success: function(data) {
         //alert("넘어왔니???"+data.blist[0].subject);
         makelist(data);
         }
       });
   });

function makelist(data) {
   var output = "";
   var bsize = data.blist.length;
   for(var i=0;i<6;i++){
      output += '<tr style="text-align:center">';
      output += '<td>';
      output += '' + decodeURI(data.blist[i].id);
      output += '</td>';
      output += '<td style="white-space: nowrap; word-wrap: break-word; text-overflow: ellipsis; overflow: hidden;">';
      output += '<a href = "${root}/main/ticketview.tfarm?seq='+decodeURI(data.blist[i].seq)+'">';
      output += ' ' + decodeURI(data.blist[i].subject);
      output += '</a>';
      output += '</td>';
      output += '<td>';
      output += '' + decodeURI(data.blist[i].hit);
      output += '</td>';
      output += '</tr>';
      
   }
   
   $("#boardlist").empty();
   $("#boardlist").append(output);
}


//인기글 ajax

$(document).ready(function() {
   $.ajax({
   type: 'POST',
   dataType: 'json',
   url: '${root}/main/totallist1.tfarm',
   success: function(data) {
     
      makelist1(data);
      }
    });
});

function makelist1(data) {
var output = "";
var nsize = data.nlist.length;
for(var i=0;i<6;i++){
   output += '<tr style="text-align:center">';
   output += '<td>';
   output += '' + decodeURI(data.nlist[i].id);
   output += '</td>';
   output += '<td style="white-space: nowrap; word-wrap: break-word; text-overflow: ellipsis; overflow: hidden;">';
   output += '<a href = "${root}/main/boardview.tfarm?seq='+decodeURI(data.nlist[i].seq)+'">';
   output += ' ' + decodeURI(data.nlist[i].subject);
   output += '</a>';
   output += '</td>';
   output += '<td>';
   output += '' + decodeURI(data.nlist[i].hit);
   output += '</td>';
   output += '</tr>';
   
   }

   $("#noticelist").empty();
   $("#noticelist").append(output);
}


//최신티켓 ajax

$(document).ready(function() {
	//alert("넘어왔니???2");
   $.ajax({
   type: 'POST',
   dataType: 'json',
   url: '${root}/main/totallist2.tfarm',
   success: function (data) { 
      makelist2(data);
      }
   });
});

function makelist2(data) {
   var output = "";
   var len = data.tlist.length;
   for(var i=0 ; i<8 ; i++){
	  output += '<div class="col-md-3">';
	  output +=	'	<div class="thumbnail">';
      output += '		<a href="${root}/main/view.tfarm?seq='+data.tlist[i].seq+'">';
      output += '		<img src="${root}/upload/'+data.tlist[i].savafolder+'/'+data.tlist[i].save_picture+'" class="img-rounded" style="height:200px; width:100%">';
      output += '		</a>';
      output += '	<div class="caption">';
      output += '		<p>'+decodeURI(data.tlist[i].subject)+'</p>';
      output += '	</div>'; 
      output += '	</div>'; 
      output += '</div>'; 
   }  
   $("#ticketlist").empty();
   $("#ticketlist").append(output);	
}

</script>
   <div class="col-xl-10">
        	<div>
                <h4 id="container">[최신티켓]</h4>
            </div>
            

        	<div class="row">
					<div class="row" id ="ticketlist" style="width: 95%;"></div>
				<!-- 티켓 목록 -->
					</div>
			<br><br>
			
			<div class="row" id="poplist">					
				<div class="col-sm-5">
		        	<div>
		                <h4 id="container">[최신공지사항]</h4>
		            </div>
		            <div class="table-responsive">
		                <!-- <table class="table table-bordered"> -->
		                <table class="table table-hover" style="table-layout:fixed;">
		                    <colgroup>
		                        <col width="80">
		                        <col width="*">
		                        <col width="70">
		                    </colgroup>
		                    <thead>
		                    <tr><th colspan="3"></th></tr>
		                    <tr>
		                        <th class="text-center">작성자</th>
		                        <th class="text-center" width="40%">제목</th>
		                        <th class="text-center" width="40%">조회수</th>
		                    </tr>
		                    </thead>
		                    <tbody class="article_list" id="boardlist">
		                     <!-- 글목록 -->
		                    </tbody>
						</table>
					</div>
				</div>
				
				<div class="col-sm-5 offset-1">
		        	<div>
		                <h4 id="container">[인기글]</h4>
		            </div>
		            <div class="table-responsive">
		                <!-- <table class="table table-bordered"> -->
		                <table class="table table-hover" style="table-layout:fixed;">
		                    <colgroup>
		                        <col width="80">
		                        <col width="*">
		                        <col width="70">
		                    </colgroup>
		                    <thead>
		                    <tr><th colspan="3"></th></tr>
		                    <tr>
		                        <th class="text-center">작성자</th>
		                        <th class="text-center" width="40%">제목</th>
		                        <th class="text-center" width="40%">조회수</th>
		                    </tr>
		                    </thead>
		                    
		                    <tbody class="article_list" id="noticelist">
		                    <!-- 글목록 -->
		                    </tbody>
						</table>
					</div>
				</div>
			</div>
       
  </div>
   

<!-- ******************우리가 코딩해야하는 부분 끝********************** -->
<%@ include file="/common/footer.jsp" %>