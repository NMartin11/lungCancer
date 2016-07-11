package lungCancer;


import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


public class Recurrence extends CoeffecientPrep {

	/*----Methods----
	 * runRecurrence(request,response) --> calculates curve for recurrence model
	 * createSession(request,response) --> creates session to access needed variables later
	 * getRiskScore(ArrayList) --> calculates risk score based on parameter values from postRecurrence.jsp
	 * getRiskGroup(ArrayList) --> determines what risk group will be used based on risk score
	 * 
	 */
	
	
	public List<double[][]> runRecurrence(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException
	{
		/*-----Variables needed to calculate curve-----
		 *gender	cell type	grade	smoke history
		 *treatment	agedx		stage	
		*/
		
		CoeffecientPrep prep = new CoeffecientPrep();
		prep.setModel("recurrence");
		prep.setBaseline();
		prep.setCoefficients(request, response);
		prep.addCoefficients((List<Object>) request.getSession().getAttribute("coeffList"));
		System.out.println("Check coeffModel values " + prep.getCoefficients());


		List<Object> list = prep.getCoefficients();
		double score = getRiskScore(list);
		String group = getRiskGroup(score);
		list.add(group);
		list.add(1);
		System.out.println("Values in list array =" + list);

        list = prep.removeTreatments(list);
        prep.calcSum(prep.MultipleTreatmentList(list),prep.getModel());
        prep.calculate(prep.sumList);

        return resultList;
	}
	
	public void createSession(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException
	{
		String stage = request.getParameter("stage");
		request.getSession().setAttribute("stage", stage);
	}
	
	public double getRiskScore(List<Object> arr)
	{
		double score = 0;
		int index;
		
		index = arr.indexOf("symprec");
		double symprec = Double.parseDouble(arr.get(index + 1).toString());
		
		index = arr.indexOf("rliver");
		double rliver = Double.parseDouble(arr.get(index + 1).toString());
		
		index = arr.indexOf("numrec");
		double numrec = Double.parseDouble(arr.get(index + 1).toString());
		
		index = arr.indexOf("psrec");
		double psrec = Double.parseDouble(arr.get(index + 1).toString());
		
		if(psrec == 1)
		{
			score = score + 1.5;
		}
		else if(psrec == 2)
		{
			score = score + 2.8;
		}
		else if(psrec == 3)
		{
			score = score + 4.2;
		}
		
		score =+ (numrec * 1) + (rliver * 2.3) + (symprec * 3.6);
		System.out.println("Score = " + score);
		
		double stghi = 0;
		for(int i = 0; i < arr.size(); i++)
		{
			if(arr.contains("stage"))
			{
				String str = arr.get(i).toString();
				if(str.equalsIgnoreCase("stageia") || str.equalsIgnoreCase("stageiia"))
				{
					stghi = 0;
				} else if(str.equalsIgnoreCase("stageiib") || str.equalsIgnoreCase("stageiiib"))
					{
						stghi = 1.8;
					}
			}
		}
		score = score + stghi;
		System.out.println("Score = " + score);		
		
		return score;
	}

	public String getRiskGroup(double score)
	{
		String group = "riskgrp2";
		 if(score >= 4.1 && score <= 6 )
		{
			return group = "riskgrp2";
		}
		else if(score >= 6.1 && score<= 8)
		{
			return group = "riskgrp3";
		}
		else if(score> 8)
		{
			return group = "riskgrp4";
		}
		return group;
	}
	

	public static void main(String[] args) {

    }
}
