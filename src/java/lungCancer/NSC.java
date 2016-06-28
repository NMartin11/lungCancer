package lungCancer;

import org.json.*;
import java.io.IOException;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


public class NSC extends CoeffecientPrep{

    JSONObject finalResults = new JSONObject();


	/*-----Methods-----
	 * runNSC(request,response)--> Gets all parameters and calculates survival rate: returns string
	 *  
	 */

	public void runNSC(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException, JSONException {
		/*-----Variables needed to calculate curve-----
		 *gender	cell type	grade	smoke history
		 *treatment	agedx		stage
		*/

		CoeffecientPrep prep = new CoeffecientPrep();
		prep.setModel("background");
		prep.setBaseline();
		prep.setCoefficients(request, response);

        /*  Gets list
         *  removes treatments selected in list
         *  creates multiple lists based on how many treatments were selected
         *  finds the sum of variables
         */
		List<Object> list = prep.getCoefficients();
        list = prep.removeTreatments(list);
        prep.calcSum(prep.MultipleTreatmentList(list),prep.getModel());
        List<double[][]> resultList = prep.calculate(prep.sumList);

/*       Creates JSON Object and sets the treatment name as the key
*        and the result list using that treatment
*/

       finalResults =  prep.resultAsJSON(resultList);

    }

    public JSONObject getFinalResults()
    {
        return this.finalResults;
    }

	
	public static void main(String[] args) {

	}

}
