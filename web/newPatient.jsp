<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<%@ page import="lungCancer.CoeffecientPrep" %>
<%@ page import = "java.util.ArrayList" %>
<%@ page import = "java.util.HashMap" %>
	<script language="JavaScript" type="text/javascript" src="/flot/jquery.min.js"></script>
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
<select id = "celltype" name = "celltype" onchange="change()">
	<option value="adeno" >Adenocarcinoma</option>
	<option value="squamous">Squamous Cell Carcinoma</option>
	<option value="largecell" >Large Cell Carcinoma</option>
	<option value="reference" >Bronchoalveolar Carcinoma</option>
	<option value="carcinoid" >Carcinoid</option>
	<option value="limited" >Limited-stage Small Cell Carcinoma</option>
	<option value="extensive" >Extensive-stage Small Cell Carcinoma</option>
	<option hidden value="smallcell">smallcell</option>
	<option value= "other"  >Other NSCLC</option>
</select>
	<script type="text/javascript">

function change()
{
	var type = document.getElementById("celltype");
	var valtype = type.options[type.selectedIndex].value;

		if(valtype == "extensive" || valtype == 'limited')
		{
			document.getElementById("treatment").options[0].disabled = true;
			document.getElementById("treatment").options[1].disabled = true;
			document.getElementById("treatment").options[3].disabled = true;
			document.getElementById("treatment").options[4].disabled = true;
			document.getElementById("treatment").options[5].disabled = true;
			document.getElementById("treatment").options[7].disabled = true;
			document.getElementById("treatment").options[8].disabled = true;
		}
			else
			{
				document.getElementById("treatment").options[0].disabled = false;
				document.getElementById("treatment").options[1].disabled = false;
				document.getElementById("treatment").options[3].disabled = false;
				document.getElementById("treatment").options[4].disabled = false;
				document.getElementById("treatment").options[5].disabled = false;
				document.getElementById("treatment").options[7].disabled = false;
				document.getElementById("treatment").options[8].disabled = false;
			}
}

	</script>

<h3>Stage</h3>
<!-- TODO: iif stageia and stageib == stagei -->
<!-- TODO: iif stageiib and stageib == stageii -->
<select id = "stage" name = "stage">
	<option value="stageia" selected="selected" >Stage IA</option>
	<option value="stageib" >Stage IB</option>
	<option value="stageiia" >Stage IIA</option>
	<option value="stageiib" >Stage IIB</option>
	<option value="stageiia" >Stage IIIA</option>
	<option value="stageiiib" >Stage IIIB</option>
	<option value="stageiv" >Stage IV</option>
</select>

<h3>Grade</h3>
Well 		<input type = "checkbox" name = "gradewell" value = "1"/><br>
Moderate 	<input type = "checkbox" name = "grademoderate" value = "1"/><br>
Poor		<input type = "checkbox" name = "gradepoor" value = "1"/><br>

<h3>Treatment to Date</h3>

<select id = "treatment" name = "treatment" size="5" multiple="multiple">
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

<h3>Self Reported Symptoms</h3><br>
	Yes<input type = "radio" name = "reported" value = "1"/>
	No <input type = "radio" name = "reported" value = "0" checked = "checked"/>


<h3>Recurrence</h3>
Yes <input type = "radio" name = "recurrence" value = "1" onclick="changeCelltype();"/>
No <input type = "radio" name = "recurrence" value = "0" checked = "checked"/>
<script type="text/javascript">
	function changeCelltype()
	{
		var recurrence = $("input[name=recurrence]:checked").val();
		var celltype;
		var type = document.getElementById("celltype");
		for(var i = 0; i < type.length; i++)
		{
			if(type[i].selected)
			{
				celltype = type[i].value;
			}
		}
		if(recurrence == '1' && (celltype == 'limited' || celltype == 'extensive'))
		{
			document.getElementById("celltype").value = 'smallcell';
			window.alert('changed celltype to small cell');
		}
		window.alert('did not do a thing');
	}

</script>

<h3>Blood Marker</h3>
Yes<input type = "radio" name = "bloodMark" value="1" /><br>
No<input type = "radio" name = "bloodMark" value="0" checked/><br>

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

<script type="text/javascript">
	function destination()
	{
		var age = $('#agedx').val();
		//window.alert("age = " + age);
		
		var gender = $("input[name=gender]:checked").val();
		//window.alert("gender = " + gender);
		
		var type = document.getElementById("celltype");
		var celltype;
		for(var i = 0; i < type.length; i++)
			{
				if(type[i].selected)
					{
					celltype = type[i].value;
					document.getElementById("celltype").setAttribute("name", celltype);
					document.getElementById("celltype").setAttribute("value",1);
					}
			}
		var x = document.getElementById("celltype").getAttribute("name");
		var y = document.getElementById("celltype").getAttribute("value");
		//window.alert("celltype name = " + x + " celltype value = " + y);
		
		
		var s = document.getElementById("stage");
		var stage;
		for(var i = 0; i < s.length; i++)
			{
				if(s[i].selected)
					{
					stage = s[i].value;
					document.getElementById("stage").setAttribute("name", stage);
					document.getElementById("stage").setAttribute("value",1);
					}
			}
		//window.alert(stage);
		
		var grade = $("input[name=grade]:checked").val();
		//window.alert(grade);
		
		var t = document.getElementById("treatment");
		var treatment = [];
		for(var i = 0; i < t.length; i++)
			{
				if(t[i].selected)
					{
					treatment.push(t[i].value);
					}
			}
		t.setAttribute("name", treatment);
		
		window.alert(treatment);
		
		var symptoms = $("input[name=reported]:checked").val();
		//window.alert(symptoms);
		
		var recurrence = $("input[name=recurrence]:checked").val();
		//window.alert(recurrence);
		
		var bmarker = $("input[name=bloodMark]:checked").val();
		//window.alert(bmarker);



		if(symptoms == '1')
			{
				document.getElementById('form_id').action = 'qol.jsp';	
			}
		else if(recurrence == '1' && treatment=='surgery'||recurrence == '1' && treatment=='surgchemo'||
				recurrence == '1' && treatment=='surgradiation'||recurrence == '1' && treatment=='surgradiationchemo'||
				recurrence == '1' && treatment=='neoadjuvent')
		{
			document.getElementById('form_id').action = 'recurrence.jsp';
		}
		else if(celltype == 'limited')
			{
				if(bmarker == 'null')
					{
					window.alert('Please provide blood testings for Small Cell Lung Cancer');
					}
				else
				{
					document.getElementById('form_id').action = 'limited.jsp';
				}
				
			}
		else if(celltype == 'extensive')
			{
				if(bmarker == '0')
					{
					window.alert('Please provide blood testings for Small Cell Lung Cancer');
					}
					else
					{
						document.getElementById('form_id').action = 'extensive.jsp';
					}	
			}
		else if(bmarker == '1')
					{
					window.alert('Model not available');
					}
				else 
					{
					document.getElementById('form_id').action = 'nscCurve.jsp';
					{
			}
		}
}
	
</script>

</body>
</html>