package com.unihyr.controller;

import java.security.Principal;
import java.util.HashSet;
import java.util.Random;
import java.util.Set;

import javax.servlet.http.HttpServletRequest;
import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.unihyr.constraints.Roles;
import com.unihyr.domain.LoginInfo;
import com.unihyr.domain.Registration;
import com.unihyr.domain.UserRole;
import com.unihyr.model.ClientUserModel;
import com.unihyr.service.LoginInfoService;
import com.unihyr.service.MailService;
import com.unihyr.service.RegistrationService;
/**
 * Controls all the request create update delete general users of client
 * @author Rohit Tiwari
 */
@Controller
public class ClientUserController
{
	
	@Autowired
	private RegistrationService registrationService;
	@Autowired
	private LoginInfoService loginInfoService;
	@Autowired
	private MailService mailService;
	
	@RequestMapping(value = "/clientnewuser", method = RequestMethod.GET)
	public String clientNewUser(ModelMap map, Principal principal)
	{
		map.addAttribute("cuForm", new ClientUserModel());
		return "clientNewUser";
	}

	@RequestMapping(value = "/clientnewuser", method = RequestMethod.POST)
	public String addUser(@ModelAttribute(value = "cuForm") @Valid ClientUserModel model,
			BindingResult result, @ModelAttribute(value = "reg") Registration reg, BindingResult regResult,
			@ModelAttribute(value = "login") LoginInfo login, BindingResult loginResult,
			@ModelAttribute(value = "urole") UserRole urole, BindingResult userroleResult,
			@RequestParam("userid") String userid, ModelMap map, HttpServletRequest request, Principal principal)
	{

		boolean valid = true; 
		try
		{
			Registration user = registrationService.getRegistationByUserId(userid);
			if (user != null)
			{
				map.addAttribute("uidex", "exist");
				 valid = false; 
			}
		} catch (Exception e)
		{
			e.printStackTrace();
			valid = false; 
		}
		if (result.hasErrors() || !valid)
		{
			System.out.println("in validation");
			return "clientNewUser";
		} else
		{
			Registration parent = registrationService.getRegistationByUserId(principal.getName());

			java.util.Date dt = new java.util.Date();
			java.sql.Date regdate = new java.sql.Date(dt.getTime());
			reg.setRegdate(regdate);
			reg.setAdmin(parent);
			
			login.setReg(reg);
			login.setIsactive("true");
			char[] alphNum = "ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789".toCharArray();

			Random rnd = new Random();

			StringBuilder sb = new StringBuilder((100000 + rnd.nextInt(900000)) + "-");
			for (int i = 0; i < 5; i++)
				sb.append(alphNum[rnd.nextInt(alphNum.length)]);

			String id = sb.toString();
			login.setPassword(id);
			
			
			
			reg.setLog(login);
			urole.setUserrole(Roles.ROLE_EMP_USER.toString());
			Set<UserRole> roles = new HashSet<UserRole>();
			roles.add(urole);
			login.setRoles(roles);
			loginInfoService.addLoginInfo(login, null);
			map.addAttribute("regSuccess", "true");
			map.addAttribute("name", reg.getName());
			mailService.sendMail(model.getUserid(), "Sign Up info",
					"Your've signed up with UniHyr sucessfully. UniHyr will contact you soon for further process. <br><br> Your password is : "
							+ id + "<br> After first login please change this password.");
		
			return "redirect:/clientaccount";
		}
	}

	@RequestMapping(value = "/clientviewuser", method = RequestMethod.GET)
	public String clientViewUser(ModelMap map, HttpServletRequest request, Principal principal, @RequestParam String uid)
	{
		map.addAttribute("status", request.getParameter("status"));
		Registration reg = registrationService.getRegistationByUserId(uid);
		if(reg != null)
		{
			map.addAttribute("registration", reg);
			return "clientViewUser";
		}
		return "redirect:clientdashboard";

	}
	
	
}
