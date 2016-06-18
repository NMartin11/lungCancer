package lungCancer;



import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


public class NSC extends CoeffecientPrep{

	/*-----Methods-----
	 * runNSC(request,response)--> Gets all parameters and calculates survival rate: returns string
	 *  
	 */

    JSONArray finalResults = new JSONArray();
    //TODO: change runNSC to normal method
    //TODO: create servlet method that returns json object

	public void runNSC(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException
	{
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
        resultList = prep.calculate(prep.sumList);

/*         Creates JSON Object and sets the treatment name as the key
*         and the result list using that treatment
*/
        //TODO: try json array in same format as var dataset from js page

        for(int i = 0; i < prep.usedTreatments.size(); i++)
        {
            finalResults.add(prep.usedTreatments.get(i));
            finalResults.add(resultList.get(i));
        }
	}

    public JSONArray getFinalResults()
    {
        return this.finalResults;
    }
	
	public static void main(String[] args) {

	}

}
