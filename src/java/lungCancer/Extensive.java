package lungCancer;



import org.json.JSONException;
import org.json.JSONObject;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class Extensive extends CoeffecientPrep {

    JSONObject finalResults = new JSONObject();

	/*------Methods----
	 * runExtensive(request,response) throws ServletException, IOException
	 * getMetas2(String) --> evaluates score and returns string: either param name or null value
	 * createSession(request,response) --> creates session for needed variables for later use
	 */

	
	
	public void  runExtensive(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException, JSONException
	{
		/*-----Variables needed to calculate curve-----
		 *gender	cell type	grade	smoke history
		 *treatment	agedx		stage	pci
		 *ln_rdw	ln_nlr		plrx	hbx
		 *psx		quit
		*/
		
		CoeffecientPrep prep = new CoeffecientPrep();
		prep.setModel("extensive");
		prep.setBaseline();
		prep.setCoefficients(request, response);
		prep.addCoefficients((List<Object>) request.getSession().getAttribute("coeffList"));
		System.out.println("Check coeffModel values " + prep.getCoefficients());


		List<Object> list = prep.getCoefficients();
		
		System.out.println("Check List values " + list);
		int index;
	
		index = list.indexOf("lymphocyte");
		double lymph =  Double.parseDouble(list.get(index + 1).toString());
		
		index = list.indexOf("neutrophil");
		double neutro = Double.parseDouble(list.get(index + 1).toString());
		
		index = list.indexOf("platelet");
		double plat = Double.parseDouble(list.get(index + 1).toString());
		
		index = list.indexOf("ps");
		double psx = Double.parseDouble(list.get(index + 1).toString());
		
		index = list.indexOf("hbx");
		double hbx = Double.parseDouble(list.get(index + 1).toString());
		
		index = list.indexOf("num_metas_over2");
		double num_metas_over2 = Double.parseDouble(list.get(index + 1).toString());
		
		double ln_nlr = nRatio(neutro, lymph);
		list.add("ln_nlr");
		list.add(ln_nlr);
		
		double plrx = pRatio(plat,lymph);
		list.add("plrx");
		list.add(plrx);
		
		psx = getECOG(psx);
		list.add("psx");
		list.add(psx);
		
		hbx = getHemo(hbx);
		index = list.indexOf("hbx");
		list.remove(index + 1);
		list.add(index + 1, hbx);
		
		num_metas_over2 = getMetas2(num_metas_over2);
		index = list.indexOf("num_metas_over2");
		list.remove(index+ 1);
		list.add(index + 1, num_metas_over2);
		
		index = list.indexOf("ln_rdw");
		double ln_rdw = Double.parseDouble(list.get(index + 1).toString());
		ln_rdw = redCellDistribution(ln_rdw);
		list.remove(index + 1);
		list.add(index + 1, ln_rdw);
				
		
		//Test to see values in list
		for(int i = 0; i < list.size(); i++)
		{
			System.out.println("Params Used: " + list.get(i));
		}

        list = prep.removeTreatments(list);
        prep.calcSum(prep.MultipleTreatmentList(list), prep.getModel());
        List<double[][]> resultList = new ArrayList<>();
        resultList = prep.calculate(prep.sumList);

        finalResults = prep.resultAsJSON(resultList);
	}

	
	//calculates natural log of the ratio of neutrophil and lymphocyte
	public double nRatio(double neutro, double lympho)
	{
		double n, l, nRatio;
		n = neutro;
		l = lympho;
		
		nRatio = Math.log(n / l);
		return nRatio;
	}
	
	//calculates natural log of the ratio of platelete and lymphocyte
	public  double pRatio(double platelete, double lympho)
	{	double result;
		double p, l, pRatio;
		p = platelete;
		l = lympho;
		
		pRatio = p / l;
		
		if(pRatio < 210)
		{
			result = 0;		
		}
		else
		{
			result = 1;
		}
				
		return result;
	}

	
	public double redCellDistribution(double rdw)
	{
			double rdwRatio = Math.log(rdw);
			
			return rdwRatio;
	}
	
	
	
	public double getMetas2(double meta2)
	{
			double val = meta2;
			if(val < 2)
			{
				return 0;
			}
		return 1;
	}

	
	public double getHemo(double hbx)
	{
			double val = hbx;
			if(val >= 12)
			{
				return 0;
			}
		return 1;
	}
	
	
	
	public double getECOG(double psx)
	{
		double val = psx;
			if(val < 2)
			{
				return 0;
			}
		return 1;
	}
	

//    Getters

    public JSONObject getFinalResults()
    {
        return this.finalResults;
    }
	
	public static void main(String[] args) {
		

	}

}
