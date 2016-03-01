package com.unihyr.dao;

import java.util.List;

import org.hibernate.Criteria;
import org.hibernate.SessionFactory;
import org.hibernate.criterion.Restrictions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.unihyr.domain.PostConsultant;

@Repository
public class PostConsultnatDaoImpl implements PostConsultnatDao
{
	@Autowired private SessionFactory sessionFactory;
	
	public List<PostConsultant> getInterestedPostForConsultantByClient(String consultantId, String clientId)
	{
		Criteria criteria = this.sessionFactory.getCurrentSession().createCriteria(PostConsultant.class);
		criteria.createAlias("post.client", "clientAlias").add(Restrictions.eq("clientAlias.userid", clientId));
		criteria.createAlias("consultant", "consAlias").add(Restrictions.eq("consAlias.userid", consultantId));
		

		return criteria.list();
	}
}
