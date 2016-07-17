package com.unihyr.controller;

import java.security.Principal;
import java.util.Date;
import javax.servlet.http.HttpServletRequest;
import org.json.simple.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import com.unihyr.constraints.GeneralConfig;
import com.unihyr.domain.ContactUs;
import com.unihyr.domain.HelpDesk;
import com.unihyr.domain.LoginInfo;
import com.unihyr.domain.Registration;
import com.unihyr.service.ContactUsService;
import com.unihyr.service.HelpDeskService;
import com.unihyr.service.LoginInfoService;
import com.unihyr.service.MailService;
import com.unihyr.service.RegistrationService;

@Controller
public class CommonController
{
	@Autowired	private MailService mailService;
	@Autowired
	private RegistrationService registrationService;
	/**
	 * login info service to invoke user login related functions
	 */
	@Autowired
	private LoginInfoService loginInfoService;
	@Autowired
	private HelpDeskService helpDeskService;
	@Autowired ContactUsService contactUsService;
	
	@RequestMapping(value = "/helpDeskMessage", method = RequestMethod.GET)
	public @ResponseBody String clientMailRejectProfile(ModelMap map, HttpServletRequest request, Principal principal)
	{
		String name = request.getParameter("name");
		String email = principal.getName();
		String msg = request.getParameter("message");

		String subject = request.getParameter("subject");
		
		JSONObject obj = new JSONObject();
		if(name != null && name.length() > 0 && email != null && email.length() > 0 && msg != null && msg.length() > 0)
		{
			subject = "Help Desk: "+subject;
			
			String content = "<table cellspacing='0' cellpadding='8' border='0' style='width: 100%; font-family: Arial, Sans-serif;  background-color: #fff' summary=''>"
					+ "<tbody><tr>"
					+ "	<td>"
					+ "<div style='padding: 2px'>"
					+ "<span></span>"
					+ "<p>Dear Admin,</p>"
					+ "<p></p>"
					+ "<p>Please note the following:</p>"
					+ "<table cellspacing='0' cellpadding='0' border='0'"
					+ "summary='Event details'>"
					+ "<tbody>"
					+ "<tr>"
					+ "<td width='100' valign='top' style='padding: 0 1em 10px 0;  white-space: nowrap'><div>"
					+ "<i style='font-style: normal'>Name</i></div></td>"
					+ "<td valign='top' style='padding-bottom: 10px; font-weight:bold;'>"
					+ name
					+ "</td>"
					+ "</tr>"
					+ "<tr>"
					+ "<td  valign='top' style='padding: 0 1em 10px 0;   white-space: nowrap'><div>"
					+ "<i style='font-style: normal'>Email</i>"
					+ "</div></td>"
					+ "<td valign='top' style='padding-bottom: 10px; font-weight:bold;'>"
					+ email
					+ "</td>"
					+ "</tr>"
					+ "<tr>"
					+ "<td valign='top' style='padding: 0 1em 10px 0;  white-space: nowrap'><div>"
					+ "<i style='font-style: normal'>Message</i>"
					+ "</div></td>"
					+ "<td valign='top' style='padding-bottom: 10px; font-weight:bold;'>"
					+ msg
					+ "</td>"
					+ "</tr>"
					+ "</tbody>"
					+ "</table>"
					+ "<p>This message is send by user in help desk. Please response quickly.</p>"
					+ "<p></p>"
					+ "<p>Best Regards,</p>"
					+ "<p></p>"
					//+ "<p><img src ='"+GeneralConfig.UniHyrUrl+"/images/logo.png' width='63'> </p>"
					+ "<p><strong>Admin Team</strong></p><p></p>"
					+ "<p>This is a system generated mail. Please do not reply to this mail. In case of any queries, please write to <a target='_blank' href='mailto:partnerdesk@unihyr.com'>partnerdesk@unihyr.com</a></p>"
					+ "</div>"
					+ "</td>"
					+ "</tr>"
					+ "</tbody>"
					+ "</table>";
			
			try{
			boolean st = mailService.sendMail(GeneralConfig.admin_email, subject, content);
			mailService.sendMail(email, subject, "Thanks for contacting us. We will revert you back soon.");
			}catch(Exception e ){
				e.printStackTrace();
			}
			HelpDesk helpDesk=new HelpDesk();
			helpDesk.setName(name);
			helpDesk.setEmail(email);
			helpDesk.setMessage(msg);
			helpDesk.setSubject(subject);
			helpDesk.setMsgDate(new java.sql.Date(new Date().getTime()));
			helpDeskService.addHelpDesk(helpDesk);
			System.out.println("sending mail......");
//			if(st)
//			{
				obj.put("status", true);
				return obj.toJSONString();
//			}
		}
		obj.put("status", false);
		return obj.toJSONString();
	}
	
