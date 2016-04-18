<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<%@ page import="lungCancer.connection" %>
<%@ page import = "java.util.ArrayList" %>
<%@ page import = "java.util.HashMap" %>
<title>LCT - New Patient</title>
<link href="test.css" rel="stylesheet" type="text/css">
</head>
<body>
	<header>
		<h1>Predicting Lung Cancer Outcomes</h1>
		<ul class="nav">
			<li><a href="index.jsp">HOME</a></li>
			<li><a href="newPatient.jsp">NEW PATIENT</a></li>
			<li><a href="existingPatient.jsp">EXISTING PATIENT</a></li>
			<li><a href="help.jsp">HELP</a></li>
			<li><a href="links.jsp">LINKS</a></li>
			<li class="icon">
			<a href="javascript:void(0);" style="font-size:15px;" onclick="myFunction()">=</a>
			</li>
		</ul>
		<script>
			function myFunction() {
			document.getElementsByClassName("nav")[0].classList.toggle("responsive");
			}
		</script>
	</header>
	<main>
		<h2>New Patient</h2>
		<p>Fill in as much information as you can and then click
		the "Submit" button at the bottom of the form. 
		Our tool predicts treatment outcomes for non-small cell 
		lung cancer and limited-stage small cell lung cancer, 
		it will select the model(s) for you based on the information entered.
		</p>

<form action = "newPatient.jsp" method = "post">

<b>Age</b>
<input type = "text" name = "agedx"/><br><br>

<b>Gender</b><br>
<input type = "radio" name = "gender" value = "gender"/>Male<br>
<input type = "radio" name = "gender" value = "gender"/>Female<br><br>

<b>Smoking History</b><br>
<input type = "radio" name = "smkcurrent" value = "smkcurrent"/>Current Smoker<br>
<input type = "radio" name = "smkformer" value = "smkformer"/>Former Smoker<br>
<input type = "radio" name = "nvrsmoked" value = "null"/>Never Smoked<br><br>

<b>Cell Type</b><br>
<select name = "celltype">
	<option value="largecell" >Adenocarcinoma</option>
	<option value = "largecell">Squamous Cell Carcinoma</option>
	<option value="largecell" >Large Cell Carcinoma</option>
	<option value="largecell" >Bronchoalveolar</option>
	<option value="largecell" >Carcinoma</option>
	<option value="limited" >Limited-Stage Small Cell Carcinoma</option>
	<option value= "extended" >Extended-Stage Small Cell</option>
	
		<!-- 
		<option value="largecell" >Limited-Stage Small Cell </option>
		<option value="largecell" >Extended Stage Small Cell</option>
		<option value="largecell" >Non Small Cell</option>
	-->
</select><br><br>

<b><i>Self Reported </i></b><br>
<b>Symptoms of Recurrence</b><br>
<input type = "radio" name = "symprec" value = "1" required = "required"/>Yes<br>
<input type = "radio" name = "symprec" value = "0" required = "required"/>No<br><br>
	

<b>Blood Marker</b><br>
<input type = "checkbox" name = "bloodMark" value="1" checked/>Yes<br>
<input type = "checkbox" name = "bloodMark" value="0" />No<br></br>

<b>Stage</b>
<select name = "stage"><br>
	<option value="stageib" >Stage IB</option>
	<option value="stageiia" selected="selected" >Stage IIA</option>
	<option value="stageiib" >Stage IIB</option>
	<option value="stageiia" >Stage IIIA</option>
	<option value="stageiiib" >Stage IIIB</option>
	<option value="stageiv" >Stage IV</option>
</select><br><br>

<b>Grade</b><br>
<input type = "radio" name = "gradewell" value = "gradewell"/>Well<br>
<input type = "radio" name = "grademoderate" value = "grademoderate"/>Moderate<br>
<input type = "radio" name = "gradepoor" value = "gradepoor"/>Poor<br><br>

<b>Treatment to Date</b><br>
<select name = "treatment">
	<!-- <option value="surg" selected="selected" >Surgery</option> -->
	<!-- surgery option isn't in given csv file -->
	
	<option value="chemo">Chemotherapy</option>
	<option value="radiation">Radiation</option>
	<option value="surgchemo">Surgery + Chemotherapy</option>
	<option value="surgradiation">Surgery + Radiation</option>
	<option value="chemoradiation">Chemotherapy + Radiation</option>
	<option value="surgradiationchemo">Surgery + Chemotherapy + Radiation</option>
	<option value="othertrt">None/Other</option>
</select><br><br>

<!-- 
-Do not have resection treatment currently in provided files
-Do not have Tumor Markers currently in provided files
-Do not have Host/Germeline Markers currently in provided files
 -->

<input class="submit" type="submit" value = "SUBMIT"/>	
</form>

<footer>
	<hr>
	<p>
		Copyright Lung Cancer Study at Mayo and Winona State University
	</p>
</footer>
<%
			
	ArrayList<String> myList = new ArrayList<String>();
	String cellType;

	String symptom;
	connection test = new connection();
	myList = test.getParamValues(request, response);
	
	System.out.println("Parameters submitted");
	for(int i = 0; i < myList.size(); i++)
	{
		System.out.println(myList.get(i));
	}
	System.out.println("");
	
	symptom = request.getParameter("symprec");
	if(symptom != null && symptom.equalsIgnoreCase("1"))
	{
		%><script type="text/javascript">window.location.replace("postRecurrence.jsp");</script><%
	}
	
	String bloodMarker = request.getParameter("bloodMark");
	System.out.println("Blood marker = " + bloodMarker);
	if(bloodMarker != null)
	{	
		if(bloodMarker.equalsIgnoreCase("0"))
		{
			%><script type="text/javascript">window.location.replace("sorry.jsp");</script><%
		}
	}
	
	for(int i = 0; i < myList.size(); i++)
	{
		cellType = myList.get(i);
		if(cellType.equalsIgnoreCase("limited"))
		{
			%><script type="text/javascript">window.location.replace("limited.jsp");</script><%
		}
		else if(cellType.equalsIgnoreCase("extended"))
		{
			%><script type="text/javascript">window.location.replace("extended.jsp");</script><%
		}
		else if(cellType.equalsIgnoreCase("largecell"))
		{
			%><script type="text/javascript">window.location.replace("qol.jsp");</script><%
		}
		
	}
	
%>
</body>
</html>