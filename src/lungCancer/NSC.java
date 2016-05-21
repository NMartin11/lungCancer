package lungCancer;


import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Objects;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


public class NSC extends CoeffecientPrep{

	/*-----Methods-----
	 * runNSC(request,response)--> Gets all parameters and calculates survival rate: returns string
	 *  
	 */

	public ArrayList<String> runNSC(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException
	{
		/*-----Variables needed to calculate curve-----
		 *gender	cell type	grade	smoke history
		 *treatment	agedx		stage	
		*/
		
		CoeffecientPrep prep = new CoeffecientPrep();
		prep.setModel("background");
		prep.setBaseline();
		prep.setCoefficients(request, response);

		List<Object> list = prep.getCoefficients();
        list = prep.removeTreatments(list);
        prep.calcSum(prep.MultipleTreatmentList(list),prep.getModel());
		prep.calculate(prep.sumList);


		return resultList;
	}
	
	public static void main(String[] args) {

	}

}