	/**
	 * 
	 * @param map
	 * @param request
	 * @param principal
	 * @return returns view resolver in tiles for test page
	 */
	
@RequestMapping(value = "/test", method = RequestMethod.GET)
public String test(ModelMap map, HttpServletRequest request, Principal principal)
{
	return "test";
}		
@RequestMapping(value = "/privacyPolicy", method = RequestMethod.GET)
public String privacyPolicy(ModelMap map, HttpServletRequest request, Principal principal)
{
	map.addAttribute("contactusform", new ContactUs());
	return "privacyPolicy";
}			
@RequestMapping(value = "/adminHelpMessages", method = RequestMethod.GET)
public String adminHelpMessages(ModelMap map, HttpServletRequest request, Principal principal)
{
	map.addAttribute("helpList",helpDeskService.getAllHelpDeskList("null"));
	return "adminHelpMessages";
}			
@RequestMapping(value = "/adminDemoRequests", method = RequestMethod.GET)
public String adminDemoRequests(ModelMap map, HttpServletRequest request, Principal principal)
{
	map.addAttribute("demorequests",contactUsService.getAllDemoRequest());
	return "adminDemoRequests";
}			
@RequestMapping(value = "/adminLoggedUsers", method = RequestMethod.GET)
public String adminLoggedUsers(ModelMap map, HttpServletRequest request, Principal principal)
{
	map.addAttribute("userList",loginInfoService.getLoggedInUsers());
	return "adminLoggedUsers";
}		
@RequestMapping(value = "/termsOfService", method = RequestMethod.GET)
public String termsOfService(ModelMap map, HttpServletRequest request, Principal principal)
{
	map.addAttribute("contactusform", new ContactUs());
	return "termsOfService";
}
	@RequestMapping(value = "/setFirstTimeFalse", method = RequestMethod.GET)
	@ResponseBody
	public String setFirstTimeFalse(ModelMap map, HttpServletRequest request, Principal principal)
	{
		String reg=request.getParameter("regid");
	Registration regis=	registrationService.getRegistationByUserId(reg);
		regis.setFirstTime(true);
		registrationService.update(regis);
		return "success";
	}

	/**
	 * Used to handle request of admin to disable a User.
	 * @param map
	 * @param request
	 * @param principal
	 * @param userid
	 * @return
	 */
	@RequestMapping(value = "/disableuser", method = RequestMethod.GET)
	public @ResponseBody String admindisableuser(ModelMap map, HttpServletRequest request ,Principal principal , @RequestParam String userid)
	{
		JSONObject obj = new JSONObject();
		if(userid != null)
		{
			LoginInfo info = loginInfoService.findUserById(userid);
			if(info != null)
			{
				info.setIsactive("false");
				loginInfoService.updateLoginInfo(info);
				obj.put("status", true);
				return obj.toJSONString();
			}
		}
		obj.put("status", false);
		return obj.toJSONString();
	}
	/**
	 * Used to handle request from admin to enable a User
	 * @param map
	 * @param request
	 * @param principal
	 * @param userid
	 * @return
	 */
	@RequestMapping(value = "/enableuser", method = RequestMethod.GET)
	public @ResponseBody String adminenableuser(ModelMap map, HttpServletRequest request ,Principal principal , @RequestParam String userid)
	{
		JSONObject obj = new JSONObject();
		if(userid != null)
		{
			LoginInfo info = loginInfoService.findUserById(userid);
			if(info != null)
			{
				info.setIsactive("true");
				loginInfoService.updateLoginInfo(info);
				obj.put("status", true);
				return obj.toJSONString();
			}
		}
		obj.put("status", false);
		return obj.toJSONString();
	}
	
}
	
