package lungCancer;


import java.util.ArrayList;
import java.util.List;
import java.util.Objects;


/**
 * Created by NMartin11 on 5/12/2016.
 */
public class MyLists extends CoeffecientPrep {

    /*-----Methods-----
     * removeTreatments(List<Objects>) return list without treatments
     * createMultipleLists(List<Objects>) return list of lists
     */

    private final String[] treatmentLists = {"background","surgery","chemo","radiation","surgchemo","surgradiation",
            "chemoradiation","surgradiationchemo","neoadjuvent","othertrt"};

    public ArrayList<String> usedTreatments = new ArrayList<>();
    public List<Object> multipleLists = new ArrayList<>();

    //Removes all treatments selected by user
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

    //Split into lists each with there own treatment
    public List<Object> MultipleTreatmentList(List<Object> list)
    {
        for(int i = 0; i < usedTreatments.size(); i++)
        {
            List<Object> temp = new ArrayList<>(list);
            temp.add(usedTreatments.get(i));
            temp.add(1.0);
            multipleLists.add(i, temp);
        }
        return multipleLists;
    }


    public static void main(String[] args){
        MyLists mylist = new MyLists();
        List<Object> coeffList = new ArrayList<>();

        coeffList.add("agedx");
        coeffList.add(50);
        coeffList.add("gender");
        coeffList.add(1.0);
        coeffList.add("smkcurrent");
        coeffList.add(1.0);
        coeffList.add("adeno");
        coeffList.add(1);
        coeffList.add("stageia");
        coeffList.add(1);
        coeffList.add("grademoderate");
        coeffList.add(1.0);
        coeffList.add("surgery");
        coeffList.add(1.0);
        coeffList.add("chemo");
        coeffList.add(1.0);
        coeffList.add("radiation");
        coeffList.add(1.0);

        coeffList = mylist.removeTreatments(coeffList);
        mylist.MultipleTreatmentList(coeffList);

    }




}