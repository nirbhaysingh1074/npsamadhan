package com.unihyr.dao;

import java.util.List;

import org.hibernate.Criteria;
import org.hibernate.FetchMode;
import org.hibernate.SQLQuery;
import org.hibernate.SessionFactory;
import org.hibernate.criterion.Order;
import org.hibernate.criterion.Projections;
import org.hibernate.criterion.Restrictions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.unihyr.domain.CandidateProfile;
import com.unihyr.domain.Registration;

@Repository
@SuppressWarnings("unchecked")
public class RegistrationDaoImpl implements RegistrationDao
{
	@Autowired private SessionFactory sessionFactory;
	
	@Override
	public Registration getRegistationByUserId(String userid)
	{
		List<Registration> logList = this.sessionFactory.getCurrentSession().createCriteria(Registration.class)
				.add(Restrictions.eq("userid", userid))
				.setFetchMode("industries", FetchMode.JOIN)
				.setResultTransformer(Criteria.DISTINCT_ROOT_ENTITY)
				.list();
		if(!logList.isEmpty())
		{
			return logList.get(0);
		}
		return null;
	}
	
	@Override
	public int countUsers()
	{
		Long c = (Long)this.sessionFactory.getCurrentSession().createCriteria(Registration.class).setProjection(Projections.rowCount()).uniqueResult();
		return c.intValue();
	}
	
	@Override
	public List<Registration> getRegistrations(int first, int max)
	{
		return this.sessionFactory.getCurrentSession().createCriteria(Registration.class).addOrder(Order.desc("lid")).setFirstResult(first).setMaxResults(max).list();
	}
	
	@Override
	public void update(Registration registration)
	{
		this.sessionFactory.getCurrentSession().update(registration);
		this.sessionFactory.getCurrentSession().flush();
		
	}
	
	@Override
	public List<Registration> getConsultantsByClient(String clientId)
	{
		String hql = "select DISTINCT reg.* from registration reg INNER JOIN candidateprofile cp ON reg.userid = cp.consultantId AND cp.profileId in(SELECT pp.profileId FROM profile_posts pp LEFT JOIN post po ON pp.postId = po.postId AND po.clientId LIKE :clientId)";
		SQLQuery query=this.sessionFactory.getCurrentSession().createSQLQuery(hql);          
		query.setParameter("clientId",clientId);
		query.addEntity(Registration.class);
		List<Registration> list = (List<Registration>)query.list();
		return list;
	}
	
	@Override
	public List<Registration> getConsultantsByPost(long postId)
	{
		String hql = "select DISTINCT reg.* from registration reg INNER JOIN candidateprofile cp ON reg.userid = cp.consultantId AND cp.profileId in(SELECT pp.profileId FROM profile_posts pp where pp.postId = :postId)";
		SQLQuery query=this.sessionFactory.getCurrentSession().createSQLQuery(hql);          
		query.setParameter("postId",postId);
		query.addEntity(Registration.class);
		List<Registration> list = (List<Registration>)query.list();
		return list;
	}
	
}
