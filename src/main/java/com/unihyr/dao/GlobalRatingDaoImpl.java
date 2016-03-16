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

import com.unihyr.domain.GlobalRating;
import com.unihyr.domain.Industry;

@Repository
public class GlobalRatingDaoImpl implements GlobalRatingDao
{

	@Autowired
	SessionFactory sessionFactory;

	@Override
	public GlobalRating getGlobalRatingById(String id)
	{
		// TODO Auto-generated method stub
		return (GlobalRating) sessionFactory.getCurrentSession().get(GlobalRating.class, id);
	}

	@Override
	public long addGlobalRating(GlobalRating rating)
	{
		// TODO Auto-generated method stub
		try
		{
			sessionFactory.getCurrentSession().save(rating);
			return rating.getSn();
		} catch (Exception e)
		{
			e.printStackTrace();
			return 0;
		}
	}

	@Override
	public long updateGlobalRating(GlobalRating rating)
	{
		// TODO Auto-generated method stub
		try
		{
			sessionFactory.getCurrentSession().update(rating);
			return rating.getSn();
		} catch (Exception e)
		{
			e.printStackTrace();
			return 0;
		}
	}

	@Override
	public List<GlobalRating> getGlobalRatingList()
	{
		// TODO Auto-generated method stub

		String sql = "SELECT * FROM globalrating WHERE industryId=2 and consultantId='amar@silvereye.co'";
		return sessionFactory.getCurrentSession().createCriteria(GlobalRating.class).list();
	}

	@Override
	public List<GlobalRating> getGlobalRatingListByIndustryAndConsultant(int industryId, int consultantId)
	{
		String sql = "SELECT * FROM globalrating WHERE industryId=:industryId and consultantId=:consultantId";
		Session session = this.sessionFactory.getCurrentSession();
		Criteria cr = session.createCriteria(GlobalRating.class);
		Criterion crt = Restrictions.eq("industryId", industryId);
		Criterion crt1 = Restrictions.eq("consultantId", consultantId);
		LogicalExpression lg = Restrictions.and(crt, crt1);
		cr.add(lg);
		cr.addOrder(Order.desc("ratingParamValue"));
		return (List<GlobalRating>) cr.list();
	}

	@Override
	public List<GlobalRating> getGlobalRatingListByIndustryAndConsultantRange(int industryId, int consultantId,
			int first,int max)
	{
		Session session = this.sessionFactory.getCurrentSession();
		Criteria cr = session.createCriteria(GlobalRating.class);
		Criterion crt = Restrictions.eq("industryId", industryId);
		Criterion crt1 = Restrictions.eq("consultantId", consultantId);
		LogicalExpression lg = Restrictions.and(crt, crt1);
		cr.add(lg);
		cr.addOrder(Order.desc("ratingParamValue"));
		cr.setFirstResult(first);
		cr.setMaxResults(max);
		return (List<GlobalRating>) cr.list();
	}

}
