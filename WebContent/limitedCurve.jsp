<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01//EN" "http://www.w3.org/TR/html4/strict.dtd">
<html>
<head>
	<%@ page import="lungCancer.Limited" %>
<<<<<<< HEAD
	<%@ page import = "java.util.ArrayList" %>
	<%@ page import = "java.util.HashMap" %>
	<%@ page import = "java.util.Enumeration" %>
    <%@ page import="java.util.List" %>
=======
    <%@ page import="org.json.JSONObject" %>
>>>>>>> refs/remotes/origin/master
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
	<title>Limited Small-cell</title>
	<link href="examples.css" rel="stylesheet" type="text/css">
	<!--[if lte IE 8]><script language="javascript" type="text/javascript" src="../../excanvas.min.js"></script><![endif]-->
	<script language="javascript" type="text/javascript" src="flot/jquery.js"></script>
	<script language="javascript" type="text/javascript" src="flot/jquery.flot.js"></script>
	<script language="javascript" type="text/javascript" src="flot/jquery.flot.crosshair.js"></script>
    <script language="javascript" type="text/javascript" src="javascript/showGraph.js"></script>

<<<<<<< HEAD
Limited limit = new Limited();
List<List<double[]>> results = limit.runLimited(request, response);
=======
    <%
//Uses java function from Limited.java/connection.java to calculate curve results
    JSONObject resultsList  = new JSONObject();
    Limited limit = new Limited();
    limit.runLimited(request, response);
    resultsList = limit.getFinalResults();
>>>>>>> refs/remotes/origin/master
%>
<script type="text/javascript">
    window.onload = function() {
    var x = <%=resultsList%>;
    showGraph(x);
    }
</script>


</head>
<body>

	<div id="header">
		<h2>Example </h2>
	</div>

	<div id="content">

		<div class="demo-container">
			<div id="placeholder" class="demo-placeholder" style="float:left; width:675px;"></div>
			<p id="choices" style="float:right; width:135px;"></p>
		</div>

		<p>This example shows the features of flot: series-toggle, tracking, and crosshair.</p>

	</div>

	<div id="footer">
		10-5-2015 
	</div>

</body>
</html>
