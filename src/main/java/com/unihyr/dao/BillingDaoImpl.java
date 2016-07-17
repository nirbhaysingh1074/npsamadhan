package com.unihyr.dao;

import java.util.HashMap;
import java.util.List;

import org.hibernate.Criteria;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.criterion.Criterion;
import org.hibernate.criterion.LogicalExpression;
import org.hibernate.criterion.Order;
import org.hibernate.criterion.Restrictions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.unihyr.domain.BillingDetails;
import com.unihyr.domain.Industry;

@Repository
public class BillingDaoImpl implements BillingDao
{

	@Autowired
	SessionFactory sessionFactory;

	@Override
	public BillingDetails getBillingDetailsById(int id)
	{
		// TODO Auto-generated method stub
		return (BillingDetails) sessionFactory.getCurrentSession().get(BillingDetails.class, id);
	}

	@Override
	public long addBillingDetails(BillingDetails rating)
	{
		// TODO Auto-generated method stub
		try
		{
			sessionFactory.getCurrentSession().save(rating);
			this.sessionFactory.getCurrentSession().flush();
			return rating.getBillId();
		} catch (Exception e)
		{
			e.printStackTrace();
			return 0;
		}
	}

	@Override
	public long updateBillingDetails(BillingDetails rating)
	{
		// TODO Auto-generated method stub
		try
		{
			sessionFactory.getCurrentSession().update(rating);
			this.sessionFactory.getCurrentSession().flush();
			return rating.getBillId();
		} catch (Exception e)
		{
			e.printStackTrace();
			return 0;
		}
	}

	@Override
	public List<BillingDetails> getBillingDetailsByClientList(String userid,String sortParam)
	{
		// TODO Auto-generated method stub
		Session session=this.sessionFactory.getCurrentSession();
		Criteria crieteria=session.createCriteria(BillingDetails.class);
		crieteria.add(Restrictions.eq("clientId", userid));
		crieteria.addOrder(Order.desc(sortParam));
		return crieteria.list();
	}
	@Override
	public List<BillingDetails> getBillingDetailsByConsList(String userid,String sortParam)
	{
		// TODO Auto-generated method stub
		Session session=this.sessionFactory.getCurrentSession();
		Criteria crieteria=session.createCriteria(BillingDetails.class);
		crieteria.add(Restrictions.eq("consultantId", userid));
		crieteria.addOrder(Order.desc(sortParam));
		return crieteria.list();
	}

	@Override
	public BillingDetails getBillingDetailsById(long ppid)
	{
		// TODO Auto-generated method stub
		Session session=this.sessionFactory.getCurrentSession();
		Criteria crieteria=session.createCriteria(BillingDetails.class);
		crieteria.add(Restrictions.eq("postProfileId", ppid));
		if(crieteria.list().isEmpty())
			return null;
		else
		return (BillingDetails)crieteria.list().get(0);
	}

	@Override
	public List<BillingDetails> getAllDetailsUnverified()
	{
		Session session=this.sessionFactory.getCurrentSession();
		Criteria crieteria=session.createCriteria(BillingDetails.class);
		crieteria.add(Restrictions.isNull("verificationStatus"));
		return crieteria.list();
	}



}
