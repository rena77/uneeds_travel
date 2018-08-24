<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
 <title>Html5around.com에 오신걸 환영합니다.</title>
 <style type="text/css">
 
 body{
 	margin:0; 
 	padding:0; 
 	-webkit-font-smoothing: antialiased; 
 	font-family:arial;
 	}

#main-content{display:flex; width:100vw; height:100vh; background:white; align-items:center; justify-content:center; text-align:center;}


svg{
  cursor:pointer; overflow:visible; width:60px;
}

svg #checkboxstarpath{
cursor:pointer; overflow:visible; width:60px;
transform-origin:center; animation:animateStarOut .3s linear forwards;
}

svg #main-circ{
transform-origin:29.5px 29.5px;

}

input[id="checkboxstar"]{
        display: none;
}

input[id="checkboxstar"]:checked + label svg  #checkboxstarpath{
       transform:scale(.2); fill:#fffe14d1; animation:animateStar .3s linear forwards .25s;
}

input[id="checkboxstar"]:checked + label svg  #main-circ{
       ransition:all 2s; animation:animateStarCircle .3s linear forwards; opacity:1;
}

 @keyframes animateStarCircle{
  40%{transform:scale(10); opacity:1; fill:#DD4688;}
  55%{transform:scale(11); opacity:1; fill:#D46ABF;}
  65%{transform:scale(12); opacity:1; fill:#CC8EF5;}
  75%{transform:scale(13); opacity:1; fill:transparent; stroke:#CC8EF5; stroke-width:.5;}
  85%{transform:scale(17); opacity:1; fill:transparent; stroke:#CC8EF5; stroke-width:.2;}
  95%{transform:scale(18); opacity:1; fill:transparent; stroke:#CC8EF5; stroke-width:.1;}
  100%{transform:scale(19); opacity:1; fill:transparent; stroke:#CC8EF5; stroke-width:0;}
}

@keyframes animateStar{
  0%{transform:scale(.2);}
  40%{transform:scale(1.2);}
  100%{transform:scale(1);}
}

@keyframes animateStarOut{
  0%{transform:scale(1.4);}
  100%{transform:scale(1);}
}
 </style>
 
 
</head>
<body>

<div id="main-content">
  <div>
    <input type="checkbox" id="checkboxstar" />
    <label for="checkboxstar">
      <svg id="star-svg" viewBox="0 0 65 65" xmlns="http://www.w3.org/2000/svg">
          <path data-name="center-star-fill" id="checkboxstarpath" d="M22.1 46.88a.37.37 0 0 1-.37-.43l2-11.39L15.4 27a.38.38 0 0 1 .21-.64l11.44-1.67 5.11-10.37a.4.4 0 0 1 .68 0L38 24.69l11.44 1.67a.38.38 0 0 1 .21.64l-8.28 8.06 2 11.39a.34.34 0 0 1-.15.36.35.35 0 0 1-.39 0L32.5 41.46l-10.23 5.38a.33.33 0 0 1-.17.04z" fill="#AAB8C2"/>
      </svg>
    </label>
  </div>
</div>
</body>
</html>