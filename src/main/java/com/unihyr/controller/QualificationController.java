package com.unihyr.controller;

import java.security.Principal;
import java.util.Date;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.unihyr.domain.Qualification;
import com.unihyr.service.QualificationService;

@Controller
public class QualificationController
{
	@Autowired QualificationService qualificationService;

	/**
	 * request controller to response for add qualification page.
	 * @param map
	 * @param principal
	 * @return name of url to be opened
	 */
	@RequestMapping(value = "/adminAddQualification", method = RequestMethod.GET)
	public String addQualification(ModelMap map, Principal principal)
	{
		map.addAttribute("qualificationForm",new Qualification());
		return "adminAddQualification";
	}

	/**
	 * @param map
	 * @param principal
	 * @param qualification object which contain details of new qualification to be added
	 * @param result
	 * @return name of url to be opened
	 */
	@RequestMapping(value = "/adminAddQualification", method = RequestMethod.POST)
	public String addQualification(ModelMap map, Principal principal,
			@ModelAttribute(value = "qualificationForm") Qualification qualification, BindingResult result)
	{
		if(result.hasErrors() || qualification.getqTitle().trim().length() <1)
		{
			map.addAttribute("qTitle_error", "Please enter qualification");
			return "adminAddQualification";
		}
		else
		{
			Date date = new Date();
			java.sql.Date dt = new java.sql.Date(date.getTime());
			qualification.setCreationDate(dt);
			qualificationService.addQualification(qualification);
			return "redirect:adminQualificationList";
		}
	}
	
	/**
	 * request handler to provide list of all qualifications
	 * @param map
	 * @param principal
	 * @return
	 */
	@RequestMapping(value="/adminQualificationList",method=RequestMethod.GET)
	public String adminQualificationList(ModelMap map,Principal principal){
		map.addAttribute("qListUg",qualificationService.getAllUGQualification());
		map.addAttribute("qListPg",qualificationService.getAllPGQualification());
		return "adminQualificationList";
	}

}
