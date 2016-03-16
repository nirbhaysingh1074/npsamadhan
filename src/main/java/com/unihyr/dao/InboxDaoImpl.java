package com.unihyr.dao;

import java.util.List;

import org.hibernate.SessionFactory;
import org.hibernate.criterion.Order;
import org.hibernate.criterion.Restrictions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.unihyr.domain.Inbox;

@Repository
public class InboxDaoImpl implements InboxDao
{
	@Autowired private SessionFactory sessionFactory;
	
	public long addInboxMessage(Inbox inbox)
	{
		this.sessionFactory.getCurrentSession().save(inbox);
		this.sessionFactory.getCurrentSession().flush();
		return inbox.getInboxId();
	}
	public boolean updateInboxMessage(Inbox inbox)
	{
		try
		{
			this.sessionFactory.getCurrentSession().update(inbox);
			this.sessionFactory.getCurrentSession().flush();
			return true;
		} 
		catch (Exception e)
		{
			return false;
			// TODO: handle exception
		}
		
		
	}
	
	@SuppressWarnings("unchecked")
	public List<Inbox> getInboxMessages(long ppid, int first, int max)
	{
		return this.sessionFactory.getCurrentSession().createCriteria(Inbox.class)
				.add(Restrictions.eq("postProfile.ppid", ppid))
				.addOrder(Order.desc("createDate"))
//				.setFirstResult(first)
//				.setMaxResults(max)
				.list();
	}
	
	public boolean setViewedByClient(long ppid)
	{
		String sql = "UPDATE inbox SET `isViewed` = 1 WHERE `ppid` = "+ppid+" and client IS NULL";
		try
		{
			int count = this.sessionFactory.getCurrentSession().createSQLQuery(sql).executeUpdate();
			return true;
		} 
		catch (Exception e)
		{
			return false;
		}
		
	}
	
	public boolean setViewedByConsultant(long ppid)
	{
		String sql = "UPDATE inbox SET `isViewed` = 1 WHERE `ppid` = "+ppid+" and consultant IS NULL";
		try
		{
			int count = this.sessionFactory.getCurrentSession().createSQLQuery(sql).executeUpdate();
			return true;
		} 
		catch (Exception e)
		{
			return false;
		}
		
	}
}
