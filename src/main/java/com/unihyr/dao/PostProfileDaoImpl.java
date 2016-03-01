package com.unihyr.dao;

import java.math.BigInteger;
import java.util.List;

import org.hibernate.FetchMode;
import org.hibernate.SessionFactory;
import org.hibernate.criterion.Order;
import org.hibernate.criterion.Projections;
import org.hibernate.criterion.Restrictions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.unihyr.domain.CandidateProfile;
import com.unihyr.domain.PostProfile;

@Repository
@SuppressWarnings("unchecked")
public class PostProfileDaoImpl implements PostProfileDao
{
	@Autowired private SessionFactory sessionFactory;
	
	@Override
	public long addPostProfile(PostProfile postProfile)
	{
		this.sessionFactory.getCurrentSession().save(postProfile);
		this.sessionFactory.getCurrentSession().flush();
		return postProfile.getPpid();
	}
	
	@Override
	public boolean updatePostProfile(PostProfile postProfile)
	{
		try
		{
			this.sessionFactory.getCurrentSession().update(postProfile);
			return true;
			
		} catch (Exception e)
		{
			e.printStackTrace();
			return false;
		}
	}
	
	@Override
	public PostProfile getPostProfile(long ppid)
	{
		return (PostProfile)this.sessionFactory.getCurrentSession().get(PostProfile.class, ppid);
	}
	
	@SuppressWarnings("unchecked")
	@Override
	public PostProfile getPostProfile(long postid, long profileId)
	{
		List<PostProfile> list = this.sessionFactory.getCurrentSession().createCriteria(PostProfile.class)
				.add(Restrictions.eq("post.postId", postid))
				.add(Restrictions.eq("profile.profileId", profileId))
				.setFirstResult(0)
				.setMaxResults(1)
				.list();
		if(list.size() > 0)
		{
			return list.get(0);
		}
		return null;
	}
	
	@SuppressWarnings("unchecked")
	@Override
	public List<PostProfile> getPostProfileByClient(String clientId, int first, int max)
	{
		List<PostProfile> list = this.sessionFactory.getCurrentSession().createCriteria(PostProfile.class)
				.createAlias("post", "postAlias")
				.createAlias("postAlias.client", "clientAlias")
				.add(Restrictions.eq("clientAlias.userid", clientId))
				.add(Restrictions.isNull("postAlias.deleteDate"))
				.addOrder(Order.desc("submitted"))
				.setFirstResult(first)
				.setMaxResults(max)
				.list();
		
		return list;
	}

	
	@Override
	public long countPostProfileByClient(String clientId)
	{
		long count = (Long)this.sessionFactory.getCurrentSession().createCriteria(PostProfile.class)
				.createAlias("post", "postAlias")
				.createAlias("postAlias.client", "clientAlias")
				.add(Restrictions.eq("clientAlias.userid", clientId))
				.add(Restrictions.isNull("postAlias.deleteDate"))
				.setProjection(Projections.rowCount()).uniqueResult();
		
		return count;
	}
	
	@SuppressWarnings("unchecked")
	@Override
	public List<PostProfile> getPostProfileByPost(long postId, int first, int max)
	{
		List<PostProfile> list = this.sessionFactory.getCurrentSession().createCriteria(PostProfile.class)
				.createAlias("post", "postAlias")
				.add(Restrictions.isNull("postAlias.deleteDate"))
				.add(Restrictions.eq("postAlias.postId", postId))
				.add(Restrictions.isNull("postAlias.deleteDate"))
				.addOrder(Order.desc("submitted"))
				.setFirstResult(first)
				.setMaxResults(max)
				.list();
		return list;
	}
	
	@Override
	public long countPostProfileByPost(long postId)
	{
		long count = (Long)this.sessionFactory.getCurrentSession().createCriteria(PostProfile.class)
				.createAlias("post", "postAlias")
				.add(Restrictions.isNull("postAlias.deleteDate"))
				.add(Restrictions.eq("postAlias.postId", postId))
				.add(Restrictions.isNull("postAlias.deleteDate"))
				.setProjection(Projections.rowCount()).uniqueResult();
		
		return count;
	}
	
