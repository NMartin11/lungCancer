<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<%@ page import="lungCancer.CoeffecientPrep" %>
<%@ page import="lungCancer.Recurrence" %>
<%@ page import = "java.util.ArrayList" %>
<%@ page import = "java.util.HashMap" %>
<title>Post Recurrence</title>
</head>
<body>

<h2> Post Recurrence</h2>

<form action = "recurrenceCurve.jsp" method = "post">
<h3>Performance Status at Recurrence</h3>
	<select name = "psrec">
			<option value = "0"> 0 </option>
			<option value = "1"> 1 </option>
			<option value = "2"> 2 </option>
			<option value = "3"> 3 </option>
			<option value = "4"> 4 </option>
		</select>
		
<h3>Symptoms at Recurrence</h3>
	Yes<input type = "radio" name = "symprec" value = "1"/><br>
	No<input type = "radio" name = "symprec" value = "0"/><br>
			
<h3>Liver Recurrence</h3>
	Yes<input type = "radio" name = "rliver" value = "1" required = "required"/><br>
	No<input type = "radio" name = "rliver" value = "0" required = "required"/><br>
	
<h3>Number of Recurrent Foci</h3>
	Multiple<input type = "radio" name = "numrec" value = "1" required = "required"/><br>
	Single<input type = "radio" name = "numrec" value = "0" required = "required"/><br>

<input type = "submit" value = "submit"/>
</form>

<%
Recurrence recur = new Recurrence();
recur.createListSession(request, response);
%>


</body>
</html>