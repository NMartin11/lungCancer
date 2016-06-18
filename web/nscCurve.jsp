<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="c"
           uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01//EN" "http://www.w3.org/TR/html4/strict.dtd">
<html>
<head>
	<%@ page import="lungCancer.CoeffecientPrep" %>
	<%@ page import="lungCancer.NSC" %>
    <%@ page import="java.util.List" %>
    <%@ page import="java.util.ArrayList" %>
    <%@ page import="java.util.*" %>
    <%@ page import="org.json.*" %>

    <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
	<title>Flot Example</title>
	<link href="examples.css" rel="stylesheet" type="text/css">
	<!--[if lte IE 8]><script language="javascript" type="text/javascript" src="../../excanvas.min.js"></script><![endif]-->
	<script language="javascript" type="text/javascript" src="flot/jquery.js"></script>
	<script language="javascript" type="text/javascript" src="flot/jquery.flot.js"></script>
	<script language="javascript" type="text/javascript" src="flot/jquery.flot.crosshair.js"></script>
    <script language="javascript" type="text/javascript" src="javascript/showGraph.js"></script>
<%
    //Uses java function from NSC.java/connection.java to calculate curve results
    JSONObject resultList = new JSONObject();
    NSC nsc = new NSC();

    //returns a JSON object to reslutList
    List<String> treatments = new ArrayList<>();
    nsc.runNSC(request,response);
    resultList = nsc.getFinalResults();


    //TODO: make JSON object a JSON string that replicates dataset object from flots javascript

%>

<script type="text/javascript">
    window.onload = function() {
        var x = <%=resultList%>;
//        window.alert(x['chemo']);
//        window.alert(x['radiation']);
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