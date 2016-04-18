package lungCancer;


import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


public class NSC extends CoeffecientPrep{

	/*-----Methods-----
	 * runNSC(request,response)--> Gets all parameters and calculates survival rate: returns string
	 *  
	 */
	
	public String runNSC(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException
	{
		/*-----Variables needed to calculate curve-----
		 *gender	cell type	grade	smoke history
		 *treatment	agedx		stage	
		*/
		
		CoeffecientPrep prep = new CoeffecientPrep();
		prep.setModel("background");
		prep.setBaseline();
		prep.setCoefficients(request, response);
		System.out.println("Check coeffModel values " + prep.getCoefficients());

		List<Object> list = prep.getCoefficients();
		
		double sum = calcSum(list, prep.getModel());
		String results = prep.calculate(sum);
		System.out.println("Results: " + results);
		return results;
	}
	
	public static void main(String[] args) {
		// TODO Auto-generated method stub

	}

}
