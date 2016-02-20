package com.unihyr.controller;

import java.security.Principal;
import java.util.HashSet;
import java.util.Set;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import javax.validation.Valid;

import org.hibernate.Session;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.unihyr.constraints.Roles;
import com.unihyr.domain.LoginInfo;
import com.unihyr.domain.Registration;
import com.unihyr.domain.UserRole;
import com.unihyr.model.ClientRegistrationModel;
import com.unihyr.model.ConsultRegModel;
import com.unihyr.service.IndustryService;
import com.unihyr.service.LoginInfoService;
import com.unihyr.service.PostService;
import com.unihyr.service.RegistrationService;
import com.unihyr.service.UserRoleService;

@Controller
public class LoginController
{
	@Autowired
	private IndustryService industryService;
	@Autowired
	private PostService postService;
	@Autowired
	private RegistrationService registrationService;
	@Autowired
	private LoginInfoService loginInfoService;
	@Autowired
	private UserRoleService userRoleService;

	
	@RequestMapping(value = "/login", method = RequestMethod.GET)
    public String login(ModelMap map) 
	{
		System.out.println("Hello to all from login");
        return "login";
    }
	
	
	@RequestMapping(value = "/getLogedIn", method=RequestMethod.GET)
	public String getLogedIn(ModelMap map, HttpServletRequest request, Principal principal)
	{
		if(principal != null)
		{
			System.out.println("Princile : " + principal.getName());
			
			Registration registration = registrationService.getRegistationByUserId(principal.getName());
			HttpSession  session = request.getSession(true);
			session.setAttribute("registration", registration);
			
			System.out.println("Princile : " + request.isUserInRole(Roles.ROLE_EMP_MANAGER.toString()));
			if(request.isUserInRole(Roles.ROLE_EMP_MANAGER.toString()) || request.isUserInRole(Roles.ROLE_EMP_USER.toString()))
			{
				return "redirect:clientdashboard";
			}
			else if(request.isUserInRole(Roles.ROLE_CON_MANAGER.toString()) || request.isUserInRole(Roles.ROLE_CON_USER.toString()))
			{
				return "redirect:consdashboard";
			}
			else if(request.isUserInRole(Roles.ROLE_ADMIN.toString()))
			{
				return "redirect:admindashboard";
			}
			else
			{
				return "redirect:error";
			}
		}
		return "redirect:home";
	}
	
	@RequestMapping(value = "/insertLogOut", method=RequestMethod.GET)
	public @ResponseBody String insertLogOut(ModelMap map, HttpServletRequest request)
	{
		System.out.println("from logout page");
		return "logedOut";
	}
	@RequestMapping(value = "/logout", method=RequestMethod.GET)
	public String logout(ModelMap map, HttpServletRequest request)
	{
		System.out.println("from logout successfull page");
		return "redirect:home";
	}
	
	@RequestMapping(value = "/failtologin", method=RequestMethod.GET)
	public String failtologin(ModelMap map){
		System.out.println("in failtologin");
		String error="true";
		return "redirect:/login?error="+error;
		
	}
	
	
	@RequestMapping(value = "/clientregistration", method = RequestMethod.GET)
	public String registration(ModelMap map)
	{
		map.addAttribute("industryList", industryService.getIndustryList());
		System.out.println("Hello to all from registration");
		map.addAttribute("regForm", new ClientRegistrationModel());
		return "registration";
	}

	@RequestMapping(value = "/clientregistration", method = RequestMethod.POST)
	public String addUser(@ModelAttribute(value = "regForm") @Valid ClientRegistrationModel register,
			BindingResult result, @ModelAttribute(value = "reg") Registration reg, BindingResult regResult,
			@ModelAttribute(value = "login") LoginInfo login, BindingResult loginResult,
			@ModelAttribute(value = "urole") UserRole urole, BindingResult userroleResult,
			@RequestParam("userid") String userid, ModelMap map, HttpServletRequest request)
	{

		System.out.println("userid in controller" + userid);
		try
		{
			Registration user = registrationService.getRegistationByUserId(userid);
			if (user != null)
			{
				map.addAttribute("industryList", industryService.getIndustryList());
				map.addAttribute("uidex", "exist");
				return "registration";
			}
		} catch (Exception e)
		{
			e.printStackTrace();
		}
		if (result.hasErrors())
		{
			System.out.println("in validation");
			map.addAttribute("industryList", industryService.getIndustryList());
			return "registration";
		} else
		{

			java.util.Date dt = new java.util.Date();
			java.sql.Date regdate = new java.sql.Date(dt.getTime());
			reg.setRegdate(regdate);
			login.setReg(reg);
			reg.setLog(login);
			urole.setUserrole(Roles.ROLE_EMP_MANAGER.toString());
			Set<UserRole> roles = new HashSet<UserRole>();
			roles.add(urole);
			login.setRoles(roles);
			loginInfoService.addLoginInfo(login, null);
			map.addAttribute("regSuccess", "true");
			map.addAttribute("orgName", reg.getOrganizationName());
			return "redirect:/login";
		}
	}

	@RequestMapping(value = "/consultantregistration", method = RequestMethod.GET)
	public String consultRegistration(ModelMap map)
	{
		map.addAttribute("industryList", industryService.getIndustryList());
		System.out.println("Hello to all from consult registration");
		map.addAttribute("regForm", new ConsultRegModel());
		return "consultRegistration";
	}

	@RequestMapping(value = "/consultantregistration", method = RequestMethod.POST)
	public String consultantregistration(@ModelAttribute(value = "regForm") @Valid ConsultRegModel register,
			BindingResult result, @ModelAttribute(value = "reg") Registration reg, BindingResult regResult,
			@ModelAttribute(value = "login") LoginInfo login, BindingResult loginResult,
			@ModelAttribute(value = "urole") UserRole urole, BindingResult userroleResult,
			@RequestParam("userid") String userid, ModelMap map, HttpServletRequest request)
	{

		System.out.println("userid in controller" + userid);
		try
		{
			Registration user = registrationService.getRegistationByUserId(userid);
			if (user != null)
			{
				map.addAttribute("industryList", industryService.getIndustryList());
				map.addAttribute("uidex", "exist");
				return "consultRegistration";
			}
		} catch (Exception e)
		{
			e.printStackTrace();
		}
		if (result.hasErrors())
		{
			System.out.println("in validation");
			map.addAttribute("industryList", industryService.getIndustryList());
			return "consultRegistration";
		} else
		{

			java.util.Date dt = new java.util.Date();
			java.sql.Date regdate = new java.sql.Date(dt.getTime());
			reg.setRegdate(regdate);
			login.setReg(reg);
			reg.setLog(login);
			urole.setUserrole(Roles.ROLE_CON_MANAGER.toString());
			Set<UserRole> roles = new HashSet<UserRole>();
			roles.add(urole);
			login.setRoles(roles);
			loginInfoService.addLoginInfo(login, null);
			map.addAttribute("regSuccess", "true");
			map.addAttribute("orgName", reg.getConsultName());
			return "redirect:/login";
		}
	}

	
}
