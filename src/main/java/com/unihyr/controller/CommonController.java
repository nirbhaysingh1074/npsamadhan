package com.unihyr.controller;

import java.security.Principal;

import javax.servlet.http.HttpServletRequest;

import org.json.simple.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.unihyr.constraints.GeneralConfig;
import com.unihyr.service.MailService;

@Controller
public class CommonController
{
	@Autowired	private MailService mailService;
	
	@RequestMapping(value = "/helpDeskMessage", method = RequestMethod.GET)
	public @ResponseBody String clientMailRejectProfile(ModelMap map, HttpServletRequest request, Principal principal)
	{
		String name = request.getParameter("name");
		String email = request.getParameter("email");
		String msg = request.getParameter("msg");
		
		JSONObject obj = new JSONObject();
		if(name != null && name.length() > 0 && email != null && email.length() > 0 && msg != null && msg.length() > 0)
		{
			String subject = "Help Desk: "+name+" - "+email;
			
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
					+ "<p><img src ='http://localhost:8081/unihyr/images/logo.png' width='63'> </p>"
					+ "<p><strong>Admin Team</strong></p><p></p>"
					+ "<p>This is a system generated mail. Please do not reply to this mail. In case of any queries, please write to <a target='_blank' href='mailto:partnerdesk@unihyr.com'>partnerdesk@unihyr.com</a></p>"
					+ "</div>"
					+ "</td>"
					+ "</tr>"
					+ "</tbody>"
					+ "</table>";
			
			boolean st = mailService.sendMail(GeneralConfig.admin_email, subject, content);
			System.out.println("sending mail......");
			if(st)
			{
				obj.put("status", true);
				return obj.toJSONString();
			}
			
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
}
	
