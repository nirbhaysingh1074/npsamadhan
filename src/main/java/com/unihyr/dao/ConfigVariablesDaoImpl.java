package com.unihyr.dao;

import org.hibernate.HibernateException;
import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.unihyr.domain.ConfigVariables;
@Repository
public class ConfigVariablesDaoImpl implements ConfigVariablesDao
{
	@Autowired SessionFactory sessionFactory;
	
	@Override
	public void load(ConfigVariables configvariables)
	{
		
		
	}

	@Override
	public void add(ConfigVariables configVariable)
	{
		// TODO Auto-generated method stub
		try
		{
			this.sessionFactory.getCurrentSession().save(configVariable);
		} catch (HibernateException e)
		{
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		
	}

}
