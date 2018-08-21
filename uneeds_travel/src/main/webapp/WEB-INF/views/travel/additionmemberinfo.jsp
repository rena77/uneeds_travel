<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
      <!--Import Google Icon Font-->
 <link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">
      <!--Import materialize.css-->
<link type="text/css" rel="stylesheet" href="/resources/travel/css/materialize.min.css"  media="screen,projection"/>
<%@ taglib uri="http://java.sun.com/jstl/core" prefix="c" %>
<style type="text/css">
body{
    display: table-cell;
    vertical-align: middle;
    background-color: #e0f2f1 !important;
}

html {
    display: table;
    margin: auto;
}

html, body {
    height: 100%;
}

.medium-small {
    font-size: 0.9rem;
    margin: 0;
    padding: 0;
}

.login-form {
    width: 280px;
}

.login-form-text {
    text-transform: uppercase;
    letter-spacing: 2px;
    font-size: 0.8rem;
}

.login-text {
    margin-top: -6px;
    margin-left: -6px !important;
}

.margin {
    margin: 0 !important;
}

.pointer-events {
    pointer-events: auto !important;
}

.input-field >.material-icons  {
    padding-top:10px;
}

.input-field div.error{
    position: relative;
    top: -1rem;
    left: 3rem;
    font-size: 0.8rem;
    color:#FF4081;
    -webkit-transform: translateY(0%);
    -ms-transform: translateY(0%);
    -o-transform: translateY(0%);
    transform: translateY(0%);
}

.abtn{
  height:40px;
  line-height:40px;  
  border-radius:3px;
  border:1px solid;
  border-color: rgba0, 0, 0, 1);
  background-color: transparent;
  font-size:13px;    
  color:rgba0, 0, 0, 1);
}

.abtn ul {
  border:1px solid;  
  border-color: rgba0, 0, 0, 1);
  border-top-left-radius: 3px;  
  border-top-right-radius:3px;
  border-bottom:0;  
  
  bottom:40px;  
  padding-left:0px;
  padding-top:5px;
}

.abtn,
.abtn ul li {
  width:105px;
  padding-left:20px;
  padding-right:16px;
}

.abtn:focus {
  border-top-left-radius: 0px;  
  border-top-right-radius:0px;
  border-top:0px;
  margin-top:1px;
  cursor:default;  
}

.abtn ul li:hover{
   background-color:rgba(249, 250, 252, 0.2);
}






/*common */
.opt-sel {
  position:relative;  
  outline: none;
  cursor:pointer;
}

.opt-sel ul{
  position:absolute;  
  left:-1px; 
  list-style:none;
  margin:0;    
}

.sel-icon {
  float:right;  
  font-size:10px;
}

.sel-icon:after {    
  content:'▼';
}

.opt-sel:focus .sel-icon:after{
  content:'▲';
}

.opt-sel ul li{    
  cursor:pointer;
}

.opt-sel:focus ul {
  display:block;  
}

.opt-sel:not(:focus) ul {  
  display:none;  
}
</style>

<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>


</head>
<body >
<div id="login-page" class="row">
  <div class="col s12 z-depth-4 card-panel">
    <form class="login-form" style="width: 280px;">
      <div class="row">
        <div class="input-field col s12 center">
          <h4>추가 입력</h4>
          <p class="center">여행 컨텐츠 사용 전 추가 입력을 부탁드립니다.</p>
        </div>
      </div>

      <div class="row margin">
        <div class="input-field col s12">
          <input id="username" name="username" type="text"/>
          <label for="username">이름을 입력해주세요.</label>
        </div>
      </div>

      <div class="row margin">
        <div class="input-field col s12">
          <div class="opt-sel abtn" tabindex="1">  select1234 <div class="sel-icon"></div>
  				<ul tabindex="1">
    				<li><div>남</div></li>
    				<li>여</li>
  				</ul>
			</div>
        </div>
      </div>

      <div class="row margin">
        <div class="input-field col s12">
          <div class="opt-sel abtn" tabindex="1">  select1234 <div class="sel-icon"></div>
  				<ul tabindex="1">
  					<c:forEach var="i" begin="1" end="100" step="1">
				      <li>${i}</li>
    				</c:forEach>
  				</ul>
			</div>
        </div>
      </div>

      <div class="row margin">
        <div class="input-field col s12">
          <input id="password_a" name="cpassword" type="password" />
          <label for="password_a">Password again</label>
        </div>
      </div>

      <div class="row">
        <div class="input-field col s12">
          <button type="submit" class="btn waves-effect waves-light col s12">REGISTER NOW</button>
          
        </div>
      </div>


    </form>
  </div>
</div>

<!--JavaScript at end of body for optimized loading-->
      <script type="text/javascript" src="/resources/travel/js/materialize.min.js"></script>
</body>
</html>