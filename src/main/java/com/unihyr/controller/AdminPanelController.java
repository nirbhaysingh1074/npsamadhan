package com.unihyr.controller;

import java.security.Principal;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.unihyr.service.IndustryService;
import com.unihyr.service.LoginInfoService;
import com.unihyr.service.PostProfileService;
import com.unihyr.service.PostService;
import com.unihyr.service.ProfileService;
import com.unihyr.service.RegistrationService;
import com.unihyr.service.UserRoleService;

@Controller
public class AdminPanelController
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
	private ProfileService profileService;
	@Autowired
	private PostProfileService postProfileService;

	
	@RequestMapping(value="/admindashboard",method=RequestMethod.GET)
	public String admindashboard(ModelMap map){
		
		map.addAttribute("totalProfiles", profileService.countProfileList());
		map.addAttribute("totalPosts", postService.countPosts());
		map.addAttribute("totalClient", registrationService.countClientsList());
		map.addAttribute("totalConsultant", registrationService.countConsultantList());
		return "admindashboard";
	}
	
	@RequestMapping(value = "/adminDashboardPostList", method = RequestMethod.GET)
	public String adminDashboardPostList(ModelMap map, HttpServletRequest request ,Principal principal)
	{
		map.addAttribute("postList", postService.getPosts(0, 10));
		map.addAttribute("ppList", postProfileService.getAllPostProfile(0, 10));
		return "adminDashboardPostList";
	}
	
	
}
