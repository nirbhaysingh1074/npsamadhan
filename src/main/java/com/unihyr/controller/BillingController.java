package com.unihyr.controller;

import java.net.Authenticator.RequestorType;
import java.security.Principal;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.json.simple.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.unihyr.domain.BillingDetails;
import com.unihyr.domain.Post;
import com.unihyr.domain.Registration;
import com.unihyr.service.BillingService;
import com.unihyr.service.PostConsultnatService;
import com.unihyr.service.PostProfileService;
import com.unihyr.service.PostService;
import com.unihyr.service.RegistrationService;
/**
 * Controls all the request of handling billing for both client and admin
 * @author Rohit Tiwari
 */
@Controller
public class BillingController
{
	
	/**
	 * service to deal with billing related functions
	 */
	@Autowired BillingService billingService;

	/**
	 * service to deal with user registration related functions
	 */
	@Autowired
	private RegistrationService registrationService;
	
	/**
	 * used to handle request to generate billing details for client
	 * @param map used to store response attribues
	 * @param request http servlet request
	 * @param principal used to get logged in user name
	 * @return billing details jsp page for client
	 */
	@RequestMapping(value = "/clientBillingDetails", method = RequestMethod.GET)
	public String clientBillingDetails(ModelMap map, HttpServletRequest request ,Principal principal )
	{
		List<BillingDetails> bills = billingService.getBillingDetailsByClientList(principal.getName(),"createDate");
		request.setAttribute("bills",bills);
		Registration reg = registrationService.getRegistationByUserId(principal.getName());
		map.addAttribute("registration",reg);
	
		return "clientBillingDetails";
	}
	
	/**
	 * 
	 * @param map
	 * @param request
	 * @param principal
	 * @return
	 */
	@RequestMapping(value = "/consBillingDetails", method = RequestMethod.GET)
	public String consBillingDetails(ModelMap map, HttpServletRequest request ,Principal principal )
	{
		List<BillingDetails> bills = billingService.getBillingDetailsByConsList(principal.getName(),"createDate");
		request.setAttribute("bills",bills);
		Registration reg = registrationService.getRegistationByUserId(principal.getName());
		map.addAttribute("registration",reg);
	
		return "consBillingDetails";
	}
	
	/**
	 * 
	 * @param map
	 * @param request
	 * @param principal
	 * @return String type value which is name of url defined in tiles.
	 */
	@RequestMapping(value = "/clientBillInvoice", method = RequestMethod.GET)
	public String clientBillInvoice(ModelMap map, HttpServletRequest request ,Principal principal )
	{
		String id=(String)request.getParameter("billId");
		BillingDetails bill = billingService.getBillingDetailsById(Integer.parseInt(id));
		request.setAttribute("bill",bill);
		request.setAttribute("clientId",principal.getName());
		new ConsultantController().createBillInvoice(bill);
		Registration reg = registrationService.getRegistationByUserId(principal.getName());
		map.addAttribute("registration",reg);
	
		return "clientBillInvoice";
	}

	/**
	 * request method to Verify invoice by client itself
	 * @param map 
	 * @param request
	 * @param principal
	 * @return billing detail page for client
	 */
	@RequestMapping(value="/clientVerifyBillingDetails",method=RequestMethod.GET)
	public String clientVerifyBillingDetails(ModelMap map,HttpServletRequest request,Principal principal)
	{
		String id=(String)request.getParameter("billId");
		BillingDetails bill = billingService.getBillingDetailsById(Integer.parseInt(id));
		bill.setVerificationStatus(true);
		billingService.updateBillingDetails(bill);
		List<BillingDetails> bills = billingService.getBillingDetailsByClientList(principal.getName(),"createDate");
		request.setAttribute("bills",bills);
		Registration reg = registrationService.getRegistationByUserId(principal.getName());
		map.addAttribute("registration",reg);
	
		return "clientBillingDetails";
	}
	/**
	 * request method to verify billing details via link provided in mail notification.
	 * @param map
	 * @param request
	 * @param principal
	 * @return
	 */
	@RequestMapping(value="/verifyBillingDetails",method=RequestMethod.GET)
	public String verifyBillingDetails(ModelMap map,HttpServletRequest request,Principal principal)
	{
		String id=(String)request.getParameter("billId");
		BillingDetails bill = billingService.getBillingDetailsById(Integer.parseInt(id));
		bill.setVerificationStatus(true);
		billingService.updateBillingDetails(bill);
		map.addAttribute("verifySuccess","true");
		return "invoiceVerification";
	}
	/**
	 * request method to update billing info via administrator unihyr
	 * @param map
	 * @param request
	 * @param principal
	 * @return
	 */
	@RequestMapping(value="/adminBillUpdate",method=RequestMethod.GET)
	public @ResponseBody String adminBillUpdate(ModelMap map,HttpServletRequest request,Principal principal)
	{
		JSONObject js=new JSONObject();
		try{
		String id=(String)request.getParameter("billId");
		BillingDetails bill = billingService.getBillingDetailsById(Integer.parseInt(id));
		bill.setVerificationStatus(true);
		bill.setClientPaidStatus(true);
		bill.setAdminPaidStatus(true);
		bill.setPaidDate(new java.sql.Date(new Date().getTime()));
		billingService.updateBillingDetails(bill);
		}catch(Exception e ){
			e.printStackTrace();
			js.put("status", "Error Occured");
		}
		js.put("status", "Paid status updated successfully");
		return js.toJSONString();
	}
	

	/**
	 * request method to generate bill invoice for consultant
	 * @param map
	 * @param request
	 * @param principal
	 * @return
	 */
	@RequestMapping(value = "/consGenerateBillInvoice", method = RequestMethod.POST)
	public String consGenerateBillInvoice(ModelMap map, HttpServletRequest request ,Principal principal )
	{
		String id=(String)request.getParameter("billId");
		String invoiceno=(String)request.getParameter("invoiceno");
		
		BillingDetails bill = billingService.getBillingDetailsById(Integer.parseInt(id));
		request.setAttribute("bill",bill);
		request.setAttribute("clientId",principal.getName());
		bill.setConsInvoicePath(new ConsultantController().createConsBillInvoice(bill,invoiceno));
		billingService.updateBillingDetails(bill);
		Registration reg = registrationService.getRegistationByUserId(principal.getName());
		map.addAttribute("registration",reg);
	
		return "redirect:/consBillingDetails";
	}

	
	
}
