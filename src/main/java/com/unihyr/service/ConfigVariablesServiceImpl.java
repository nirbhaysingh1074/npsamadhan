package com.unihyr.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.unihyr.dao.ConfigVariablesDao;
import com.unihyr.domain.ConfigVariables;
@Service
public class ConfigVariablesServiceImpl implements ConfigVariablesService
{

	@Autowired ConfigVariablesDao configVariablesDao;
	
	@Override
	public void load(ConfigVariables configVariables)
	{
		// TODO Auto-generated method stub
	}

	@Override
	public void add(ConfigVariables configVariable)
	{
		// TODO Auto-generated method stub
		configVariablesDao.add(configVariable);
		
	}

}
