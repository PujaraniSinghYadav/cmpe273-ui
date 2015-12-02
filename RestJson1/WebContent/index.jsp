<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<%@ page import="java.lang.*" %>
<%@ page import="java.io.*" %>
<%@ page import="java.net.*" %>
<%@ page import="org.json.*" %>
<%!
public String httpGet(String urlStr) throws IOException {
  URL url = new URL(urlStr);
  HttpURLConnection conn =
      (HttpURLConnection) url.openConnection();

  if (conn.getResponseCode() != 200) {
    throw new IOException(conn.getResponseMessage());
  }

  // Buffer the result into a string
  BufferedReader rd = new BufferedReader(
      new InputStreamReader(conn.getInputStream()));
  StringBuilder sb = new StringBuilder();
  String line;
  while ((line = rd.readLine()) != null) {
    sb.append(line);
  }
  rd.close();

  conn.disconnect();
  return sb.toString();
}

public String str(JSONObject obj, String key) {
	if (!obj.isNull(key)) {
		return obj.getString(key);
	}
	return "";
}
%>
<%
String nodesdata = httpGet("http://localhost:8080/RedisApi/rest/status/getAllNodes");
JSONArray nodes = new JSONArray(nodesdata);
%>

<html lang="en">
<style>
table {
    width:40%;
}
table, th, td {
    border: 1px solid black;
    border-collapse: collapse;
}
th, td {
    padding: 5px;
    text-align: center;
}
table#t01 tr:nth-child(even) {
    background-color: #eee;
}
table#t01 tr:nth-child(odd) {
   background-color:#fff;
}
table#t01 th	{
    background-color: black;
    color: white;
}
</style>


<html lang="en">
<head>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <meta name="description" content="">
  <meta name="author" content="">
  <title>Main Page</title>

  <!-- Bootstrap core CSS -->
  <link href="css/bootstrap.css" rel="stylesheet">

  <!-- Custom CSS -->
  <link href="css/main.css" rel="stylesheet">
  <link href="css/font-awesome.min.css" rel="stylesheet">
  <link href="css/animate-custom.css" rel="stylesheet">
  <link href='http://fonts.googleapis.com/css?family=Lato:300,400,700,300italic,400italic' rel='stylesheet' type='text/css'>
  <link href='http://fonts.googleapis.com/css?family=Raleway:400,300,700' rel='stylesheet' type='text/css'>
  <script src="js/jquery.min.js"></script>
  <script type="text/javascript" src="js/modernizr.custom.js"></script>
 <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.3/jquery.min.js"></script>
<script>
function run(){
    console.log("yea0");
    $.support.cors = true;

var postData = {
  "name": "puja14",
  "role": "master",
  "ip": "127.0.0.7",
  "port": "7005",
  "slaves": [
    {
      "slaveIp": "127.0.0.1",
      "port": "6379"
    }
  ]
}
alert("REsponse data:"+postData);
     $.ajax({
             type: "POST",
             url: "http://localhost:8080/RedisApi/rest/status/newNode",
             data:JSON.stringify(postData),
             contentType: 'application/json',
             crossDomain: true,
             dataType: "json",
             success: function (data, status, jqXHR) {

                 alert("name"+data.ip+" "+"");
             },

             error: function (jqXHR, status) {
                 // error handler
                 console.log( jqXHR);
                 alert('fail' + status.code);
             }
          });
}  
</script>
</head>

<body  data-spy="scroll" data-offset="0" data-target="#navbar-main" >
  <p id="demo"></p>
<div id="navbar-main"> 
  <!-- Fixed navbar -->
  <div class="navbar navbar-inverse navbar-fixed-top">
    <div class="container">
      <div class="navbar-header">
        <button type="button" class="navbar-toggle" data-toggle="collapse" data-target=".navbar-collapse"> <span class="icon-bar"></span> <span class="icon-bar"></span> <span class="icon-bar"></span> </button>
        <a class="navbar-brand" href="index.html">Team Invictus</a> </div>
      <div class="navbar-collapse collapse">
        <ul class="nav navbar-nav navbar-right">
          <li><a href="index.html" class="smoothScroll">Home</a></li>
          <li> <a href="statistics.html" class="smoothScroll"> Statistics</a></li>
          <li> <a href="contact-us.html" class="smoothScroll"> Contact Us</a></li>
      <li> <a href="about-us.html" class="smoothScroll"> About Us</a></li>
      <li> <a href="Homepage.html" class="smoothScroll"> Logout</a></li>
        </ul>
      </div>
    </div>
  </div>
