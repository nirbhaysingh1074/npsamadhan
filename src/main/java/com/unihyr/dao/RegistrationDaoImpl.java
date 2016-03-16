package com.unihyr.dao;

import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;
import java.util.Set;

import org.hibernate.Criteria;
import org.hibernate.FetchMode;
import org.hibernate.SQLQuery;
import org.hibernate.SessionFactory;
import org.hibernate.criterion.Disjunction;
import org.hibernate.criterion.Order;
import org.hibernate.criterion.Projections;
import org.hibernate.criterion.Restrictions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.unihyr.constraints.Roles;
import com.unihyr.domain.CandidateProfile;
import com.unihyr.domain.Industry;
import com.unihyr.domain.Post;
import com.unihyr.domain.PostConsultant;
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
		String hql = "select DISTINCT reg.* from registration reg INNER JOIN candidateprofile cp ON reg.userid = cp.consultantId AND cp.profileId in(SELECT pp.profileId FROM postprofile pp LEFT JOIN post po ON pp.postId = po.postId AND po.clientId LIKE :clientId)";
		SQLQuery query=this.sessionFactory.getCurrentSession().createSQLQuery(hql);          
		query.setParameter("clientId",clientId);
		query.addEntity(Registration.class);
		List<Registration> list = (List<Registration>)query.list();
		return list;
	}
	
	@Override
	public List<Registration> getConsultantsByPost(long postId)
	{
		String hql = "select DISTINCT reg.* from registration reg INNER JOIN candidateprofile cp ON reg.userid = cp.consultantId AND cp.profileId in(SELECT pp.profileId FROM postprofile pp where pp.postId = :postId)";
		SQLQuery query=this.sessionFactory.getCurrentSession().createSQLQuery(hql);          
		query.setParameter("postId",postId);
		query.addEntity(Registration.class);
		List<Registration> list = (List<Registration>)query.list();
		return list;
	}
	
	@Override
	public List<Registration> getClientsByIndustyForConsultant(String consultantId)
	{
		Criteria criteria =  this.sessionFactory.getCurrentSession().createCriteria(PostConsultant.class)
				.createAlias("post", "postAlias")
				.createAlias("postAlias.client", "clientAlias")
				.createAlias("consultant", "conAlias")
				.setProjection(Projections.distinct((Projections.projectionList().add(Projections.id()).add(Projections.property("clientAlias.lid")))))
				.add(Restrictions.eq("conAlias.userid", consultantId))
				.setResultTransformer(Criteria.DISTINCT_ROOT_ENTITY);
				
		List<Integer[]> idList = criteria.list();
		//get the id's from the projection
//        List<Integer> longList = new ArrayList<Integer>();
//        for (Object[] record : idList) {
//            longList.add((Integer) record[1]);
//        }

		if (idList.size() > 0)
		{
			
			criteria = this.sessionFactory.getCurrentSession().createCriteria(Registration.class);
			criteria.add(Restrictions.in("lid", idList));
		}
		else
		{
		//no results, so let's ommit the second query to the DB
	         return new ArrayList<Registration>();
        }

		return criteria.list();
		
	}
	
	@Override
	public long countConsultantList()
	{
		Disjunction or = Restrictions.disjunction();
		or.add(Restrictions.eq("roleAlias.userrole", Roles.ROLE_CON_MANAGER.toString()));
		or.add(Restrictions.eq("roleAlias.userrole", Roles.ROLE_CON_USER.toString()));
		
		long count = (Long)this.sessionFactory.getCurrentSession().createCriteria(Registration.class)
				.createCriteria("log", "logAlias")
				.createCriteria("logAlias.roles", "roleAlias")
				.add(or)
				.setProjection(Projections.rowCount())
				.uniqueResult();
		return count;
	}
	
	@Override
	public long countClientsList()
	{
		Disjunction or = Restrictions.disjunction();
		or.add(Restrictions.eq("roleAlias.userrole", Roles.ROLE_EMP_MANAGER.toString()));
		or.add(Restrictions.eq("roleAlias.userrole", Roles.ROLE_EMP_USER.toString()));
		
		Criteria criteria = this.sessionFactory.getCurrentSession().createCriteria(Registration.class);
		criteria.createCriteria("log", "logAlias");
		criteria.createCriteria("logAlias.roles", "roleAlias");
		criteria.add(Restrictions.or(Restrictions.eq("roleAlias.userrole", Roles.ROLE_EMP_MANAGER.toString()),Restrictions.eq("roleAlias.userrole", Roles.ROLE_EMP_USER.toString())));
		
		long count = (Long)criteria.setProjection(Projections.rowCount())
				.uniqueResult();
		return count;
	}
	
}
