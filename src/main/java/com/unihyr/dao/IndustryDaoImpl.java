package com.unihyr.dao;

import java.util.List;

import org.hibernate.SessionFactory;
import org.hibernate.criterion.Order;
import org.hibernate.criterion.Restrictions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.unihyr.domain.Industry;

@Repository
public class IndustryDaoImpl implements IndustryDao
{
	@Autowired private SessionFactory sessionFactory; 
	
	@Override
	public int addIndustry(Industry industry)
	{
		
		try
		{
			this.sessionFactory.getCurrentSession().save(industry);
			this.sessionFactory.getCurrentSession().flush();
			return industry.getId();
		}
		catch(Exception e)
		{
			e.printStackTrace();
			return 0;
		}
	}
	
	@Override
	public void updateIndustry(Industry industry)
	{
		this.sessionFactory.getCurrentSession().update(industry);
		this.sessionFactory.getCurrentSession().flush();
	}
	
	@Override
	public Industry getIndustry(int id)
	{
		return (Industry)this.sessionFactory.getCurrentSession().get(Industry.class, id);
	}
	
	@Override
	public List<Industry> getIndustryList()
	{
		return this.sessionFactory.getCurrentSession().createCriteria(Industry.class).add(Restrictions.isNull("deleteDate")).addOrder(Order.asc("industry")).list();
	}
	
	@Override
	public List<Industry> getIndustryList(int first, int max)
	{
		return this.sessionFactory.getCurrentSession().createCriteria(Industry.class).add(Restrictions.isNull("deleteDate")).addOrder(Order.asc("industry")).setFirstResult(first).setMaxResults(max).list();
	}

}
