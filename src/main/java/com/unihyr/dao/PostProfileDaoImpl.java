package com.unihyr.dao;

import java.math.BigInteger;
import java.util.List;

import org.hibernate.Criteria;
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
		List<PostProfile> list = this.sessionFactory.getCurrentSession().createCriteria(PostProfile.class)
				.add(Restrictions.eq("ppid", ppid))
				.setFetchMode("messages", FetchMode.JOIN)
				.setFirstResult(0)
				.setMaxResults(1)
				.list();
		if(list.size() > 0)
		{
			return list.get(0);
		}
		return null;
//		return (PostProfile)this.sessionFactory.getCurrentSession().get(PostProfile.class, ppid);
	}
	
	@SuppressWarnings("unchecked")
	@Override
	public PostProfile getPostProfile(long postid, long profileId)
	{
		List<PostProfile> list = this.sessionFactory.getCurrentSession().createCriteria(PostProfile.class)
				.add(Restrictions.eq("post.postId", postid))
				.add(Restrictions.eq("profile.profileId", profileId))
				.setFetchMode("messages", FetchMode.JOIN)
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
				.setFetchMode("messages", FetchMode.JOIN)
				.setResultTransformer(Criteria.DISTINCT_ROOT_ENTITY)
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
				.setFetchMode("messages", FetchMode.JOIN)
				.setResultTransformer(Criteria.DISTINCT_ROOT_ENTITY)
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
				.setFetchMode("messages", FetchMode.JOIN)
				.setResultTransformer(Criteria.DISTINCT_ROOT_ENTITY)
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
				.setFetchMode("messages", FetchMode.JOIN)
				.setResultTransformer(Criteria.DISTINCT_ROOT_ENTITY)
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

	
	@Override
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
				.setFetchMode("messages", FetchMode.JOIN)
				.setResultTransformer(Criteria.DISTINCT_ROOT_ENTITY)
				.addOrder(Order.desc("submitted"))
				.setFirstResult(first)
				.setMaxResults(max)
				.list();
		return list;
	}
	
	@Override
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
				.setFetchMode("messages", FetchMode.JOIN)
				.setResultTransformer(Criteria.DISTINCT_ROOT_ENTITY)
				.addOrder(Order.desc("submitted"))
				.setFirstResult(first)
				.setMaxResults(max)
				.list();
		return list;
	}

//	public List<PostProfile> getProfileListByConsultantIdAndClientAndPostIdInRange(String consultantId, String clientId, String postId, int i, int j);
	
	@Override
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


	@Override
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

	@Override
	public long countAllProfileListByConsultantIdInRange(String consultantId)
	{
		long count = (Long)this.sessionFactory.getCurrentSession().createCriteria(PostProfile.class)
				.createAlias("profile", "profileAlias")
				.createAlias("profileAlias.registration", "regAlias")
				.add(Restrictions.eq("regAlias.userid", consultantId))
				.setProjection(Projections.rowCount()).uniqueResult();
		
		return count;
	}
	
	@Override
	public boolean checkPostProfileAvailability(long postId, String email, String contact)
	{
		long count = (Long)this.sessionFactory.getCurrentSession().createCriteria(PostProfile.class)
				.createAlias("profile", "profileAlias")
				.createAlias("post", "postAlias")
				.add(Restrictions.eq("profileAlias.email", email))
				.add(Restrictions.eq("profileAlias.contact", contact))
				.add(Restrictions.eq("postAlias.postId", postId))
				.setProjection(Projections.rowCount()).uniqueResult();
		
		if(count > 0)
		{
			return true;
		}
		return false;
	}
	
	public List<PostProfile> getAllPostProfile(int first, int max)
	{
		List<PostProfile> list = this.sessionFactory.getCurrentSession().createCriteria(PostProfile.class)
				.setResultTransformer(Criteria.DISTINCT_ROOT_ENTITY)
				.addOrder(Order.desc("submitted"))
				.setFirstResult(first)
				.setMaxResults(max)
				.list();
		return list;
	}
	
}
