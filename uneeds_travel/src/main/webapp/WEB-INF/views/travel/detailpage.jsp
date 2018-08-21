<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Detail Page</title>
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<link rel="stylesheet" id="gnb_style" type="text/css"
	href="/resources/travel/css/gnb.css">
<link rel="stylesheet" type="text/css"
	href="/resources/travel/css/app.acc61d928b7bdc51a817.css">


<%
	request.setCharacterEncoding("UTF-8"); //받아올 데이터의 인코딩
	String id = (String)session.getAttribute("userid");
	String input1 = request.getParameter("input1"); //넘겨오는 데이터중에 input1 속성을 가져옴 // title 이름
	String data1 = request.getParameter("data1"); //넘겨오는 데이터중에 data1 속성을 가져옴 // list의 번호
	String data2 = request.getParameter("data2"); //넘겨오는 데이터중에 data2 속성을 가져옴 // contentid
	String data3 = request.getParameter("data3"); //넘겨오는 데이터중에 data3 속성을 가져옴 // contenttypeid
	String contenttype = null;
	
	if(data3.equals("12")){
		contenttype = "관광지";
	}else if(data3.equals("14")){
		contenttype = "문화시설";
	}else if(data3.equals("15")){
		contenttype = "행사/공연/축제";
	}else if(data3.equals("25")){
		contenttype = "여행코스";
	}else if(data3.equals("28")){
		contenttype = "레포츠";
	}else if(data3.equals("32")){
		contenttype = "숙박";
	}else if(data3.equals("38")){
		contenttype = "쇼핑";
	}else if(data3.equals("39")){
		contenttype = "음식점";
	}
%>
<!-- 상세 정보 처음에 가져오기 -->
<script>
	// 값 가져오기
	$(function() {
		$.ajax({
			url : "detailedinformation",
			type : 'get',
			datatype : 'json', //respone 데이터 타입
			data : {
				"contenttype" : <%=data3%>,
				"contentId" : <%=data2%>}, 
			success : function(data) {
				detailedinformationlist(data);}, 
			error : function(request, status, error) { //에러 함수
				alert("ERROR");
			}
		});

		$.ajax({
			url : "reviewselectinfo",
			type : 'get',
			data : {
				"contentid" : <%=data2%>},
			success : function(data) {
				
				dt = null;
				star = null;
				list = $(".list_card");
				list.empty();
				for (var i = 0; i < data.length; i++) {
					d = data[i];
					star += d.star;
					dt = new Date(d.tourdate);
					
					list.append(
							"<div class='flick_content' role='listItem'>" +
								"<div class='list_item' role='listitem'>" +
									"<div class=star_area_list>" +
										"<span class=star_list> <span class=bg> <span class=value style='width: "+ d.star*20 +"%'></span></span></span> " +
										"<span class=score><em>" + d.star + "</em> / 5</span>" +
									"</div>" +
									"<div class='txt'>" +
										"<div class='' style='width:228px;min-height:25px'>"+ d.tourtext +"</div></div>" +
								"</div></div>")
					}
				move();
				},
				error : function(request, status, error) { //에러 함수
					alert("ERROR");
				}
		});
	})
</script>

<script>	// review 버튼 클릭 시 review 이동 스크립트
	var reviewlistlength = 0;
	
	function move(test) {
		
		var $img = $(".list_card");
		var leftright = $(test).attr("aria-label");
		reviewlist = document.getElementById("review_list_right");  //review의 list 객체 받아오기
				
		if(leftright == "다음"){
			reviewlistlength -= 250; 
			reviewlist.style.transform="translate("+reviewlistlength+"px , 0px)";     //왼쪽으로 이동
		}
		if(leftright == "이전"){
			reviewlistlength += 250; 
			reviewlist.style.transform="translate("+reviewlistlength+"px , 0px)"; 		//오른쪽으로 이동
		}
		
		if(reviewlistlength >= 0){	//버튼 클릭 쇼 하이드
			$(".btn_prev").hide();
		} else if (reviewlistlength < -(reviewlist.offsetWidth/2 + 60)){
			$(".btn_next").hide();
		} else{
			$(".btn_prev").show();
			$(".btn_next").show();
		}
	};
</script>
<script>

$(function(){
	var star1 = document.getElementById("star1");
	var star2 = document.getElementById("star2");
	var star3 = document.getElementById("star3");
	var star4 = document.getElementById("star4");
	var star5 = document.getElementById("star5");
	
	var starattrarr = [$('#star1'), $('#star2'), $('#star3'), $('#star4'), $('#star5')];
	var starattr1 = $('#star1');
	var starattr2 = $('#star2');
	var starattr3 = $('#star3');
	var starattr4 = $('#star4');
	var starattr5 = $('#star5');
	
	star1.onclick = function(){
		if(starattr1.attr('class') == 'rating-star'){
			starattr1.attr('class', 'rating-star rating-star-full');
			starattr1.attr('aria-checked', true);
			starattr1.attr('aria-pressed', true);
		} else {
			starattr1.attr('class', 'rating-star');
			starattr1.attr('aria-checked', false);
			starattr1.attr('aria-pressed', false);
		}	
	}
	
	star2.onclick = function(){
		if(starattr2.attr('class') == 'rating-star'){
			for(var i = 0; i < 2; i++){
				starattrarr[i].attr('class', 'rating-star rating-star-full');
				starattrarr[i].attr('aria-checked', true);
				starattrarr[i].attr('aria-pressed', true);
			}
		} else {
			for(var i = 0; i < 5; i++){
				starattrarr[i].attr('class', 'rating-star');
				starattrarr[i].attr('aria-checked', false);
				starattrarr[i].attr('aria-pressed', false);
			}
		}	
	}
	
	star3.onclick = function(){
		if(starattr3.attr('class') == 'rating-star'){
			for(var i = 0; i < 3; i++){
				starattrarr[i].attr('class', 'rating-star rating-star-full');
				starattrarr[i].attr('aria-checked', true);
				starattrarr[i].attr('aria-pressed', true);
			}
		} else {
			for(var i = 0; i < 5; i++){
				starattrarr[i].attr('class', 'rating-star');
				starattrarr[i].attr('aria-checked', false);
				starattrarr[i].attr('aria-pressed', false);
			}
		}
	}
	
	star4.onclick = function(){
		if(starattr4.attr('class') == 'rating-star'){
			for(var i = 0; i < 4; i++){
				starattrarr[i].attr('class', 'rating-star rating-star-full');
				starattrarr[i].attr('aria-checked', true);
				starattrarr[i].attr('aria-pressed', true);
			}
		} else {
			for(var i = 0; i < 5; i++){
				starattrarr[i].attr('class', 'rating-star');
				starattrarr[i].attr('aria-checked', false);
				starattrarr[i].attr('aria-pressed', false);
			}
		}
	}
	
	star5.onclick = function(){
		if(starattr5.attr('class') == 'rating-star'){
			for(var i = 0; i < 5; i++){
				starattrarr[i].attr('class', 'rating-star rating-star-full');
				starattrarr[i].attr('aria-checked', true);
				starattrarr[i].attr('aria-pressed', true);
			}
		} else {
			for(var i = 0; i < 5; i++){
				starattrarr[i].attr('class', 'rating-star');
				starattrarr[i].attr('aria-checked', false);
				starattrarr[i].attr('aria-pressed', false);
			}
		}
	}
});

