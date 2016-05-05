package com.unihyr.service;

import com.unihyr.domain.ConfigVariables;

public interface ConfigVariablesService
{
public void load(ConfigVariables configVariables);

public void add(ConfigVariables configVariable);
}
