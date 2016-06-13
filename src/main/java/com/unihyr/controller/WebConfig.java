package com.unihyr.controller;

import static org.junit.Assert.assertEquals;

import javax.annotation.PostConstruct;

import org.junit.After;
import org.junit.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import com.unihyr.domain.ConfigVariables;
import com.unihyr.service.ConfigVariablesService;
import com.unihyr.service.PostProfileService;
@Component
public class WebConfig
{
	@Autowired
	private ConfigVariablesService configVariablesService;

	@Autowired 
	private PostProfileService postProfileService;
	
	@PostConstruct
	public void initialize()  throws Exception {
			System.out.println("initialized");
			ConfigVariables configVariable= new ConfigVariables();
			configVariable.setVarName("CESS");
			configVariable.setVarValue("0.5");
			//configVariablesService.add(configVariable);

			

	}
	public static boolean checkPostIdle(){
	//	System.out.println(postProfileService);
		return false;
	}
}
