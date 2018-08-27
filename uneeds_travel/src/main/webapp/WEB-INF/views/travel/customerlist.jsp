<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script type="text/javascript" src="https://openapi.map.naver.com/openapi/v3/maps.js?clientId=ucYte0wemG4pQC7n_XNz"></script>
<%@ taglib uri="http://java.sun.com/jstl/core" prefix="c" %>

<title>Insert title here</title>

<link rel="stylesheet" type="text/css" href="/resources/travel/css/app.d6157d9993ceb446bea8.css">
<link rel ="stylesheet" id="gnb_style" type="text/css" href="/resources/travel/css/gnb.css">

<%
	request.setCharacterEncoding("UTF-8"); //받아올 데이터의 인코딩
	String id = (String)session.getAttribute("userid");
%>

<script>
	
$(function() { 
	var userwrite = $("#userwrite").val();
	var tabletd = $("#customerlisttable");
	var number = 0;
	
	$.ajax({
		url : "userinfolist",
		type : 'get',
		data : {
			userid : '<%=id%>',
			infonumber : userwrite
		},success : function(data) {
			tabletd.empty();
			tabletd.append("<colgroup>" +
									"<col width='7%' />" +
									"<col width='20%' />" +
									"<col width='*' />" +
									"<col width='7%' />" +
								"</colgroup>" +
								"<thead><tr>" +
									"<th class ='number'>번호</th>"+
									"<th class = 'info'>이름</th>"+
									"<th class = 'info'>리뷰 내용</th>"+
									"<th class = 'info'>"+
										"<select id ='userwrite' style='background: white; font-weight: bold;' onchange = 'javascript:userwritechange(this.data)'>"+
										"<option value='0'>옵션 선택</option>" +
										"<option value='1'>리뷰 내용</option>"+
										"<option value='2'>즐겨 찾기</option>"+
										"<option value='3'>좋 아 요</option>"+
									"</select></th></tr></thead>")
			for (var i = 0; i < data.length; i++){
				var text = data[i].tourtext;
				var rcode = data[i].rcode;
				$.ajax({
					url : "overviewinformaiton",
					type : 'get',
					datatype : 'json',
					async : false,
					data : {
						"contentId" : data[i].contentid,
						"contenttype" : data[i].contenttype
					},
					success : function(datalist) {
						number += 1;
						var items = $(datalist).find("item");
						
						for (var i = 0; i < items.length; i++){
							item = $(items[i]);
								tabletd.append("<tr>" +
										"<td>"+ number +"</td>" +
										"<td>"+ item.find("title").text()+"</td>" +
										"<td>"+ text +"</td>" +
										"<td><input type='button' class = 'button button5' onclick= 'javascript:reviewdelete(this);' value ='삭제' attr ='"+item.find("contentid").text()+"' attr2 = '"+ rcode +"'></td>" +
									"</tr>");
						}
					},error : function(request, status, error){ //에러 함수
						alert("ERROR");
					}
				});
			}
		},
		error : function(request, status, error){ //에러 함수
			alert("ERROR");
		}
	});
})
</script>

