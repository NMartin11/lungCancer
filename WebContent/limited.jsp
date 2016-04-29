<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">

<%@ page import="lungCancer.Limited" %>


<script language="javascript" type="text/javascript" src="/flot/jquery.js"></script>
<script src="//ajax.googleapis.com/ajax/libs/jquery/1.9.1/jquery.min.js"></script>  
<title>Limited Small Cell</title>
</head>
<body>
<!-- put all variables from limited and extended small cell on this page -->

<form id = "form_id" action = "limitedCurve.jsp" method = "post" onsubmit = 'return limitedPage();'>

	<h3>Prophylactic Cranial Irradiation:</h3>
	Yes<input type = "radio" name = "pci" value = "1" required = "required" />
	No<input type = "radio" name = "pci" value = "0" /><br><br>

	<h3>Red Cell Distribution Width (Reference rage: 11-15%)</h3>
	<input id = "ln_rdw" type = "number" name = "ln_rdw" placeholder = "rdw"/>

	<h3>Lymphocyte (Reference range: 1300-3500 counts per L)</h3>
	<input type = "number" name = "lymphocyte" min = "0" />

	<h3>Neutrophil (Reference range: 2000-7500 counts per L)</h3>
	<input type = "number" name = "neutrophil" min = "0" /><br>

	<h3>Platelet (Reference range: 140-450 counts per L)</h3>
	<input type = "number" name = "platelet" min = "0" /><br>

	<h3>Hemoglobin (Reference range: 120-180g per L)</h3>
	<input type = "number" name = "hbx" min = "0" />
	
	<h3>ECOG Performance Score:</h3>
			<select id = "ps" name = "ps">
				<option value = "0"> 0 </option>
				<option value = "1"> 1 </option>
				<option value = "2"> 2 </option>
				<option value = "3"> 3 </option>
				<option value = "4"> 4 or More </option>
			</select>
	<br><br>
	
	<h3>Cessation of Smoking:</h3>
	Yes<input type = "radio" name = "quit" value = "1" /><br>
	No<input type = "radio" name = "quit" value = "0" />
	
	<br>

<br>

<input type="submit" value = "submit"/>	
</form>

<%
	Limited Session = new Limited();
	Session.createListSession(request, response);
%>

<script type="text/javascript">
function limitedPage()
{
	var pci = $("input[name=pci]:checked").val();

	
	var ln_rdw = $('#ln_rdw').val();

	
	var lymphocyte = $("#lymphocyte").val();

	
	var neutrophil = $("#neutrophil").val();

	
	var platelet = $("#platelet").val();

	
	var hbx = $("#hbx").val();

	
	var e = document.getElementById("ps");
	var ecog;
	for(var i = 0; i < e.length; i++)
		{
			if(e[i].selected)
				{
				ecog = e[i].value;
				}
		}

	
	var quit = $('input[name=pci]:checked').val();


}

</script>

</head>


</body>
</html>