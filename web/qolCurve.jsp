<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01//EN" "http://www.w3.org/TR/html4/strict.dtd">
<html>
<head>
	<%@ page import="lungCancer.CoeffecientPrep" %>
	<%@ page import="lungCancer.qolCurve" %>
    <%@ page import="org.json.JSONObject" %>
    <%@ page import="com.google.gson.JsonObject" %>
    <%@ page import="java.util.List" %>
    <%@ page import="com.google.gson.JsonArray" %>
    <%@ page import="java.util.Map" %>
    <%@ page import="com.google.gson.JsonElement" %>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
	<title>Flot Example</title>
	<link href="examples.css" rel="stylesheet" type="text/css">
	<!--[if lte IE 8]><script language="javascript" type="text/javascript" src="../../excanvas.min.js"></script><![endif]-->
    <link rel="stylesheet" href="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/css/bootstrap.min.css">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
    <script src="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/js/bootstrap.min.js"></script>
	<script language="javascript" type="text/javascript" src="flot/jquery.js"></script>
	<script language="javascript" type="text/javascript" src="flot/jquery.flot.js"></script>
	<script language="javascript" type="text/javascript" src="flot/jquery.flot.crosshair.js"></script>
    <script language="javascript" type="text/javascript" src="javascript/showGraph.js"></script>

<%
    JsonObject resultList = new JsonObject();
	qolCurve qol = new qolCurve();
    qol.runQOL(request, response);
    resultList = qol.getFinalResults();
    List<String> treatments = qol.getUsedTreatments();
    JsonObject data = new JsonObject();
    for(String usedTreats : treatments) {
        JsonObject tempObj = resultList.get(usedTreats).getAsJsonObject();
        data.add(usedTreats,tempObj.get("data").getAsJsonArray());
    }

    JsonArray rowData = new JsonArray();
%>

</head>
<body>

<div class="container">
    <h2>Dynamic Tabs</h2>
    <ul class="nav nav-tabs">
        <li class="active"><a data-toggle="tab" href="#curve">Curve</a></li>
        <li><a data-toggle="tab" href="#table">Table</a></li>
    </ul>

    <div class="tab-content">
        <div id="home" class="tab-pane fade in active">
            <h3>Curve</h3>
            <script type="text/javascript">
                window.onload = function() {
                    var x = <%=resultList%>;
                    showGraph(x);
                }
            </script>
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
        </div>
        <div id="table" class="tab-pane fade">
            <h3>Table</h3>
            <table class="table">
                <thead>
                <tr>
                    <th>Treatment</th>
                    <th>0</th>
                    <th>1</th>
                    <th>2</th>
                    <th>3<th>
                    <th>4</th>
                    <th>5</th>
                    <th>6</th>
                    <th>7</th>
                </tr>
                </thead>
                <tbody>
                <%for(Map.Entry<String,JsonElement> entry : data.entrySet()) { %>
                <tr>
                    <td>
                        <%= entry.getKey()%>
                    </td>
                    <% for(int x = 0; x < 8; x++) { %>
                    <td>
                        <%rowData = data.get(entry.getKey()).getAsJsonArray();%>
                        <%JsonArray temp = rowData.get(x).getAsJsonArray();%>
                        <%=temp.get(1)%>
                    </td>
                    <%}%>
                </tr>
                <%}%>

                </tbody>
            </table>
        </div>
    </div>
</div>

</body>
</html>