</div>

<!-- ==== HEADERWRAP ==== -->
<div id="headerwrap" name="home">
  <header class="clearfix"> 
    <h1>Server Details </h1><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br>
<button onclick="run()" >TP</button>

     <!-- <a href="serverpage.html" class="smoothScroll btn btn-lg">Add a new Server!</a> -->
     <form>
     
     	<% for (int i = 0; i < nodes.length(); i++) { %>
     		<table align="center" id="t01">
 			<tr>
 				<td>Node</td>
 				<td><%= i %></td>
 			</tr>
 			<tr>
 				<td>Role</td>
 				<td><%= nodes.getJSONObject(i).getString("role") %></td>
 			</tr>
 			<tr>
 				<td>Name</td>
 				<td><%= nodes.getJSONObject(i).getString("name") %></td>
 			</tr>
 			<tr>
 				<td>IP#</td>
 				<td><%= nodes.getJSONObject(i).getString("ip") %></td>
 			</tr>
 			<tr>
 				<td>Port #</td>
 				<td><%= str(nodes.getJSONObject(i), "port") %></td>
 			</tr>
 			<% JSONArray slaves =  nodes.getJSONObject(i).getJSONArray("slaves"); %>
 			<% for (int j = 0; j < slaves.length(); j++) { %>
 				<tr>
 					<td>Slave <%= j %></td>
 					<td></td>
 				</tr>
 				<tr>
 					<td>Slave IP Address</td>
 					<td><%= str(slaves.getJSONObject(j), "slaveIp") %></td>
 				</tr>
     			<tr>
     				<td>Slave Port #</td>
     				<td><%= str(slaves.getJSONObject(j), "port") %></td>
     			</tr>
     		<% } %>
     		</table>
     	<% } %>

 	</form>


  <div class="col-lg-8 col-lg-offset-2 centered">
    
    <button> Generate a new dataset </button><br><br>
    <a href="#portfolio" class="smoothScroll btn btn-lg">Add New Server</a>
  </div>
    </header>
</div>

<!-- ==== PORTFOLIO ==== -->
<div id="portfolio" name="portfolio">
  <div class="container">
    <div class="row">
      <h2 class="centered">Add New Server</h2>
      <hr>
      <div class="col-lg-8 col-lg-offset-2 left">
        <p class="large"><strong>Please enter the server details below.</strong></p>
      </div>
    </div>
    <div class="container">
      <div class="row"> 
        
        <div class="col-md-4 centered">
    <form method="POST" action="http://localhost:8080/RedisApi/rest/status/newNode">
      Server Name:&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp
  <input type="text" name="servername">
  <br><br>
    Server Role:&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp
  <input type="text" name="role">
  <br><br>
  Server IP Address:
  <input type="text" name="ipaddress">
  <br><br>
  Server Port:&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp
  <input type="text" name="portnumber">

  <br><br>

<button type="button" onclick="run()" href="index.html">OK</button>
  <button type="button">Cancel</button>

    </form>
</div>
</div>
</div>
 <br><br><br>   

<div id="footerwrap">
  <div class="container">
    <div class="row">
      <div class="col-md-8"> <span class="copyright">Copyright &copy; CMPE 273 Team Invictus Fall'15</span> </div>
      <div class="col-md-4">
        <ul class="list-inline social-buttons">
          <li><a href="#"><i class="fa fa-twitter"></i></a> </li>
          <li><a href="#"><i class="fa fa-facebook"></i></a> </li>
          <li><a href="#"><i class="fa fa-google-plus"></i></a> </li>
          <li><a href="#"><i class="fa fa-linkedin"></i></a> </li>
        </ul>
      </div>
    </div>
  </div>
</div>

<script type="text/javascript" src="js/bootstrap.min.js"></script> 
<script type="text/javascript" src="js/retina.js"></script> 
<script type="text/javascript" src="js/jquery.easing.1.3.js"></script> 
<script type="text/javascript" src="js/smoothscroll.js"></script> 
<script type="text/javascript" src="js/jquery-func.js"></script>
</body>
</html>