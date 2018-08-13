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

<link rel="stylesheet" type="text/css" href="./resources/css/app.d6157d9993ceb446bea8.css">
<link rel ="stylesheet" id="gnb_style" type="text/css" href="./resources/css/gnb.css">

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
				'       <img src="'+ item.find("firstimage").text()+ '"width="55" height="55" alt="'+ item.find("title").text()+ '" class="thumb" /><br />',
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
			        	url: HOME_PATH +'/resources/img/food2.png',
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
	
	// 마커 클릭시 값 가져오기
</script>
<script>
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

<!--  list 표시 -->
<script>
	function detailedinformat(number){
		var ul = $("#list_place_col1");
		detailshowhide();
		
		ul.empty();
		
		ul.append(
				"<li class=list_item type_restaurant=''>" +
						"<div class=list_item_inner id ='listdetail'>"+
						"</div>" +
					"<div class=list_item_inner>" +
						"</div>" +
					"<div class=list_item_inner>" +
						"<h3><span> 함께 검색한 장소 </span></h3>" +
						"</div>" +
					"<div class=list_item_inner>" +
						"<h3>리뷰</h3>" +
						"<div class='star_area'>" +
							"<span class='star'>" +
								"<span class='bg'>"+
								"<span class='value' style='width:86%'></span></span></span>"+
								"<span class='score'><em>4.3</em> / 5</span></div>" +
								"<input type = 'button' value = '리뷰 더 보기' style='text-align: center;' />" +
						"</div><button onclick = javascript:detailshowhide()>돌아가기</button></li>");
	}
	
</script>