</script>

<script> // 리뷰 쓰기 모달 창
$(function(){
var modal = document.getElementById("myModal");

// Get the button that opens the modal
var btn = document.getElementById("reviewbutton");

// Get the <span> element that closes the modal
var span = document.getElementsByClassName("modal-close")[0];                                          

var id = '<%=session.getAttribute("userid")%>';
// When the user clicks on the button, open the modal 


btn.onclick = function() {
	if(id == 'null'){
		alert("로그인 후 등록해주세요.");
	}else {
	    modal.style.display = "block";
	}
}


// When the user clicks on <span> (x), close the modal
span.onclick = function() {
    modal.style.display = "none";
}

// When the user clicks anywhere outside of the modal, close it
window.onclick = function(event) {
    if (event.target == modal) {
        modal.style.display = "none";
    }
}


});

</script>

<!-- api의 상세 정보 표시 -->
<script>
	function detailedinformationlist(data) {
		var item = $(data).find("item");
		var contenttypeid = item.find("contenttypeid").text();

		var ullist = $(".list_bizinfo");
		ullist.empty();

		if (item.find("accomcount").text() != ''
				&& item.find("accomcount").text() != '0') {
			ullist.append("<span>수용인원 : " + item.find("accomcount").text()
					+ "</span></br>")
		}
		;
		if (item.find("chkbabycarriage").text() != ''
				&& item.find("chkbabycarriage").text() != '0') {
			ullist.append("<span>유모차대여 정보 : "
					+ item.find("chkbabycarriage").text() + "</span></br>")
		}
		;
		if (item.find("chkcreditcard").text() != ''
				&& item.find("chkcreditcard").text() != '0') {
			ullist.append("<span>신용카드가능 정보 : "
					+ item.find("chkcreditcard").text() + "</span></br>")
		}
		;
		if (item.find("chkpet").text() != ''
				&& item.find("chkpet").text() != '0') {
			ullist.append("<span>애완동물동반가능 정보 : " + item.find("chkpet").text()
					+ "</span></br>")
		}
		;
		if (item.find("expagerange").text() != ''
				&& item.find("expagerange").text() != '0') {
			ullist.append("<span>체험가능 연령 : " + item.find("expagerange").text()
					+ "</span></br>")
		}
		;
		if (item.find("expguide").text() != ''
				&& item.find("expguide").text() != '0') {
			ullist.append("<span>체험안내 : " + item.find("expguide").text()
					+ "</span></br>")
		}
		;
		if (item.find("heritage1").text() != ''
				&& item.find("heritage1").text() != '0') {
			ullist.append("<span>세계 문화유산 유무 : " + item.find("heritage1").text()
					+ "</span></br>")
		}
		;
		if (item.find("heritage2").text() != ''
				&& item.find("heritage2").text() != '0') {
			ullist.append("<span>세계 자연유산 유무 : " + item.find("heritage2").text()
					+ "</span></br>")
		}
		;
		if (item.find("heritage3").text() != ''
				&& item.find("heritage3").text() != '0') {
			ullist.append("<span>세계 기록유산 유무 : " + item.find("heritage3").text()
					+ "</span></br>")
		}
		;
		if (item.find("infocenter").text() != ''
				&& item.find("infocenter").text() != '0') {
			ullist.append("<span>문의 및 안내 : " + item.find("infocenter").text()
					+ "</span></br>")
		}
		;
		if (item.find("opendate").text() != ''
				&& item.find("opendate").text() != '0') {
			ullist.append("<span>개장일 : " + item.find("opendate").text()
					+ "</span></br>")
		}
		;
		if (item.find("parking").text() != ''
				&& item.find("parking").text() != '0') {
			ullist.append("<span>주차시설 : " + item.find("parking").text()
					+ "</span></br>")
		}
		;
		if (item.find("restdate").text() != ''
				&& item.find("restdate").text() != '0') {
			ullist.append("<span>쉬는날 : " + item.find("restdate").text()
					+ "</span></br>")
		}
		;
		if (item.find("useseason").text() != ''
				&& item.find("useseason").text() != '0') {
			ullist.append("<span>이용시기 : " + item.find("useseason").text()
					+ "</span></br>")
		}
		;
		if (item.find("usetime").text() != ''
				&& item.find("usetime").text() != '0') {
			ullist.append("<span>이용시간 : " + item.find("usetime").text()
					+ "</span></br>")
		}
		;
		if (item.find("accomcountculture").text() != ''
				&& item.find("accomcountculture").text() != '0') {
			ullist.append("<span>수용인원 : "
					+ item.find("accomcountculture").text() + "</span></br>")
		}
		;
		if (item.find("chkbabycarriage culture").text() != ''
				&& item.find("chkbabycarriage culture").text() != '0') {
			ullist.append("<span>유모차대여 정보 : "
					+ item.find("chkbabycarriage culture").text()
					+ "</span></br>")
		}
		;
		if (item.find("chkcreditcardculture").text() != ''
				&& item.find("chkcreditcardculture").text() != '0') {
			ullist
					.append("<span>신용카드가능 정보 : "
							+ item.find("chkcreditcardculture").text()
							+ "</span></br>")
		}
		;
		if (item.find("chkpetculture").text() != ''
				&& item.find("chkpetculture").text() != '0') {
			ullist.append("<span>애완동물동반가능 정보 : "
					+ item.find("chkpetculture").text() + "</span></br>")
		}
		;
		if (item.find("discountinfo").text() != ''
				&& item.find("discountinfo").text() != '0') {
			ullist.append("<span>할인정보 : " + item.find("discountinfo").text()
					+ "</span></br>")
		}
		;
		if (item.find("infocenterculture").text() != ''
				&& item.find("infocenterculture").text() != '0') {
			ullist.append("<span>문의 및 안내 : "
					+ item.find("infocenterculture").text() + "</span></br>")
		}
		;
		if (item.find("parkingculture").text() != ''
				&& item.find("parkingculture").text() != '0') {
			ullist.append("<span>주차시설 : " + item.find("parkingculture").text()
					+ "</span></br>")
		}
		;
		if (item.find("parkingfee").text() != ''
				&& item.find("parkingfee").text() != '0') {
			ullist.append("<span>주차요금 : " + item.find("parkingfee").text()
					+ "</span></br>")
		}
		;
		if (item.find("restdateculture").text() != ''
				&& item.find("restdateculture").text() != '0') {
			ullist.append("<span>쉬는날 : " + item.find("restdateculture").text()
					+ "</span></br>")
		}
		;
		if (item.find("usefee").text() != ''
				&& item.find("usefee").text() != '0') {
			ullist.append("<span>이용요금 : " + item.find("usefee").text()
					+ "</span></br>")
		}
		;
		if (item.find("usetimeculture").text() != ''
				&& item.find("usetimeculture").text() != '0') {
			ullist.append("<span>이용시간 : " + item.find("usetimeculture").text()
					+ "</span></br>")
		}
		;
		if (item.find("scale").text() != '' && item.find("scale").text() != '0') {
			ullist.append("<span>규모 : " + item.find("scale").text()
					+ "</span></br>")
		}
		;
		if (item.find("spendtime").text() != ''
				&& item.find("spendtime").text() != '0') {
			ullist.append("<span>관람 소요시간 : " + item.find("spendtime").text()
					+ "</span></br>")
		}
		;
		if (item.find("agelimit").text() != ''
				&& item.find("agelimit").text() != '0') {
			ullist.append("<span>관람 가능연령 : " + item.find("agelimit").text()
					+ "</span></br>")
		}
		;
		if (item.find("bookingplace").text() != ''
				&& item.find("bookingplace").text() != '0') {
			ullist.append("<span>예매처 : " + item.find("bookingplace").text()
					+ "</span></br>")
		}
		;
		if (item.find("discountinfofestival").text() != ''
				&& item.find("discountinfofestival").text() != '0') {
			ullist
					.append("<span>할인정보 : "
							+ item.find("discountinfofestival").text()
							+ "</span></br>")
		}
		;
		if (item.find("eventenddate").text() != ''
				&& item.find("eventenddate").text() != '0') {
			ullist.append("<span>행사 종료일 : " + item.find("eventenddate").text()
					+ "</span></br>")
		}
		;
		if (item.find("eventhomepage").text() != ''
				&& item.find("eventhomepage").text() != '0') {
			ullist.append("<span>행사 홈페이지 : "
					+ item.find("eventhomepage").text() + "</span></br>")
		}
		;
		if (item.find("eventplace").text() != ''
				&& item.find("eventplace").text() != '0') {
			ullist.append("<span>행사 장소 : " + item.find("eventplace").text()
					+ "</span></br>")
		}
		;
		if (item.find("eventstartdate").text() != ''
				&& item.find("eventstartdate").text() != '0') {
			ullist.append("<span>행사 시작일 : "
					+ item.find("eventstartdate").text() + "</span></br>")
		}
		;
		if (item.find("festivalgrade").text() != ''
				&& item.find("festivalgrade").text() != '0') {
			ullist.append("<span>축제등급 : " + item.find("festivalgrade").text()
					+ "</span></br>")
		}
		;
		if (item.find("placeinfo").text() != ''
				&& item.find("placeinfo").text() != '0') {
			ullist.append("<span>행사장 위치안내 : " + item.find("placeinfo").text()
					+ "</span></br>")
		}
		;
		if (item.find("playtime").text() != ''
				&& item.find("playtime").text() != '0') {
			ullist.append("<span>공연시간 : " + item.find("playtime").text()
					+ "</span></br>")
		}
		;
		if (item.find("program").text() != ''
				&& item.find("program").text() != '0') {
			ullist.append("<span>행사 프로그램 : " + item.find("program").text()
					+ "</span></br>")
		}
		;
		if (item.find("spendtimefestival").text() != ''
				&& item.find("spendtimefestival").text() != '0') {
			ullist.append("<span>관람 소요시간 : "
					+ item.find("spendtimefestival").text() + "</span></br>")
		}
		;
		if (item.find("sponsor1").text() != ''
				&& item.find("sponsor1").text() != '0') {
			ullist.append("<span>주최자 정보 : " + item.find("sponsor1").text()
					+ "</span></br>")
		}
		;
		if (item.find("sponsor1tel").text() != ''
				&& item.find("sponsor1tel").text() != '0') {
			ullist.append("<span>주최자 연락처 : " + item.find("sponsor1tel").text()
					+ "</span></br>")
		}
		;
		if (item.find("sponsor2").text() != ''
				&& item.find("sponsor2").text() != '0') {
			ullist.append("<span>주관사 정보 : " + item.find("sponsor2").text()
					+ "</span></br>")
		}
		;
		if (item.find("sponsor2tel").text() != ''
				&& item.find("sponsor2tel").text() != '0') {
			ullist.append("<span>주관사 연락처 : " + item.find("sponsor2tel").text()
					+ "</span></br>")
		}
		;
		if (item.find("subevent").text() != ''
				&& item.find("subevent").text() != '0') {
			ullist.append("<span>부대행사 : " + item.find("subevent").text()
					+ "</span></br>")
		}
		;
		if (item.find("usetimefestival").text() != ''
				&& item.find("usetimefestival").text() != '0') {
			ullist.append("<span>이용요금 : " + item.find("usetimefestival").text()
					+ "</span></br>")
		}
		;
		if (item.find("distance").text() != ''
				&& item.find("distance").text() != '0') {
			ullist.append("<span>코스 총거리 : " + item.find("distance").text()
					+ "</span></br>")
		}
		;
		if (item.find("infocentertour course").text() != ''
				&& item.find("infocentertour course").text() != '0') {
			ullist.append("<span>문의 및 안내 : "
					+ item.find("infocentertour course").text()
					+ "</span></br>")
		}
		;
		if (item.find("schedule").text() != ''
				&& item.find("schedule").text() != '0') {
			ullist.append("<span>코스 일정 : " + item.find("schedule").text()
					+ "</span></br>")
		}
		;
		if (item.find("taketime").text() != ''
				&& item.find("taketime").text() != '0') {
			ullist.append("<span>코스 총 소요 시간 : " + item.find("taketime").text()
					+ "</span></br>")
		}
		;
		if (item.find("theme").text() != '' && item.find("theme").text() != '0') {
			ullist.append("<span>코스 테마 : " + item.find("theme").text()
					+ "</span></br>")
		}
		;
		if (item.find("accomcountleports").text() != ''
				&& item.find("accomcountleports").text() != '0') {
			ullist.append("<span>수용인원 : "
					+ item.find("accomcountleports").text() + "</span></br>")
		}
		;
		if (item.find("chkbabycarriageleports").text() != ''
				&& item.find("chkbabycarriageleports").text() != '0') {
			ullist.append("<span>유모차대여 정보 : "
					+ item.find("chkbabycarriageleports").text()
					+ "</span></br>")
		}
		;
		if (item.find("chkcreditcardleports").text() != ''
				&& item.find("chkcreditcardleports").text() != '0') {
			ullist
					.append("<span>신용카드가능 정보 : "
							+ item.find("chkcreditcardleports").text()
							+ "</span></br>")
		}
		;
		if (item.find("chkpetleports").text() != ''
				&& item.find("chkpetleports").text() != '0') {
			ullist.append("<span>애완동물동반가능 정보 : "
					+ item.find("chkpetleports").text() + "</span></br>")
		}
		;
		if (item.find("expagerangeleports").text() != ''
				&& item.find("expagerangeleports").text() != '0') {
			ullist.append("<span>체험 가능연령 : "
					+ item.find("expagerangeleports").text() + "</span></br>")
		}
		;
		if (item.find("infocenterleports").text() != ''
				&& item.find("infocenterleports").text() != '0') {
			ullist.append("<span>문의 및 안내 : "
					+ item.find("infocenterleports").text() + "</span></br>")
		}
		;
		if (item.find("openperiod").text() != ''
				&& item.find("openperiod").text() != '0') {
			ullist.append("<span>개장기간 : " + item.find("openperiod").text()
					+ "</span></br>")
		}
		;
		if (item.find("parkingfeeleports").text() != ''
				&& item.find("parkingfeeleports").text() != '0') {
			ullist.append("<span>주차요금 : "
					+ item.find("parkingfeeleports").text() + "</span></br>")
		}
		;
		if (item.find("parkingleports").text() != ''
				&& item.find("parkingleports").text() != '0') {
			ullist.append("<span>주차시설 : " + item.find("parkingleports").text()
					+ "</span></br>")
		}
		;
		if (item.find("reservation").text() != ''
				&& item.find("reservation").text() != '0') {
			ullist.append("<span>예약안내 : " + item.find("reservation").text()
					+ "</span></br>")
		}
		;
		if (item.find("restdateleports").text() != ''
				&& item.find("restdateleports").text() != '0') {
			ullist.append("<span>쉬는날 : " + item.find("restdateleports").text()
					+ "</span></br>")
		}
		;
		if (item.find("scaleleports").text() != ''
				&& item.find("scaleleports").text() != '0') {
			ullist.append("<span>규모 : " + item.find("scaleleports").text()
					+ "</span></br>")
		}
		;
		if (item.find("usefeeleports").text() != ''
				&& item.find("usefeeleports").text() != '0') {
			ullist.append("<span>입장료 : " + item.find("usefeeleports").text()
					+ "</span></br>")
		}
		;
		if (item.find("usetimeleports").text() != ''
				&& item.find("usetimeleports").text() != '0') {
			ullist.append("<span>이용시간 : " + item.find("usetimeleports").text()
					+ "</span></br>")
		}
		;
		if (item.find("accomcountlodging").text() != ''
				&& item.find("accomcountlodging").text() != '0') {
			ullist.append("<span>수용 가능인원 : "
					+ item.find("accomcountlodging").text() + "</span></br>")
		}
		;
		if (item.find("benikia").text() != ''
				&& item.find("benikia").text() != '0') {
			ullist.append("<span>베니키아 여부 : " + item.find("benikia").text()
					+ "</span></br>")
		}
		;
		if (item.find("chekintime").text() != ''
				&& item.find("chekintime").text() != '0') {
			ullist.append("<span>입실 시간 : " + item.find("chekintime").text()
					+ "</span></br>")
		}
		;
		if (item.find("checkouttime").text() != ''
				&& item.find("checkouttime").text() != '0') {
			ullist.append("<span>퇴실 시간 : " + item.find("checkouttime").text()
					+ "</span></br>")
		}
		;
		if (item.find("chkcooking").text() != ''
				&& item.find("chkcooking").text() != '0') {
			ullist.append("<span>객실내 취사 여부 : " + item.find("chkcooking").text()
					+ "</span></br>")
		}
		;
		if (item.find("foodplace").text() != ''
				&& item.find("foodplace").text() != '0') {
			ullist.append("<span>식음료장 : " + item.find("foodplace").text()
					+ "</span></br>")
		}
		;
		if (item.find("goodstay").text() != ''
				&& item.find("goodstay").text() != '0') {
			ullist.append("<span>굿스테이 여부 : " + item.find("goodstay").text()
					+ "</span></br>")
		}
		;
		if (item.find("hanok").text() != '' && item.find("hanok").text() != '0') {
			ullist.append("<span>한옥 여부 : " + item.find("hanok").text()
					+ "</span></br>")
		}
		;
		if (item.find("infocenterlodging").text() != ''
				&& item.find("infocenterlodging").text() != '0') {
			ullist.append("<span>문의 및 안내 : "
					+ item.find("infocenterlodging").text() + "</span></br>")
		}
		;
		if (item.find("parkingloding").text() != ''
				&& item.find("parkingloding").text() != '0') {
			ullist.append("<span>CLOB : " + item.find("parkingloding").text()
					+ "</span></br>")
		}
		;
		if (item.find("pickup").text() != ''
				&& item.find("pickup").text() != '0') {
			ullist.append("<span>픽업 서비스 : " + item.find("pickup").text()
					+ "</span></br>")
		}
		;
		if (item.find("roomcount").text() != ''
				&& item.find("roomcount").text() != '0') {
			ullist.append("<span>객실수 : " + item.find("roomcount").text()
					+ "</span></br>")
		}
		;
		if (item.find("reservationlodging").text() != ''
				&& item.find("reservationlodging").text() != '0') {
			ullist.append("<span>예약안내 : "
					+ item.find("reservationlodging").text() + "</span></br>")
		}
		;
		if (item.find("reservationlodging").text() != ''
				&& item.find("reservationlodging").text() != '0') {
			ullist.append("<span>예약안내 홈페이지 : "
					+ item.find("reservationlodging").text() + "</span></br>")
		}
		;
		if (item.find("roomtype").text() != ''
				&& item.find("roomtype").text() != '0') {
			ullist.append("<span>객실유형 : " + item.find("roomtype").text()
					+ "</span></br>")
		}
		;
		if (item.find("scalelodging").text() != ''
				&& item.find("scalelodging").text() != '0') {
			ullist.append("<span>규모 : " + item.find("scalelodging").text()
					+ "</span></br>")
		}
		;
		if (item.find("subfacility").text() != ''
				&& item.find("subfacility").text() != '0') {
			ullist.append("<span>부대시설 (기타) : "
					+ item.find("subfacility").text() + "</span></br>")
		}
		;
		if (item.find("barbecue").text() != ''
				&& item.find("barbecue").text() != '0') {
			ullist.append("<span>바비큐장 여부 : " + item.find("barbecue").text()
					+ "</span></br>")
		}
		;
		if (item.find("beauty").text() != ''
				&& item.find("beauty").text() != '0') {
			ullist.append("<span>뷰티시설 정보 : " + item.find("beauty").text()
					+ "</span></br>")
		}
		;
		if (item.find("beverage").text() != ''
				&& item.find("beverage").text() != '0') {
			ullist.append("<span>식음료장 여부 : " + item.find("beverage").text()
					+ "</span></br>")
		}
		;
		if (item.find("bicycle").text() != ''
				&& item.find("bicycle").text() != '0') {
			ullist.append("<span>자전거 대여 여부 : " + item.find("bicycle").text()
					+ "</span></br>")
		}
		;
		if (item.find("campfire").text() != ''
				&& item.find("campfire").text() != '0') {
			ullist.append("<span>캠프파이어 여부 : " + item.find("campfire").text()
					+ "</span></br>")
		}
		;
		if (item.find("fitness").text() != ''
				&& item.find("fitness").text() != '0') {
			ullist.append("<span>휘트니스 센터 여부 : " + item.find("fitness").text()
					+ "</span></br>")
		}
		;
		if (item.find("karaoke").text() != ''
				&& item.find("karaoke").text() != '0') {
			ullist.append("<span>노래방 여부 : " + item.find("karaoke").text()
					+ "</span></br>")
		}
		;
		if (item.find("publicbath").text() != ''
				&& item.find("publicbath").text() != '0') {
			ullist.append("<span>공용 샤워실 여부 : " + item.find("publicbath").text()
					+ "</span></br>")
		}
		;
		if (item.find("publicpc").text() != ''
				&& item.find("publicpc").text() != '0') {
			ullist.append("<span>공동 PC실 여부 : " + item.find("publicpc").text()
					+ "</span></br>")
		}
		;
		if (item.find("sauna").text() != '' && item.find("sauna").text() != '0') {
			ullist.append("<span>사우나실 여부 : " + item.find("sauna").text()
					+ "</span></br>")
		}
		;
		if (item.find("seminar").text() != ''
				&& item.find("seminar").text() != '0') {
			ullist.append("<span>세미나실 여부 : " + item.find("seminar").text()
					+ "</span></br>")
		}
		;
		if (item.find("sports").text() != ''
				&& item.find("sports").text() != '0') {
			ullist.append("<span>스포츠 시설 여부 : " + item.find("sports").text()
					+ "</span></br>")
		}
		;
		if (item.find("chkbabycarriageshopping").text() != ''
				&& item.find("chkbabycarriageshopping").text() != '0') {
			ullist.append("<span>유모차대여 정보 : "
					+ item.find("chkbabycarriageshopping").text()
					+ "</span></br>")
		}
		;
		if (item.find("chkcreditcardshopping").text() != ''
				&& item.find("chkcreditcardshopping").text() != '0') {
			ullist.append("<span>신용카드가능 정보 : "
					+ item.find("chkcreditcardshopping").text()
					+ "</span></br>")
		}
		;
		if (item.find("chkpetshopping").text() != ''
				&& item.find("chkpetshopping").text() != '0') {
			ullist.append("<span>애완동물동반가능 정보 : "
					+ item.find("chkpetshopping").text() + "</span></br>")
		}
		;
		if (item.find("culturecenter").text() != ''
				&& item.find("culturecenter").text() != '0') {
			ullist.append("<span>문화센터 바로가기 : "
					+ item.find("culturecenter").text() + "</span></br>")
		}
		;
		if (item.find("fairday").text() != ''
				&& item.find("fairday").text() != '0') {
			ullist.append("<span>장서는 날 : " + item.find("fairday").text()
					+ "</span></br>")
		}
		;
		if (item.find("infocentershopping").text() != ''
				&& item.find("infocentershopping").text() != '0') {
			ullist.append("<span>문의 및 안내 : "
					+ item.find("infocentershopping").text() + "</span></br>")
		}
		;
		if (item.find("opendateshopping").text() != ''
				&& item.find("opendateshopping").text() != '0') {
			ullist.append("<span>개장일 : " + item.find("opendateshopping").text()
					+ "</span></br>")
		}
		;
		if (item.find("opentime").text() != ''
				&& item.find("opentime").text() != '0') {
			ullist.append("<span>영업시간 : " + item.find("opentime").text()
					+ "</span></br>")
		}
		;
		if (item.find("parkingshopping").text() != ''
				&& item.find("parkingshopping").text() != '0') {
			ullist.append("<span>주차시설 : " + item.find("parkingshopping").text()
					+ "</span></br>")
		}
		;
		if (item.find("restdateshopping").text() != ''
				&& item.find("restdateshopping").text() != '0') {
			ullist.append("<span>쉬는날 : " + item.find("restdateshopping").text()
					+ "</span></br>")
		}
		;
		if (item.find("restroom").text() != ''
				&& item.find("restroom").text() != '0') {
			ullist.append("<span>화장실 설명 : " + item.find("restroom").text()
					+ "</span></br>")
		}
		;
		if (item.find("saleitem").text() != ''
				&& item.find("saleitem").text() != '0') {
			ullist.append("<span>판매 품목 : " + item.find("saleitem").text()
					+ "</span></br>")
		}
		;
		if (item.find("sleitemcost").text() != ''
				&& item.find("sleitemcost").text() != '0') {
			ullist.append("<span>판매 품목별 가격 : "
					+ item.find("sleitemcost").text() + "</span></br>")
		}
		;
		if (item.find("scaleshopping").text() != ''
				&& item.find("scaleshopping").text() != '0') {
			ullist.append("<span>규모 : " + item.find("scaleshopping").text()
					+ "</span></br>")
		}
		;
		if (item.find("shopguide").text() != ''
				&& item.find("shopguide").text() != '0') {
			ullist.append("<span>매장안내 : " + item.find("shopguide").text()
					+ "</span></br>")
		}
		;
		if (item.find("chkcreditcrdfood").text() != ''
				&& item.find("chkcreditcrdfood").text() != '0') {
			ullist.append("<span>신용카드가능 정보 : "
					+ item.find("chkcreditcrdfood").text() + "</span></br>")
		}
		;
		if (item.find("discountinfofood").text() != ''
				&& item.find("discountinfofood").text() != '0') {
			ullist.append("<span>할인정보 : "
					+ item.find("discountinfofood").text() + "</span></br>")
		}
		;
		if (item.find("firstmenu").text() != ''
				&& item.find("firstmenu").text() != '0') {
			ullist.append("<span>대표 메뉴 : " + item.find("firstmenu").text()
					+ "</span></br>")
		}
		;
		if (item.find("infocenterfood").text() != ''
				&& item.find("infocenterfood").text() != '0') {
			ullist.append("<span>문의 및 안내 : "
					+ item.find("infocenterfood").text() + "</span></br>")
		}
		;
		if (item.find("kidsfacility").text() != ''
				&& item.find("kidsfacility").text() != '0') {
			ullist.append("<span>어린이 놀이방 여부 : "
					+ item.find("kidsfacility").text() + "</span></br>")
		}
		;
		if (item.find("opendatefood").text() != ''
				&& item.find("opendatefood").text() != '0') {
			ullist.append("<span>개업일 : " + item.find("opendatefood").text()
					+ "</span></br>")
		}
		;
		if (item.find("opentimefood").text() != ''
				&& item.find("opentimefood").text() != '0') {
			ullist.append("<span>영업시간 : " + item.find("opentimefood").text()
					+ "</span></br>")
		}
		;
		if (item.find("packing").text() != ''
				&& item.find("packing").text() != '0') {
			ullist.append("<span>포장 가능 : " + item.find("packing").text()
					+ "</span></br>")
		}
		;
		if (item.find("parkingfood").text() != ''
				&& item.find("parkingfood").text() != '0') {
			ullist.append("<span>주차시설 : " + item.find("parkingfood").text()
					+ "</span></br>")
		}
		;
		if (item.find("reservationfood").text() != ''
				&& item.find("reservationfood").text() != '0') {
			ullist.append("<span>예약안내 : " + item.find("reservationfood").text()
					+ "</span></br>")
		}
		;
		if (item.find("restdatefood").text() != ''
				&& item.find("restdatefood").text() != '0') {
			ullist.append("<span>쉬는날 : " + item.find("restdatefood").text()
					+ "</span></br>")
		}
		;
		if (item.find("scalefood").text() != ''
				&& item.find("scalefood").text() != '0') {
			ullist.append("<span>규모 : " + item.find("scalefood").text()
					+ "</span></br>")
		}
		;
		if (item.find("seat").text() != '' && item.find("seat").text() != '0') {
			ullist.append("<span>좌석수 : " + item.find("seat").text()
					+ "</span></br>")
		}
		;
		if (item.find("smoking").text() != ''
				&& item.find("smoking").text() != '0') {
			ullist.append("<span>금연/흡연 여부 : " + item.find("smoking").text()
					+ "</span></br>")
		}
		;
		if (item.find("treatmenu").text() != ''
				&& item.find("treatmenu").text() != '0') {
			ullist.append("<span>취급 메뉴 : " + item.find("treatmenu").text()
					+ "</span></br>")
		}
		;
	}
