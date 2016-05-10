<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01//EN" "http://www.w3.org/TR/html4/strict.dtd">
<html>
<head>
	<%@ page import="lungCancer.CoeffecientPrep" %>
	<%@ page import="lungCancer.NSC" %>
    <%@ page import="java.util.List" %>
    <%@ page import="java.util.ArrayList" %>
    <%@ page import="java.util.*" %>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
	<title>Flot Example</title>
	<link href="examples.css" rel="stylesheet" type="text/css">
	<!--[if lte IE 8]><script language="javascript" type="text/javascript" src="../../excanvas.min.js"></script><![endif]-->
	<script language="javascript" type="text/javascript" src="flot/jquery.js"></script>
	<script language="javascript" type="text/javascript" src="flot/jquery.flot.js"></script>
	<script language="javascript" type="text/javascript" src="flot/jquery.flot.crosshair.js"></script>

<%
    //Uses java function from NSC.java/connection.java to calculate curve results
	NSC nsc = new NSC();
    //String results = nsc.runNSC(request,response);
    String temp1 = "[[0, 0.9999348211],[1, 0.9965811844],[2, 0.9922479041],[3, 0.9874647028],[4, 0.9832159416],[5, 0.9794621641],[6, 0.9755124241],[7, 0.9715942569],[8, 0.9675570381],[9, 0.9633792607],[10, 0.9595088228],[11, 0.9557196276],[12, 0.9514568265],[13, 0.9472509198],[14, 0.9436876576],[15, 0.9396892696],[16, 0.9361625616],[17, 0.9324332109],[18, 0.9290728591],[19, 0.92565974],[20, 0.9224240493],[21, 0.9189742473],[22, 0.9160066585],[23, 0.9127602501],[24, 0.9098657115],[25, 0.9070117823],[26, 0.9042467409],[27, 0.900669035],[28, 0.8974106946],[29, 0.8948704962],[30, 0.8923170839],[31, 0.8896942178],[32, 0.8866097848],[33, 0.8836961914],[34, 0.8820002278],[35, 0.8796528834],[36, 0.8773332836],[37, 0.8750343892],[38, 0.87325455],[39, 0.8706967381],[40, 0.8678695121],[41, 0.8659429566],[42, 0.8632849274],[43, 0.8611178826],[44, 0.8582295213],[45, 0.8560540434],[46, 0.854152473],[47, 0.8519814477],[48, 0.8500455044],[49, 0.8478284273],[50, 0.845733453],[51, 0.8440171992],[52, 0.8418346409],[53, 0.8398029428],[54, 0.838313519],[55, 0.8362686194],[56, 0.8345872174],[57, 0.8328069148],[58, 0.8309863003],[59, 0.8292000893],[60, 0.8272324579]]";
    String temp2 = "[[0, 0.9996609484],[1, 0.9823406767],[2, 0.9603207108],[3, 0.9364791804],[4, 0.9157046724],[5, 0.8976616487],[6, 0.8789878838],[7, 0.8607746925],[8, 0.8423282233],[9, 0.8235770639],[10, 0.8065076305],[11, 0.7900744735],[12, 0.7719117625],[13, 0.7543235135],[14, 0.7396772813],[15, 0.7235169303],[16, 0.7095008256],[17, 0.6949188],[18, 0.6819878448],[19, 0.6690535088],[20, 0.6569752361],[21, 0.6442923548],[22, 0.6335412094],[23, 0.621946404],[24, 0.6117534534],[25, 0.6018360454],[26, 0.5923517916],[27, 0.5802595975],[28, 0.5694210656],[29, 0.5610853083],[30, 0.5528058109],[31, 0.5444041459],[32, 0.5346562575],[33, 0.5255782516],[34, 0.5203516703],[35, 0.5131870268],[36, 0.5061855569],[37, 0.4993229179],[38, 0.4940615444],[39, 0.4865789176],[40, 0.4784149367],[41, 0.4729154239],[42, 0.4654118002],[43, 0.459365655],[44, 0.451405807],[45, 0.4454844212],[46, 0.440360118],[47, 0.4345680165],[48, 0.4294551455],[49, 0.4236595976],[50, 0.4182414476],[51, 0.4138446004],[52, 0.4083071452],[53, 0.403206382],[54, 0.3994998481],[55, 0.3944558571],[56, 0.3903471278],[57, 0.3860344737],[58, 0.3816640558],[59, 0.3774151533],[60, 0.3727790141]]";
    ArrayList<String> results = new ArrayList<String>();
    results.add(temp1);
    results.add(temp2);
%>

<%@ include file="plotCurve.jspf" %>
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
