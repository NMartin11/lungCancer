<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<%@ page import="lungCancer.CoeffecientPrep" %>
<%@ page import = "java.util.ArrayList" %>
<%@ page import = "java.util.HashMap" %>
<title>Lung Cancer Tool</title>
</head>
<body>
<h1>Predicting Lung Cancer Outcomes</h1>

<div class = "nav-bar">
	<a href="index.jsp">Home</a>
	<a href="newPatient.jsp">New Patient</a>
	<a href="existingPatient.jsp">Existing Patient</a>
	<a href="help.jsp">Help</a>
</div>

<h2>Introduction</h2>
This web based tool provides a unified platform for a quick delivery of lung cancer survival prediction model
in clinical setting. Users may conveniently save their models in the system; clinicians may access to the models
via this web interfaces. As a showcase, we used two models. The first model (background) includes patient's information
 at the time of diagnosis (e.g, age, sex histology and staging). The second model (specified)includes additional information
  such as treatment modalities. 
  
<h3>Quick Start</h3>

<a href="newPatient.jsp">New Patient</a>
<p> or </p>
<a href="existingPatient.jsp">Existing Patient</a>

</body>
</html>