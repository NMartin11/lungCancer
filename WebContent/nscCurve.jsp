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
    <%@ page import="org.json.JSONArray" %>
    <%@ page import="org.json.JSONObject" %>


    <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
	<title>Flot Example</title>
	<link href="examples.css" rel="stylesheet" type="text/css">
	<!--[if lte IE 8]><script language="javascript" type="text/javascript" src="../../excanvas.min.js"></script><![endif]-->
	<script language="javascript" type="text/javascript" src="flot/jquery.js"></script>
	<script language="javascript" type="text/javascript" src="flot/jquery.flot.js"></script>
	<script language="javascript" type="text/javascript" src="flot/jquery.flot.crosshair.js"></script>
    <script language="javascript" type="text/javascript" src="javascript/showGraph.js"></script>
    <script language="javascript" type="text/javascript" src="flot/createGraph.js"></script>
<%
    //Uses java function from NSC.java/connection.java to calculate curve results
    List<List<double[]>> resultList = new ArrayList<>();
    List<String> treatments = new ArrayList<>();
    CoeffecientPrep prep = new CoeffecientPrep();
    NSC nsc = new NSC();

    treatments = nsc.getUsedTreatements();
    nsc.runNSC(request,response);
    resultList = nsc.getFinalResults();
    JSONObject obj2 = new JSONObject();
    JSONArray arr = new JSONArray();
//   TODO: make array that follows { label:[treatment name], data: [results] }

    for(int i = 0; i < treatments.size(); i++)
    {
        JSONObject obj = new JSONObject();

        obj.put("label", treatments.get(i));
        obj.put("data", resultList.get(i));
        obj2.put(treatments.get(i), obj);
        System.out.println("This is obj2 " + obj2);

    }




//   TODO: make object that has treatment name as key and corresponding array as value


%>

<script type="text/javascript">
    window.onload = function() {
        var x = <%=obj2%>;
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
