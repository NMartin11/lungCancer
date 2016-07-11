package lungCancer;


import java.io.IOException;
import java.util.ArrayList;
import java.util.Enumeration;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


public class qolCurve extends CoeffecientPrep{

	
	private static final long serialVersionUID = 1L;
	
	/*-----Methods-----
	 * run(request,response) 			--> Gets all parameters and calculates survival rate: returns string
	 * qolVar(request,response) 		--> determines what comorbidities to use: returns Array List
	 * createSession(request.response)	--> sets session for parameters ( age, treatment, gender, stage, celltype )
	 */
	
	public void createSession(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException
	{
		System.out.println("FROM New Patient JSP PAGE");
		String age = request.getParameter("agedx");
		String gender = request.getParameter("gender");
		String treatment = request.getParameter("treatment");
		String celltype = request.getParameter("celltype");
		String stage = request.getParameter("stage");

		System.out.println(age);
		System.out.println(gender);
		System.out.println(treatment);
		System.out.println(celltype);
		System.out.println(stage);
		System.out.println("");


		request.getSession().setAttribute("age", age);
		request.getSession().setAttribute("gender", gender);
		request.getSession().setAttribute("treatment", treatment);
		request.getSession().setAttribute("celltype", celltype);
		request.getSession().setAttribute("stage", stage);
	}
	
	public ArrayList<String> qolVar(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException
	{
		ArrayList<String> listValues = new ArrayList<String>();
		ArrayList<String> listNames = new ArrayList<String>();
		Enumeration paramNames = request.getParameterNames();
		System.out.println("Enumeration Loop");
		while(paramNames.hasMoreElements())
		{
			String paramName = (String)paramNames.nextElement();
			String[] paramValues = request.getParameterValues(paramName);
			
			listNames.add(paramName);
			System.out.println(paramName);
			listValues.add(paramValues[0]);	
		}
		System.out.println("");
		System.out.println("List Names: " + listNames);
		System.out.println("List Values: " + listValues);
		System.out.println("");
		for(int i = 0; i < listNames.size(); i++)
		{
			String valTemp = listValues.get(i);
			System.out.println("valTemp: " + valTemp);
			boolean contains = containsDigit(valTemp);
			if(contains == true)
			{
				double val = Double.parseDouble(valTemp);
				System.out.println("val: " + val);
				if(val >= 5)
				{
					listNames.remove(i);
					i--;
				}
			}
		
		}
		return listNames;
	}
	
	public List<double[][]> runQOL(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException
	{	
		
		/*-----Variables needed---------
		*Age		gender			stage	celltype	
		*treatment	comorbidities	
		*
		*/
		CoeffecientPrep prep = new CoeffecientPrep();
		prep.setModel("qolModel");
		prep.setBaseline();
		prep.setCoefficients(request, response);
		prep.addCoefficients((List<Object>) request.getSession().getAttribute("coeffList"));
		System.out.println("Check coeffModel values " + prep.getCoefficients());


		List<Object> list = prep.getCoefficients();
		System.out.println("Values in list array =" + list);

		int index;

		index = list.indexOf("fatigue");
		double fatigue = Double.parseDouble((list.get(index + 1).toString()));
		list.remove(index + 1);
		list.add(index + 1, comorbVal(fatigue));

		index = list.indexOf("cough");
		double cough = Double.parseDouble((list.get(index + 1).toString()));
		list.remove(index + 1);
		list.add(index + 1,comorbVal(cough));

		index = list.indexOf("dyspnea");
		double dyspnea = Double.parseDouble((list.get(index + 1).toString()));
		list.remove(index + 1);
		list.add(index + 1,comorbVal(dyspnea));

        list = prep.removeTreatments(list);
        prep.calcSum(prep.MultipleTreatmentList(list),prep.getModel());
        prep.calculate(prep.sumList);

		return resultList;
	}

	public double comorbVal(double score)
	{
		double val = score;
		if(val >= 5)
		{
			return 0;
		} else
		{
			return 1;
		}		
	}
	
	public static void main(String[] args) {
		

	}

}
