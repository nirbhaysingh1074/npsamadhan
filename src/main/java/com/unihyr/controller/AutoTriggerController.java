package com.unihyr.controller;

import java.util.List;
import java.util.Timer;

import javax.annotation.PostConstruct;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.ApplicationContext;
import org.springframework.stereotype.Component;

import com.unihyr.domain.ConfigVariables;
import com.unihyr.service.ConfigVariablesService;
import com.unihyr.service.PostProfileService;
import com.unihyr.util.ApplicationContextProvider;

@Component
public class AutoTriggerController
{
	@Autowired
	private ConfigVariablesService configVariablesService;
	
	@Autowired 
	private PostProfileService postProfileService;
	

	public static boolean checkPostIdle(){
		
			System.out.println();
		return false;
	}
}
