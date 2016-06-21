<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01//EN" "http://www.w3.org/TR/html4/strict.dtd">
<html>
<head>
	<%@ page import="lungCancer.connection" %>
	<%@ page import = "java.util.ArrayList" %>
	<%@ page import = "java.util.HashMap" %>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
	<title>LCT</title>
	<link href="test.css" rel="stylesheet" type="text/css">
	<!--[if lte IE 8]><script language="javascript" type="text/javascript" src="../../excanvas.min.js"></script><![endif]-->
	<script language="javascript" type="text/javascript" src="flot/jquery.js"></script>
	<script language="javascript" type="text/javascript" src="flot/jquery.flot.js"></script>
	<script language="javascript" type="text/javascript" src="flot/jquery.flot.crosshair.js"></script>
	<script language="javascript" type="text/javascript" src="flot/jquery.flot.resize.js"></script>
	
	
	<script type="text/javascript">

	<%
	//Creates the hashmap that will hold the values for the model
	HashMap<String, Double> backgroundFile = new HashMap<String, Double>();
	//Creates the arralist that will hold the values submitted from index.jsp
	ArrayList<String> BparamValues = new ArrayList<String>();
	connection background = new connection();
	
	background.doGet(request, response);
	BparamValues = background.paramList;
	backgroundFile = background.readBackground();
	String results = background.calculate(BparamValues, backgroundFile);
	
	//Creates the hashmap that will hold the values for the model
	HashMap<String, Double> treatmentFile = new HashMap<String, Double>();
	//Creates the arralist that will hold the values submitted from index.jsp
	ArrayList<String> TparamValues = new ArrayList<String>();
	connection treatment = new connection();
	
	treatment.doGet(request, response);
	TparamValues = treatment.paramList;
	treatmentFile = treatment.readTreatment();
	String treatResults = treatment.calculate(TparamValues, treatmentFile);
	
	//System.out.println(results);
	
	%>
	$(function() {
			
			var datasets = {       
					"background": {
					label: "background",
					data: <%= results %> 
						
				},
				"treatment": {
					label: "treatment",
					data: <%= treatResults %>
				}
		};
	
			var i = 0;
			$.each(datasets, function(key, val) {
				val.color = i;
				++i;
			});

			//insert checkboxes 
			var choiceContainer = $("#choices");
			$.each(datasets, function(key, val) {
				choiceContainer.append("<br/><input type='checkbox' name='" + key +
					"' checked='checked' id='id" + key + "'></input>" +
					"<label for='id" + key + "'>"
					+ val.label + "</label>");
			});

			choiceContainer.find("input").click(plotAccordingToChoices);


			function plotAccordingToChoices() {

				var data = [];

				choiceContainer.find("input:checked").each(function () {
					var key = $(this).attr("name");
					if (key && datasets[key]) {
						data.push(datasets[key]);
					}
				}); 
				
				

				if (data.length > 0) {
					$.plot("#placeholder", data, {
						 legend: {
						      show: true,
						      container: $('#legend-container'),
						      noColumns: 0,
						    },
					
				series: {
					lines: {
						show: true,
					}
				},
				
				grid: {
					hoverable: true,
					clickable: true,
					autoHighlight: true
				},
				yaxis: {
					min: 0.0,
					max: 1.0
				},
				
				xaxis: {
					min: 0,
					max: 60 }
			});					
				
					
					window.resize = function(event) {
					    $.plot($("#placeholder"), datasets);    };
					
					choiceContainer.find("input").click(plotAccordingToChoices);
				}
				
			} 
			
			
			
			
			$("#placeholder").bind("plothover", function (event, pos, item) {

				if ($("#enablePosition:checked").length > 0) {
					var str = "(" + pos.x.toFixed(2) + ", " + pos.y.toFixed(2) + ")";
					$("#hoverdata").text(str);
				}
			});

			plotAccordingToChoices();

			var legends = $(".demo-container .legendLabel");

			legends.each(function () {
				// fix the widths so they don't jump around
				$(this).css('width', $(this).width()+2);
			});

			var updateLegendTimeout = null;
			var latestPosition = null;

			function updateLegend() {

				updateLegendTimeout = null;

				var pos = latestPosition;

				var axes = plot.getAxes();
				if (pos.x < axes.xaxis.min || pos.x > axes.xaxis.max ||
					pos.y < axes.yaxis.min || pos.y > axes.yaxis.max) {
					return;
				}

				var i, j, dataset = plot.getData();
				for (i = 0; i < dataset.length; ++i) {

					var series = dataset[i];

					// Find the nearest points, x-wise

					for (j = 0; j < series.data.length; ++j) {
						if (series.data[j][0] > pos.x) {
							break;
						}
					}

					// Now Interpolate

					var y,
						p1 = series.data[j - 1],
						p2 = series.data[j];

					if (p1 == null) {
						y = p2[1];
					} else if (p2 == null) {
						y = p1[1];
					} else {
						y = p1[1] + (p2[1] - p1[1]) * (pos.x - p1[0]) / (p2[0] - p1[0]);
					}

					legends.eq(i).text(series.label.replace(/=.*/, "= " + y.toFixed(2)));
				}
			} 

			$("#placeholder").bind("plothover",  function (event, pos, item) {
				latestPosition = pos;
				if (!updateLegendTimeout) {
					updateLegendTimeout = setTimeout(updateLegend, 50);
				}
			});

			$("<div id='tooltip'></div>").css({
				position: "absolute",
				display: "none",
				border: "1px solid #fdd",
				"font-size": "0.8em",
				color: "#000",
				"background-color": "#fee",
				opacity: 0.80
			}).appendTo("body");

			$("#placeholder").bind("plothover", function (event, pos, item) {

				if (true) {
					var str = "(" + pos.x.toFixed(2) + ", " + pos.y.toFixed(2) + ")";
					$("#hoverdata").text(str);
				}

				if (true) {
					if (item) {
						var x = item.datapoint[0].toFixed(2),
							y = item.datapoint[1].toFixed(2);

						$("#tooltip").html(item.series.label + " of " + x + " months = " + y*100 +"%")
							.css({top: item.pageY+5, left: item.pageX+5})
							.fadeIn(200);
					} else {
						$("#tooltip").hide();
					}
				}
			});

			// Add the Flot version string to the footer

			$("#footer").prepend("Flot " + $.plot.version + " &ndash; ");
		});
		</script>
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
	
	<h2>Patient ID #1</h2>
		<p id="keep">*keep this number for later reference</p>
		<p id="choices">Show:</p>

			<div class="demo-container">
				<div id="legend-container"></div>
				<div id="placeholder" class="demo-placeholder"></div>
			</div>
	</main>

	<footer>
	<hr>
	<p>
		Copyright Lung Cancer Study at Mayo and Winona State University
	</p>
	</footer>
	
	</body>
	</html>
