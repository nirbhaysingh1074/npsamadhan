package com.unihyr.constraints;

import java.util.ArrayList;
import java.util.List;
import java.util.Random;
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
	public static final double KrishiKalyan = 0.5;
	public static final String UploadPath = "/var/unihyr/data/";
	public static final String Label_Activate = "Activate";
	public static final String Label_DeActivate = "Deactivate";
	public static final String SubmittedOnly = "Pending";
	public static final String Withdraw = "Withdrawn";
	public static final String Shortlist = "In Process";
	public static final String ShortlistRejected = "CV Rejected";
	public static final String SendOffer = "Offer Sent";
	public static final String SendOfferDb = "recruited";
	public static final String SendOfferReject = "Interview Reject";
	public static final String OfferAccept = "Offered";
	public static final String OfferAcceptReject = "Offer Declined";
	public static final String OfferJoin = "Joined";
	public static final String OfferDrop = "Dropped";
	//public static final String UniHyrUrl = "http://localhost:8082/unihyr/";
	public static final String DataUrl = "http://54.191.37.178/";
	//public static final String UniHyrUrl = "http://54.191.37.178/";
	public static final String UniHyrUrl = "http://54.191.37.178/unihyr/";
	public static final long PostDaysOut = 15;
	public static final long PostDaysInactive = 25;
	public static final long IdleCheckInterval = 86400000;
	public static final String Add_Post_Submit_Button_Value = "Submit";
	public static final String Delimeter = ",,,,,,";
	public static final long BillDaysOut = 7;
	public static final String UnihyrAddress = "Gurgaon";
	//public static final String UploadPath = "D:/var/unihyr/data/";
	public static double TAX = 14;
	public static int NoOfRatingStaticParams = 2;
	public static int NoOfRatingDynamicParams = 3;
	public static int rpp = 10;
	public static int rpp_cons = 10;
	public static int globalRatingMaxRows1=10;
	public static int globalRatingWeight1=50;
	public static int globalRatingMaxRows2=21;
	public static int globalRatingWeight2=50;
	public static String admin_email = "unihyr@gmail.com";
	public static int filesize=1024000;
	public static List<String> filetype = new ArrayList<>();
	public static List<String> topLocations= new ArrayList<>();
	
	static
	{
		filetype.add("doc");
		filetype.add("docx");
		filetype.add("pdf");
		topLocations.add("Delhi");
		topLocations.add("Mumbai");
		topLocations.add("Hyderabad");
		topLocations.add("Pune");
		topLocations.add("Bangalore");
		topLocations.add("Chennai");
		topLocations.add("Kolkata");
		topLocations.add("Gurgaon");
		topLocations.add("Noida");
	}
	
	/**
	 * String variable to store pattern for password validation.
	 */
	public static String passwordRegEx = "(?=.*\\d)(?=.*[a-z]).{6,20}";
	
	/** to validate password having required pattern or not
	 * @param password a String variable to pass password as an argument
	 * @return return boolean value either password is valid or not.
	 */
	public static boolean checkPasswordValid(String password)
	{
		Pattern p = Pattern.compile(passwordRegEx);//. represents single character  
		Matcher m = p.matcher(password);  
		boolean b = m.matches();  
		return b;
	}

	/**generate random password
	 * @return random value of type string
	 */
	public static String generatePassword()
	{
		char[] alphNum = "ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789".toCharArray();

		Random rnd = new Random();

		StringBuilder sb = new StringBuilder((100000 + rnd.nextInt(900000)) );
		for (int i = 0; i < 6; i++)
			sb.append(alphNum[rnd.nextInt(alphNum.length)]);

		String id = sb.toString();
		return id;
	}
}
