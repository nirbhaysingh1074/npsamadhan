package com.unihyr.controller;

import java.security.Principal;
import java.util.HashSet;
import java.util.Set;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import javax.validation.Valid;

import org.hibernate.Session;
import org.json.simple.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.unihyr.constraints.GeneralConfig;
import com.unihyr.constraints.Roles;
import com.unihyr.constraints.Validation;
import com.unihyr.domain.Industry;
import com.unihyr.domain.LoginInfo;
import com.unihyr.domain.Registration;
import com.unihyr.domain.UserRole;
import com.unihyr.model.ClientRegistrationModel;
import com.unihyr.model.ConsultRegModel;
import com.unihyr.service.IndustryService;
import com.unihyr.service.LocationService;
import com.unihyr.service.LoginInfoService;
import com.unihyr.service.PostService;
import com.unihyr.service.RegistrationService;
import com.unihyr.service.UserRoleService;
/**
 * Controls all the request related to Authentication
 * @author Rohit Tiwari
 */
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
	@Autowired
	private LocationService locationService;

	
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
	
	
	
	
	@RequestMapping(value = "/resetpassword", method = RequestMethod.GET)
	public String resetPassword(ModelMap map, HttpServletRequest request)
	{
		String userid = request.getParameter("userid");
		String resetToken = request.getParameter("resetToken");
		if(userid != null && resetToken != null)
		{
			LoginInfo  logininfo = loginInfoService.findUserById(userid);
			if(logininfo != null && resetToken.equals(logininfo.getForgotpwdid()))
			{
				map.addAttribute("resetToken", resetToken);
				
			}
		}
		
		return "resetPassword";
	}
	@RequestMapping(value = "/regSuccess", method = RequestMethod.GET)
	public String regSuccess(ModelMap map)
	{
		
		return "regSuccess";
	}
	
	@RequestMapping(value = "/clientregistration", method = RequestMethod.GET)
	public String registration(ModelMap map)
	{
		map.addAttribute("industryList", industryService.getIndustryList());
		map.addAttribute("locList", locationService.getLocationList());
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
				map.addAttribute("locList", locationService.getLocationList());
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
			map.addAttribute("locList", locationService.getLocationList());
			return "registration";
		} else
		{

			java.util.Date dt = new java.util.Date();
			java.sql.Date regdate = new java.sql.Date(dt.getTime());
			reg.setRegdate(regdate);
			
			reg.getIndustries().add(industryService.getIndustry(register.getIndustry().getId()));
			login.setReg(reg);
			reg.setLog(login);
			urole.setUserrole(Roles.ROLE_EMP_MANAGER.toString());
			Set<UserRole> roles = new HashSet<UserRole>();
			roles.add(urole);
			login.setRoles(roles);
			loginInfoService.addLoginInfo(login, null);
			map.addAttribute("regSuccess", "true");
			map.addAttribute("orgName", reg.getOrganizationName());
			return "redirect:/regSuccess";
		}
	}

	@RequestMapping(value = "/consultantregistration", method = RequestMethod.GET)
	public String consultRegistration(ModelMap map)
	{
		map.addAttribute("industryList", industryService.getIndustryList());
		map.addAttribute("locList", locationService.getLocationList());
		ConsultRegModel model = new ConsultRegModel();
		model.setConsultant_type(true);
		map.addAttribute("regForm", model);
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
		System.out.println("indusries : " + request.getParameterValues("industries"));
		String []industries = request.getParameterValues("industries");
		boolean valid = true;
		try
		{
			Registration user = registrationService.getRegistationByUserId(userid);
			if (user != null)
			{
				valid = false;
				map.addAttribute("uidex", "exist");
			}
			if(industries== null || industries.length < 1)
			{
				valid = false;
				map.addAttribute("industry_req", "Please select atleast one industry");
			}
			
		} catch (Exception e)
		{
			e.printStackTrace();
		}
		if (result.hasErrors() || !valid)
		{
			System.out.println("in validation");
			map.addAttribute("industryList", industryService.getIndustryList());
			map.addAttribute("locList", locationService.getLocationList());
			map.addAttribute("sel_inds", industries);
			return "consultRegistration";
		} else
		{

			java.util.Date dt = new java.util.Date();
			java.sql.Date regdate = new java.sql.Date(dt.getTime());
			reg.setRegdate(regdate);
			
			Set<Industry> indset = new HashSet<>();
			try
			{
				for(String ind : industries)
				{
					Industry inds = industryService.getIndustry(Integer.parseInt(ind));
					if(inds != null)
					{
						indset.add(inds);
					}
				}
				
				reg.setIndustries(indset);
				login.setReg(reg);
				reg.setLog(login);
				urole.setUserrole(Roles.ROLE_CON_MANAGER.toString());
				Set<UserRole> roles = new HashSet<UserRole>();
				roles.add(urole);
				login.setRoles(roles);
				loginInfoService.addLoginInfo(login, null);
				map.addAttribute("regSuccess", "true");
				map.addAttribute("orgName", reg.getConsultName());
				return "redirect:/regSuccess";
			}
			catch(Exception e)
			{
				e.printStackTrace();
				map.addAttribute("industryList", industryService.getIndustryList());
				return "consultRegistration";
			}
			
		}
	}

	@RequestMapping(value = "/changeUserPassword", method = RequestMethod.POST)
	public String changeUserPassword(Principal principal ,ModelMap map , HttpServletRequest request, @RequestParam("oldPassword") String oldPassword, @RequestParam("newPassword") String password, @RequestParam("rePassword") String rePassword)
	{
		if(password.equals(rePassword))
		{
			if(loginInfoService.checkUser(principal.getName(), oldPassword))
			{
				boolean status = loginInfoService.updatePassword(principal.getName(), oldPassword, password);
				if(status)
				{
					map.addAttribute("status", "success");
					
					return "redirect:userAcccount";
				}
			}
			map.addAttribute("status", "wrongoldpassword");
			return "redirect:userAcccount";
		}
		map.addAttribute("status", "notmatched");
		return "redirect:userAcccount";
	}
	
	
	@RequestMapping(value = "/changeChildPassword", method = RequestMethod.POST)
	public String changeChildPassword(Principal principal ,ModelMap map , HttpServletRequest request, @RequestParam("childId") String childId, @RequestParam("newPassword") String password, @RequestParam("rePassword") String rePassword)
	{
		Registration child = registrationService.getRegistationByUserId(childId);
		map.addAttribute("registration",child);
		if(child != null && child.getAdmin() != null && child.getAdmin().getUserid().equals(principal.getName()))
		{
			if(password != null && GeneralConfig.checkPasswordValid(password) && password.equals(rePassword))
			{
				boolean status = loginInfoService.updatePassword(childId, null, password);
				if(status)
				{
					map.addAttribute("status", "success");
					return "redirect:clientviewuser?uid="+childId;
				}
			}
			map.addAttribute("status", "notmatched");
			return "redirect:clientviewuser?uid="+childId;
		
		}
		return "redirect:userAcccount";
	
	}
	
	@RequestMapping(value = "/userAcccount", method = RequestMethod.GET)
	public String userAcccount(Principal principal ,ModelMap map, HttpServletRequest request )
	{
		map.addAttribute("status", request.getParameter("status"));
		if(request.isUserInRole("ROLE_ADMIN"))
		{
			return "redirect:userAcccount";
		}
		else if(request.isUserInRole("ROLE_EMP_MANAGER") || request.isUserInRole("ROLE_EMP_USER"))
		{
			return "redirect:clientaccount";
		}
		else if(request.isUserInRole("ROLE_CON_MANAGER") || request.isUserInRole("ROLE_CON_USER"))
		{
			return "redirect:consultantaccount";
		}
		return "redirect:error";
	}
	
	
	@RequestMapping(value = "/checkUserExistance", method = RequestMethod.GET)
	public @ResponseBody String checkUserExistance(Principal principal ,ModelMap map, HttpServletRequest request , @RequestParam String userid)
	{
		map.addAttribute("status", request.getParameter("status"));
		JSONObject obj = new JSONObject();
		
		Registration reg = registrationService.getRegistationByUserId(userid);
		if(reg!= null)
		{
			obj.put("uidexist", true);
			return obj.toJSONString();
		}
		obj.put("uidexist", false);
		return obj.toJSONString();
	}
}
