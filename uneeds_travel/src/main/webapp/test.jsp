<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
 <title>Html5around.com에 오신걸 환영합니다.</title>
<script>
  var roundPicture;                                           //이미지를 받을 변수
  var imgWidth,imgHeight;                                     //이미지 크기 변수
  var winWidth,winHeight;                                     //화면 안쪽 크기
 var mvX=27,mvY=27;                                          //x,y축으로 27px씩 이동
 var mvCircle=0;                                             //회전 각도
 var timeCount=0;                                            //종료를 위한 타임 카운트

/** 이미지 클릭 시 실행 초기화 **/
 function mvInit(){
     roundPicture=document.getElementById("html5around");  //이미지 객체 받아오기
     imgWidth = parseInt(roundPicture.style.width);        //이미지 폭 읽어오기
     imgHeight = parseInt(roundPicture.style.height);      //이미지 높이 읽어오기
     winWidth = window.innerWidth;                         //브라우져 안쪽 폭
     winHeight = window.innerHeight;                       //브라우져 안쪽 높이
     roundPicture.style.left=parseInt((Math.random()*(winWidth-125)))+"px";  //랜덤하게 나올 위치
     roundPicture.style.top="-125px";                      // 화면 바깥에 위치시키기
     mvStart();                                            // 시작하기
 }

/** 화면 바깥에서 서서히 내려오기 **/
 function mvStart(){
    roundPicture.style.transform="scale(1.0)";     //원래 크기로 돌리기
    var check=parseInt(roundPicture.style.top);    //top 좌표 읽어오기
    if(check <= 0){
       roundPicture.style.top=parseInt(check+10)+"px"; //top 증가
       setTimeout("mvStart()",5);                    //0.3초마다 
    } else {
       mvE7E();                                        // top좌표가 0보타 크면 
    }
 }

/** 회전하면서 대각선으로 움직이고, 벽에 부딪히면 비틀리면 방향바꾸기 **/
 function mvE7E(){
    if(++timeCount >= 80 ){                         // 타임카운트 80 넘으면 
      roundPicture.style.transform="scale(2.0)";    // 이미지 2배로 키우기
      timeCount=0;                                  //타임카운트 초기화
      return;                                       // 종료
    }

    mvCircle=parseInt(mvCircle % 360)+15;          // 360도 나눈 나머지에 값 추가
    hl=parseInt(roundPicture.style.left);          //이미지의 변한 left값 확인
    hh=parseInt(roundPicture.style.top);           //이미지의 변한 top 값 확인

   /** 좌우 벽에 부딪히면 찌그러지며 X축 방향 전환 **/
    if( hl <=0 || (hl+imgWidth) >= winWidth ) {
       roundPicture.style.transform="rotate("+mvCircle+"deg) skew("+parseInt((mvCircle % 45)+20) +"deg,0deg)";
       mvX = -mvX;
  
   /** 상하 벽에 부딪히면 찌그러지면 Y축 방향전환 **/
    }else if( hh <=0 || (hh+imgHeight) >= winHeight) {
       roundPicture.style.transform="rotate("+mvCircle+"deg) skew(0deg,"+parseInt((mvCircle % 45)+20) +"deg)";
       mvY = -mvY;
   /** 충돌 없으면 비틀기 없이 회전 **/
    }else {
       roundPicture.style.transform="rotate("+mvCircle+"deg) skew(0deg,0deg)";
    }
    roundPicture.style.left=(hl+mvX)+"px";  // 이미지 left값 증감
    roundPicture.style.top=(hh+mvY)+"px";   // 이미지 top값 증감
    setTimeout("mvE7E()",200);              // 0.2초마다 재귀 호출         
 }

/** 화면사이즈 변경시 화면 크기 다시 읽기 **/
 function ckSize(){
   winWidth = window.innerWidth;
   winHeight= window.innerHeight;
 }
</script>
</head>
<body style="background-color:black;color:yellow;" onresize="ckSize()">
 <h1>
 둥그런 이미지를 클릭 해보세요 <img draggable="false" class="emoji" alt="🙂" src="https://s.w.org/images/core/emoji/11/svg/1f642.svg">
 </h1>
 <img id="html5around" style="position:absolute;left:50%;top:50%;width:125px;height:125px;border-radius:50%;display:block;" src="http://html5around.com/wordpress/wp-content/uploads/2017/02/html5around_w.png" style="" alt="html5around.com" onclick="mvInit()">
</body>
</html>