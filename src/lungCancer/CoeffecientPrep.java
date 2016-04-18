package lungCancer;

import java.io.BufferedReader;

import java.io.FileNotFoundException;
import java.io.FileReader;
import java.io.IOException;
import java.text.DecimalFormat;
import java.util.ArrayList;
import java.util.Enumeration;
import java.util.HashMap;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;


public class CoeffecientPrep extends HttpServlet{


	private static final long serialVersionUID = 1L;
	private List<Object> modelCoeff;
	private List<Double> baseline = new ArrayList<>();
	private HashMap<String,Double> model = new HashMap<>();
	
	
	//----------------------Methods--------------------------
	
	/*Gets Names of Parameters and returns them in a ArrayList
	public ArrayList<String> getParamNames(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException
	{	
		ArrayList<String> testList = new ArrayList<String>();

		
		Enumeration paramNames = request.getParameterNames();
		while(paramNames.hasMoreElements())
		{
			String paramName = (String)paramNames.nextElement();
			testList.add(paramName);
			System.out.println("Parameter name: " + paramName); 
		}
		return testList;
	}
*/	
	
	//Sets values of Parameters and returns them in a list of objects
	public void setCoefficients(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException
	{	
		//Makes session for age, gender, treatment for later use
		ArrayList<Object> testList = new ArrayList<>();

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

	public void createListSession(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException
	{
		//Makes session for age, gender, treatment for later use
		ArrayList<Object> testList = new ArrayList<>();

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
	
	public List<Object> addCoefficients(List<Object> list)
	{
		this.modelCoeff.addAll(list);
		return this.modelCoeff;
	}
	
	public List<Object> getCoefficients()
	{
		return this.modelCoeff;
	}

	public List<Double> getBaseline()
	{
		return this.baseline;
	}
	
	public void setBaseline()
	{
		for(int i = 0; i < 61; i++)
		{
			baseline.add(this.model.get(Integer.toString(i)));
		}
	}
	
	//Retrieves CSV file and puts it in HashMap. Takes the file name as a string
	//Will print out in the console
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

	public HashMap<String,Double> getModel()
	{
		return this.model;
	}
	
	//Will fill gaps in data for the model being used: duplicates previous data
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
	
	//Takes ArrayList with parameters and HashMap which holds the model for calculations
	public String calculate(double sum)
	    {
	        String results = "[";

	        for(int i = 0; i < 61; i++)	//iterates 60 times --> each time is a month --> total of 5 years
	        {
	            double answer = 0;
	            answer =  ( Math.exp( -( 1- baseline.get(i)) * Math.exp(sum))); // calculates survival rate --> age multiplied by index value

	            //Formats value of answer to 10 decimal places
	            DecimalFormat df = new DecimalFormat("#.##########");
	            String val = df.format(answer);

	            //Creates a string to pass to javascript in tracking.jsp page
	            //i being the month and val being survival curve
	            if(i < 60)
	            {
	                results += "[" + i + "," + " " + val + "],";
	            }
	            else
	            {
	                results += "[" + i + "," + " " + val + "]]";
	            }
	        }
	        return results;
	    }
	
	public Double calcSum(List<Object> p, HashMap<String, Double> m)
	    {
	        String str = "";
	        double val,val2;
	        double sum = 0;
	        //adds coefficient values being used
	        for(int i = 0; i < p.size(); i++)
	        {
	            str = p.get(i).toString();
	            i++;
	            if(m.containsKey(str) && !m.get(str).isNaN())
	            {
		            val = m.get(str);
		            val2 = Double.parseDouble(p.get(i).toString());
		            System.out.println("val = " + val + " " + "val2 = " + val2);
		            sum += val * val2;
	            }
	        }

	        System.out.println("Sum = " + sum);
	        return sum;
	    }
	
	//Checks if the string has a digit: if it does returns true
	public final boolean containsDigit(String s)
	{  
	    boolean containsDigit = false;
	    if(s != null && !s.isEmpty()){
	        for(char c : s.toCharArray()){
	            if(containsDigit = Character.isDigit(c)){
	                return containsDigit = true;
	            }
	        }
	    }
	    return containsDigit;
	}

	
	
	public static void main(String[] args) {
		
		
	}

}