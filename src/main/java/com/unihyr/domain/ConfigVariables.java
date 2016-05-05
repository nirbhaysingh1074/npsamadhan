package com.unihyr.domain;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

/**
 * Model class Used to store all configurations which are global to whole applicationa and 
 * to all type of Users. These permissions can only be updated by Admin  
 * @author Rohit Tiwari
 */
@Entity
@Table(name="configvarialbes")
public class ConfigVariables
{
	@Id
	@Column(nullable=false)
	@GeneratedValue(strategy=GenerationType.AUTO)
	private int configId;
	@Column
	private String varName;
	@Column
	private String varValue;
	public int getConfigId()
	{
		return configId;
	}
	public void setConfigId(int configId)
	{
		this.configId = configId;
	}
	public String getVarName()
	{
		return varName;
	}
	public void setVarName(String varName)
	{
		this.varName = varName;
	}
	public String getVarValue()
	{
		return varValue;
	}
	public void setVarValue(String varValue)
	{
		this.varValue = varValue;
	}
	
	
	

}
