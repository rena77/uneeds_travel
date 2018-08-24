<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
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

<!-- 선택시 맵 변경 부분 -->
<script>

var map; // map 표시 (최초 맵과 맵 표시 부분을 공용으로 사용)
var HOME_PATH = window.HOME_PATH || '.';  //   ../web/ 을 써줌
var contentString; // 마커 내용
var markers = []; // 마커 배열
var infowindows = []; // 정보 배열

	// 최초 맵 표시 부분
	$(function(){
		map = new naver.maps.Map('map', {
			center : new naver.maps.LatLng(37.4978992118, 127.0276129349), // 강남 좌표
			zoom : 10
		});
	})
			
	function mapchange(data){					
		var items = $(data).find("item"); // api로 가지고온 데이터
		
		deleteMarkers(map,markers);
		
		markers = [];
		infowindows = []; 
		
		for (var i = 0; i < items.length; i++){ // 데이터 map infowindow에 뿌림
			item = $(items[i]);
			contentString = [
				'<div class= iw_inner>',
				'   <h3>'+ item.find("title").text()+ '</h3>',
				'   <p>'+ item.find("addr1").text()+ '<br />',
				'       <img src="'+ item.find("firstimage").text()+ '" width="55" height="55" onerror= "javascript:imagechage(this);" alt ="" class="thumb" /><br />',
				'       '+ item.find("tel").text()+ '<br />',
				'		<INPUT TYPE="hidden" NAME="hid1" VALUE="'+ item.find("contentid").text()+ '">',
        		'		<INPUT TYPE="hidden" NAME="hid2" VALUE="'+ item.find("contenttypeid").text()+ '">',
				'   </p>', 
				'</div>'
				].join('');

			// 마커 정보 표시창
			var infowindow = new naver.maps.InfoWindow({
				content : contentString});
			//
			
			// 지도 마커 위치
			var position = new naver.maps.LatLng(item.find("mapy").text(), item.find("mapx").text());
							
			var markerOptions = {
			    	position: position.destinationPoint(90, 15),
			    	map: map,
			    	icon: {
			        	url: '/resources/travel/img/food2.png',
			        	size: new naver.maps.Size(50, 50),
			        	origin: new naver.maps.Point(0, 0),
			        	anchor: new naver.maps.Point(25, 26)
			    	}
				};

			var marker = new naver.maps.Marker(markerOptions);

			markers.push(marker);
			infowindows.push(infowindow);
			
		}

		// 지도 이동
		var select = new naver.maps.Point(item.find("mapx").text(), item.find("mapy").text()); //마지막 좌표값으로 지도 이동
		map.setCenter(select);
		//

		naver.maps.Event.addListener(map, 'idle' , function() { //idle 지도의 움직임이 종료되었을 때(유휴 상태) 이벤트가 발생
			updateMarkers(map,markers);			// 마커 표시 추가
		});

		for (var i = 0, ii = markers.length; i < ii; i++) {	// click 시 gethandler 사용 하여 지도 마커 내용 온/오프
			naver.maps.Event.addListener(markers[i] , 'click' , getClickHandler(i));
		}

	}
	
	function deleteMarkers(map, markers) {
		var mapBounds = map.getBounds();
		var marker, position, infoWindow;

		for (var i = 0; i < markers.length; i++) {
			marker = markers[i];
			position = marker.getPosition();
			infoWindow = infowindows[i];
		
			if (mapBounds.hasLatLng(position) || infoWindow.getMap()) {
				hideMarker(map, marker);	// 마커 사라지기
				infoWindow.close();
			}
		}         
	}
		
	function updateMarkers(map,markers) {
		var mapBounds = map.getBounds();
		var marker, position;

		for (var i = 0; i < markers.length; i++) {
			marker = markers[i];
			position = marker.getPosition();
		
			if (mapBounds.hasLatLng(position)) {
				showMarker(map, marker);	// 마커 보여주기
			} else {
				hideMarker(map,marker);		// 마커 사라지기
			}
		}
	}
		
	// Marker show / hide 변경
	function showMarker(map, marker) {
		if (marker.setMap())
		return;
		marker.setMap(map);
	}

	function hideMarker(map, marker) {
		if (!marker.setMap())
		return;
		marker.setMap(null);
	}

	// 해당 마커의 인덱스를 seq라는 클로저 변수로 저장하는 이벤트 핸들러를 반환합니다.
	function getClickHandler(seq) {
		return function(e) {
			var marker = markers[seq], infoWindow = infowindows[seq];
			
			if (infoWindow.getMap()) {
				infoWindow.close();
			} else {
				map.setCenter(new naver.maps.Point(markers[seq].position.x, markers[seq].position.y));
				infoWindow.open(map,marker);
				maplist(seq);
			}
		}
	}
	
	function listClickHandler(seq) {
			var marker = markers[seq], infoWindow = infowindows[seq];
			if (infoWindow.getMap()) {
				infoWindow.close();
			} else {
				map.setCenter(new naver.maps.Point(markers[seq].position.x, markers[seq].position.y));
				infoWindow.open(map,marker);
			}
	}
</script>

<script>	// list show hide
  function detailshowhide(){
	  
	  var ul1 = $("#list_place_col");
	  var ul2= $("#list_place_col1");
	  
	  if(ul1.css("display") == "none"){
		    ul1.show();
		    ul2.hide();
		    
		} else {
		    ul1.hide();
		    ul2.show();
		}
  }
</script>

