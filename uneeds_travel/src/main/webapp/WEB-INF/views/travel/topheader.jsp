<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script type="text/javascript" src="https://openapi.map.naver.com/openapi/v3/maps.js?clientId=ucYte0wemG4pQC7n_XNz"></script>


<title>Insert title here</title>

<link rel="stylesheet" type="text/css" href="/resources/travel/css/app.d6157d9993ceb446bea8.css">
<link rel ="stylesheet" id="gnb_style" type="text/css" href="/resources/travel/css/gnb.css">

<script>
	function listcancel(){
		alert("로그인 후 사용해주세요.");
	}
</script>
	<body>
	<%
		//로그인이 아닐 때
		if (session.getAttribute("userid") == null) {
	%>
		<div class="header_inner">
			<h1><img class="logo"  src="/resources/travel/img/KakaoTalk_20180710_143413418.png">
			</h1>
				<a class="button button5" type="button" style="margin-left: 130px; margin-top: 15px" href="viewtest.jsp">지도</a>
				<a class="button button5" type="button" onclick="javascript:listcancel()">사용자 정보</a>
			<div class="api_naver_gnb">
				<div id="gnb" class="">
					<strong class="blind">사용자 링크</strong>
					<ul class="gnb_lst" id="gnb_lst" style="display: block;">
						<li class="gnb_login_li" id="gnb_login_layer" style="display: inline-block;">
							<a class="gnb_btn_login" id="gnb_login_button" href = "/uneeds/login" style="padding-right: 10px;">
								<span class="gnb_bg"></span>
								<span class="gnb_bdr"></span>
								<span class="gnb_txt">로그인</span>
							</a>
						</li>
					</ul>
				</div>
			</div>
		</div>
	<%} else { 
		String id = (String)session.getAttribute("userid"); 
	%>
 		<div class="header_inner">
			<h1><img class="logo"  src="/resources/travel/img/KakaoTalk_20180710_143413418.png">
			</h1>
				<a class="button button5" type="button" style="margin-left: 130px; margin-top: 15px" href="viewtest.jsp">지도</a>
				<a class="button button5" type="button" href="customerlist.jsp">사용자 정보</a>
			<div class="api_naver_gnb">
				<div id="gnb" class="">
					<strong class="blind">사용자 링크</strong>
					<ul class="gnb_lst" id="gnb_lst" style="display: block;">
						<li class="gnb_login_li" id="gnb_login_layer" style="display: inline-block;">
						<a class="gnb_btn_login_login" id="gnb_login_button" href = "/uneeds/logout" style="padding-right: 10px;"></a>
								<span class="gnb_bg"></span>
								<span class="gnb_bdr_login"></span>
								<span class="gnb_txt_login">로그인 중</span>
						</li>
					</ul>
				</div>
			</div>
		</div>
 	<% } %>
	</body>
</html>