<!-- api list 표시 -->
<script>
	function detailedinformationlist(data){
		var item = $(data).find("item");
		var contenttypeid = item.find("contenttypeid").text();
				

		var ullist = $("#listdetail");
		ullist.empty();
				
		if(item.find("accomcount").text() != '' && item.find("accomcount").text() != '0'){ullist.append("<span>수용인원 : " + item.find("accomcount").text()+ "</span></br>")};
		if(item.find("chkbabycarriage").text() != '' && item.find("chkbabycarriage").text() != '0'){ullist.append("<span>유모차대여 정보 : " + item.find("chkbabycarriage").text()+ "</span></br>")};
		if(item.find("chkcreditcard").text() != '' && item.find("chkcreditcard").text() != '0'){ullist.append("<span>신용카드가능 정보 : " + item.find("chkcreditcard").text()+ "</span></br>")};
		if(item.find("chkpet").text() != '' && item.find("chkpet").text() != '0'){ullist.append("<span>애완동물동반가능 정보 : " + item.find("chkpet").text()+ "</span></br>")};
		if(item.find("expagerange").text() != '' && item.find("expagerange").text() != '0'){ullist.append("<span>체험가능 연령 : " + item.find("expagerange").text()+ "</span></br>")};
		if(item.find("expguide").text() != '' && item.find("expguide").text() != '0'){ullist.append("<span>체험안내 : " + item.find("expguide").text()+ "</span></br>")};
		if(item.find("heritage1").text() != '' && item.find("heritage1").text() != '0'){ullist.append("<span>세계 문화유산 유무 : " + item.find("heritage1").text()+ "</span></br>")};
		if(item.find("heritage2").text() != '' && item.find("heritage2").text() != '0'){ullist.append("<span>세계 자연유산 유무 : " + item.find("heritage2").text()+ "</span></br>")};
		if(item.find("heritage3").text() != '' && item.find("heritage3").text() != '0'){ullist.append("<span>세계 기록유산 유무 : " + item.find("heritage3").text()+ "</span></br>")};
		if(item.find("infocenter").text() != '' && item.find("infocenter").text() != '0'){ullist.append("<span>문의 및 안내 : " + item.find("infocenter").text()+ "</span></br>")};
		if(item.find("opendate").text() != '' && item.find("opendate").text() != '0'){ullist.append("<span>개장일 : " + item.find("opendate").text()+ "</span></br>")};
		if(item.find("parking").text() != '' && item.find("parking").text() != '0'){ullist.append("<span>주차시설 : " + item.find("parking").text()+ "</span></br>")};
		if(item.find("restdate").text() != '' && item.find("restdate").text() != '0'){ullist.append("<span>쉬는날 : " + item.find("restdate").text()+ "</span></br>")};
		if(item.find("useseason").text() != '' && item.find("useseason").text() != '0'){ullist.append("<span>이용시기 : " + item.find("useseason").text()+ "</span></br>")};
		if(item.find("usetime").text() != '' && item.find("usetime").text() != '0'){ullist.append("<span>이용시간 : " + item.find("usetime").text()+ "</span></br>")};
		if(item.find("accomcountculture").text() != '' && item.find("accomcountculture").text() != '0'){ullist.append("<span>수용인원 : " + item.find("accomcountculture").text()+ "</span></br>")};
		if(item.find("chkbabycarriage culture").text() != '' && item.find("chkbabycarriage culture").text() != '0'){ullist.append("<span>유모차대여 정보 : " + item.find("chkbabycarriage culture").text()+ "</span></br>")};
		if(item.find("chkcreditcardculture").text() != '' && item.find("chkcreditcardculture").text() != '0'){ullist.append("<span>신용카드가능 정보 : " + item.find("chkcreditcardculture").text()+ "</span></br>")};
		if(item.find("chkpetculture").text() != '' && item.find("chkpetculture").text() != '0'){ullist.append("<span>애완동물동반가능 정보 : " + item.find("chkpetculture").text()+ "</span></br>")};
		if(item.find("discountinfo").text() != '' && item.find("discountinfo").text() != '0'){ullist.append("<span>할인정보 : " + item.find("discountinfo").text()+ "</span></br>")};
		if(item.find("infocenterculture").text() != '' && item.find("infocenterculture").text() != '0'){ullist.append("<span>문의 및 안내 : " + item.find("infocenterculture").text()+ "</span></br>")};
		if(item.find("parkingculture").text() != '' && item.find("parkingculture").text() != '0'){ullist.append("<span>주차시설 : " + item.find("parkingculture").text()+ "</span></br>")};
		if(item.find("parkingfee").text() != '' && item.find("parkingfee").text() != '0'){ullist.append("<span>주차요금 : " + item.find("parkingfee").text()+ "</span></br>")};
		if(item.find("restdateculture").text() != '' && item.find("restdateculture").text() != '0'){ullist.append("<span>쉬는날 : " + item.find("restdateculture").text()+ "</span></br>")};
		if(item.find("usefee").text() != '' && item.find("usefee").text() != '0'){ullist.append("<span>이용요금 : " + item.find("usefee").text()+ "</span></br>")};
		if(item.find("usetimeculture").text() != '' && item.find("usetimeculture").text() != '0'){ullist.append("<span>이용시간 : " + item.find("usetimeculture").text()+ "</span></br>")};
		if(item.find("scale").text() != '' && item.find("scale").text() != '0'){ullist.append("<span>규모 : " + item.find("scale").text()+ "</span></br>")};
		if(item.find("spendtime").text() != '' && item.find("spendtime").text() != '0'){ullist.append("<span>관람 소요시간 : " + item.find("spendtime").text()+ "</span></br>")};
		if(item.find("agelimit").text() != '' && item.find("agelimit").text() != '0'){ullist.append("<span>관람 가능연령 : " + item.find("agelimit").text()+ "</span></br>")};
		if(item.find("bookingplace").text() != '' && item.find("bookingplace").text() != '0'){ullist.append("<span>예매처 : " + item.find("bookingplace").text()+ "</span></br>")};
		if(item.find("discountinfofestival").text() != '' && item.find("discountinfofestival").text() != '0'){ullist.append("<span>할인정보 : " + item.find("discountinfofestival").text()+ "</span></br>")};
		if(item.find("eventenddate").text() != '' && item.find("eventenddate").text() != '0'){ullist.append("<span>행사 종료일 : " + item.find("eventenddate").text()+ "</span></br>")};
		if(item.find("eventhomepage").text() != '' && item.find("eventhomepage").text() != '0'){ullist.append("<span>행사 홈페이지 : " + item.find("eventhomepage").text()+ "</span></br>")};
		if(item.find("eventplace").text() != '' && item.find("eventplace").text() != '0'){ullist.append("<span>행사 장소 : " + item.find("eventplace").text()+ "</span></br>")};
		if(item.find("eventstartdate").text() != '' && item.find("eventstartdate").text() != '0'){ullist.append("<span>행사 시작일 : " + item.find("eventstartdate").text()+ "</span></br>")};
		if(item.find("festivalgrade").text() != '' && item.find("festivalgrade").text() != '0'){ullist.append("<span>축제등급 : " + item.find("festivalgrade").text()+ "</span></br>")};
		if(item.find("placeinfo").text() != '' && item.find("placeinfo").text() != '0'){ullist.append("<span>행사장 위치안내 : " + item.find("placeinfo").text()+ "</span></br>")};
		if(item.find("playtime").text() != '' && item.find("playtime").text() != '0'){ullist.append("<span>공연시간 : " + item.find("playtime").text()+ "</span></br>")};
		if(item.find("program").text() != '' && item.find("program").text() != '0'){ullist.append("<span>행사 프로그램 : " + item.find("program").text()+ "</span></br>")};
		if(item.find("spendtimefestival").text() != '' && item.find("spendtimefestival").text() != '0'){ullist.append("<span>관람 소요시간 : " + item.find("spendtimefestival").text()+ "</span></br>")};
		if(item.find("sponsor1").text() != '' && item.find("sponsor1").text() != '0'){ullist.append("<span>주최자 정보 : " + item.find("sponsor1").text()+ "</span></br>")};
		if(item.find("sponsor1tel").text() != '' && item.find("sponsor1tel").text() != '0'){ullist.append("<span>주최자 연락처 : " + item.find("sponsor1tel").text()+ "</span></br>")};
		if(item.find("sponsor2").text() != '' && item.find("sponsor2").text() != '0'){ullist.append("<span>주관사 정보 : " + item.find("sponsor2").text()+ "</span></br>")};
		if(item.find("sponsor2tel").text() != '' && item.find("sponsor2tel").text() != '0'){ullist.append("<span>주관사 연락처 : " + item.find("sponsor2tel").text()+ "</span></br>")};
		if(item.find("subevent").text() != '' && item.find("subevent").text() != '0'){ullist.append("<span>부대행사 : " + item.find("subevent").text()+ "</span></br>")};
		if(item.find("usetimefestival").text() != '' && item.find("usetimefestival").text() != '0'){ullist.append("<span>이용요금 : " + item.find("usetimefestival").text()+ "</span></br>")};
		if(item.find("distance").text() != '' && item.find("distance").text() != '0'){ullist.append("<span>코스 총거리 : " + item.find("distance").text()+ "</span></br>")};
		if(item.find("infocentertour course").text() != '' && item.find("infocentertour course").text() != '0'){ullist.append("<span>문의 및 안내 : " + item.find("infocentertour course").text()+ "</span></br>")};
		if(item.find("schedule").text() != '' && item.find("schedule").text() != '0'){ullist.append("<span>코스 일정 : " + item.find("schedule").text()+ "</span></br>")};
		if(item.find("taketime").text() != '' && item.find("taketime").text() != '0'){ullist.append("<span>코스 총 소요 시간 : " + item.find("taketime").text()+ "</span></br>")};
		if(item.find("theme").text() != '' && item.find("theme").text() != '0'){ullist.append("<span>코스 테마 : " + item.find("theme").text()+ "</span></br>")};
		if(item.find("accomcountleports").text() != '' && item.find("accomcountleports").text() != '0'){ullist.append("<span>수용인원 : " + item.find("accomcountleports").text()+ "</span></br>")};
		if(item.find("chkbabycarriageleports").text() != '' && item.find("chkbabycarriageleports").text() != '0'){ullist.append("<span>유모차대여 정보 : " + item.find("chkbabycarriageleports").text()+ "</span></br>")};
		if(item.find("chkcreditcardleports").text() != '' && item.find("chkcreditcardleports").text() != '0'){ullist.append("<span>신용카드가능 정보 : " + item.find("chkcreditcardleports").text()+ "</span></br>")};
		if(item.find("chkpetleports").text() != '' && item.find("chkpetleports").text() != '0'){ullist.append("<span>애완동물동반가능 정보 : " + item.find("chkpetleports").text()+ "</span></br>")};
		if(item.find("expagerangeleports").text() != '' && item.find("expagerangeleports").text() != '0'){ullist.append("<span>체험 가능연령 : " + item.find("expagerangeleports").text()+ "</span></br>")};
		if(item.find("infocenterleports").text() != '' && item.find("infocenterleports").text() != '0'){ullist.append("<span>문의 및 안내 : " + item.find("infocenterleports").text()+ "</span></br>")};
		if(item.find("openperiod").text() != '' && item.find("openperiod").text() != '0'){ullist.append("<span>개장기간 : " + item.find("openperiod").text()+ "</span></br>")};
		if(item.find("parkingfeeleports").text() != '' && item.find("parkingfeeleports").text() != '0'){ullist.append("<span>주차요금 : " + item.find("parkingfeeleports").text()+ "</span></br>")};
		if(item.find("parkingleports").text() != '' && item.find("parkingleports").text() != '0'){ullist.append("<span>주차시설 : " + item.find("parkingleports").text()+ "</span></br>")};
		if(item.find("reservation").text() != '' && item.find("reservation").text() != '0'){ullist.append("<span>예약안내 : " + item.find("reservation").text()+ "</span></br>")};
		if(item.find("restdateleports").text() != '' && item.find("restdateleports").text() != '0'){ullist.append("<span>쉬는날 : " + item.find("restdateleports").text()+ "</span></br>")};
		if(item.find("scaleleports").text() != '' && item.find("scaleleports").text() != '0'){ullist.append("<span>규모 : " + item.find("scaleleports").text()+ "</span></br>")};
		if(item.find("usefeeleports").text() != '' && item.find("usefeeleports").text() != '0'){ullist.append("<span>입장료 : " + item.find("usefeeleports").text()+ "</span></br>")};
		if(item.find("usetimeleports").text() != '' && item.find("usetimeleports").text() != '0'){ullist.append("<span>이용시간 : " + item.find("usetimeleports").text()+ "</span></br>")};
		if(item.find("accomcountlodging").text() != '' && item.find("accomcountlodging").text() != '0'){ullist.append("<span>수용 가능인원 : " + item.find("accomcountlodging").text()+ "</span></br>")};
		if(item.find("benikia").text() != '' && item.find("benikia").text() != '0'){ullist.append("<span>베니키아 여부 : " + item.find("benikia").text()+ "</span></br>")};
		if(item.find("chekintime").text() != '' && item.find("chekintime").text() != '0'){ullist.append("<span>입실 시간 : " + item.find("chekintime").text()+ "</span></br>")};
		if(item.find("checkouttime").text() != '' && item.find("checkouttime").text() != '0'){ullist.append("<span>퇴실 시간 : " + item.find("checkouttime").text()+ "</span></br>")};
		if(item.find("chkcooking").text() != '' && item.find("chkcooking").text() != '0'){ullist.append("<span>객실내 취사 여부 : " + item.find("chkcooking").text()+ "</span></br>")};
		if(item.find("foodplace").text() != '' && item.find("foodplace").text() != '0'){ullist.append("<span>식음료장 : " + item.find("foodplace").text()+ "</span></br>")};
		if(item.find("goodstay").text() != '' && item.find("goodstay").text() != '0'){ullist.append("<span>굿스테이 여부 : " + item.find("goodstay").text()+ "</span></br>")};
		if(item.find("hanok").text() != '' && item.find("hanok").text() != '0'){ullist.append("<span>한옥 여부 : " + item.find("hanok").text()+ "</span></br>")};
		if(item.find("infocenterlodging").text() != '' && item.find("infocenterlodging").text() != '0'){ullist.append("<span>문의 및 안내 : " + item.find("infocenterlodging").text()+ "</span></br>")};
		if(item.find("parkingloding").text() != '' && item.find("parkingloding").text() != '0'){ullist.append("<span>CLOB : " + item.find("parkingloding").text()+ "</span></br>")};
		if(item.find("pickup").text() != '' && item.find("pickup").text() != '0'){ullist.append("<span>픽업 서비스 : " + item.find("pickup").text()+ "</span></br>")};
		if(item.find("roomcount").text() != '' && item.find("roomcount").text() != '0'){ullist.append("<span>객실수 : " + item.find("roomcount").text()+ "</span></br>")};
		if(item.find("reservationlodging").text() != '' && item.find("reservationlodging").text() != '0'){ullist.append("<span>예약안내 : " + item.find("reservationlodging").text()+ "</span></br>")};
		if(item.find("reservationlodging").text() != '' && item.find("reservationlodging").text() != '0'){ullist.append("<span>예약안내 홈페이지 : " + item.find("reservationlodging").text()+ "</span></br>")};
		if(item.find("roomtype").text() != '' && item.find("roomtype").text() != '0'){ullist.append("<span>객실유형 : " + item.find("roomtype").text()+ "</span></br>")};
		if(item.find("scalelodging").text() != '' && item.find("scalelodging").text() != '0'){ullist.append("<span>규모 : " + item.find("scalelodging").text()+ "</span></br>")};
		if(item.find("subfacility").text() != '' && item.find("subfacility").text() != '0'){ullist.append("<span>부대시설 (기타) : " + item.find("subfacility").text()+ "</span></br>")};
		if(item.find("barbecue").text() != '' && item.find("barbecue").text() != '0'){ullist.append("<span>바비큐장 여부 : " + item.find("barbecue").text()+ "</span></br>")};
		if(item.find("beauty").text() != '' && item.find("beauty").text() != '0'){ullist.append("<span>뷰티시설 정보 : " + item.find("beauty").text()+ "</span></br>")};
		if(item.find("beverage").text() != '' && item.find("beverage").text() != '0'){ullist.append("<span>식음료장 여부 : " + item.find("beverage").text()+ "</span></br>")};
		if(item.find("bicycle").text() != '' && item.find("bicycle").text() != '0'){ullist.append("<span>자전거 대여 여부 : " + item.find("bicycle").text()+ "</span></br>")};
		if(item.find("campfire").text() != '' && item.find("campfire").text() != '0'){ullist.append("<span>캠프파이어 여부 : " + item.find("campfire").text()+ "</span></br>")};
		if(item.find("fitness").text() != '' && item.find("fitness").text() != '0'){ullist.append("<span>휘트니스 센터 여부 : " + item.find("fitness").text()+ "</span></br>")};
		if(item.find("karaoke").text() != '' && item.find("karaoke").text() != '0'){ullist.append("<span>노래방 여부 : " + item.find("karaoke").text()+ "</span></br>")};
		if(item.find("publicbath").text() != '' && item.find("publicbath").text() != '0'){ullist.append("<span>공용 샤워실 여부 : " + item.find("publicbath").text()+ "</span></br>")};
		if(item.find("publicpc").text() != '' && item.find("publicpc").text() != '0'){ullist.append("<span>공동 PC실 여부 : " + item.find("publicpc").text()+ "</span></br>")};
		if(item.find("sauna").text() != '' && item.find("sauna").text() != '0'){ullist.append("<span>사우나실 여부 : " + item.find("sauna").text()+ "</span></br>")};
		if(item.find("seminar").text() != '' && item.find("seminar").text() != '0'){ullist.append("<span>세미나실 여부 : " + item.find("seminar").text()+ "</span></br>")};
		if(item.find("sports").text() != '' && item.find("sports").text() != '0'){ullist.append("<span>스포츠 시설 여부 : " + item.find("sports").text()+ "</span></br>")};
		if(item.find("chkbabycarriageshopping").text() != '' && item.find("chkbabycarriageshopping").text() != '0'){ullist.append("<span>유모차대여 정보 : " + item.find("chkbabycarriageshopping").text()+ "</span></br>")};
		if(item.find("chkcreditcardshopping").text() != '' && item.find("chkcreditcardshopping").text() != '0'){ullist.append("<span>신용카드가능 정보 : " + item.find("chkcreditcardshopping").text()+ "</span></br>")};
		if(item.find("chkpetshopping").text() != '' && item.find("chkpetshopping").text() != '0'){ullist.append("<span>애완동물동반가능 정보 : " + item.find("chkpetshopping").text()+ "</span></br>")};
		if(item.find("culturecenter").text() != '' && item.find("culturecenter").text() != '0'){ullist.append("<span>문화센터 바로가기 : " + item.find("culturecenter").text()+ "</span></br>")};
		if(item.find("fairday").text() != '' && item.find("fairday").text() != '0'){ullist.append("<span>장서는 날 : " + item.find("fairday").text()+ "</span></br>")};
		if(item.find("infocentershopping").text() != '' && item.find("infocentershopping").text() != '0'){ullist.append("<span>문의 및 안내 : " + item.find("infocentershopping").text()+ "</span></br>")};
		if(item.find("opendateshopping").text() != '' && item.find("opendateshopping").text() != '0'){ullist.append("<span>개장일 : " + item.find("opendateshopping").text()+ "</span></br>")};
		if(item.find("opentime").text() != '' && item.find("opentime").text() != '0'){ullist.append("<span>영업시간 : " + item.find("opentime").text()+ "</span></br>")};
		if(item.find("parkingshopping").text() != '' && item.find("parkingshopping").text() != '0'){ullist.append("<span>주차시설 : " + item.find("parkingshopping").text()+ "</span></br>")};
		if(item.find("restdateshopping").text() != '' && item.find("restdateshopping").text() != '0'){ullist.append("<span>쉬는날 : " + item.find("restdateshopping").text()+ "</span></br>")};
		if(item.find("restroom").text() != '' && item.find("restroom").text() != '0'){ullist.append("<span>화장실 설명 : " + item.find("restroom").text()+ "</span></br>")};
		if(item.find("saleitem").text() != '' && item.find("saleitem").text() != '0'){ullist.append("<span>판매 품목 : " + item.find("saleitem").text()+ "</span></br>")};
		if(item.find("sleitemcost").text() != '' && item.find("sleitemcost").text() != '0'){ullist.append("<span>판매 품목별 가격 : " + item.find("sleitemcost").text()+ "</span></br>")};
		if(item.find("scaleshopping").text() != '' && item.find("scaleshopping").text() != '0'){ullist.append("<span>규모 : " + item.find("scaleshopping").text()+ "</span></br>")};
		if(item.find("shopguide").text() != '' && item.find("shopguide").text() != '0'){ullist.append("<span>매장안내 : " + item.find("shopguide").text()+ "</span></br>")};
		if(item.find("chkcreditcrdfood").text() != '' && item.find("chkcreditcrdfood").text() != '0'){ullist.append("<span>신용카드가능 정보 : " + item.find("chkcreditcrdfood").text()+ "</span></br>")};
		if(item.find("discountinfofood").text() != '' && item.find("discountinfofood").text() != '0'){ullist.append("<span>할인정보 : " + item.find("discountinfofood").text()+ "</span></br>")};
		if(item.find("firstmenu").text() != '' && item.find("firstmenu").text() != '0'){ullist.append("<span>대표 메뉴 : " + item.find("firstmenu").text()+ "</span></br>")};
		if(item.find("infocenterfood").text() != '' && item.find("infocenterfood").text() != '0'){ullist.append("<span>문의 및 안내 : " + item.find("infocenterfood").text()+ "</span></br>")};
		if(item.find("kidsfacility").text() != '' && item.find("kidsfacility").text() != '0'){ullist.append("<span>어린이 놀이방 여부 : " + item.find("kidsfacility").text()+ "</span></br>")};
		if(item.find("opendatefood").text() != '' && item.find("opendatefood").text() != '0'){ullist.append("<span>개업일 : " + item.find("opendatefood").text()+ "</span></br>")};
		if(item.find("opentimefood").text() != '' && item.find("opentimefood").text() != '0'){ullist.append("<span>영업시간 : " + item.find("opentimefood").text()+ "</span></br>")};
		if(item.find("packing").text() != '' && item.find("packing").text() != '0'){ullist.append("<span>포장 가능 : " + item.find("packing").text()+ "</span></br>")};
		if(item.find("parkingfood").text() != '' && item.find("parkingfood").text() != '0'){ullist.append("<span>주차시설 : " + item.find("parkingfood").text()+ "</span></br>")};
		if(item.find("reservationfood").text() != '' && item.find("reservationfood").text() != '0'){ullist.append("<span>예약안내 : " + item.find("reservationfood").text()+ "</span></br>")};
		if(item.find("restdatefood").text() != '' && item.find("restdatefood").text() != '0'){ullist.append("<span>쉬는날 : " + item.find("restdatefood").text()+ "</span></br>")};
		if(item.find("scalefood").text() != '' && item.find("scalefood").text() != '0'){ullist.append("<span>규모 : " + item.find("scalefood").text()+ "</span></br>")};
		if(item.find("seat").text() != '' && item.find("seat").text() != '0'){ullist.append("<span>좌석수 : " + item.find("seat").text()+ "</span></br>")};
		if(item.find("smoking").text() != '' && item.find("smoking").text() != '0'){ullist.append("<span>금연/흡연 여부 : " + item.find("smoking").text()+ "</span></br>")};
		if(item.find("treatmenu").text() != '' && item.find("treatmenu").text() != '0'){ullist.append("<span>취급 메뉴 : " + item.find("treatmenu").text()+ "</span></br>")};	
	}