	@SuppressWarnings("unchecked")
	@Override
	public List<PostProfile> getPostProfileByClientAndConsultant(String clientId, String consultantId, int first, int max)
	{
		List<PostProfile> list = this.sessionFactory.getCurrentSession().createCriteria(PostProfile.class)
				.createAlias("post", "postAlias")
				.createAlias("postAlias.client", "clientAlias")
				.createAlias("profile.registration", "consAlias")
				.add(Restrictions.isNull("postAlias.deleteDate"))
				.add(Restrictions.eq("clientAlias.userid", clientId))
				.add(Restrictions.eq("consAlias.userid", consultantId))
				.addOrder(Order.desc("submitted"))
				.setFirstResult(first)
				.setMaxResults(max)
				.list();
		return list;
	}
	
	
	@Override
	public long countPostProfileByClientAndConsultant(String clientId, String consultantId)
	{
		long count = (Long)this.sessionFactory.getCurrentSession().createCriteria(PostProfile.class)
				.createAlias("post", "postAlias")
				.createAlias("postAlias.client", "clientAlias")
				.createAlias("profile", "profileAlias")
				.createAlias("profileAlias.registration", "consAlias")
				.add(Restrictions.isNull("postAlias.deleteDate"))
				.add(Restrictions.eq("clientAlias.userid", clientId))
				.add(Restrictions.eq("consAlias.userid", consultantId))
				
				.setProjection(Projections.rowCount()).uniqueResult();
		
		return count;
	}
	
	
	@SuppressWarnings("unchecked")
	@Override
	public List<PostProfile> getPostProfileByClientPostAndConsultant(String clientId, String consultantId, long postId, int first, int max)
	{
		List<PostProfile> list = this.sessionFactory.getCurrentSession().createCriteria(PostProfile.class)
				.createAlias("post", "postAlias")
				.createAlias("postAlias.client", "clientAlias")
				.add(Restrictions.eq("clientAlias.userid", clientId))
				.add(Restrictions.isNull("postAlias.deleteDate"))
				.add(Restrictions.isNotNull("postAlias.published"))
				
				.createAlias("profile.registration", "consAlias")
				.add(Restrictions.eq("consAlias.userid", consultantId))
				.add(Restrictions.eq("post.postId", postId))
				.addOrder(Order.desc("submitted"))
				.setFirstResult(first)
				.setMaxResults(max)
				.list();
		return list;
	}

	
	@Override
	public long countPostProfileByClientPostAndConsultant(String clientId, String consultantId, long postId)
	{
		long count = (Long)this.sessionFactory.getCurrentSession().createCriteria(PostProfile.class)
				.createAlias("post", "postAlias")
				.createAlias("postAlias.client", "clientAlias")
				.createAlias("profile", "profileAlias")
				.createAlias("profileAlias.registration", "consAlias")
				.add(Restrictions.eq("clientAlias.userid", clientId))
				.add(Restrictions.eq("consAlias.userid", consultantId))
				.add(Restrictions.eq("post.postId", postId))
				.add(Restrictions.isNull("postAlias.deleteDate"))
				.setProjection(Projections.rowCount()).uniqueResult();
		
		return count;
	}

	
	
	public List<PostProfile> getProfileListByConsultantIdInRange(String consultantId, int first, int max)
	{
		List<PostProfile> list = this.sessionFactory.getCurrentSession().createCriteria(PostProfile.class)
				.createAlias("profile", "profileAlias")
				.createAlias("profileAlias.registration", "regAlias")
				.add(Restrictions.eq("regAlias.userid", consultantId))
				.add(Restrictions.isNull("profileAlias.deleteDate"))
				.add(Restrictions.isNotNull("profileAlias.published"))
				
				.createAlias("post", "postAlias")
				.add(Restrictions.isNull("postAlias.deleteDate"))
				.addOrder(Order.desc("submitted"))
				.setFirstResult(first)
				.setMaxResults(max)
				.list();
		return list;
	}
	
	
	public List<PostProfile> getProfileListByConsultantIdAndPostIdInRange(String consultantId, long postId, int first, int max)
	{
		
		List<PostProfile> list = this.sessionFactory.getCurrentSession().createCriteria(PostProfile.class)
				.createAlias("profile", "profileAlias")
				.createAlias("profileAlias.registration", "regAlias")
				.add(Restrictions.eq("regAlias.userid", consultantId))
				.add(Restrictions.isNull("profileAlias.deleteDate"))
				.add(Restrictions.isNotNull("profileAlias.published"))
				
				.createAlias("post", "postAlias")
				.add(Restrictions.eq("postAlias.postId", postId))
				.add(Restrictions.isNull("postAlias.deleteDate"))
				
				.addOrder(Order.desc("submitted"))
				.setFirstResult(first)
				.setMaxResults(max)
				.list();
		return list;
	}

//	public List<PostProfile> getProfileListByConsultantIdAndClientAndPostIdInRange(String consultantId, String clientId, String postId, int i, int j);
	
	
	public long countProfileListByConsultantIdInRange(String consultantId)
	{
		long count = (Long)this.sessionFactory.getCurrentSession().createCriteria(PostProfile.class)
				.createAlias("profile", "profileAlias")
				.createAlias("profileAlias.registration", "regAlias")
				.add(Restrictions.eq("regAlias.userid", consultantId))
				.add(Restrictions.isNull("profileAlias.deleteDate"))
				.add(Restrictions.isNotNull("profileAlias.published"))
				.createAlias("post", "postAlias")
				.add(Restrictions.isNull("postAlias.deleteDate"))
				.setProjection(Projections.rowCount()).uniqueResult();
		
		return count;
	}


	public long countProfileListByConsultantIdAndPostIdInRange(String consultantId, long postId)
	{
		long count = (Long)this.sessionFactory.getCurrentSession().createCriteria(PostProfile.class)
				.createAlias("profile", "profileAlias")
				.createAlias("profileAlias.registration", "regAlias")
				.add(Restrictions.eq("regAlias.userid", consultantId))
				.add(Restrictions.isNull("profileAlias.deleteDate"))
				.add(Restrictions.isNotNull("profileAlias.published"))
				.createAlias("post", "postAlias")
				.add(Restrictions.eq("postAlias.postId", postId))
				.add(Restrictions.isNull("postAlias.deleteDate"))
				.setProjection(Projections.rowCount()).uniqueResult();
		
		return count;
	}

	public long countAllProfileListByConsultantIdInRange(String consultantId)
	{
		long count = (Long)this.sessionFactory.getCurrentSession().createCriteria(PostProfile.class)
				.createAlias("profile", "profileAlias")
				.createAlias("profileAlias.registration", "regAlias")
				.add(Restrictions.eq("regAlias.userid", consultantId))
				.setProjection(Projections.rowCount()).uniqueResult();
		
		return count;
	}
	
	
}
