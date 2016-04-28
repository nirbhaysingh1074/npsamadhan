package com.unihyr.controller;

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

@Controller
public class BillingController
{
	@Autowired BillingService billingService;

	@RequestMapping(value = "/clientBillingDetails", method = RequestMethod.GET)
	public String clientBillingDetails(ModelMap map, HttpServletRequest request ,Principal principal )
	{
		List<BillingDetails> bills = billingService.getBillingDetailsByClientList(principal.getName(),"createDate");
		request.setAttribute("bills",bills);
		return "clientBillingDetails";
	}
	@RequestMapping(value = "/consBillingDetails", method = RequestMethod.GET)
	public String consBillingDetails(ModelMap map, HttpServletRequest request ,Principal principal )
	{
		List<BillingDetails> bills = billingService.getBillingDetailsByConsList(principal.getName(),"createDate");
		request.setAttribute("bills",bills);
		return "consBillingDetails";
	}
	@RequestMapping(value = "/clientBillInvoice", method = RequestMethod.GET)
	public String clientBillInvoice(ModelMap map, HttpServletRequest request ,Principal principal )
	{
		String id=(String)request.getParameter("billId");
		BillingDetails bill = billingService.getBillingDetailsById(Integer.parseInt(id));
		request.setAttribute("bill",bill);
		request.setAttribute("clientId",principal.getName());
		return "clientBillInvoice";
	}
	
	

}
