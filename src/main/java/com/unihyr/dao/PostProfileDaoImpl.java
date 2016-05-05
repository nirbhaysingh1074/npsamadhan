package com.unihyr.dao;

import java.math.BigInteger;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashSet;
import java.util.List;

import org.hibernate.Criteria;
import org.hibernate.FetchMode;
import org.hibernate.SessionFactory;
import org.hibernate.criterion.Criterion;
import org.hibernate.criterion.Order;
import org.hibernate.criterion.Projections;
import org.hibernate.criterion.Restrictions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.unihyr.domain.CandidateProfile;
import com.unihyr.domain.Post;
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
	public List<PostProfile> getPostProfileByPost(long postId, int first, int max,String sortParam,String filterBy)
	{
		Criteria criteria = this.sessionFactory.getCurrentSession().createCriteria(PostProfile.class)
				.createAlias("post", "postAlias")
				.add(Restrictions.eq("postAlias.postId", postId))
				.setFetchMode("messages", FetchMode.JOIN)
				.setResultTransformer(Criteria.DISTINCT_ROOT_ENTITY)
				.setFirstResult(first)
				.setMaxResults(max);
		if(filterBy.indexOf("pending")>=0){
			criteria.add(Restrictions.isNull("accepted"));
			criteria.add(Restrictions.isNull("rejected"));
		}
		else
		criteria.add(Restrictions.isNotNull(filterBy));
		if(sortParam.indexOf("submitted")>=0)
		criteria.addOrder(Order.desc(sortParam));
		else
		criteria.addOrder(Order.asc(sortParam));
		return criteria.list();
	}
	
	@Override
	public long countPostProfileByPost(long postId,String filterBy)
	{
		Criteria criteria = this.sessionFactory.getCurrentSession().createCriteria(PostProfile.class)
				.createAlias("post", "postAlias")
				.add(Restrictions.isNull("postAlias.deleteDate"))
				.add(Restrictions.eq("postAlias.postId", postId))
				.add(Restrictions.isNull("postAlias.deleteDate"));
		if(filterBy.indexOf("pending")>=0){
			criteria.add(Restrictions.isNull("accepted"));
			criteria.add(Restrictions.isNull("rejected"));
		}
		else
		criteria.add(Restrictions.isNotNull(filterBy));
		long count=	(Long)criteria.setProjection(Projections.rowCount()).uniqueResult();
		return count;
	}
	
	@SuppressWarnings("unchecked")
	@Override
	public List<PostProfile> getPostProfileByClientAndConsultant(String clientId, String consultantId, int first, int max,String sortParam,String filterBy)
	{
		Criteria criteria = this.sessionFactory.getCurrentSession().createCriteria(PostProfile.class)
				.createAlias("post", "postAlias")
				.createAlias("postAlias.client", "clientAlias")
				.createAlias("profile.registration", "consAlias")
				.add(Restrictions.isNull("postAlias.deleteDate"))
				.add(Restrictions.eq("clientAlias.userid", clientId))
				.add(Restrictions.eq("consAlias.userid", consultantId))
				.setFetchMode("messages", FetchMode.JOIN)
				.setResultTransformer(Criteria.DISTINCT_ROOT_ENTITY)
				.setFirstResult(first)
				.setMaxResults(max);

		if(filterBy.indexOf("pending")>=0){
			criteria.add(Restrictions.isNull("accepted"));
			criteria.add(Restrictions.isNull("rejected"));
		}
		else
		criteria.add(Restrictions.isNotNull(filterBy));
 		if(sortParam.indexOf("submitted")>=0)
  		criteria.addOrder(Order.desc(sortParam));
  		else
  		criteria.addOrder(Order.asc(sortParam));
		
		
		
		return criteria.list();
	}
	
	
	@Override
	public long countPostProfileByClientAndConsultant(String clientId, String consultantId,String sortParam)
	{
		long count = (Long)this.sessionFactory.getCurrentSession().createCriteria(PostProfile.class)
				.createAlias("post", "postAlias")
				.createAlias("postAlias.client", "clientAlias")
				.createAlias("profile", "profileAlias")
				.createAlias("profileAlias.registration", "consAlias")
				.add(Restrictions.isNull("postAlias.deleteDate"))
				.add(Restrictions.isNotNull(sortParam))
				.add(Restrictions.eq("clientAlias.userid", clientId))
				.add(Restrictions.eq("consAlias.userid", consultantId))
				.setProjection(Projections.rowCount()).uniqueResult();
		
		return count;
	}
	
	
	@SuppressWarnings("unchecked")
	@Override
	public List<PostProfile> getPostProfileByClientPostAndConsultant(String clientId, String consultantId, long postId, int first, int max,String sortParam,String filterBy)
	{
		List<PostProfile> list = null;
				
		Criteria criteria=		this.sessionFactory.getCurrentSession().createCriteria(PostProfile.class)
				.createAlias("post", "postAlias")
				.createAlias("postAlias.client", "clientAlias");
//		criteria.add(Restrictions.eq("clientAlias.userid", clientId));
		
		Criterion cn1 = Restrictions.eq("clientAlias.userid", clientId);
		Criterion cn2 = Restrictions.eq("clientAlias.admin.userid", clientId);
		criteria.add(Restrictions.or(cn1, cn2));
        
				
		criteria.add(Restrictions.isNull("postAlias.deleteDate"))
				.add(Restrictions.isNotNull("postAlias.published"));
				
		criteria.createAlias("profile.registration", "consAlias");
//		criteria.add(Restrictions.eq("consAlias.userid", consultantId));
				
		Criterion cn3 = Restrictions.eq("consAlias.userid", consultantId);
		Criterion cn4 = Restrictions.eq("consAlias.admin.userid", consultantId);
		criteria.add(Restrictions.or(cn3, cn4));
		        
				
		criteria.add(Restrictions.eq("post.postId", postId))
				.setFetchMode("messages", FetchMode.JOIN)
				.setResultTransformer(Criteria.DISTINCT_ROOT_ENTITY)
				.setFirstResult(first)
				.setMaxResults(max);
				if(filterBy.indexOf("pending")>=0){
					criteria.add(Restrictions.isNull("accepted"));
					criteria.add(Restrictions.isNull("rejected"));
				}
				else
				criteria.add(Restrictions.isNotNull(filterBy));
		 		if(sortParam.indexOf("submitted")>=0)
	      		criteria.addOrder(Order.desc(sortParam));
	      		else
	      		criteria.addOrder(Order.asc(sortParam));
		return criteria.list();
	}

	
	@Override
	public long countPostProfileByClientPostAndConsultant(String clientId, String consultantId, long postId,String filterBy)
	{
		Criteria criteria = this.sessionFactory.getCurrentSession().createCriteria(PostProfile.class)
				.createAlias("post", "postAlias")
				.createAlias("postAlias.client", "clientAlias")
				.createAlias("profile", "profileAlias")
				.createAlias("profileAlias.registration", "consAlias");
				
		Criterion cn1 = Restrictions.eq("clientAlias.userid", clientId);
		Criterion cn2 = Restrictions.eq("clientAlias.admin.userid", clientId);
		criteria.add(Restrictions.or(cn1, cn2));
        
				
		criteria.add(Restrictions.isNull("postAlias.deleteDate"))
				.add(Restrictions.isNotNull("postAlias.published"));
				
//		criteria.createAlias("profile.registration", "consAlias");
				
		Criterion cn3 = Restrictions.eq("consAlias.userid", consultantId);
		Criterion cn4 = Restrictions.eq("consAlias.admin.userid", consultantId);
		criteria.add(Restrictions.or(cn3, cn4));
				
		
//		criteria.add(Restrictions.eq("clientAlias.userid", clientId))
//				.add(Restrictions.eq("consAlias.userid", consultantId));
				
		criteria.add(Restrictions.eq("post.postId", postId))
				.add(Restrictions.isNull("postAlias.deleteDate"));
		if(filterBy.indexOf("pending")>=0){
			criteria.add(Restrictions.isNull("accepted"));
			criteria.add(Restrictions.isNull("rejected"));
		}
		else
		criteria.add(Restrictions.isNotNull(filterBy));
		long count		=(Long)criteria.setProjection(Projections.rowCount()).uniqueResult();
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

	@Override
	public List<PostProfile> getProfileListByConsultantIdAndPostIdInRangeAsc(String consultantId, long postId, int first, int max)
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
				.addOrder(Order.asc("submitted"))
				.setFetchMode("industries", FetchMode.JOIN)
				.setFirstResult(first)
				.setMaxResults(max)
				.list();
		return list;
	}
	@Override
	public long countProfileListByConsultantIdAndPostId(String consultantId, long postId)
	{
		long count = (Long) this.sessionFactory.getCurrentSession().createCriteria(PostProfile.class)
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
		Criteria criteria = this.sessionFactory.getCurrentSession().createCriteria(PostProfile.class);
		criteria.createAlias("profile", "profileAlias");
		criteria.createAlias("post", "postAlias");
		criteria.add(Restrictions.eq("postAlias.postId", postId));
		
		if(email != null && email.length() > 0)
		{
//			Criterion emailcheck = Restrictions.eq("profileAlias.email", email);
			criteria.add(Restrictions.eq("profileAlias.email", email));
		}
		if(contact != null && contact.length() > 0)
		{
//			Criterion contactcheck = Restrictions.eq("profileAlias.contact", contact);
			criteria.add(Restrictions.eq("profileAlias.contact", contact));
		}
		
		if((email != null && email.length() > 0) || (contact != null && contact.length() > 0))
		{
			criteria.setProjection(Projections.rowCount());
			
			long count = (Long)criteria.uniqueResult();
			if(count > 0)
			{
				return true;
			}
		}
		return false;
	}
	
	public List<PostProfile> getAllPostProfile(int first, int max)
	{
		List<PostProfile> list = this.sessionFactory.getCurrentSession().createCriteria(PostProfile.class)
				.addOrder(Order.desc("submitted"))
				.setResultTransformer(Criteria.DISTINCT_ROOT_ENTITY)
				.setFirstResult(first)
				.setMaxResults(max)
				.list();
		return list;
	}

	@Override
	public List<PostProfile> getPostProfileByPost(long postId)
	{
		List<PostProfile> list = this.sessionFactory.getCurrentSession().createCriteria(PostProfile.class)
				.createAlias("post", "postAlias")
				.add(Restrictions.isNull("postAlias.deleteDate"))
				.add(Restrictions.eq("postAlias.postId", postId))
				.add(Restrictions.isNull("postAlias.deleteDate"))
				.addOrder(Order.desc("submitted"))
				.list();
		return list;
	}

	@Override
	public long countShortlistedProfileListByConsultantIdAndPostId(String consultantId, long postId)
	{
		long count = (Long) this.sessionFactory.getCurrentSession().createCriteria(PostProfile.class)
				.createAlias("profile", "profileAlias")
				.createAlias("profileAlias.registration", "regAlias")
				.add(Restrictions.eq("regAlias.userid", consultantId))
				.add(Restrictions.isNull("profileAlias.deleteDate"))
				.add(Restrictions.isNotNull("profileAlias.published"))
				.createAlias("post", "postAlias")   
				.add(Restrictions.eq("postAlias.postId", postId))
				.add(Restrictions.isNull("postAlias.deleteDate"))	
				.add(Restrictions.isNotNull("accepted"))
				.setProjection(Projections.rowCount()).uniqueResult();
		return count;
	}

	@Override
	public long countRecruitedProfileListByConsultantIdAndPostId(String userid, long postId)
	{
		long count = (Long) this.sessionFactory.getCurrentSession().createCriteria(PostProfile.class)
				.createAlias("profile", "profileAlias")
				.createAlias("profileAlias.registration", "regAlias")
				.add(Restrictions.eq("regAlias.userid", userid))
				.add(Restrictions.isNull("profileAlias.deleteDate"))
				.add(Restrictions.isNotNull("profileAlias.published"))
				.createAlias("post", "postAlias")   
				.add(Restrictions.eq("postAlias.postId", postId))
				.add(Restrictions.isNull("postAlias.deleteDate"))	
				.add(Restrictions.isNotNull("recruited"))
				.setProjection(Projections.rowCount()).uniqueResult();
		return count;
	}
	
	public long countPostProfilesForPostByDate(long pid, String consid, Date date)
	{
		Criteria criteria = this.sessionFactory.getCurrentSession().createCriteria(PostProfile.class)
				.createAlias("post", "postAlias")   
				.createAlias("profile", "profileAlias")
				.createAlias("profileAlias.registration", "consAlias")
				.add(Restrictions.eq("postAlias.postId", pid))
				.add(Restrictions.gt("submitted", date));
				
		
		Criterion cn3 = Restrictions.eq("consAlias.userid", consid);
		Criterion cn4 = Restrictions.eq("consAlias.admin.userid", consid);
		criteria.add(Restrictions.or(cn3, cn4));
		
		long count = (Long) criteria.setProjection(Projections.rowCount()).uniqueResult();
		return count;
	}
	
	
	
	
	public long countSubmittedProfileByClientOrConsultant(String client, String consultant)
	{
		
		Criteria criteria = this.sessionFactory.getCurrentSession().createCriteria(PostProfile.class)
				.createAlias("post", "postAlias")
				.createAlias("postAlias.client", "clientAlias")
				.createAlias("profile", "profileAlias")
				.createAlias("profileAlias.registration", "consAlias");
				
		if(client != null && client.length() > 0)
		{
			Criterion cn1 = Restrictions.eq("clientAlias.userid", client);
			Criterion cn2 = Restrictions.eq("clientAlias.admin.userid", client);
			criteria.add(Restrictions.or(cn1, cn2));
		}
		
		if(consultant != null && consultant.length() > 0)
		{
			Criterion cn3 = Restrictions.eq("consAlias.userid", consultant);
			Criterion cn4 = Restrictions.eq("consAlias.admin.userid", consultant);
			criteria.add(Restrictions.or(cn3, cn4));
		}
		return (Long)criteria.setProjection(Projections.rowCount()).uniqueResult();
	}
	
	public long countShortListedProfileByClientOrConsultant(String client, String consultant)
	{
		Criteria criteria = this.sessionFactory.getCurrentSession().createCriteria(PostProfile.class)
				.add(Restrictions.isNotNull("recruited"))
				.createAlias("post", "postAlias")
				.createAlias("postAlias.client", "clientAlias")
				.createAlias("profile", "profileAlias")
				.createAlias("profileAlias.registration", "consAlias");
		if(client != null && client.length() > 0)
		{
			Criterion cn1 = Restrictions.eq("clientAlias.userid", client);
			Criterion cn2 = Restrictions.eq("clientAlias.admin.userid", client);
			criteria.add(Restrictions.or(cn1, cn2));
		}
		
		if(consultant != null && consultant.length() > 0)
		{
			Criterion cn3 = Restrictions.eq("consAlias.userid", consultant);
			Criterion cn4 = Restrictions.eq("consAlias.admin.userid", consultant);
			criteria.add(Restrictions.or(cn3, cn4));
		}
		return (Long)criteria.setProjection(Projections.rowCount()).uniqueResult();
	}
	
	public long countJoinedProfileByClientOrConsultant(String client, String consultant)
	{
		Criteria criteria = this.sessionFactory.getCurrentSession().createCriteria(PostProfile.class)
				.add(Restrictions.isNotNull("joinDate"))
				.createAlias("post", "postAlias")
				.createAlias("postAlias.client", "clientAlias")
				.createAlias("profile", "profileAlias")
				.createAlias("profileAlias.registration", "consAlias");
		if(client != null && client.length() > 0)
		{
			Criterion cn1 = Restrictions.eq("clientAlias.userid", client);
			Criterion cn2 = Restrictions.eq("clientAlias.admin.userid", client);
			criteria.add(Restrictions.or(cn1, cn2));
		}
		
		if(consultant != null && consultant.length() > 0)
		{
			Criterion cn3 = Restrictions.eq("consAlias.userid", consultant);
			Criterion cn4 = Restrictions.eq("consAlias.admin.userid", consultant);
			criteria.add(Restrictions.or(cn3, cn4));
		}
		return (Long)criteria.setProjection(Projections.rowCount()).uniqueResult();
	}
	
	public long countPartnerByClientOrConsultant(String client, String consultant)
	{
		Criteria criteria = this.sessionFactory.getCurrentSession().createCriteria(PostProfile.class)
				.createAlias("post", "postAlias")
				.createAlias("postAlias.client", "clientAlias")
				.createAlias("profile", "profileAlias")
				.createAlias("profileAlias.registration", "consAlias");
		if(client != null && client.length() > 0)
		{
			Criterion cn1 = Restrictions.eq("clientAlias.userid", client);
			Criterion cn2 = Restrictions.eq("clientAlias.admin.userid", client);
			criteria.add(Restrictions.or(cn1, cn2));
			criteria.setProjection(Projections.distinct((Projections.projectionList().add(Projections.property("clientAlias.userid")))));
			return new HashSet<>(criteria.list()).size();
		}
		else if(consultant != null && consultant.length() > 0)
		{
			Criterion cn3 = Restrictions.eq("consAlias.userid", consultant);
			Criterion cn4 = Restrictions.eq("consAlias.admin.userid", consultant);
			criteria.add(Restrictions.or(cn3, cn4));
			criteria.setProjection(Projections.distinct((Projections.projectionList().add(Projections.property("consAlias.userid")))));
			return new HashSet<>(criteria.list()).size();
		}
		
		return 0;
	}
	
	
	
	
	
	
	
	@SuppressWarnings("unchecked")
	@Override
	public List<PostProfile> getPostProfileByClientForCenter(String clientId, int first, int max)
	{
		Criteria criteria = this.sessionFactory.getCurrentSession().createCriteria(PostProfile.class);
		criteria.setProjection(Projections.distinct((Projections.projectionList().add(Projections.id()).add(Projections.property("ppid")))));
		
		criteria.createAlias("post", "postAlias");
		criteria.createAlias("postAlias.client", "clientAlias");
		
		Criterion cn1 = Restrictions.eq("clientAlias.userid", clientId);
		Criterion cn2 = Restrictions.eq("clientAlias.admin.userid", clientId);
		criteria.add(Restrictions.or(cn1, cn2));
		
		criteria.setFirstResult(first);
		criteria.setMaxResults(max);
		
		
		List<Object[]> idList = criteria.list();
		//get the id's from the projection
        List<Long> longList = new ArrayList<Long>();
        for (Object[] long1 : idList) {
            Object[] record = long1;
            longList.add((Long) record[0]);
        }

		if (longList.size() > 0)
		{
			criteria = this.sessionFactory.getCurrentSession().createCriteria(PostProfile.class);
            criteria.add(Restrictions.in("ppid", longList));
            criteria.setResultTransformer(Criteria.DISTINCT_ROOT_ENTITY);
        } 
		else
		{
		//no results, so let's ommit the second query to the DB
	         return new ArrayList<PostProfile>();
        }

		return criteria.list();
		
	}

	
	@Override
	public long countPostProfileByClientForCenter(String clientId)
	{
		Criteria criteria =  this.sessionFactory.getCurrentSession().createCriteria(PostProfile.class);

		criteria.createAlias("post", "postAlias");
		criteria.createAlias("postAlias.client", "clientAlias");
		
//		criteria.add(Restrictions.eq("client.userid", clientId));
		Criterion cn1 = Restrictions.eq("clientAlias.userid", clientId);
		Criterion cn2 = Restrictions.eq("clientAlias.admin.userid", clientId);
		criteria.add(Restrictions.or(cn1, cn2));
		
		
		long count = (Long)criteria.setProjection(Projections.rowCount()).uniqueResult();
		
		return count;
	}
	
	public List<PostProfile> getPostProfileByConsForCenter(String consid, int first, int max)
	{
		Criteria criteria = this.sessionFactory.getCurrentSession().createCriteria(PostProfile.class);
		criteria.setProjection(Projections.distinct((Projections.projectionList().add(Projections.id()).add(Projections.property("ppid")))));
		
		
		criteria.createAlias("profile", "profileAlias");
		criteria.createAlias("profileAlias.registration", "consAlias");
		
		Criterion cn1 = Restrictions.eq("consAlias.userid", consid);
		Criterion cn2 = Restrictions.eq("consAlias.admin.userid", consid);
		criteria.add(Restrictions.or(cn1, cn2));
		
		criteria.setFirstResult(first);
		criteria.setMaxResults(max);
		
		
		List<Object[]> idList = criteria.list();
		//get the id's from the projection
        List<Long> longList = new ArrayList<Long>();
        for (Object[] long1 : idList) {
            Object[] record = long1;
            longList.add((Long) record[0]);
        }

		if (longList.size() > 0)
		{
			criteria = this.sessionFactory.getCurrentSession().createCriteria(PostProfile.class);
            criteria.add(Restrictions.in("ppid", longList));
            criteria.setResultTransformer(Criteria.DISTINCT_ROOT_ENTITY);
        } 
		else
		{
		//no results, so let's ommit the second query to the DB
	         return new ArrayList<PostProfile>();
        }

		return criteria.list();
	}
	
	public long countPostProfileByConsForCenter(String consid)
	{
		Criteria criteria =  this.sessionFactory.getCurrentSession().createCriteria(PostProfile.class);

		criteria.createAlias("profile", "profileAlias");
		criteria.createAlias("profileAlias.registration", "consAlias");
		
		Criterion cn1 = Restrictions.eq("consAlias.userid", consid);
		Criterion cn2 = Restrictions.eq("consAlias.admin.userid", consid);
		criteria.add(Restrictions.or(cn1, cn2));
		
		
		long count = (Long)criteria.setProjection(Projections.rowCount()).uniqueResult();
		
		return count;
	}

	@Override
	public long countProfileListByPostId(long postId)
	{
		long count = (Long) this.sessionFactory.getCurrentSession().createCriteria(PostProfile.class)
				.createAlias("profile", "profileAlias")
				.createAlias("profileAlias.registration", "regAlias")
				.add(Restrictions.isNull("profileAlias.deleteDate"))
				.add(Restrictions.isNotNull("profileAlias.published"))
				.createAlias("post", "postAlias")   
				.add(Restrictions.eq("postAlias.postId", postId))
				.add(Restrictions.isNull("postAlias.deleteDate"))	
				.add(Restrictions.isNotNull("recruited"))
				.setProjection(Projections.rowCount()).uniqueResult();
		return count;
	}
}
