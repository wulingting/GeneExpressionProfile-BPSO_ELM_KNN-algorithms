package dealtxt;

import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.InputStreamReader;
import java.io.OutputStreamWriter;
import java.util.HashMap;
import java.util.Map;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

public class dealmytxt2 {

    private static final Integer ONE = 1;
    private static Integer TranscriptIDnum = 0;
    private static Integer Namenum = 0;
    private static Integer Namenum2 = 0;
    private static Integer Rationum = 0;
    private static String[] Name=new String[20];
    private static String[] Ratio=new String[4020];
    private static String[] TranscriptID=new String[20];
    

    public static void main(String[] args) {
        Map<String, Integer> map = new HashMap<String, Integer>();

        /* 读取数据 */
        try {
            BufferedReader br = new BufferedReader(new InputStreamReader(new FileInputStream(new File("C:/Users/LY/Desktop/lxa/StageIvsNormal29.txt")),
                                                                         "UTF-8"));
            String lineTxt = null;
            while ((lineTxt = br.readLine()) != null) {
//              System.out.print(lineTxt);
       
              String[] sourceStrArray = lineTxt.split("\n");
              for (int i = 0; i < sourceStrArray.length; i++) {
                  String s=sourceStrArray[i];//获取每行
                  boolean isTranscriptID = s.contains("text-decoration:none;");
                  boolean isName = s.contains("<td id=\"td_text_right\" style=\"padding-left: 5px; padding-right: 5px; white-space: nowrap;\">");
                  boolean isratio = s.contains("TCGA");
                  if(isratio==true)
                  {
                	  Pattern p = Pattern.compile("07: (.*)\">");  
                	  Matcher m = p.matcher(s);  
                	  while(m.find()){
                		
               		   String str= m.group(0);
//               		 System.out.print(str);System.out.print(" ");
               		 String str1=str.substring(4,(str.length())-1);
//               		 str=str.substring(4,str.length()-2);
//               		  System.out.print(str1);System.out.print(" ");
//               		System.out.print(Rationum);
                	  Ratio[Rationum]=str1;
                	  Rationum++; 
                	  
                	  }
                  }                
                  else if(isTranscriptID==true)
                  {
                	  Pattern p = Pattern.compile("none;\">(.*)</a></td>");  
                	  Matcher m = p.matcher(s);
                	  while(m.find()){  
                		  String str= m.group(1); 
//                		  System.out.print(str); System.out.print(" ");
                		  TranscriptID[TranscriptIDnum]=str;
                		  TranscriptIDnum++;
                    	  }
                   }
                  else if(isName==true)
                  { 
                	  Namenum2++;
                	  if(Namenum2%4==0)
                	  {
                      Pattern p = Pattern.compile("\">(.*)</td>");  
                	  Matcher m = p.matcher(s);
                	  while(m.find()){  
                		  String str= m.group(1);
//                		  System.out.print(str); System.out.print(" ");
                		  Name[Namenum]=str;
                		  Namenum++;
                    	  }
                	  }
                	
                  }
                 
              }
//                for (String name : names) {
//                    if (map.keySet().contains(name)) {
//                        map.put(name, (map.get(name) + ONE));
//                    } else {
//                        map.put(name, ONE);
//                    }
//                }
            }
            br.close();
        } catch (Exception e) {
            System.err.println("read errors :" + e);
        }
System.out.print(Rationum);System.out.print(" ");
System.out.print(TranscriptIDnum);System.out.print(" ");
System.out.print(Namenum);
System.out.printf("\n");
for(int i=0;i<Namenum;i++)
{
	 System.out.print(Name[i]); System.out.print(" ");
}
System.out.printf("\n");
for(int i=0;i<TranscriptIDnum;i++)
{
	 System.out.print(TranscriptID[i]); System.out.print(" ");
}
System.out.printf("\n");
for(int i=0;i<Rationum;i++)
{
	 System.out.print(Ratio[i]); System.out.print(" ");
}
	
		
        /* 输出数据 */
try {
    BufferedWriter bw = new BufferedWriter(new OutputStreamWriter(new FileOutputStream(new File("C:/Users/LY/Desktop/lxa/StageIvsNormalRatio29.txt")),
                                                                  "UTF-8"));

    for(int i=0;i<Rationum;)
    {
    	String Ratiow = Ratio[i];
    	Ratiow=Ratiow.substring(0,Ratiow.length()-1);
    	if(Ratiow.length()>7)
    		Ratiow=Ratiow.substring(0,7);
        bw.write(Ratiow+" ");
        i++;
        if(i%201==0)
        	bw.write("\n");
    }
    bw.close();
} catch (Exception e) {
    System.err.println("write errors :" + e);
}
try {
    BufferedWriter bw = new BufferedWriter(new OutputStreamWriter(new FileOutputStream(new File("C:/Users/LY/Desktop/lxa/StageIvsNormalTranscriptID29.txt")),
                                                                  "UTF-8"));

    for(int i=0;i<TranscriptIDnum;i++)
    {
        bw.write(TranscriptID[i] + ";");
        
    }
    bw.close();
} catch (Exception e) {
    System.err.println("write errors :" + e);
}
        try {
            BufferedWriter bw = new BufferedWriter(new OutputStreamWriter(new FileOutputStream(new File("C:/Users/LY/Desktop/lxa/StageIvsNormalName29.txt")),
                                                                          "UTF-8"));

            for(int i=0;i<Namenum;i++)
            {
                bw.write(Name[i] + ";");
                
            }
            bw.close();
        } catch (Exception e) {
            System.err.println("write errors :" + e);
        }
    }
	 
	 
	}
