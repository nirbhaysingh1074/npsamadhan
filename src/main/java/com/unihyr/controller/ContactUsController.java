package com.unihyr.controller;

import java.security.Principal;

import javax.servlet.http.HttpServletRequest;
import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.unihyr.domain.ContactUs;
import com.unihyr.service.ContactUsService;

@Controller
public class ContactUsController
{
	@Autowired ContactUsService contactUsService;
	
	@RequestMapping(value = "/requestfordemo", method = RequestMethod.GET)
	public String requestfordemo(ModelMap map, HttpServletRequest request ,Principal principal)
	{
		return "requestfordemo";
	}
	@RequestMapping(value = "/requestfordemo", method = RequestMethod.POST)
	public String requestfordemo(@ModelAttribute(value = "contactusform") @Valid ContactUs model,ModelMap map, HttpServletRequest request ,Principal principal)
	{
		contactUsService.addContactUsDetails(model);
		map.addAttribute("regSuccess", "true");
		map.addAttribute("orgName", model.getName());
		return "redirect:/regSuccess";
	}
}