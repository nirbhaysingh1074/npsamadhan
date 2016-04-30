package com.unihyr.constraints;

import java.util.ArrayList;
import java.util.List;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import scala.languageFeature.reflectiveCalls;
/**
 * Used to store configuartion variables which will exist 
 * for whole application
 * @author Rohit Tiwari
 */
public class GeneralConfig 
{
	public static final double CESS = 0.5;
	public static final String UploadPath = "/var/unihyr/data/";
	public static double TAX = 14;
	public static int NoOfRatingParams = 3;
	public static int rpp = 10;
	public static int rpp_cons = 10;
	public static int globalRatingMaxRows1=10*NoOfRatingParams;
	public static int globalRatingWeight1=50;
	public static int globalRatingMaxRows2=21;
	public static int globalRatingWeight2=50;
	public static String admin_email = "amar@silvereye.co";
	public static int filesize=1024000;
	public static List<String> filetype = new ArrayList<>();
	
	static
	{
		filetype.add("doc");
		filetype.add("docx");
		filetype.add("pdf");
	}
	
	public static String passwordRegEx = "(?=.*\\d)(?=.*[a-z]).{6,20}";
	
	public static boolean checkPasswordValid(String password)
	{
		Pattern p = Pattern.compile(passwordRegEx);//. represents single character  
		Matcher m = p.matcher(password);  
		boolean b = m.matches();  
		return b;
	}
}
