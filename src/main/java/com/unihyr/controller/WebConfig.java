package com.unihyr.controller;

import static org.junit.Assert.assertEquals;

import javax.annotation.PostConstruct;

import org.junit.After;
import org.junit.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import com.unihyr.domain.ConfigVariables;
import com.unihyr.service.ConfigVariablesService;
@Component
public class WebConfig
{
	@Autowired
	private ConfigVariablesService configVariablesService;

	
	public void initData() throws Exception {
			System.out.println("initialized");
			ConfigVariables configVariable= new ConfigVariables();
			configVariable.setVarName("CESS");
			configVariable.setVarValue("0.5");
			configVariablesService.add(configVariable);

			

	}
}
