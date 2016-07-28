package lungCancer;

import com.google.gson.JsonObject;
import com.google.gson.JsonParser;
import org.json.JSONException;
import org.json.JSONObject;
import java.io.BufferedReader;
import java.io.FileNotFoundException;
import java.io.FileReader;
import java.io.IOException;
import java.text.DecimalFormat;
import java.util.*;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;


public class CoeffecientPrep extends HttpServlet{

	private static final long serialVersionUID = 1L;
	private List<Object> modelCoeff;
	private List<Double> baseline = new ArrayList<Double>();
	private HashMap<String,Double> model = new HashMap<String,Double>();
    private final String[] treatmentLists = {"background","surgery","chemo","radiation","surgchemo","surgradiation",
                                                "chemoradiation","surgradiationchemo","neoadjuvent","othertrt"};
    public ArrayList<String> usedTreatments = new ArrayList<String>();
    public List<List<Object>> multipleLists = new ArrayList<List<Object>>();
    public List<Double> sumList = new ArrayList<Double>();
    public List<double[][]> resultList = new ArrayList<>();


	//----------------------Methods--------------------------

    /***
     * @Decription Sets Coefficients that are being used
      * @param request
     * @param response
     * @throws ServletException
     * @throws IOException
     */
	public void setCoefficients(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException
	{	
		//Makes session for age, gender, treatment for later use
		ArrayList<Object> testList = new ArrayList<Object>();

		Enumeration paramNames = request.getParameterNames();
		while(paramNames.hasMoreElements())
		{
			String paramName = (String)paramNames.nextElement();
			System.out.println("Name " + paramName);
			if(!paramName.contains(","))
			{
				testList.add(paramName);
			}
			String[] paramValues = request.getParameterValues(paramName);
			if(paramValues.length > 1)
			{
				for(int i = 0; i < paramValues.length; i++)
				{
					testList.add(paramValues[i]);
					testList.add(1);
				}
			}	else if(containsDigit(paramValues[0]))
				{
					double value = Double.parseDouble(paramValues[0]);
					testList.add(value);
				} else
					{
						testList.add(1);
					}
		}
		System.out.println("TestList: " + testList);
		this.modelCoeff = testList;
	}

    /***
     * @Description creates session to pass form data
     * @param request
     * @param response
     * @throws ServletException
     * @throws IOException
     */
	public void createListSession(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException
	{
		//Makes session for age, gender, treatment for later use
		ArrayList<Object> testList = new ArrayList<Object>();

		Enumeration paramNames = request.getParameterNames();
		while(paramNames.hasMoreElements())
		{
			String paramName = (String)paramNames.nextElement();
			System.out.println("Name " + paramName);
			if(!paramName.contains(","))
			{
				testList.add(paramName);
			}
			String[] paramValues = request.getParameterValues(paramName); 
			if(paramValues.length > 1)
			{
				for(int i = 0; i < paramValues.length; i++)
				{
					testList.add(paramValues[i]);
					testList.add(1);
				}
			}	else if(containsDigit(paramValues[0]))
				{
					double value = Double.parseDouble(paramValues[0]);			
					testList.add(value);
				} else
					{
						testList.add(1);
					}
		}
		System.out.println("TestList: " + testList);
		
		HttpSession session = request.getSession();
		session.setAttribute("coeffList", testList);
	}

    /***
     * @Description adds coeffiecients to the global list
     * @param list
     * @return
     */
	public List<Object> addCoefficients(List<Object> list)
	{
		this.modelCoeff.addAll(list);
		return this.modelCoeff;
	}

    /***
     *
     * @return
     */
	public List<Object> getCoefficients()
	{
		return this.modelCoeff;
	}

    /***
     *
     * @return
     */
	public List<Double> getBaseline()
	{
		return this.baseline;
	}

    /***
     * Set basline using global model list
     */
	public void setBaseline()
	{
		for(int i = 0; i < 61; i++)
		{
			baseline.add(this.model.get(Integer.toString(i)));
		}
	}

    /***
     * Retrieves CSV file and puts it in HashMap.
     * @param csvFileName
     */
	public void setModel(String csvFileName)
	{
		 HashMap<String, Double> model = new HashMap<String, Double>();
	        String csvFile = "C:/NewLCT/" + csvFileName +".csv";
	        BufferedReader br = null;
	        String line;
	        String cvsSplitBy = ",";
	        try
	        {
	            br = new BufferedReader(new FileReader(csvFile));
	            while ((line = br.readLine()) != null) {
	                // use comma as separator
	                String[] data = line.split(cvsSplitBy);

	                double value = Double.parseDouble(data[1]);
	                model.put(data[0], value);
	                //testing
	                //System.out.println(data[0] + " " + model.get(data[0]));
	            }
	        }	catch (FileNotFoundException e)
	        {
	            e.printStackTrace();
	        }
	        catch (IOException e)
	        {
	            e.printStackTrace();
	        }
	        finally
	        {
	            if (br != null)
	            {
	                try
	                {
	                    br.close();
	                }
	                catch (IOException e)
	                {
	                    e.printStackTrace();
	                }
	            }
	        }

	        //Finished going through the file
	        System.out.println("Done Reading file");

	        this.model = fixModel(model);
	}

    /**
     * Returns global model
     * @return
     */
	public HashMap<String,Double> getModel()
	{
		return this.model;
	}

    /**
     * Will fill gaps in data for the model being used: duplicates previous data
     * @param model
     * @return
     */
	public HashMap<String, Double> fixModel(HashMap<String,Double> model)
	{
		//loop to check for null key values 0 - 60
		for(int i = 0; i < 61; i++)
		{
			//check if i is a used key in model: if not then put key and set value of previous key val
			String key = Integer.toString(i);
			boolean check = model.containsKey(key);
			if(check == false)
			{
				double val = model.get(Integer.toString(i - 1));
				model.put(key, val);
			}
		}
		return model;
	}

    /***
     * Using Cox Proportional Hazard Model to calculate results
     * @param sumList
     * @return
     */
	public List<double[][]> calculate(List<Double> sumList)
    {
            for(Double sum : sumList)
            {
                double[][] arr = new double[60][2];

                for(int i = 0; i < 60; i++)	//iterates 60 times --> each time is a month --> total of 5 years
                {
                    double answer = 0;
                    answer =  ( Math.exp( -( 1- baseline.get(i)) * Math.exp(sum))); // calculates survival rate --> age multiplied by index value

                    //Formats value of answer to 10 decimal places
                    DecimalFormat df = new DecimalFormat("#.##########");
                    double  val = Double.parseDouble(df.format(answer));

                    //Create List of double[][] for results
                    arr[i][0] = i;
                    arr[i][1] = val;
                    System.out.println(i);
                }
                resultList.add(arr);
            }

	        return resultList;
	    }

    /***
     * Calculates sum to be used in calculate method
     * @param p
     * @param m
     * @return
     */
	public List<Double> calcSum(List<List<Object>> p, HashMap<String, Double> m)
    {
	        String str = "";
	        double val,val2;
	        double sum = 0;

            //For each list in p
            for(List<Object> temp: p)
            {
                //adds coefficient values being used
                for(int i = 0; i < temp.size(); i++)
                {
                    str = temp.get(i).toString();
                    i++;
                    if(m.containsKey(str) && !m.get(str).isNaN())
                    {
                        val = m.get(str);
                        val2 = Double.parseDouble(temp.get(i).toString());
                        System.out.println("val = " + val + " " + "val2 = " + val2);
                        sum += val * val2;
                    }
                }
                sumList.add(sum);
            }

	        System.out.println("Sum = " + sum);
	        return sumList;
	    }

    /***
     *
     * Removes all treatments selected by user
     * @param list
     * @return
     */
    public List<Object> removeTreatments(List<Object> list)
    {
        for(String str: treatmentLists)
        {
            if(list.contains(str))
            {
                int index = list.indexOf(str);
                list.remove(index + 1);
                list.remove(str);
                usedTreatments.add(str);
            }
        }
        return list;
    }

    /***
     Split into lists each with there own treatment
     *
     * @param list
     * @return
     */
    public List<List<Object>> MultipleTreatmentList(List<Object> list)
    {
        for(int i = 0; i < usedTreatments.size(); i++)
        {
            List<Object> temp = new ArrayList<Object>(list);
            temp.add(usedTreatments.get(i));
            temp.add(1.0);
            multipleLists.add(i, temp);
        }
        return multipleLists;
    }

    /***
     * Checks if string contains digit
     * @param s
     * @return
     */
	public final boolean containsDigit(String s) {
        boolean containsDigit = false;
        if(s != null && !s.isEmpty()){ for(char c : s.toCharArray()){
	            if(containsDigit = Character.isDigit(c)){
	                return containsDigit = true;
	            }
	        }
	    }
	    return containsDigit;
	}

    /***
     * Returns treatments being used
      * @return ArrayList
     */
    public ArrayList<String> getUsedTreatements()
    {
        return usedTreatments;
    }

    public List<Double> getSumList() {
        return this.sumList;
    }

    public List<double[][]> getResultList() {
        return this.resultList;
    }

    /***
     * Returns the results as a json object
     * @param resultList
     * @return
     * @throws JSONException
     */
    public JsonObject resultAsJSON(List<double[][]> resultList) throws JSONException {
        JsonObject finalResults = new JsonObject();
        List<String> t = new ArrayList<>();
        t = getUsedTreatements();

        for(int i = 0; i < t.size(); i++) {
            JSONObject obj = new JSONObject();
            obj.put("label", t.get(i));
            obj.put("data", resultList.get(i));
            JsonParser parser = new JsonParser();

            finalResults.add(t.get(i),parser.parse(obj.toString()));
        }
        return finalResults;
    }

}