<!-- api의 상세 정보 표시 -->
<script>
	function detailedinformationlist(data) {
		var item = $(data).find("item");
		var contenttypeid = item.find("contenttypeid").text();

		var ullist = $("#listdetail");
		ullist.empty();
		ullist.append("<h3><span> 기본 정보 </span></h3>"+
					"<input type='hidden' id = 'detailcontentid' name ='detailcontentid' class = 'detailcontentid' value = '" + item.find("contentid").text() + "'>" +
					"<input type='hidden' id = 'detailcontenttypeid' name ='detailcontenttypeid' class = 'detailcontenttypeid' value = '" + item.find("contenttypeid").text() + "'>");
		if (item.find("accomcount").text() != '' && item.find("accomcount").text() != '0') {ullist.append("<span>수용인원 : " + item.find("accomcount").text() + "</span></br>")};
		if (item.find("chkbabycarriage").text() != '' && item.find("chkbabycarriage").text() != '0') {ullist.append("<span>유모차대여 정보 : " + item.find("chkbabycarriage").text() + "</span></br>")};
		if (item.find("chkcreditcard").text() != ''&& item.find("chkcreditcard").text() != '0') {ullist.append("<span>신용카드가능 정보 : "+ item.find("chkcreditcard").text() + "</span></br>")};
		if (item.find("chkpet").text() != ''&& item.find("chkpet").text() != '0') {ullist.append("<span>애완동물동반가능 정보 : " + item.find("chkpet").text()+ "</span></br>")};
		if (item.find("expagerange").text() != ''&& item.find("expagerange").text() != '0') {ullist.append("<span>체험가능 연령 : " + item.find("expagerange").text()+ "</span></br>")};
		if (item.find("expguide").text() != ''&& item.find("expguide").text() != '0') {ullist.append("<span>체험안내 : " + item.find("expguide").text()+ "</span></br>")};
		if (item.find("heritage1").text() != ''&& item.find("heritage1").text() != '0') {ullist.append("<span>세계 문화유산 유무 : " + item.find("heritage1").text()+ "</span></br>")};
		if (item.find("heritage2").text() != ''&& item.find("heritage2").text() != '0') {ullist.append("<span>세계 자연유산 유무 : " + item.find("heritage2").text()+ "</span></br>")};
		if (item.find("heritage3").text() != ''&& item.find("heritage3").text() != '0') {ullist.append("<span>세계 기록유산 유무 : " + item.find("heritage3").text()+ "</span></br>")};
		if (item.find("infocenter").text() != ''&& item.find("infocenter").text() != '0') {ullist.append("<span>문의 및 안내 : " + item.find("infocenter").text()+ "</span></br>")};
		if (item.find("opendate").text() != ''&& item.find("opendate").text() != '0') {ullist.append("<span>개장일 : " + item.find("opendate").text()+ "</span></br>")};
		if (item.find("parking").text() != ''&& item.find("parking").text() != '0') {ullist.append("<span>주차시설 : " + item.find("parking").text()+ "</span></br>")};
		if (item.find("restdate").text() != ''&& item.find("restdate").text() != '0') {ullist.append("<span>쉬는날 : " + item.find("restdate").text()+ "</span></br>")};
		if (item.find("useseason").text() != ''&& item.find("useseason").text() != '0') {ullist.append("<span>이용시기 : " + item.find("useseason").text()+ "</span></br>")};
		if (item.find("usetime").text() != ''&& item.find("usetime").text() != '0') {ullist.append("<span>이용시간 : " + item.find("usetime").text()+ "</span></br>")};
		if (item.find("accomcountculture").text() != ''&& item.find("accomcountculture").text() != '0') {ullist.append("<span>수용인원 : "+ item.find("accomcountculture").text() + "</span></br>")};
		if (item.find("chkbabycarriage culture").text() != ''&& item.find("chkbabycarriage culture").text() != '0') {ullist.append("<span>유모차대여 정보 : "+ item.find("chkbabycarriage culture").text()+ "</span></br>")};
		if (item.find("chkcreditcardculture").text() != ''&& item.find("chkcreditcardculture").text() != '0') {ullist.append("<span>신용카드가능 정보 : "+ item.find("chkcreditcardculture").text()+ "</span></br>")};
		if (item.find("chkpetculture").text() != ''&& item.find("chkpetculture").text() != '0') {ullist.append("<span>애완동물동반가능 정보 : "+ item.find("chkpetculture").text() + "</span></br>")};
		if (item.find("discountinfo").text() != ''&& item.find("discountinfo").text() != '0') {ullist.append("<span>할인정보 : " + item.find("discountinfo").text()+ "</span></br>")};
		if (item.find("infocenterculture").text() != ''&& item.find("infocenterculture").text() != '0') {ullist.append("<span>문의 및 안내 : "+ item.find("infocenterculture").text() + "</span></br>")};
		if (item.find("parkingculture").text() != ''&& item.find("parkingculture").text() != '0') {ullist.append("<span>주차시설 : " + item.find("parkingculture").text()+ "</span></br>")};
		if (item.find("parkingfee").text() != ''&& item.find("parkingfee").text() != '0') {ullist.append("<span>주차요금 : " + item.find("parkingfee").text()+ "</span></br>")};
		if (item.find("restdateculture").text() != ''&& item.find("restdateculture").text() != '0') {ullist.append("<span>쉬는날 : " + item.find("restdateculture").text()+ "</span></br>")};
		if (item.find("usefee").text() != ''&& item.find("usefee").text() != '0') {ullist.append("<span>이용요금 : " + item.find("usefee").text()+ "</span></br>")};
		if (item.find("usetimeculture").text() != ''&& item.find("usetimeculture").text() != '0') {ullist.append("<span>이용시간 : " + item.find("usetimeculture").text()+ "</span></br>")};
		if (item.find("scale").text() != '' && item.find("scale").text() != '0') {ullist.append("<span>규모 : " + item.find("scale").text()+ "</span></br>")};
		if (item.find("spendtime").text() != ''&& item.find("spendtime").text() != '0') {ullist.append("<span>관람 소요시간 : " + item.find("spendtime").text()+ "</span></br>")};
		if (item.find("agelimit").text() != ''&& item.find("agelimit").text() != '0') {ullist.append("<span>관람 가능연령 : " + item.find("agelimit").text()+ "</span></br>")};
		if (item.find("bookingplace").text() != ''&& item.find("bookingplace").text() != '0') {ullist.append("<span>예매처 : " + item.find("bookingplace").text()+ "</span></br>")};
		if (item.find("discountinfofestival").text() != ''&& item.find("discountinfofestival").text() != '0') {ullist.append("<span>할인정보 : "+ item.find("discountinfofestival").text()+ "</span></br>")};
		if (item.find("eventenddate").text() != ''&& item.find("eventenddate").text() != '0') {ullist.append("<span>행사 종료일 : " + item.find("eventenddate").text()+ "</span></br>")};
		if (item.find("eventhomepage").text() != ''&& item.find("eventhomepage").text() != '0') {ullist.append("<span>행사 홈페이지 : "+ item.find("eventhomepage").text() + "</span></br>")};
		if (item.find("eventplace").text() != ''&& item.find("eventplace").text() != '0') {ullist.append("<span>행사 장소 : " + item.find("eventplace").text()+ "</span></br>")};
		if (item.find("eventstartdate").text() != ''&& item.find("eventstartdate").text() != '0') {ullist.append("<span>행사 시작일 : "+ item.find("eventstartdate").text() + "</span></br>")};
		if (item.find("festivalgrade").text() != ''&& item.find("festivalgrade").text() != '0') {ullist.append("<span>축제등급 : " + item.find("festivalgrade").text()+ "</span></br>")};
		if (item.find("placeinfo").text() != ''&& item.find("placeinfo").text() != '0') {ullist.append("<span>행사장 위치안내 : " + item.find("placeinfo").text()+ "</span></br>")};
		if (item.find("playtime").text() != ''&& item.find("playtime").text() != '0') {ullist.append("<span>공연시간 : " + item.find("playtime").text()+ "</span></br>")};
		if (item.find("program").text() != ''&& item.find("program").text() != '0') {ullist.append("<span>행사 프로그램 : " + item.find("program").text()+ "</span></br>")};
		if (item.find("spendtimefestival").text() != ''&& item.find("spendtimefestival").text() != '0') {ullist.append("<span>관람 소요시간 : "+ item.find("spendtimefestival").text() + "</span></br>")};
		if (item.find("sponsor1").text() != ''&& item.find("sponsor1").text() != '0') {ullist.append("<span>주최자 정보 : " + item.find("sponsor1").text()+ "</span></br>")};
		if (item.find("sponsor1tel").text() != ''&& item.find("sponsor1tel").text() != '0') {ullist.append("<span>주최자 연락처 : " + item.find("sponsor1tel").text()+ "</span></br>")};
		if (item.find("sponsor2").text() != ''&& item.find("sponsor2").text() != '0') {ullist.append("<span>주관사 정보 : " + item.find("sponsor2").text()+ "</span></br>")};
		if (item.find("sponsor2tel").text() != ''&& item.find("sponsor2tel").text() != '0') {ullist.append("<span>주관사 연락처 : " + item.find("sponsor2tel").text()+ "</span></br>")};
		if (item.find("subevent").text() != ''&& item.find("subevent").text() != '0') {ullist.append("<span>부대행사 : " + item.find("subevent").text()+ "</span></br>")};
		if (item.find("usetimefestival").text() != ''&& item.find("usetimefestival").text() != '0') {ullist.append("<span>이용요금 : " + item.find("usetimefestival").text()+ "</span></br>")};
		if (item.find("distance").text() != ''&& item.find("distance").text() != '0') {ullist.append("<span>코스 총거리 : " + item.find("distance").text()+ "</span></br>")};
		if (item.find("infocentertour course").text() != ''&& item.find("infocentertour course").text() != '0') {ullist.append("<span>문의 및 안내 : "+ item.find("infocentertour course").text()+ "</span></br>")};
		if (item.find("schedule").text() != ''&& item.find("schedule").text() != '0') {ullist.append("<span>코스 일정 : " + item.find("schedule").text()+ "</span></br>")};
		if (item.find("taketime").text() != ''&& item.find("taketime").text() != '0') {ullist.append("<span>코스 총 소요 시간 : " + item.find("taketime").text()+ "</span></br>")};
		if (item.find("theme").text() != '' && item.find("theme").text() != '0') {ullist.append("<span>코스 테마 : " + item.find("theme").text()+ "</span></br>")};
		if (item.find("accomcountleports").text() != ''&& item.find("accomcountleports").text() != '0') {ullist.append("<span>수용인원 : "+ item.find("accomcountleports").text() + "</span></br>")};
		if (item.find("chkbabycarriageleports").text() != ''&& item.find("chkbabycarriageleports").text() != '0') {ullist.append("<span>유모차대여 정보 : "+ item.find("chkbabycarriageleports").text()+ "</span></br>")};
		if (item.find("chkcreditcardleports").text() != ''&& item.find("chkcreditcardleports").text() != '0') {ullist.append("<span>신용카드가능 정보 : "+ item.find("chkcreditcardleports").text()+ "</span></br>")};
		if (item.find("chkpetleports").text() != ''&& item.find("chkpetleports").text() != '0') {ullist.append("<span>애완동물동반가능 정보 : "+ item.find("chkpetleports").text() + "</span></br>")};
		if (item.find("expagerangeleports").text() != ''&& item.find("expagerangeleports").text() != '0') {ullist.append("<span>체험 가능연령 : "+ item.find("expagerangeleports").text() + "</span></br>")};
		if (item.find("infocenterleports").text() != ''&& item.find("infocenterleports").text() != '0') {ullist.append("<span>문의 및 안내 : "+ item.find("infocenterleports").text() + "</span></br>")};
		if (item.find("openperiod").text() != ''&& item.find("openperiod").text() != '0') {ullist.append("<span>개장기간 : " + item.find("openperiod").text()+ "</span></br>")};
		if (item.find("parkingfeeleports").text() != ''&& item.find("parkingfeeleports").text() != '0') {ullist.append("<span>주차요금 : "+ item.find("parkingfeeleports").text() + "</span></br>")};
		if (item.find("parkingleports").text() != ''&& item.find("parkingleports").text() != '0') {ullist.append("<span>주차시설 : " + item.find("parkingleports").text()+ "</span></br>")};
		if (item.find("reservation").text() != ''&& item.find("reservation").text() != '0') {ullist.append("<span>예약안내 : " + item.find("reservation").text()+ "</span></br>")};
		if (item.find("restdateleports").text() != ''&& item.find("restdateleports").text() != '0') {ullist.append("<span>쉬는날 : " + item.find("restdateleports").text()+ "</span></br>")};
		if (item.find("scaleleports").text() != ''&& item.find("scaleleports").text() != '0') {ullist.append("<span>규모 : " + item.find("scaleleports").text()+ "</span></br>")};
		if (item.find("usefeeleports").text() != ''&& item.find("usefeeleports").text() != '0') {ullist.append("<span>입장료 : " + item.find("usefeeleports").text()+ "</span></br>")};
		if (item.find("usetimeleports").text() != ''&& item.find("usetimeleports").text() != '0') {ullist.append("<span>이용시간 : " + item.find("usetimeleports").text()+ "</span></br>")};
		if (item.find("accomcountlodging").text() != ''&& item.find("accomcountlodging").text() != '0') {ullist.append("<span>수용 가능인원 : "+ item.find("accomcountlodging").text() + "</span></br>")};
		if (item.find("benikia").text() != ''&& item.find("benikia").text() != '0') {ullist.append("<span>베니키아 여부 : " + item.find("benikia").text()+ "</span></br>")};
		if (item.find("chekintime").text() != ''&& item.find("chekintime").text() != '0') {ullist.append("<span>입실 시간 : " + item.find("chekintime").text()+ "</span></br>")};
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


<script>	//star 버튼 변환

$(function(){
	var main = document.getElementById("mainstar");
	var star1 = document.getElementById("star1");
	var star2 = document.getElementById("star2");
	var star3 = document.getElementById("star3");
	var star4 = document.getElementById("star4");
	var star5 = document.getElementById("star5");
	
	var starattrarr = [$('#star1'), $('#star2'), $('#star3'), $('#star4'), $('#star5')];
	var mainstar = $('#mainstar');
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
			mainstar.attr('title', 1);
		} else {
			for(var i = 0; i < 5; i++){
				starattrarr[i].attr('class', 'rating-star');
				starattrarr[i].attr('aria-checked', false);
				starattrarr[i].attr('aria-pressed', false);
			}
			mainstar.attr('title', 0);
		}
	}
	
	star2.onclick = function(){
		if(starattr2.attr('class') == 'rating-star'){
			for(var i = 0; i < 2; i++){
				starattrarr[i].attr('class', 'rating-star rating-star-full');
				starattrarr[i].attr('aria-checked', true);
				starattrarr[i].attr('aria-pressed', true);
			}
			mainstar.attr('title', 2);
		} else {
			for(var i = 0; i < 5; i++){
				starattrarr[i].attr('class', 'rating-star');
				starattrarr[i].attr('aria-checked', false);
				starattrarr[i].attr('aria-pressed', false);
			}
			mainstar.attr('title', 0);
		}	
	}
	
	star3.onclick = function(){
		if(starattr3.attr('class') == 'rating-star'){
			for(var i = 0; i < 3; i++){
				starattrarr[i].attr('class', 'rating-star rating-star-full');
				starattrarr[i].attr('aria-checked', true);
				starattrarr[i].attr('aria-pressed', true);
			}
			mainstar.attr('title', 3);
		} else {
			for(var i = 0; i < 5; i++){
				starattrarr[i].attr('class', 'rating-star');
				starattrarr[i].attr('aria-checked', false);
				starattrarr[i].attr('aria-pressed', false);
			}
			mainstar.attr('title', 0);
		}
	}
	
	star4.onclick = function(){
		if(starattr4.attr('class') == 'rating-star'){
			for(var i = 0; i < 4; i++){
				starattrarr[i].attr('class', 'rating-star rating-star-full');
				starattrarr[i].attr('aria-checked', true);
				starattrarr[i].attr('aria-pressed', true);
			}
			mainstar.attr('title', 4);
		} else {
			for(var i = 0; i < 5; i++){
				starattrarr[i].attr('class', 'rating-star');
				starattrarr[i].attr('aria-checked', false);
				starattrarr[i].attr('aria-pressed', false);
			}
			mainstar.attr('title', 0);
		}
	}
	
	star5.onclick = function(){
		if(starattr5.attr('class') == 'rating-star'){
			for(var i = 0; i < 5; i++){
				starattrarr[i].attr('class', 'rating-star rating-star-full');
				starattrarr[i].attr('aria-checked', true);
				starattrarr[i].attr('aria-pressed', true);
			}
			mainstar.attr('title', 5);
		} else {
			for(var i = 0; i < 5; i++){
				starattrarr[i].attr('class', 'rating-star');
				starattrarr[i].attr('aria-checked', false);
				starattrarr[i].attr('aria-pressed', false);
			}
			mainstar.attr('title', 0);
		}
	}
});

