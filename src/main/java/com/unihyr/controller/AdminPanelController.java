package com.unihyr.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller
public class AdminPanelController
{
	
	@RequestMapping(value="/admindashboard",method=RequestMethod.GET)
	public String admindashboard(ModelMap map){
		return "admindashboard";
	}

}
