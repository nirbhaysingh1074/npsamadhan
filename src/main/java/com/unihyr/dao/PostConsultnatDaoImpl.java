package com.unihyr.dao;

import java.util.ArrayList;
import java.util.List;

import org.hibernate.Criteria;
import org.hibernate.SessionFactory;
import org.hibernate.criterion.Criterion;
import org.hibernate.criterion.Order;
import org.hibernate.criterion.Restrictions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.unihyr.domain.Industry;
import com.unihyr.domain.PostConsultant;

@Repository
public class PostConsultnatDaoImpl implements PostConsultnatDao
{
	@Autowired private SessionFactory sessionFactory;
	
	public List<PostConsultant> getInterestedPostForConsultantByClient(String consultantId, String clientId,String sortParam)
	{
		Criteria criteria = this.sessionFactory.getCurrentSession().createCriteria(PostConsultant.class);
		criteria.createAlias("post.client", "clientAlias").createAlias("post", "postAlias")
		.add(Restrictions.isNotNull("postAlias.verifyDate"));
		// criteria.add(Restrictions.eq("clientAlias.userid", clientId));
		Criterion cn1 = Restrictions.eq("clientAlias.userid", clientId);
		// criteria.createAlias("client", "clientAlias");
		Criterion cn2 = Restrictions.eq("clientAlias.admin.userid", clientId);
		criteria.add(Restrictions.or(cn1, cn2));
		criteria.createAlias("consultant", "consAlias").add(Restrictions.eq("consAlias.userid", consultantId));
		criteria.addOrder(Order.asc(sortParam));
		return criteria.list();
	}
	
	@Override
	public List<PostConsultant> getInterestedConsultantByPost(long postId,String sortOrder)
	{
		Criteria criteria = this.sessionFactory.getCurrentSession().createCriteria(PostConsultant.class);
		if(sortOrder.indexOf("desc")>=0)
		criteria.addOrder(Order.desc("percentile"));
		else
		criteria.addOrder(Order.asc("percentile"));
			
		criteria.add(Restrictions.eq("post.postId", postId));
		return criteria.list();
	}
	@Override
	public List<PostConsultant> getInterestedConsultantSortedByPost(long postId,String sortParam,String order)
	{
		Criteria criteria = this.sessionFactory.getCurrentSession().createCriteria(PostConsultant.class);
		criteria.add(Restrictions.eq("post.postId", postId));
		criteria.addOrder(Order.asc(sortParam));
		return criteria.list();
	}

	@Override
	public void updatePostConsultant(PostConsultant postConsultant)
	{
		this.sessionFactory.getCurrentSession().update(postConsultant);
		this.sessionFactory.getCurrentSession().flush();
		return;
	}

	@Override
	public List<PostConsultant> getInterestedPostConsultantsByConsIdandPostId(String consName, long postId, String ratingParam)
	{
		List<PostConsultant> list=new  ArrayList<PostConsultant>();
		Criteria criteria = this.sessionFactory.getCurrentSession().createCriteria(PostConsultant.class);
		criteria.add(Restrictions.eq("post.postId", postId));
		if(ratingParam.indexOf("turnAround")>=0||ratingParam.indexOf("offerdrop")>=0)
			criteria.addOrder(Order.desc(ratingParam));
			else
		criteria.addOrder(Order.asc(ratingParam));
		list=criteria.list();
		if(list!=null)
		return list;
		else
		return new  ArrayList<PostConsultant>();
	}
}
