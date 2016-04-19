<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<%@ page import="lungCancer.CoeffecientPrep" %>
<%@ page import="lungCancer.Extensive" %>
<%@ page import = "java.util.ArrayList" %>
<%@ page import = "java.util.HashMap" %>
<title>Extended Small Cell</title>
</head>
<body>

<!-- put all variables from limited and extended small cell on this page -->

<form action = "extensiveCurve.jsp" method = "post">

	<h3>Red Cell Distribution Width (Reference rage: 11-15%)</h3>
	<input type = "number" name = "ln_rdw" placeholder = "rdw"/>

	<h3>Lymphocyte (Reference range: 1300-3500 counts per L)</h3>
	<input type = "number" name = "lymphocyte" min = "0" />

	<h3>Neutrophil (Reference range: 2000-7500 counts per L)</h3>
	<input type = "number" name = "neutrophil" min = "0" /><br>

	<h3>Platelet (Reference range: 140-450 counts per L)</h3>
	<input type = "number" name = "platelet" min = "0" /><br>

	<h3>Hemoglobin (Reference range: 120-180g per L)</h3>
	<input type = "number" name = "hbx" min = "0" />
	
	<h3>ECOG Performance Score:</h3>
			<select name = "ps">
				<option value = "0"> 0 </option>
				<option value = "1"> 1 </option>
				<option value = "2"> 2 </option>
				<option value = "3"> 3 </option>
				<option value = "4"> 4 </option>
				<option value = "5"> 5 </option>
			</select>
	<br><br>
			
	<h3>Liver Metastases:</h3>
	Yes<input type = "radio" name = "liver_metas" value = "1" /><br>
	No<input type = "radio" name = "liver_metas" value = "0" />
	
	<h3>Number of metastatic sites:</h3>
			<select name = "num_metas_over2">
				<option value = "0"> 0 </option>
				<option value = "1"> 1 </option>
				<option value = "2"> 2 </option>
				<option value = "3"> 3 </option>
				<option value = "4"> 4 or More </option>
			</select>

<br>

<input type="submit" value = "submit"/>	
</form>

<%
//Retrieves needed parameters and puts them in a session for later use
Extensive exten = new Extensive();
exten.createListSession(request, response);
%>



</body>
</html>