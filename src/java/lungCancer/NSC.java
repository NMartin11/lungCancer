package lungCancer;

import com.google.gson.JsonObject;
import org.json.*;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


public class NSC extends CoeffecientPrep{

    JsonObject finalResults = new JsonObject();
    List<String> usedTreatments = new ArrayList<>();
    List<double[][]> data = new ArrayList<double[][]>();

    /***
     * Calls necessary methods to generate results
     * @param request
     * @param response
     * @throws ServletException
     * @throws IOException
     * @throws JSONException
     */
	public void runNSC(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException, JSONException {

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
        usedTreatments = prep.getUsedTreatements();
        prep.calcSum(prep.MultipleTreatmentList(list),prep.getModel());
        data = prep.getResultList();
        List<double[][]> resultList = prep.calculate(prep.sumList);

       finalResults =  prep.resultAsJSON(resultList);

    }

    public List<String> getUsedTreatments() {
        return this.usedTreatments;
    }

    public List<double[][]> getData() {
        return data;
    }

    public JsonObject getFinalResults()
    {
        return this.finalResults;
    }



}