</script>

<script> // 리뷰 쓰기 모달 창
function reviewmodal(){
	var modal = document.getElementById("myModal");
	var btn = document.getElementById("reviewbutton"); // Get the button that opens the modal
	var span = document.getElementsByClassName("modal-close")[1];         // Get the <span> element that closes the modal                                 

	var id = '<%=session.getAttribute("userid")%>';
	// When the user clicks on the button, open the modal
	
	if(id == 'null'){
		alert("로그인 후 등록해주세요.");
	}else {
	    modal.style.display = "block";
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
}

</script>

<script> // 리뷰 등록 창
	function reviewinsert(listdata){
	
		var detailcontentid = document.getElementById("detailcontentid");			
		var contentid = $(detailcontentid).attr("value");
		var star = $(mainstar).attr("title");
		var text = $("textarea#textarea-text").val();
		var modal = document.getElementById("myModal");
		
		console.log(star);
		
		$.post("t_reviewinsert", {
			tourmembercode : '<%=id %>',
			contentid : contentid,
			tourtext : text,
			star : star
			}).done(function(data, state) {
			});
		
		alert("리뷰 작성 감사합니다.")
		
		modal.style.display = "none";
	}

</script>

<!--  list 표시 -->
<script>	// 리스트에서 상세 리스트 띄우기
	function detailedinformat(data){
		var ul = $("#list_place_col1");
		
		var item = $(data).find("item");
		var contentid = item.find("contentid").text();
		
		ul.empty();
		ul.append(
				"<li class=list_item type_restaurant=''><form>" +
					"<div class='func_btn_area'>"+
						"<ul class = 'list_func_btn'>" +
							"<li class='list_item'>" +
								"<div style ='width :100px; '>" +
					    			"<input type='checkbox' id='checkbox' onclick= 'javascript:listpage2(this.form);' />" +
					   		 		"<label for='checkbox'>" +
					      				"<svg id='heart-svg' viewBox='467 392 58 57' xmlns='http://www.w3.org/2000/svg'>" +
					       				"<g id='Group' fill='none' fill-rule='evenodd' transform='translate(467 392)'>" +
					          			"<path d='M29.144 20.773c-.063-.13-4.227-8.67-11.44-2.59C7.63 28.795 28.94 43.256 29.143 43.394c.204-.138 21.513-14.6 11.44-25.213-7.214-6.08-11.377 2.46-11.44 2.59z' id='heart' fill='#AAB8C2'/>" +
					        			"</g></svg>" +
					        		"</label><h2>좋 아 요</h2></div></li>" +
					        "<li class='list_item'>" +
					    		"<div style ='width :100px;'>" +
					    			"<input type='checkbox' id='checkboxstar' onclick= javascript:listpage4(this.form); />" +
					        			"<label for='checkboxstar'>" +
					          				"<svg id='star-svg' viewBox='0 0 65 65' xmlns='http://www.w3.org/2000/svg'>" +
					              			"<path data-name='center-star-fill' id='checkboxstarpath' d='M22.1 46.88a.37.37 0 0 1-.37-.43l2-11.39L15.4 27a.38.38 0 0 1 .21-.64l11.44-1.67 5.11-10.37a.4.4 0 0 1 .68 0L38 24.69l11.44 1.67a.38.38 0 0 1 .21.64l-8.28 8.06 2 11.39a.34.34 0 0 1-.15.36.35.35 0 0 1-.39 0L32.5 41.46l-10.23 5.38a.33.33 0 0 1-.17.04z' fill='#AAB8C2'/>" +
					          				"</svg></label><h2>즐겨찾기</h2></li></ul></div>" +
						
						"<input type='hidden' name = 'bookmarkcontentid' class = 'bookmarkcontentid' value = '" + item.find("contentid").text() + "'>" +
						"<input type='hidden' name = 'bookmarkcontenttypeid' class = 'bookmarkcontenttypeid' value = '" + item.find("contenttypeid").text() + "'>" +
						"</form></div>"+
					"<div class=list_item_inner id ='listdetail'>"+
						"</div>" +
					"<div class=list_item_inner>" +
						"<h3><span> 추천 여행지 </span></h3>" +
						"<div class='flick_container' style='height: 150px; z-index: 1;'>"+
							"<a class='btn_direction btn_prev' id = 'recommend_prev' aria-label='이전' role='button' onclick='javascript:moverecommend(this);'>"+
							"<svg class='icon' role='presentation' version='1.1' width='9' height='16' viewBox='0 0 9 16'>"+
							"<path fill='#666666' d='M8,9v1H7v1H6v1H5v1H4v1H3v1H2v1H1v-1H0v-1h1v-1h1v-1h1v-1h1v-1h1V9 h1V7H5V6H4V5H3V4H2V3H1V2H0V1h1V0h1v1h1v1h1v1h1v1h1v1h1v1h1v1h1v2H8z'></path></svg></a>" +
							"<div><div class='flick_wrapper list_card' id = 'recommend' role='list' style='position: absolute; left: 0px; top: 0px; height: 100%; transform: translate(0px, 0px);'></div></div>" +
							"<a class='btn_direction btn_next' id = 'recommend_next' aria-label='다음' role='button' onclick='javascript:moverecommend(this);'>" +
							"<svg class='icon' role='presentation' version='1.1' width='9' height='16' viewBox='0 0 9 16'>" +
							"<path fill='#666666' d='M8,9v1H7v1H6v1H5v1H4v1H3v1H2v1H1v-1H0v-1h1v-1h1v-1h1v-1h1v-1h1V9 h1V7H5V6H4V5H3V4H2V3H1V2H0V1h1V0h1v1h1v1h1v1h1v1h1v1h1v1h1v1h1v2H8z'></path></svg></a></div>" +
							"</div>" +
					"<div class=list_item_inner>" +
						"<div><h3 style='float:left; padding-top: 8px;'>리뷰</h3><input class= 'button button5' type = 'button'  name='input1' onclick= javascript:reviewmodal(); value ='리뷰쓰기' style='margin-left : 200px'></div>" +
						"<div class='flick_container' style='height: 150px; z-index: 1;'>"+
							"<a class='btn_direction btn_prev' id = 'reviewlist_prev' aria-label='이전' role='button' onclick='javascript:move(this);'>"+
							"<svg class='icon' role='presentation' version='1.1' width='9' height='16' viewBox='0 0 9 16'>"+
							"<path fill='#666666' d='M8,9v1H7v1H6v1H5v1H4v1H3v1H2v1H1v-1H0v-1h1v-1h1v-1h1v-1h1v-1h1V9 h1V7H5V6H4V5H3V4H2V3H1V2H0V1h1V0h1v1h1v1h1v1h1v1h1v1h1v1h1v1h1v2H8z'></path></svg></a>"+
							"<div><div class='flick_wrapper list_card' id='review_list_right' role='list' style='position: absolute; left: 0px; top: 0px; height: 100%; transform: translate(0px, 0px);'></div></div>"+
							"<a class='btn_direction btn_next' id = 'reviewlist_next' aria-label='다음' role='button' onclick='javascript:move(this);'>" +
							"<svg class='icon' role='presentation' version='1.1' width='9' height='16' viewBox='0 0 9 16'>" +
							"<path fill='#666666' d='M8,9v1H7v1H6v1H5v1H4v1H3v1H2v1H1v-1H0v-1h1v-1h1v-1h1v-1h1v-1h1V9 h1V7H5V6H4V5H3V4H2V3H1V2H0V1h1V0h1v1h1v1h1v1h1v1h1v1h1v1h1v1h1v2H8z'></path></svg></a>"+
						"</div></div></div><input class='button button5' type=button value='돌아가기' onClick='detailshowhide();' style='margin-left : 250px; margin-top : 8px; margin-bottom : 8px;'></li>");
		reviewstar(contentid);
		moverecommend();
		checkboxbookmarkview(contentid);
		checkboxgoodview(contentid);
	}
</script>

<script>
	function checkboxbookmarkview(contentid){
		var id = '<%=session.getAttribute("userid")%>';
		
			$.ajax({
				url : "checkboxbookmarkview",
				type : 'get',
				datatype: 'boolean',
				data : {
					"mid" : id,
					"contentid" : contentid
					},
				success :	function(data){
					
					if(data == true){
						$("#checkbox").prop("checked", true);
						$("#checkbox").attr("title", 1);
					}else{
						$("#checkbox").prop("checked", false);
						$("#checkbox").attr("title", 0);
					}
				},
				error : function(request, status, error){ //에러 함수
					alert("ERROR");
				}
			});
		}
	
	function checkboxgoodview(contentid){
		var id = '<%=session.getAttribute("userid")%>';
		
			$.ajax({
				url : "checkboxgoodmarkview",
				type : 'get',
				datatype: 'boolean',
				data : {
					"mid" : id,
					"contentid" : contentid
					},
				success :	function(data){
					if(data == true){
						$("#checkboxstar").prop("checked", true);
						$("#checkboxstar").attr("title", 1);
					}else{
						$("#checkboxstar").prop("checked", false);
						$("#checkboxstar").attr("title", 0);
					}
				},
				error : function(request, status, error){ //에러 함수
					alert("ERROR");
				}
			});
		}

</script>

<script> // checkbox click;
	function checkboxclick(){
		$("#checkbox").change(function(){
			
			var id = '<%=session.getAttribute("userid")%>';
			if(id == 'null'){
				$("#checkbox").prop("checked", false);
				$("#checkbox").attr("title", 0);
			}
		});
		
		$("#checkboxstar").change(function(){
			
			var id = '<%=session.getAttribute("userid")%>';
			if(id == 'null'){
				$("#checkboxstar").prop("checked", false);
				$("#checkboxstar").attr("title", 0);
			}
		});
	}

</script>

<script> // 리뷰 값 가져오기

function	reviewstar(contentid){
	
	$.ajax({
		url : "reviewselectinfo",
		type : 'get',
		data : {
			"contentid" : contentid},
		success : function(data) {
			
		dt = null;
		star = null;
		list = $("#review_list_right");
		list.empty();
		
		if(data[0] == null){
			list.append("<span>방문하셔서 첫번째 리뷰를 작성해주세요.</span>")
		}
		
		for (var i = 0; i < data.length; i++) {
			
			d = data[i];
			star += d.star;
			dt = new Date(d.tourdate);
			list.append(
					"<div class='flick_content' role='listItem'>" +
						"<div class='list_item' role='listitem'>" +
							"<div class = 'txt' style='float:left; font-size:18px; margin-left : 10px; margin-right : 10px;'><strong>"+ d.mid +"</strong></div>" +
							"<div style='font-size: 13px; margin : 3px;'> (" + dt.getFullYear() + "." + (dt.getMonth() + 1) + "." + dt.getDate()+ " " + dt.getHours() + ":" + dt.getMinutes() + ":" + dt.getSeconds() + "  작성)</div>" +
							"<div class=star_area_list>" +
								"<span class=star_list> <span class=bg> <span class=value style='width: "+ d.star*20 +"%'></span></span></span> " +
								"<span class=score><em>" + d.star + "</em> / 5</span>" +
							"</div>" +
							"<div class='txtdiv' style = 'text-align: center;'>" +
								"<div class ='txtbox' style='width:228px;min-height:25px;'>"+ d.tourtext +"</div></div>" +
						"</div></div>");
			}
		move();
		},
		error : function(request, status, error) { //에러 함수
			alert("ERROR");
		}
	});
}
</script>

<script>	// review 버튼 클릭 시 review 이동 스크립트
	
	var reviewlistlength = 0;
	var recommendlistlength = 0;
	
	function move(click) {
		var leftright = $(click).attr("aria-label");
		reviewlist = document.getElementById("review_list_right");  //review의 list 객체 받아오기
		
		if(leftright == "다음"){
			reviewlistlength -= 272; 
			reviewlist.style.transform="translate("+reviewlistlength+"px , 0px)";     //왼쪽으로 이동
		}
		if(leftright == "이전"){
			reviewlistlength += 272; 
			reviewlist.style.transform="translate("+reviewlistlength+"px , 0px)"; 		//오른쪽으로 이동
		}
		
		if (reviewlist.offsetWidth < 564){
			$("#reviewlist_prev").hide();
			$("#reviewlist_next").hide();
		}else if(reviewlistlength >= 0){	//버튼 클릭 쇼 하이드
			$("#reviewlist_prev").hide();
			$("#reviewlist_next").show();
		} else if (reviewlistlength < -(reviewlist.offsetWidth - 564)){
			$("#reviewlist_next").hide();
			$("#reviewlist_prev").show();
		}
		else{
			$("#reviewlist_prev").show();
			$("#reviewlist_next").show();
		}
	}
	
	function moverecommend(click) {
		
		var leftright = $(click).attr("aria-label");
		recommendlist = document.getElementById("recommend");  //review의 list 객체 받아오기
		
		if(leftright == "다음"){
			recommendlistlength -= 282; 
			recommendlist.style.transform="translate("+recommendlistlength+"px , 0px)";     //왼쪽으로 이동
		}
		if(leftright == "이전"){
			recommendlistlength += 282; 
			recommendlist.style.transform="translate("+recommendlistlength+"px , 0px)"; 		//오른쪽으로 이동
		}
		
		if (recommendlist.offsetWidth < 564){
			$("#recommend_prev").hide();
			$("#recommend_next").hide();
		}else if(recommendlistlength >= 0){	//버튼 클릭 쇼 하이드
			$("#recommend_prev").hide();
			$("#recommend_next").show();
		} else if (recommendlistlength < -(recommendlist.offsetWidth - 564)){
			$("#recommend_next").hide();
			$("#recommend_prev").show();
		}
		else{
			$("#recommend_prev").show();
			$("#recommend_next").show();
		}
	}
</script>

<script> // 버튼 눌러서 값 가져오는 부분
function listpage1(listdata){
	
	var number = listdata.data1.value; //번호
	var contentid = listdata.data2.value; //contentid
	var contenttypeid = listdata.data3.value; //contenttypeid
		reviewlistlength = 0;
		recommendlistlength = 0;
		$.ajax({
			url : "detailedinformation",
			type : 'get',
			datatype : 'json', //respone 데이터 타입
			data : {
				"contenttype" : contenttypeid,
				"contentId" : contentid
				},
			success :	function(data){
				detailedinformat(data);
				detailedinformationlist(data);
				detailshowhide();
				listClickHandler(number);
				bookmarkrecommend();
			},
			error : function(request, status, error){ //에러 함수
				alert("ERROR");
			}
		});
}

	function listpage2(listdata){
		var listcontentid = listdata.bookmarkcontentid.value; //contentid
		var contenttypeid = listdata.bookmarkcontenttypeid.value; //contenttypeid

		var id = '<%=session.getAttribute("userid")%>';
			checkboxclick();
						
			if(id == 'null'){
				alert("로그인 후 등록해주세요.");
			}else if($("#checkbox").attr("title") == 1){
				alert("등록 취소하였습니다.");
				
				$.post("t_bookmarkdelete", {
					tourmembercode : id,
					contentid : listcontentid
					}).done(function(data, state) {
				});
				$("#checkbox").attr("title", 0);
			}else {
				alert("등록되었습니다.");
				
				$.post("t_bookmarkinfo", {
					tourmembercode : id,
					contentid : listcontentid
					}).done(function(data, state) {
				});
				$("#checkbox").attr("title", 1);
			}
	}
	
	function listpage4(listdata){
		var listcontentid = listdata.bookmarkcontentid.value; //contentid
		var contenttypeid = listdata.bookmarkcontenttypeid.value; //contenttypeid
	
		var id = '<%=session.getAttribute("userid")%>';
			checkboxclick();
			if(id == 'null'){
				alert("로그인 후 등록해주세요.");
			}else if($("#checkboxstar").attr("title") == 1){
				alert("등록 취소하였습니다.");
				
				$.post("t_goodmarkdelete", {
					tourmembercode : id,
					contentid : listcontentid
					}).done(function(data, state) {
				});
				$("#checkboxstar").attr("title", 0);
			}else {
				alert("등록되었습니다.");
				
				$.post("t_goodmarkinfo", {
					tourmembercode : id,
					contentid : listcontentid
					}).done(function(data, state) {
				});
				$("#checkboxstar").attr("title", 1);
			}
	}
	
	function listpage3(listdata){
		
		var number = listdata.data1.value; //번호
		var contentid = listdata.data2.value; //contentid
		var contenttypeid = listdata.data3.value; //contenttypeid
		reviewlistlength = 0;
		recommendlistlength = 0;		
		
		var ul1 = $("#list_place_col");
		var ul2 = $("#list_place_col1");
		  
		 if(ul2.css("display") == "none"){
			    ul2.show();
			    ul1.hide();		    
		};
		
			$.ajax({
				url : "detailedinformation",
				type : 'get',
				datatype : 'json', //respone 데이터 타입
				data : {
					"contenttype" : contenttypeid,
					"contentId" : contentid
					},
				success :	function(data){
					detailedinformat(data);
					detailedinformationlist(data);
					bookmarkrecommend();
				},
				error : function(request, status, error){ //에러 함수
					alert("ERROR");
				}
			});
	}
	
	function maplist(mapnumber){
		var test = document.getElementById("gnb_bookmark_" + mapnumber);
		
		$("#gnb_bookmark_" + mapnumber).trigger("onclick");

	}
</script>

<!--  시도 구분 -->
<script>// 시군구 api를 통해서 list를 왼쪽 폴더창에 보여줌
	function bindList(data){
		var ul = $("#list_place_col");
		var items = $(data).find("item");

			ul.empty();
			for (var i = 0; i < items.length; i++){
				item = $(items[i]);
				var title = item.find("title").text();
				
					if(item.find("title").text().length > 17){
						title = item.find("title").text().substr(0, 13);
						title = title.slice(0, 12) + "...";
					}
				
					ul.append("<li 'id'= '"+ item.find("title").text() + "' class= list_item type_restaurant>" +  
									"<div class = list_item_inner>" +
		    							"<a class= 'thumb_area fr' href= '" + item.find("firstimage").text() + "' target=_blank>" +
										"<div class= thumb style = 'z-index: 0;'>" +
											"<img src= '" + item.find("firstimage").text() + "' width='100' height='100' onerror= 'javascript:imagechage(this);'  alt=''>" +
										"</div>" +
										"</a>" +
										"<form>"+
										"<div class= info_area>" +
											"<div class= tit>" +
												"<span class=tit_inner>" +
												"<em class='alphabet' style = 'color: rgb(0, 0, 238);'>"+ (i+1) +"&nbsp;</em>"+
												"<input class = 'infoarea'  type = 'button' name='input1' value='" + title + "' onclick= javascript:listpage1(this.form);>" +
											"</input></span></div>" +
											"<div class = listid  id= 'listid_" + item.find("contentid").text() + "' title= '" + item.find("contentid").text() + "'></div>" +
												"<input type='hidden' name = 'data1' class = 'data1' value = '"+ i +"'>" +
												"<input type='hidden' name = 'data2' class = 'data2' value = '" + item.find("contentid").text() + "'>" +
												"<input type='hidden' name = 'data3' class = 'data3' value = '" + item.find("contenttypeid").text() + "'>" +
												"<input type='hidden' id='gnb_bookmark_" + i +"' onclick= javascript:listpage3(this.form); >"+
											"</div>" +
											"<input type= 'button' class='button button5' value ='개요/설명 보기' onclick= javascript:arealistvinfo(this.form);>"+
											"<input type= 'button' class='button button5' value ='홈페이지' onclick= javascript:arealishomepage(this.form);>"+
											"<div><span>콘텐츠 조회수 : " + item.find("readcount").text() + "</span></div>"+
											"</form></div></li>");
					
					$.post("t_travelapilist", {
						contentid : Number(item.find("contentid").text()),
						contenttype : Number(item.find("contenttypeid").text()),
						mapx : Number(item.find("mapx").text()),
						mapy : Number(item.find("mapy").text()),
						count : Number(item.find("readcount").text())
					}).done(function(data, state) {
					});
			}
	}		
	
	//시도 구분하기
	function bindSelsido(data) {
		var items = $(data).find("item");
		var sg = $("#selsido");
		for (var i = 0; i < items.length; i++) {
			item = $(items[i]);
			sg.append("<option value ='" + item.find("code").text() + "'>" + item.find("name").text() + "</option>");
		}
	} 

	//군구 구분하기
	function bindSelgu(data) {
		var items = $(data).find("item");
		var sg = $("#selGu");
		sg.empty();
		for (var i = 0; i < items.length; i++) {
			item = $(items[i]);
			sg.append("<option value ='" + item.find("code").text() + "'>" + item.find("name").text() + "</option>");
		}
	}	
</script>

<script>	//over 정보 주기
	function arealistvinfo(data){
		
		var number = data.data1.value; //번호
		var contentid = data.data2.value; //contentid
		var contenttypeid = data.data3.value; //contenttypeid

		var modal = document.getElementById("ovewview");
		var btn = document.getElementById("reviewbutton"); // Get the button that opens the modal
		var span = document.getElementsByClassName("modal-close")[0];         // Get the <span> element that closes the modal    
		var overviewstory = $("#ovewviewinfo");
		
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
								
		$.ajax({
			url : "overviewinformaiton",
			type : 'get',
			datatype : 'json',
			async : true,
			data : {
				"contentId" : contentid,
				"contenttype" : contenttypeid
			},
			success : function(datalist) {
				
				var items = $(datalist).find("item");
				modal.style.display = "block";
				overviewstory.empty();
				
				for (var i = 0; i < items.length; i++){
					item = $(items[i]);
					overviewstory.append(item.find("overview").text());
				}
			},error : function(request, status, error){ //에러 함수
				alert("ERROR");
			}
		});
	}
	
function arealishomepage(data){
		
		var number = data.data1.value; //번호
		var contentid = data.data2.value; //contentid
		var contenttypeid = data.data3.value; //contenttypeid

		$.ajax({
			url : "overviewinformaiton",
			type : 'get',
			datatype : 'json',
			async : true,
			data : {
				"contentId" : contentid,
				"contenttype" : contenttypeid
			},
			success : function(datalist) {
				
				var items = $(datalist).find("item");
				
				for (var i = 0; i < items.length; i++){
					item = $(items[i]);
											
						var homepagelist = item.find("homepage").text().split('<').join(',').split('>').join(',').split('"').join(',').split(',');
						
						for (var j = 0; j < homepagelist.length; j++){
							if (homepagelist[j].match('http')) {
								var homepage = homepagelist[j];
							}
					}
				}
				window.open(homepage);
			},error : function(request, status, error){ //에러 함수
				alert("ERROR");
			}
		});
	}

</script>

<!-- 최초 표현 -->
<script>
	// 최초 시도 표현
	$(function() {
	 		$.ajax({
			url : "areasidocode",
			type : 'get', // get/post 방식
			datatype : 'json', // response 데이터 타입
			success : bindSelsido,
			error : function(request, status, error){ //에러 함수
				alert("ERROR");
			}
		});
	})

// 최초 군구 표현
	$(function() {
		 	$.ajax({
			url : "areagungucode",
			type : 'get', // get/post 방식
			datatype : 'json', // response 데이터 타입,
			success : bindSelgu,
			error : function(request, status, error){ //에러 함수
				alert("ERROR");
			}
		});
	})
	
// 기본 표시 실행
	$(function(){
		$.ajax({
			url : "coordinates",
			type : 'get',
			datatype : 'json', //respone 데이터 타입
			data : {
				"areaCode" : 1, 
				"sigunguCode" : 1, 
				"contenttype" : 12
				},
			success : function(data){
				bindList(data);
				mapchange(data);
			},
			error : function(request, status, error){ //에러 함수
				alert("ERROR");
			}
		});
	})

</script>
<!-- 최초 표현 -->

<!-- 선택시 변경 -->
<script>

//시도 변경 시 군구 변경
$(function(){
	$("#selsido").on("change", function() {
		$.ajax({
			url : "areagungucode",
			type : 'get', // get/post 방식
			datatype : 'json', // response 데이터 타입
			data : {"areaCode" : this.value},
			success : bindSelgu,
			error : function(request, status, error){ //에러 함수
				alert("ERROR");
			}
		});
	});	
})

//버튼 클릭시 지도 표시
$(function(){	 
	$("#btnSearch").on("click", function() {
		var ul1 = $("#list_place_col");
		var ul2= $("#list_place_col1");
		  
		 if(ul1.css("display") == "none"){
			    ul1.show();
			    ul2.hide();		    
		};
		
		$.ajax({
			url : "coordinates",
			type : 'get',
			datatype : 'json', //respone 데이터 타입
			data : {
				"areaCode" : $("#selsido").val(), 
				"sigunguCode" : $("#selGu").val(), 
				"contenttype" : $("#contenttype").val()
				},
			success :	function(data) { // 성공함수
				bindList(data);
				mapchange(data);
			}, 
			error : function(request, status, error){ //에러 함수
				alert("ERROR");
			}
		});
	});
})
</script>
<!-- 선택시 변경 -->

<!-- 높이 자동 조정 -->
<script>
function funLoad(){
    var Cheight = $(window).height();    
    
    $('.list_area').css({'height':Cheight -140+'px'});
    $('#map').css({'height':Cheight -140+'px'});
}
window.onload = funLoad;
window.onresize = funLoad;
</script>
<!-- 높이 자동 조정 -->

<script> // 이미지 없을 시 빈이미지 출력
	function imagechage(data){
		var img = $(data).attr("img")
		if(img == null){
			$(data).attr('src', "/resources/travel/img/noimage.gif");
		}
	}
</script>

<script>	// 가입 시 추가 정보 입력 창
	function additionmemberinfo(data){
					
		var username = $("#selectusername").val(); 
		var gender = $("#selectgender").val();
		var age = $("#selectage").val();
		var phone = $("#selectphone").val();
		
		console.log(username);
		console.log(phone);
		
		if(username == '' && phone == ''){
			alert("username 또는 phone을 입력해주세요.")
		}else{
			
		$.post("t_additionmemberinfo", {
			mid : '<%=id %>',
			tmname : username,
			tmgender : gender,
			tmage : age,
			tmphone :phone
			}).done(function(data, state) {
		});
		
		var modal = document.getElementById("myadditionmemberModal");
		modal.style.display = "none";
		alert()
		}
	}
</script>

<script>	// 나이로 추천지 검색하기
	function bookmarkrecommend(){
	
		var id = '<%=id%>';
		// When the user clicks on the button, open the modal
		
		if(id == 'null'){
			$.ajax({
				url : "nologinrecommend",
				type : 'get',
				async : false,
				success : function(data) {
				
					var ullist = $("#recommend");
					ullist.empty();
				
					for (var i = 0; i < data.length; i++) {
						$.ajax({
							url : "areabase",
							type : 'get',
							data : {
								"contentid" : data[i].contentid
							},
							success : function(datalist) {
								for (var i = 0; i < datalist.length; i++) {
									overview(datalist[i].contentid, datalist[i].contenttype)
								}
							},error : function(request, status, error){ //에러 함수
								alert("ERROR");
							}
						});
					}
				}
			});
		}else{
			$.ajax({
				url : "bookmarkrecommend",
				type : 'get',
				data : {
					mid : '<%=id%>'},
				success : function(data) {
				
					var ullist = $("#recommend");
					ullist.empty();
				
					if(data[0] == null){
						ullist.append("<span>추천 검색이 없습니다.</span>");
					}else{
						for (var i = 0; i < data.length; i++) {
							$.ajax({
								url : "areabase",
								type : 'get',
								data : {
									"contentid" : data[i].contentid
								},
								success : function(datalist) {
									for (var i = 0; i < datalist.length; i++) {
										overview(datalist[i].contentid, datalist[i].contenttype)
									}
								},error : function(request, status, error){ //에러 함수
									alert("ERROR");
								}
							});
						}
					}
				}
			});
		}
	}
	
	function overview(contentid, contenttype){
		var ullist = $("#recommend");

		$.ajax({
			url : "overviewinformaiton",
			type : 'get',
			datatype : 'json',
			data : {
				"contentId" : contentid,
				"contenttype" : contenttype
			},
			success : function(datalist) {
				
				var items = $(datalist).find("item");
				
				for (var i = 0; i < items.length; i++){
					item = $(items[i]);
						ullist.append("<div class='flick_content' role='listItem'>" +
						"<div class='list_item' role='listitem'>" +
							"<div class='thumb' style='z-index: 0; text-align:center;'>" +
							"<img src= '" + item.find("firstimage").text()+ "' width='100' height='100' onerror= 'javascript:imagechage(this);' alt=''></div>"+
							"<div class='txtdiv' style='text-align: center;'><div class='txtbox' style='width:228px;min-height:25px;'>"+ item.find("title").text()+ "</div>"+
							"</div></div></div>");
				}
			},error : function(request, status, error){ //에러 함수
				alert("ERROR");
			}
		});
	};
</script>


</head>
<body class="place_list">
							
	<%if (id != null) { // 처음 로그인 시 추가 정보 입력 조건문%>
		<script>
			$(function(){
				$.ajax({
					url : "membercheck",
					type : 'get',
					data : {
						mid : '<%=id%>'},
					success : function(data) {
						if(data[0] == null){
							var modal = document.getElementById("myadditionmemberModal");
							modal.style.display = "block";
						}
					}
				});
			})
		</script>
	<%
	} else {
	}
	%>
	 <!-- Modal -->
  <div class="modal fade" id="myadditionmemberModal" role="dialog">
    <div class="modal-dialog">
    
      <!-- Modal content-->
      <form>
      <div class="modal-content">
        <div class="modal-header" style ="margin: 15px">
          <h4 class="modal-title" style="text-align: center;">여행 컨텐츠 사용 전 추가 입력을 부탁드립니다.</h4>
        </div>
        
        <div class="modal-body" style="text-align: center; margin-bottom: 8px;">
        	<p>이름 입력 : <input id="selectusername" name="selectusername" type="text" required/></p>
        </div>
        
        <div class="modal-body" style="margin-bottom: 8px;">
        	<div style="padding-left :100px; width:200px; float:left; margin:0 auto; text-align:center;">성별 입력 :  
  				<select id ="selectgender" style="margin-right :5px" >
					<option value="남">남</option>
					<option value="여">여</option>
				</select></div>
			
			<div >나이 입력 :  
  				<select id ="selectage" >
  					<c:forEach var="i" begin="1" end="100" step="1">
				      <option value = "${i}">${i}</option>
    				</c:forEach>
				</select></div>	
        </div>
        
        <div class="modal-body" style="text-align: center; margin-bottom: 8px;">
        	<p>전화번호 입력 : <input id="selectphone" name="selectphone" type="text" required/></p>
        </div>
        
        <div class="modal-footer" style="text-align: right;">
        	<input id="addtionmember" type="button"  style="margin: 5px;" value ="추가 정보 입력" onclick="javascript:additionmemberinfo(this.form)">
        </div>
      </div> 
      </form>
    </div>
  </div>

	
	<div id = "modal-content">
    	<div id="ovewview" class="modal">
	 		<!-- Modal content -->
	 		<div class="modal-content">	
	 			<div style="text-align: center; margin: 5px">
        			<span class="modal-close">&times;</span>
	 				<h3 >개요 / 설명</h3>
        		</div>							                                                           
        		<div class = "reviewmaincontaier"> 
        			<div class="tile user-tile">
        				<div class="user-indent">
        					<div class="user-name" id = "ovewviewinfo"></div>
        				</div>
        			</div>
        		</div>
			</div>
		</div>
	</div>
	
	<!-- header 부분 -->
	<header id= "header" role="banner">
			<jsp:include page="topheader.jsp" flush="false"/>
	</header>
	<!-- header 부분 -->

	<!-- container 부분 -->
	<div id="container" role="main" data-reactroot="">
		<!-- 필터 부분 -->
		<div class="filter_area" style="z-index: 1;">
			<div class = "filter_group type_restaurant">
				<strong class="filter_label"><span>시</span></strong>
				<div class ="filter_group_inner">
					<select id="selsido" ></select>
				</div>
				
				<strong class="filter_label"><span>군구</span></strong>
				<div class ="filter_group_inner">
					<select id ="selGu"></select>
				</div>
				
				<strong class="filter_label"><span>타입</span></strong>
				<div class ="filter_group_inner">
					<select id ="contenttype" >
						<option value="12">관광지</option>
						<option value="14">문화시설</option>
						<option value="15">행사/공연/축제</option>
						<option value="25">여행코스</option>
						<option value="28">레포츠</option>
						<option value="32">숙박</option>
						<option value="38">쇼핑</option> 
						<option value="39">음식점</option>  
					</select>
				</div>
				<button type="button" id="btnSearch" class="btn btn-default">SEARCH</button>
			</div>
		</div>
		<!-- 필터 부분 -->
		
		<!-- list 부분 -->
		<div class="placemap_area">
			<div class="list_wrapper" style="width: 401px;">
				<div class="list_area" style="height: 700px; overflow-y: auto; list_item: z-index: 0;">
					<ul class="list_place_col1" id ="list_place_col"></ul>
					<ul class="list_place_col1" id ="list_place_col1" style="display: none;"></ul>
					
						<!-- 리  뷰 -->
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
        									                                                           
        									<div class = "reviewmaincontaier" style="text-align:center;"> 
        										<div class="tile user-tile">
        												<div class="user-indent">
        													<div class="user-name"><%=id %>님 리뷰를 작성해주세요.</div>
        												</div>
        										</div>
        									
        										<div class="tile rating-tile">
        											<div aria-label="별표 평점"  tabindex="0" jstcache="13" class="rating-indent rating rating-actionable" style="text-align:center; -moz-user-select: none;">
        												<span class="rating" id="mainstar" title="0">
        													<span aria-label="1성급" id="star1" role="button" tabindex="0" jstcache="14" class="rating-star" aria-checked="false" aria-pressed="false"></span>
        													<span aria-label="2성급" id="star2" role="button" tabindex="0" jstcache="15" class="rating-star" aria-checked="false" aria-pressed="false"></span>
        													<span aria-label="3성급" id="star3" role="button" tabindex="0" jstcache="16" class="rating-star" aria-checked="false" aria-pressed="false"></span>
        													<span aria-label="4성급" id="star4" role="button" tabindex="0" jstcache="17" class="rating-star" aria-checked="false" aria-pressed="false"></span>
        													<span aria-label="5성급" id="star5" role="button" tabindex="0" jstcache="18" class="rating-star" aria-checked="false" aria-pressed="false"></span>
        												</span> </div> </div>
        										</div>
        									
        										<div class="mobile-scrollable-fill" style="text-align:center;">
        											<div class="tile review-text-tile-with-add-photo" >
        												<div class="review-text-indent">
        													<textarea placeholder="이 장소에서의 경험을 자세히 공유하세요." class="review-text" id="textarea-text" style="height: 120px;"></textarea>
        												</div>
        											</div>
        										</div>
        										
        										<div class = "reviewputipcancel" style="text-align: right;">
        											<input id="reviewputup" type="button"  style="margin: 5px; " value ="리뷰 쓰기" onclick="javascript:reviewinsert(this.form)">
        										</div>
        									
        									</div></div></div></form>
		</div>
		<!-- list 부분 -->
		
				<!-- list 창 접기 -->
				<a id="btn_fold_list" class="btn_fold_list" aria-label="목록영역접기"
					href="javascript:void(0)" target="_self" style="display: block;"
					onclick="this.parentNode.style.width='0px'; this.style.display ='none'; document.getElementById('btn_fold_list_folded').style.display ='block';">
					<svg class="icon" version="1.1" width="11" height="7" viewBox="0 0 11 7">
						<path d="M5.5,6.846l-5.53-5.53L1.03,0.255L5.5,4.725l4.47-4.469l1.061,1.061L5.5,6.846z"></path></svg></a>
				 <a id="btn_fold_list_folded" class="btn_fold_list folded"
					aria-label="목록영역 접기" href="javascript:void(0)" target="_self"
					style="display: none;"
					onclick="this.parentNode.style.width='401px'; this.style.display ='none'; document.getElementById('btn_fold_list').style.display ='block';">
					<svg class="icon" version="1.1" width="11" height="7" viewBox="0 0 11 7">
						<path d="M5.5,6.846l-5.53-5.53L1.03,0.255L5.5,4.725l4.47-4.469l1.061,1.061L5.5,6.846z"></path></svg></a>
				
				<!-- list 창 접기 -->	
			</div>
			
			<!--  지도 창 -->
			<div class ="map_wrapper _list_dynamic_map_wrapper">
				<div class = "map_area type_dynamic _map_area">
						<div align="center">
							<div ></div>
							<div id="map" style="align-items: center; width: 100%; height: 1100px;"></div>
						</div>
				</div>
			</div>
			<!--  지도 창 -->
			
		</div>
	</div>
	<!-- container 부분 -->
	
</body>
</html>