</script>

<script>

function listpage1(listdata){
	var number = listdata.data1.value; //번호
	var contentid = listdata.data2.value; //contentid
	var contenttypeid = listdata.data3.value; //contenttypeid
	
		$.ajax({
			url : "detailedinformation",
			type : 'get',
			datatype : 'json', //respone 데이터 타입
			data : {
				"contenttype" : contenttypeid,
				"contentId" : contentid
				},
			success :	function(data){
				detailedinformat(number);
				detailedinformationlist(data);
				listClickHandler(number);
			},
			error : function(request, status, error){ //에러 함수
				alert("ERROR");
			}
		});
}

	function listpage2(listdata){
		var number = listdata.data1.value; //번호
		var listcontentid = listdata.data2.value; //contentid
		var contenttypeid = listdata.data3.value; //contenttypeid
	
		var id = '<%=session.getAttribute("userid")%>';
			console.log(id);
			if(id == 'null'){
				alert("로그인 후 등록해주세요.");
			}else {
				alert("등록되었습니다.");
				
				$.post("t_bookmarkinfo", {
					tourmembercode : id,
					contentid : listcontentid
					}).done(function(data, state) {
					});
			}
	}
</script>

<!--  시도 구분 -->
<script>
	// 시군구 api를 통해서 list를 왼쪽 폴더창에 보여줌
	function bindList(data){
		var ul = $("#list_place_col");
		var items = $(data).find("item");
			ul.empty();
			for (var i = 0; i < items.length; i++){
				item = $(items[i]);
				
					ul.append("<li 'id'= '"+ item.find("title").text() + "' class= list_item type_restaurant>" +  
									"<div class = list_item_inner>" +
		    							"<a id = '_sls.img' class= 'thumb_area fr' href= '" + item.find("firstimage").text() + "' target=_blank>" +
										"<div class= thumb>" +
											"<img src='" + item.find("firstimage").text() + "' alt= '"+ item.find("title").text()+ "' width='100' height='100'>" +
										"</div>" +
										"</a>" +
										"<form name ='form_"+ i +"' type = 'get'>"+
										"<div class= info_area>" +
											"<div class= tit>" +
												"<span class=tit_inner>" +
												"<input class = 'infoarea' type = 'button'  name='input1' value='" + item.find("title").text() + "' onclick= javascript:listpage1(this.form);>" +
											"</input></span></div>" +
											"<div class = listid  id= 'listid_" + item.find("contentid").text() + "' title= '" + item.find("contentid").text() + "'></div>" +
												"<input class= 'gnb_btn_bookmark' name='input2' type= 'button'  value ='즐겨찾기' onclick= javascript:listpage2(this.form);  id='gnb_bookmark_" + i +"'>" +
												"<input type='hidden' name = 'data1' class = 'data1' value = '"+ i +"'>" +
												"<input type='hidden' name = 'data2' class = 'data2' value = '" + item.find("contentid").text() + "'>" +
												"<input type='hidden' name = 'data3' class = 'data3' value = '" + item.find("contenttypeid").text() + "'>" +
											"</div></form>" +
											"<div><span>콘텐츠 조회수 : " + item.find("readcount").text() + "</span></div>"+
											"</div></li>");
					
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

</head>
<body class="place_list">
	<!-- header 부분 -->
	<header id= "header" role="banner">
			<jsp:include page="topheader.jsp" flush="false"/>
	</header>
	<!-- header 부분 -->

	<!-- container 부분 -->
	<div id="container" role="main" data-reactroot="">
		<!-- 필터 부분 -->
		<div class="filter_area">
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
				<div class="list_area" style="height: 700px; overflow-y: auto;">
					<ul class="list_place_col1" id ="list_place_col"></ul>
					<ul class="list_place_col1" id ="list_place_col1" style="display: none;"></ul>
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