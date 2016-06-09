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
import com.unihyr.service.BillingService;
import com.unihyr.service.PostConsultnatService;
import com.unihyr.service.PostProfileService;
import com.unihyr.service.PostService;
/**
 * Controls all the request of handling billing for both client and admin
 * @author Rohit Tiwari
 */
@Controller
public class BillingController
{
	@Autowired BillingService billingService;

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
		new ConsultantController().createBillInvoice(bill, principal.getName());
		return "clientBillInvoice";
	}

	@RequestMapping(value="/clientVerifyBillingDetails",method=RequestMethod.GET)
	public String clientVerifyBillingDetails(ModelMap map,HttpServletRequest request,Principal principal)
	{
		String id=(String)request.getParameter("billId");
		BillingDetails bill = billingService.getBillingDetailsById(Integer.parseInt(id));
		bill.setVerificationStatus(true);
		billingService.updateBillingDetails(bill);
		List<BillingDetails> bills = billingService.getBillingDetailsByClientList(principal.getName(),"createDate");
		request.setAttribute("bills",bills);
		return "clientBillingDetails";
	}
	@RequestMapping(value="/verifyBillingDetails",method=RequestMethod.GET)
	public String verifyBillingDetails(ModelMap map,HttpServletRequest request,Principal principal)
	{
		String id=(String)request.getParameter("billId");
		BillingDetails bill = billingService.getBillingDetailsById(Integer.parseInt(id));
		bill.setVerificationStatus(true);
		billingService.updateBillingDetails(bill);
		return "invoiceVerification";
	}
}
