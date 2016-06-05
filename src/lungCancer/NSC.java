package lungCancer;

import org.json.simple.*;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


public class NSC extends CoeffecientPrep{

	/*-----Methods-----
	 * runNSC(request,response)--> Gets all parameters and calculates survival rate: returns string
	 *  
	 */
    JSONObject finalResults = new JSONObject();

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
        List<String> treatments = new ArrayList<>();
        treatments = prep.usedTreatments;
        //TODO: try json array in same format as var dataset from js page
        for(int i = 0; i < treatments.size(); i++)
        {
            finalResults.put(treatments.get(i),"label:" + treatments.get(i) + "," + "data:" + resultList.get(i));
        }
	}

    public JSONObject getFinalResults()
    {
        return this.finalResults;
    }
	
	public static void main(String[] args) {
        List<String> treatments = new ArrayList<>();
        treatments.add("chemo");
        treatments.add("radiation");
        treatments.add("surgery");
        JSONObject obj = new JSONObject();
        JSONObject JSobj = new JSONObject();
        for(String treat: treatments)
        {
            obj.put(treat,"[{0,0.998},{0,0.997},{0,0.996},{0,0.990}]");
        }

        String jsonObject = obj.toString();
        String string = obj.toJSONString();

        System.out.println(obj);
	}

}
