package com.unihyr.dao;

import com.unihyr.domain.ConfigVariables;

public interface ConfigVariablesDao
{

	public void load(ConfigVariables configvariables);

	public void add(ConfigVariables configVariable);
	
}
