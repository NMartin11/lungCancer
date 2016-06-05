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
    <%@ page import="org.json.simple.JSONObject" %>
    <%@ page import="org.json.simple.JSONArray" %>

    <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
	<title>Flot Example</title>
	<link href="examples.css" rel="stylesheet" type="text/css">
	<!--[if lte IE 8]><script language="javascript" type="text/javascript" src="../../excanvas.min.js"></script><![endif]-->
	<script language="javascript" type="text/javascript" src="flot/jquery.js"></script>
	<script language="javascript" type="text/javascript" src="flot/jquery.flot.js"></script>
	<script language="javascript" type="text/javascript" src="flot/jquery.flot.crosshair.js"></script>
    <script language="javascript" type="text/javascript" src="javascript/showGraph.js"></script>
<%
    //Uses java function from NSC.java/connection.java to calculate curve results
    JSONObject resultList = new JSONObject();
    NSC nsc = new NSC();

    //returns a JSON object to reslutList
    List<String> treatments = new ArrayList<>();
    nsc.runNSC(request,response);
    resultList = nsc.getFinalResults();
    System.out.println(resultList);

    //TODO: make JSON object a JSON string that replicates dataset object from flots javascript

%>
    <script type="text/javascript">

        $(function() {
            //TODO: get results from list to display curve
            var datasets = JSON.parseJSON(<%=resultList%>)

            // hard-code color indices to prevent them from shifting as
            // countries are turned on/off

            var i = 0;
            $.each(datasets, function(key, val) {
                val.color = i;
                ++i;
            });

            // insert checkboxes
            var choiceContainer = $("#choices");
            $.each(datasets, function(key, val) {
                choiceContainer.append("<br/><input type='checkbox' name='" + key +
                        "' checked='checked' id='id" + key + "'>" +
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
                }
            }

            $("#placeholder").bind("plothover", function (event, pos, item) {

                if ($("#enablePosition:checked").length > 0) {
                    var str = "(" + pos.x.toFixed(2) + ", " + pos.y.toFixed(2) + ")";
                    $("#hoverdata").text(str);
                }
            });

            plotAccordingToChoices();

            var legends = $("#placeholder .legendLabel");

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
                padding: "2px",
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
