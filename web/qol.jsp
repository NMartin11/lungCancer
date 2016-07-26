<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<%@ page import="lungCancer.CoeffecientPrep" %>
<%@ page import="lungCancer.qolCurve" %>
<%@ page import = "java.util.ArrayList" %>
<%@ page import = "java.util.HashMap" %>
<title>Lung Cancer Tool</title>
<script language="javascript" type="text/javascript" src="flot/jquery.js"></script>
	<script language="javascript" type="text/javascript" src="flot/jquery.flot.js"></script>
	<script language="javascript" type="text/javascript" src="flot/jquery.flot.crosshair.js"></script>
</head>
<body>


<form action = "qolCurve.jsp" method = "post">
<h3>Comorbidities
	<select name = "comorb">
		<option disabled selected> -- select an option -- </option>
		<option value = "1"> Cocancer </option> 
		<option value = "1"> Co lung diseases </option>
		<option value = "1"> Co other diseases </option>
	</select>
</h3>
<p>Enter the symptoms. Rate 0 - 10.(0-best, 10-worst)</p>
	<h3>Fatigue
		<select name = "fatigue">
			<option value = "0"> 0 </option>
			<option value = "1"> 1 </option>
			<option value = "2"> 2 </option>
			<option value = "3"> 3 </option>
			<option value = "4"> 4 </option>
			<option value = "5"> 5 </option>
			<option value = "6"> 6 </option>
			<option value = "7"> 7 </option>
			<option value = "8"> 8 </option>
			<option value = "9"> 9 </option>
			<option value = "10"> 10 </option>
		</select>
	</h3>
	
<h3>Cough
	<select name = "cough">
		<option value = "0"> 0 </option>
		<option value = "1"> 1 </option>
		<option value = "2"> 2 </option>
		<option value = "3"> 3 </option>
		<option value = "4"> 4 </option>
		<option value = "5"> 5 </option>
		<option value = "6"> 6 </option>
		<option value = "7"> 7 </option>
		<option value = "8"> 8 </option>
		<option value = "9"> 9 </option>
		<option value = "10"> 10 </option>
	</select>
</h3>

<h3>Short of Breath
	<select name = "dyspnea">
		<option value = "0"> 0 </option>
		<option value = "1"> 1 </option>
		<option value = "2"> 2 </option>
		<option value = "3"> 3 </option>
		<option value = "4"> 4 </option>
		<option value = "5"> 5 </option>
		<option value = "6"> 6 </option>
		<option value = "7"> 7 </option>
		<option value = "8"> 8 </option>
		<option value = "9"> 9 </option>
		<option value = "10"> 10 </option>
	</select>
</h3>

<input type="submit" value = "submit"/>	
</form>

<%
//Gets needed Parameters and creates session for later use
	qolCurve Session = new qolCurve();
	Session.createListSession(request, response);
%>
	
</body>
</html>