<script>
	function userwritechange(){
		var userwrite = $("#userwrite").val();
		var tabletd = $("#customerlisttable");
		var number = 0;
		$.ajax({
			url : "userinfolist",
			type : 'get',
			data : {
				userid : '<%=id%>',
				infonumber : userwrite
			},success : function(data) {
				tabletd.empty();
					if(userwrite == "1"){
						tabletd.append("<colgroup>" +
										"<col width='7%' />" +
										"<col width='20%' />" +
										"<col width='*' />" +
										"<col width='7%' />" +
									"</colgroup>" +
									"<thead><tr>" +
										"<th class ='number'>번호</th>"+
										"<th class = 'info'>이름</th>"+
										"<th class = 'info'>리뷰 내용</th>"+
										"<th class = 'info'>"+
											"<select id ='userwrite' style='background: white; font-weight: bold;' onchange = 'javascript:userwritechange(this.data)'>"+
											"<option value='0'>옵션 선택</option>" +
											"<option value='1'>리뷰 내용</option>"+
											"<option value='2'>즐겨 찾기</option>"+
											"<option value='3'>좋 아 요</option>"+
										"</select></th></tr></thead>")
						} else if(userwrite == "2"){
							tabletd.append("<colgroup>" +
									"<col width='7%' />" +
									"<col width='15%' />" +
									"<col width='7%' />" +
								"</colgroup>" +
								"<thead><tr>" +
									"<th class ='number'>번호</th>"+
									"<th class = 'info'>이름</th>"+
									"<th class = 'info'>"+
										"<select id ='userwrite' style='background: white; font-weight: bold;' onchange = 'javascript:userwritechange(this.data)'>"+
										"<option value='0'>옵션 선택</option>" +
										"<option value='1'>리뷰 내용</option>"+
										"<option value='2'>즐겨 찾기</option>"+
										"<option value='3'>좋 아 요</option>"+
									"</select></th></tr></thead>")
						} else{
							tabletd.append("<colgroup>" +
									"<col width='7%' />" +
									"<col width='15%' />" +
									"<col width='7%' />" +
								"</colgroup>" +
								"<thead><tr>" +
									"<th class ='number'>번호</th>"+
									"<th class = 'info'>이름</th>"+
									"<th class = 'info'>"+
										"<select id ='userwrite' style='background: white; font-weight: bold;' onchange = 'javascript:userwritechange(this.data)'>"+
										"<option value='0'>옵션 선택</option>" +
										"<option value='1'>리뷰 내용</option>"+
										"<option value='2'>즐겨 찾기</option>"+
										"<option value='3'>좋 아 요</option>"+
									"</select></th></tr></thead>")
						}
					
				for (var i = 0; i < data.length; i++){
					var text = data[i].tourtext;
					var rcode = data[i].rcode;
					$.ajax({
						url : "overviewinformaiton",
						type : 'get',
						datatype : 'json',
						async : false,
						data : {
							"contentId" : data[i].contentid,
							"contenttype" : data[i].contenttype
						},
						success : function(datalist) {
							number += 1;
							var items = $(datalist).find("item");
							
							for (var i = 0; i < items.length; i++){
								item = $(items[i]);
								if(userwrite == "1"){
									tabletd.append("<tr>" +
											"<td>"+ number +"</td>" +
											"<td>"+ item.find("title").text()+"</td>" +
											"<td>"+ text +"</td>" +
											"<td><input type='button' class = 'button button5' onclick= 'javascript:reviewdelete(this);' value ='삭제' attr ='"+item.find("contentid").text()+"' attr2 = '"+ rcode +"'></td>" +
										"</tr>");
								}else if(userwrite == "2"){
									tabletd.append("<tr align = 'center' valign = 'center'>" +
											"<td>"+ number +"</td>" +
											"<td>"+ item.find("title").text()+"</td>" +
											"<td><input type='button' class = 'button button5' onclick= 'javascript:bookmarkdelete(this);' value ='삭제' attr ='"+item.find("contentid").text()+"'></td>" +
										"</tr>");
								}else{
									tabletd.append("<tr>" +
											"<td>"+ number +"</td>" +
											"<td>"+ item.find("title").text()+"</td>" +
											"<td><input type='button' class = 'button button5' onclick= 'javascript:gooddelete(this);' value ='삭제' attr ='"+item.find("contentid").text()+"'></td>" +
										"</tr>");
								}
							}
						},error : function(request, status, error){ //에러 함수
							alert("ERROR");
						}
					});
				}
			},
			error : function(request, status, error){ //에러 함수
				alert("ERROR");
			}
		});
		
	}
</script>

<script>
	function bookmarkdelete(data){
		alert("등록 취소하였습니다.");
		var userwrite = $("#userwrite");
		
		$.post("t_bookmarkdelete", {
			tourmembercode : '<%=id %>',
			contentid : $(data).attr("attr")
			}).done(function(data, state) {
				window.location.reload();
		});
	}
		
		
	function reviewdelete(data){
		alert("등록 취소하였습니다.");
		var userwrite = $("#userwrite");
		
		$.post("t_reviewdelete", {
			mid : '<%=id %>',
			rcode : $(data).attr("attr2")
			}).done(function(data, state) {
				window.location.reload();
		});
	}
	
	function gooddelete(data){
		alert("등록 취소하였습니다.");
		var userwrite = $("#userwrite");
		
		$.post("t_goodmarkdelete", {
			tourmembercode : '<%=id %>',
			contentid : $(data).attr("attr")
			}).done(function(data, state) {
				window.location.reload();
		});
	}
</script>

<script> // 이미지 없을 시 빈이미지 출력
	function imagechage(data){
		var img = $(data).attr("img")
		if(img == null){
			$(data).attr('src', "/resources/travel/img/noimage.gif");
		}
	}
</script>

</head>
	<%
		//로그인이 아닐 때
		if (session.getAttribute("userid") == null) {
	%>
		<jsp:include page="viewtest.jsp" flush="true"/>
	<%}%>
<body class="place_list">
	
	<!-- header 부분 -->
	<header id= "header" role="banner">
		<jsp:include page="topheader.jsp" flush="true"/>
	</header>
	<!-- header 부분 -->

	<!-- container 부분 -->	
	<div id="container" role="main">
		<div class="customerlistarea">
			<div>
				<table class = "customerlisttable" id ="customerlisttable">
					    <colgroup>
					    	<col width="7%" />
					    	<col width="15%" />
					    	<col width="*" />
					    	<col width="15%" />
					    	<col width="7%" />
					    </colgroup>
					<thead>
						<tr>
							<th class ="number">번호</th>
							<th class = "info">이름</th>
							<th class = "info">내용</th>
							<th class = "image">이미지</th>
							<th class = "info">
								<select id ="userwrite" style="background: white; font-weight: bold;">
									<option value="1">리뷰 내용</option>
									<option value="2">즐겨 찾기</option>
									<option value="3">좋 아 요</option>
								</select>
							</th>
						</tr>
					</thead>
				</table>
			</div>
		</div>
	</div>
</body>
</html>