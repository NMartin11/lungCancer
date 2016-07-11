/**
 * Created by NMartin11 on 7/10/2016.
 */
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

    //window.alert(treatment);

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
        if(bmarker == '0')
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

//Note: The changeCellStage() is only for the QoL model, it SHOULD be placed in the qol.jsp
//It combiness stageia & stageib to stagei ... and combines limted & extensive to smallcell
function changeCellStage()
{

    var celltype;
    var type = document.getElementById("celltype");
    for(var i = 0; i < type.length; i++)
    {
        if(type[i].selected && (type[i].value=="limited" || type[i].value=="extensive") )
        {
            type[i].value = "smallcell";
        }
    }

    var stage;
    var stage = document.getElementById("stage");
    for(var i = 0; i < type.length; i++)
    {
        if(stage[i].selected && (stage[i].value=="stageia" || stage[i].value=="stageib") )
        {
            stage[i].value = "stagei";
        }
        else if(stage[i].selected && (stage[i].value=="stageiia" || stage[i].value=="stageiib") )
        {
            stage[i].value = "stageii";
        }
        else if(stage[i].selected && (stage[i].value=="stageiiia" || stage[i].value=="stageiiib") )
        {
            stage[i].value = "stageiii";
        }
    }
}


function changeTreatment()
{
    var type = document.getElementById("celltype");
    var valtype = type.options[type.selectedIndex].value;

    var recurrence = $("input[name=recurrence]:checked").val();
    var reported = $("input[name=reported]:checked").val();

    document.getElementById("treatment").options[0].disabled = false;
    document.getElementById("treatment").options[1].disabled = false;
    document.getElementById("treatment").options[2].disabled = false;
    document.getElementById("treatment").options[3].disabled = false;
    document.getElementById("treatment").options[4].disabled = false;
    document.getElementById("treatment").options[5].disabled = false;
    document.getElementById("treatment").options[6].disabled = false;
    document.getElementById("treatment").options[7].disabled = false;
    document.getElementById("treatment").options[8].disabled = false;
    document.getElementById("treatment").options[9].disabled = false;

    if (recurrence == "1")
    {
        document.getElementById("treatment").options[0].disabled = true;
        document.getElementById("treatment").options[1].disabled = false;
        document.getElementById("treatment").options[2].disabled = true;
        document.getElementById("treatment").options[3].disabled = true;
        document.getElementById("treatment").options[4].disabled = false;
        document.getElementById("treatment").options[5].disabled = false;
        document.getElementById("treatment").options[6].disabled = true;
        document.getElementById("treatment").options[7].disabled = false;
        document.getElementById("treatment").options[8].disabled = true;
        document.getElementById("treatment").options[9].disabled = true;
    }
    else if(valtype == "extensive" && reported == "0")
    {
        document.getElementById("treatment").options[0].disabled = true;
        document.getElementById("treatment").options[1].disabled = true;
        document.getElementById("treatment").options[2].disabled = false;
        document.getElementById("treatment").options[3].disabled = true;
        document.getElementById("treatment").options[4].disabled = true;
        document.getElementById("treatment").options[5].disabled = true;
        document.getElementById("treatment").options[6].disabled = false;
        document.getElementById("treatment").options[7].disabled = true;
        document.getElementById("treatment").options[8].disabled = true;
        document.getElementById("treatment").options[9].disabled = false;
    }
    else if(valtype == 'limited' && reported == "0")
    {
        document.getElementById("treatment").options[0].disabled = true;
        document.getElementById("treatment").options[1].disabled = true;
        document.getElementById("treatment").options[2].disabled = false;
        document.getElementById("treatment").options[3].disabled = true;
        document.getElementById("treatment").options[4].disabled = false;
        document.getElementById("treatment").options[5].disabled = true;
        document.getElementById("treatment").options[6].disabled = false;
        document.getElementById("treatment").options[7].disabled = true;
        document.getElementById("treatment").options[8].disabled = true;
        document.getElementById("treatment").options[9].disabled = false;
    }

}