</script>

<script>
	function reviewinsert(listdata){
			
		console.log("확인");	
		console.log();
	}
</script>


</head>
<body class="place_list">
	<!-- header 부분 -->
	<header id="header" role="banner"> <jsp:include
		page="topheader.jsp" flush="false" /> </header>
	<!-- header 부분 -->

	<div id="app">
		<div id="container" role="main" data-reactroot="" >
			<div id="content" class="content">
				<div class="ct_box_area">
					<div class="biz_name_area">
						<strong class="name"><%=input1%></strong><span class="category"><%=contenttype %></span>
						<div class="info">
							<div class="info_inner">
								<span class="txt"></span>
							</div>
						</div>
					</div>
					<div class="func_btn_area">
						<ul class="list_func_btn">
							<li class="list_item"><a class="btn"
								href="http://map.naver.com/?eText=%EC%98%81%EC%B2%9C%EC%98%81%ED%99%94%20%EC%B2%AD%EB%8B%B4%EC%A0%90&amp;eelng=127.0496180&amp;elng=127.0495269&amp;eelat=37.5240980&amp;elat=37.5239503"><svg
										version="1.1" width="50" height="28" viewBox="0 0 50 28">
									<path fill="#0abe16"
										d="M15.165,13.125h12V4.016l-4.161,4.161l-1.508-1.508L28.165,0 l6.669,6.669l-1.508,1.508l-4.161-4.161v11.109h-12v11h-2V13.125z"></path></svg>길찾기</a></li>
							<li class="list_item"><a class="btn"
								href="http://map.naver.com/index.nhn?pinId=13124988&amp;pinType=site&amp;streetviewer=on"><svg
										version="1.1" width="50" height="28" viewBox="0 0 50 28">
									<path fill="#0abe16"
										d="M25,0c-5.285,0-8.192,3.135-9.37,6.477l0,0c-0.001,0.003-0.001,0.005-0.002,0.008 c-0.279,0.794-0.459,1.595-0.551,2.373c0,0.004-0.002,0.009-0.002,0.013c0,0,0,0,0,0c-0.047,0.404-0.078,0.803-0.078,1.187 c0,5.275,9.695,15.45,10.004,15.95c0.309-0.5,10.004-10.675,10.004-15.95C35.004,5.824,32.204,0,25,0z M25,2 c5.052,0,7.133,3.355,7.769,6.127l-0.001,0.001c-2.096,1.786-4.806,2.872-7.77,2.872c-2.963,0-5.673-1.085-7.769-2.871 C17.867,5.355,19.947,2,25,2z M17.033,10.504c2.262,1.569,5.004,2.495,7.966,2.495c2.962,0,5.705-0.926,7.967-2.495l0.001-0.001 c-0.22,1.603-1.68,5.117-7.967,12.439C18.714,15.621,17.253,12.108,17.033,10.504z"></path></svg>거리뷰</a></li>
							<li class="list_item"><a id="_ifo.share"
								class="naver-splugin spi_sns_share btn" role="button"
								href="javascript://" target="_self" data-style="type_a"
								data-prevent-short-url="on" data-title="영천영화 청담점"
								data-kakaotalk-image-url="https://search.pstatic.net/common/?autoRotate=true&amp;quality=100&amp;src=http%3A%2F%2Fldb.phinf.naver.net%2F20150831_141%2F14409904884720nfdO_JPEG%2FSUBMIT_1290576667507_13124988.jpg&amp;type=f640_380"
								data-bookmark-display="on"
								data-url="https://store.naver.com/restaurants/detail?id=13124988&amp;query=%EC%98%81%EC%B2%9C%EC%98%81%ED%99%94%20%EC%B2%AD%EB%8B%B4%EC%A0%90"
								splugin-id="9802183822"><svg version="1.1" width="50"
										height="28" viewBox="0 0 50 28"> <path fill="#0abe16"
										d="M40.001,7.395l-7.982,7.395V9.891H28.18 C22.347,9.971,21,13.904,21,13.904c0.406-4.545,3.099-9.012,7.764-9.012l3.255,0.008V0L40.001,7.395z M16.001,22.406h18v-6h2v6v2h-2 h-18h-2v-2v-17v-2h2h5v2h-5V22.406z"></path></svg>공유</a></li>
						</ul>
					</div>
				</div>

				<div class="ct_box_area">
					<div class="bizinfo_area">
						<div class="list_bizinfo"></div>
					</div>

					<div id="panel01" class="tab_detail_area" role="tabpanel" aria-labelledby="tab01" aria-expanded="true" aria-hidden="false"> <div>

								<!-- 리  뷰 -->
							<div class="sc_box relation_place">
								<h3> 리뷰 
								    <button id="reviewbutton" style="position: absolute; right: 0;">리뷰 쓰기</button>
 								</h3>
								    <!-- The Modal -->
							<form>
								<div id = "modal-content">
    								<div id="myModal" class="modal">
	 									<!-- Modal content -->
	 									<div class="modal-content">
        									<span class="modal-close">&times;</span>
        								
        									<div class="tile title-tile"> 
        										<div>
        											<div class="place-indent">
        												<div class="title" style="text-align:center; color: white;">평가 및 리뷰</div>
        												</div>
        										</div>
        									</div>    
        									                                                           
        									<div class = "reviewmaincontaier"> 
        										<div class="tile user-tile">
        												<div class="user-indent">
        													<div class="user-name"><%=id %>님 리뷰를 작성해주세요.</div>
        												</div>
        										</div>
        									
        										<div class="tile rating-tile">
        											<div aria-label="별표 평점" tabindex="0" jstcache="13" class="rating-indent rating rating-actionable" style="-moz-user-select: none;">
        												<span class="rating">
        													<span aria-label="1성급" id="star1" role="button" tabindex="0" jstcache="14" class="rating-star" aria-checked="false" aria-pressed="false"></span>
        													<span aria-label="2성급" id="star2" role="button" tabindex="0" jstcache="15" class="rating-star" aria-checked="false" aria-pressed="false"></span>
        													<span aria-label="3성급" id="star3" role="button" tabindex="0" jstcache="16" class="rating-star" aria-checked="false" aria-pressed="false"></span>
        													<span aria-label="4성급" id="star4" role="button" tabindex="0" jstcache="17" class="rating-star" aria-checked="false" aria-pressed="false"></span>
        													<span aria-label="5성급" id="star5" role="button" tabindex="0" jstcache="18" class="rating-star" aria-checked="false" aria-pressed="false"></span>
        												</span> </div> </div>
        										</div>
        									
        										<div class="mobile-scrollable-fill">
        											<div class="tile review-text-tile-with-add-photo" >
        												<div class="review-text-indent">
        													<textarea placeholder="이 장소에서의 경험을 자세히 공유하세요." class="review-text" style="height: 120px;"></textarea>
        												</div>
        											</div>
        										</div>
        										
        										<div class = "reviewputipcancel" style="text-align: right;">
        											<input id="reviewputup" type="button"  style="margin: 5px; " value ="리뷰 쓰기" onclick="javascript:reviewinsert(this.form)">
        										</div>
        									
        									</div></div></div></form>
        									</div>
        									

								<div class="relation_place_area">
									<div class="flick_container" style="height: 150px; z-index: 0;">
										<a class="btn_direction btn_prev " aria-label="이전" role="button" onclick="javascript:move(this);">
										<svg class="icon" role="presentation" version="1.1" width="9" height="16" viewBox="0 0 9 16">
										<path fill="#666666" d="M8,9v1H7v1H6v1H5v1H4v1H3v1H2v1H1v-1H0v-1h1v-1h1v-1h1v-1h1v-1h1V9 h1V7H5V6H4V5H3V4H2V3H1V2H0V1h1V0h1v1h1v1h1v1h1v1h1v1h1v1h1v1h1v2H8z"></path></svg></a>
										
										<div>
											<div class="flick_wrapper list_card" id="review_list_right" role="list" style="position: absolute; left: 0px; top: 0px; height: 100%; transform: translate(0px, 0px);">
												
											</div>
										</div>
										<a class="btn_direction btn_next " aria-label="다음" role="button" onclick="javascript:move(this);">
										<svg class="icon" role="presentation" version="1.1" width="9" height="16" viewBox="0 0 9 16">
										<path fill="#666666" d="M8,9v1H7v1H6v1H5v1H4v1H3v1H2v1H1v-1H0v-1h1v-1h1v-1h1v-1h1v-1h1V9 h1V7H5V6H4V5H3V4H2V3H1V2H0V1h1V0h1v1h1v1h1v1h1v1h1v1h1v1h1v1h1v2H8z"></path></svg></a>
								</div>
							</div>
						</div>
								
							<!-- 블로그 리뷰 -->
							<div class="sc_box review">
								<div class="review_area">
									<h3>블로그 리뷰</h3>
									<ul class="list_place_col1 list_review">
										<li class="list_item type_review"><div
												class="list_item_inner">
												<a class="thumb_area fl"
													href="https://blog.naver.com/hmlee68/221335737156"
													target="_blank"><div class="thumb">
														<img
															src="https://search.pstatic.net/common/?autoRotate=true&amp;quality=95&amp;src=http%3A%2F%2Fblogfiles.naver.net%2FMjAxODA4MDlfMTI2%2FMDAxNTMzODAyMzgwMDYx.uH-2TdHckJwyl2zG7hyXmS5BoilXRYF7VgqEDNdek_4g.LR7G6DNHCuixjJQ7A2JfwZVqHHnC3PobGrnodWCPdqog.JPEG.hmlee68%2F1533802302157.jpg%23865x1014&amp;type=f120_120"
															alt="리뷰 이미지" width="120" height="120">
													</div></a>
												<div class="info_area">
													<div class="tit">
														<a class="name"
															href="https://blog.naver.com/hmlee68/221335737156"
															target="_blank">❤수요미식회 영천영화 청담점 육회비빔밥</a>
													</div>
													<div class="txt ellp2">영업시간 평일 00:00~24:00 명절휴무 수요미식회
														전지적 참견시점 이영자의 맛집 내멋대로에서도 육회를 넘 맛있게 먹는 걸 보면 아니 갈 수없었던 집 영업은
														24시간 기다리는건 각오하고 가야함 20~20분은 기본 연예인들이...</div>
													<div class="author_area">
														<span class="author_info"><a class="info name"
															href="http://blog.naver.com/hmlee68" target="_blank"><span>기차
																	첫칸에 앉아</span></a><span class="info time">6일전</span><span
															class="info channel">블로그</span></span>
													</div>
												</div>
											</div></li>
										<li class="list_item type_review"><div
												class="list_item_inner">
												<a class="thumb_area fl"
													href="https://blog.naver.com/78stella/221332482390"
													target="_blank"><div class="thumb">
														<img
															src="https://search.pstatic.net/common/?autoRotate=true&amp;quality=95&amp;src=http%3A%2F%2Fblogfiles.naver.net%2FMjAxODA4MDRfMjMw%2FMDAxNTMzMzUwNTAxMDI2.pIpUBxK3wZi2WSAe_6p_Fr8MoQITQeQ03Nngl6pCScog.paQFmFsZpi4IPEL7WDdFb7BZt2vg_ghCGqWExtjehkUg.JPEG.78stella%2F18.jpg%23936x624&amp;type=f120_120"
															alt="리뷰 이미지" width="120" height="120">
													</div></a>
												<div class="info_area">
													<div class="tit">
														<a class="name"
															href="https://blog.naver.com/78stella/221332482390"
															target="_blank">이영자 육회비빔밥 청담동 &lt;영천영화&gt;</a>
													</div>
													<div class="txt ellp2">이영자 육회비빔밥 청담동 영천영화 안녕하세요, 꿈나예요
														:) 이웃님들,,,오늘도 행복한 하루 보내세요^^ 토요일 밤의 힐링 예능 "전지적참견시점" 그 중에서도
														꿈나가 애정하는 영자언니의 먹방ㅋㅋㅋ 이번주 전참시...</div>
													<div class="author_area">
														<span class="author_info"><a class="info name"
															href="http://blog.naver.com/78stella" target="_blank"><span>똥꼬발랄
																	땡구씨의 행복한 육견일기</span></a><span class="info time">2018.08.04.</span><span
															class="info channel">블로그</span></span>
													</div>
												</div>
											</div></li>
										<li class="list_item type_review"><div
												class="list_item_inner">
												<a class="thumb_area fl"
													href="https://blog.naver.com/zephyr122059/221330174050"
													target="_blank"><div class="thumb">
														<img
															src="https://search.pstatic.net/common/?autoRotate=true&amp;quality=95&amp;src=http%3A%2F%2Fblogfiles.naver.net%2FMjAxODA4MDNfMjc5%2FMDAxNTMzMjg2NjY2MDAx.EMqL_8wBaPlv8sf5kiee7SwlS9dvJKTWDNssfA-0Mvwg.nBkJDXr1EKno5c-v-ZNI-BuJao8JiOsMWdM38kySu3cg.JPEG.zephyr122059%2F20180803_145340.jpg%23800x600&amp;type=f120_120"
															alt="리뷰 이미지" width="120" height="120">
													</div></a>
												<div class="info_area">
													<div class="tit">
														<a class="name"
															href="https://blog.naver.com/zephyr122059/221330174050"
															target="_blank">청담동 맛집 - 영천영화 청담점 : 전참시 이영자 맛집, 36시간
															숙성... </a>
													</div>
													<div class="txt ellp2">◆◆영천영화 청담점 : 전참시 이영자 맛집, 36시간
														숙성 이영자 육회비빔밥, 육회◆◆ 배우 이시영 씨 남편이 CEO인 프랜차이즈로 수요미식회에도 전현무 씨
														단골집으로 소개된 청담동동 맛집 영천영화 청담점을 찾았다....</div>
													<div class="author_area">
														<span class="author_info"><a class="info name"
															href="http://blog.naver.com/zephyr122059" target="_blank"><span>사랑이
																	밥먹여준다</span></a><span class="info time">2018.08.04.</span><span
															class="info channel">블로그</span></span>
													</div>
												</div>
											</div></li>
									</ul>
									<a class="btn_sc_more" href="javascript:void(0)" target="_self">더보기<svg
											class="icon" version="1.1" width="17" height="14"
											viewBox="0 0 17 14"> <path fill="#0ABE16"
											d="M16.992,7L17,7.008l-6.607,6.607l-1.289-1.289L13.429,8H-0.008V6h13.437L9.104,1.675l1.289-1.289L17,6.992 L16.992,7z"></path></svg></a>
								</div>
							</div>
								</div>
							</div>
					</div>
				</div>
			</div>
		</div>
</body>
</html>