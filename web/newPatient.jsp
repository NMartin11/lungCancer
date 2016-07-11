<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<%@ page import="lungCancer.CoeffecientPrep" %>
<%@ page import = "java.util.ArrayList" %>
<%@ page import = "java.util.HashMap" %>
	<script language="JavaScript" type="text/javascript" src="flot/jquery.min.js"></script>
    <script language="JavaScript" type="text/javascript" src="javascript/newPatient.js"></script>
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

<br>
<form id = "form_id"  method="post" name='form_id' onsubmit = 'return destination();' >
Age:<input type = "text" name = "agedx" id = "agedx"/><br>

<h3>Gender</h3>
Male <input type = "radio" name = "gender" value = "1"/><br>
Female <input type = "radio" name = "gender" value = "0"/><br>

<h3>Smoking History</h3>
Current Smoker: <input type = "checkbox" name = "smkcurrent" value = "1"/><br>
Former Smoker:  <input type = "checkbox" name = "smkformer" value = "1"/><br>
Never Smoked:	<input type = "checkbox" name = "smkcurrent" value = "0"/><br>

<h3>Cell Type</h3>
<select id = "celltype" name = "celltype" onchange="changeTreatment()">
	<option value="adeno" >Adenocarcinoma</option>
	<option value="squamous">Squamous Cell Carcinoma</option>
	<option value="largecell" >Large Cell Carcinoma</option>
	<option value="reference" >Bronchoalveolar Carcinoma</option>
	<option value="carcinoid" >Carcinoid</option>
	<option value="limited" >Limited-stage Small Cell Carcinoma</option>
	<option value="extensive" >Extensive-stage Small Cell Carcinoma</option>
	<option value= "other"  >Other NSCLC</option>
</select>

<h3>Stage</h3>
<select id = "stage" name = "stage">
	<option value="stageia" selected="selected" >Stage IA</option>
	<option value="stageib" >Stage IB</option>
	<option value="stageiia" >Stage IIA</option>
	<option value="stageiib" >Stage IIB</option>
	<option value="stageiiia" >Stage IIIA</option>
	<option value="stageiiib" >Stage IIIB</option>
	<option value="stageiv" >Stage IV</option>
</select>

<h3>Grade</h3>
Well 		<input type = "checkbox" name = "gradewell" value = "1"/><br>
Moderate 	<input type = "checkbox" name = "grademoderate" value = "1"/><br>
Poor		<input type = "checkbox" name = "gradepoor" value = "1"/><br>


<h3>Is Self Reported Symptoms Available?</h3><br>
	Yes<input type = "radio" name = "reported" value = "1" onclick="changeCellStage();"/>
	No <input type = "radio" name = "reported" value = "0" checked = "checked"/>

<h3>Is Blood Testing Available for Small Cell?</h3>
Yes<input type = "radio" name = "bloodMark" value="1" /><br>
No<input type = "radio" name = "bloodMark" value="0" checked/><br>


<h3>Is There Post-surgery Recurrence?</h3>
Yes <input type = "radio" name = "recurrence" value = "1" onclick="changeTreatment()"/>
No <input type = "radio" name = "recurrence" value = "0" checked = "checked"/>

<h3>Treatment to Date</h3>

<select id = "treatment" name = "treatment" size="5" onchange="changeTreatment()" multiple="multiple">
	<option value="background" selected = "selected">--Please Pick Treatment--</option>
	<option value="surgery">Surgery Only</option>
	<option value="chemo">Chemotherapy Only</option>
	<option value="radiation">Radiation Only</option>
	<option value="surgchemo">Surgery + Chemotherapy</option>
	<option value="surgradiation">Surgery + Radiation</option>
	<option value="chemoradiation">Chemotherapy + Radiation</option>
	<option value="surgradiationchemo">Surgery + Chemotherapy + Radiation</option>
	<option value="neoadjuvent">Neoadjuvent</option>
	<option value="othertrt">None/Other</option>
</select>



<h3>Tumor Markers</h3>
	<select name = "tumor">
		<option name = "null" value = "0">To be added </option>
	</select>
<!-- 
-Do not have resection treatment currently in provided files
-Do not have Tumor Markers currently in provided files
-Do not have Host/Germeline Markers currently in provided files
 -->
<br>
<input type='submit' value='Submit' />
</form>


</body>
</html>