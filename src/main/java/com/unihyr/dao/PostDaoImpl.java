package com.unihyr.dao;

import java.util.ArrayList;
import java.util.Collection;
import java.util.Iterator;
import java.util.List;
import java.util.Set;

import org.hibernate.Criteria;
import org.hibernate.FetchMode;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.criterion.Disjunction;
import org.hibernate.criterion.Expression;
import org.hibernate.criterion.Order;
import org.hibernate.criterion.Projections;
import org.hibernate.criterion.Restrictions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.unihyr.domain.Industry;
import com.unihyr.domain.Post;
import com.unihyr.domain.Registration;

@Repository
@SuppressWarnings("unchecked")
public class PostDaoImpl implements PostDao
{
	@Autowired private SessionFactory sessionFactory;
	
	@Override
	public long addPost(Post post)
	{
		this.sessionFactory.getCurrentSession().save(post);
		this.sessionFactory.getCurrentSession().flush();
		return post.getPostId();
	}
	
	@Override
	public void updatePost(Post post)
	{
		this.sessionFactory.getCurrentSession().update(post);
		this.sessionFactory.getCurrentSession().flush();
	}
	
	@Override
	public Post getPost(long postId)
	{
		List<Post> list  = this.sessionFactory.getCurrentSession().createCriteria(Post.class)
				.add(Restrictions.eq("postId", postId)).addOrder(Order.desc("createDate"))
				.setFetchMode("postProfile", FetchMode.JOIN)
				.setFetchMode("postConsultants", FetchMode.JOIN)
				
				.list();
		if(list != null)
		{
			return list.get(0);
		}
		return null;
	}
	
	@Override
	public List<Post> getPosts()
	{
		return this.sessionFactory.getCurrentSession().createCriteria(Post.class)
				.add(Restrictions.isNull("deleteDate")).addOrder(Order.desc("createDate"))
				.setFetchMode("postProfile", FetchMode.JOIN)
				.setResultTransformer(Criteria.DISTINCT_ROOT_ENTITY)
				.list();
	}
	
	public long countPosts()
	{
		long count = (Long)this.sessionFactory.getCurrentSession().createCriteria(Post.class)
				.add(Restrictions.isNull("deleteDate"))
				.setProjection(Projections.rowCount())
				.uniqueResult();
		return count;
	}
	
	@Override
	public List<Post> getPosts(int first, int max)
	{
		Criteria criteria =this.sessionFactory.getCurrentSession().createCriteria(Post.class)
				.add(Restrictions.isNull("deleteDate"))
				.addOrder(Order.desc("createDate"))
				.setFetchMode("postProfile", FetchMode.JOIN)
				.setFirstResult(first).setMaxResults(max)
				.setResultTransformer(Criteria.DISTINCT_ROOT_ENTITY);
				
		
		return criteria.list();
	}
	
	public List<Post> getActivePostsByClient(String clientId)
	{
		Criteria criteria = this.sessionFactory.getCurrentSession().createCriteria(Post.class)
				.add(Restrictions.eq("client.userid", clientId))

				.add(Restrictions.isNotNull("published"))
				.add(Restrictions.eq("isActive", true))
				.add(Restrictions.isNull("deleteDate"))
				.add(Restrictions.isNull("closeDate"))
				
				.setFetchMode("postProfile", FetchMode.JOIN).addOrder(Order.desc("createDate"))
				.setResultTransformer(Criteria.DISTINCT_ROOT_ENTITY);
		return criteria.list();
	}
	
	
	public List<Post> getActivePostsByClient(String clientId, int first, int max)
	{
		Criteria criteria = this.sessionFactory.getCurrentSession().createCriteria(Post.class);
		criteria.setProjection(Projections.distinct((Projections.projectionList().add(Projections.id()).add(Projections.property("postId")))));
		criteria.add(Restrictions.eq("client.userid", clientId));
		criteria.add(Restrictions.isNotNull("published"))
		.add(Restrictions.eq("isActive", true))
		.add(Restrictions.isNull("deleteDate"))
		.add(Restrictions.isNull("closeDate"));

		criteria.addOrder(Order.desc("createDate"));
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
			//get all the id's corresponding to the projection, 
			//then apply distinct root entity
            criteria = this.sessionFactory.getCurrentSession().createCriteria(Post.class);
            criteria.add(Restrictions.in("postId", longList)).addOrder(Order.desc("createDate"));
            criteria.setFetchMode("postProfile", FetchMode.JOIN);
            criteria.addOrder(Order.desc("createDate"));
            criteria.setResultTransformer(Criteria.DISTINCT_ROOT_ENTITY);
        } 
		else
		{
		//no results, so let's ommit the second query to the DB
	         return new ArrayList<Post>();
        }

		return criteria.list();
		
//		return this.sessionFactory.getCurrentSession().createCriteria(Post.class)
//				.add(Restrictions.isNull("deleteDate")).add(Restrictions.eq("client.userid", userid))
//				.addOrder(Order.desc("createDate")).setFetchMode("postProfile", FetchMode.JOIN)
//				.setFirstResult(first).setMaxResults(max)
//				.setResultTransformer(Criteria.DISTINCT_ROOT_ENTITY)
//				.list();
	}
	
	
	@Override
	public long countActivePostByClient(String clientId)
	{
		long count = (Long)this.sessionFactory.getCurrentSession().createCriteria(Post.class)
				.add(Restrictions.eq("client.userid", clientId))
				
				.add(Restrictions.isNotNull("published"))
				.add(Restrictions.eq("isActive", true))
				.add(Restrictions.isNull("deleteDate"))
				.add(Restrictions.isNull("closeDate"))

				.setProjection(Projections.rowCount())
				.uniqueResult();
		return count;
	}
	
	@Override
	public List<Post> getAllPostsByClient(String userid, int first, int max)
	{
		Criteria criteria = this.sessionFactory.getCurrentSession().createCriteria(Post.class);
		criteria.setProjection(Projections.distinct((Projections.projectionList().add(Projections.id()).add(Projections.property("postId")))));
		criteria.add(Restrictions.isNull("deleteDate")).add(Restrictions.eq("client.userid", userid));
		criteria.addOrder(Order.desc("createDate"));
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
			//get all the id's corresponding to the projection, 
			//then apply distinct root entity
            criteria = this.sessionFactory.getCurrentSession().createCriteria(Post.class);
            criteria.add(Restrictions.in("postId", longList));
            criteria.setFetchMode("postProfile", FetchMode.JOIN);
            criteria.addOrder(Order.desc("createDate"));
            criteria.setResultTransformer(Criteria.DISTINCT_ROOT_ENTITY);
        } 
		else
		{
		//no results, so let's ommit the second query to the DB
	         return new ArrayList<Post>();
        }

		return criteria.list();
		
	}
	
	@Override
	public long countAllPostByClient(String clientId)
	{
		long count = (Long)this.sessionFactory.getCurrentSession().createCriteria(Post.class)
				.add(Restrictions.isNull("deleteDate")).add(Restrictions.eq("client.userid", clientId))
				.setProjection(Projections.rowCount())
				.uniqueResult();
		return count;
	}
	
	@Override
	public List<Post> getPublishedPostsByClient(String clientId, int first, int max)
	{
		
		Criteria criteria = this.sessionFactory.getCurrentSession().createCriteria(Post.class);
		criteria.setProjection(Projections.distinct((Projections.projectionList().add(Projections.id()).add(Projections.property("postId")))));
		criteria.add(Restrictions.isNotNull("published"))
		.add(Restrictions.isNull("deleteDate"))
		.add(Restrictions.isNull("closeDate"));

		criteria.add(Restrictions.eq("client.userid", clientId));
		
		criteria.addOrder(Order.desc("createDate"));
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
			//get all the id's corresponding to the projection, 
			//then apply distinct root entity
            criteria = this.sessionFactory.getCurrentSession().createCriteria(Post.class);
            criteria.add(Restrictions.in("postId", longList));
            criteria.setFetchMode("postProfile", FetchMode.JOIN);
            criteria.addOrder(Order.desc("postId"));
            criteria.setResultTransformer(Criteria.DISTINCT_ROOT_ENTITY);
        } 
		else
		{
		//no results, so let's ommit the second query to the DB
	         return new ArrayList<Post>();
        }

		return criteria.list();
		
	}
	
	@Override
	public long countPublishedPostByClient(String clientId)
	{
		long count = (Long)this.sessionFactory.getCurrentSession().createCriteria(Post.class)
				.add(Restrictions.eq("client.userid", clientId))
				.add(Restrictions.isNotNull("published"))
				.add(Restrictions.isNull("deleteDate"))
				.add(Restrictions.isNull("closeDate"))

				.setProjection(Projections.rowCount())
				.uniqueResult();
		return count;
	}

	@Override
	public List<Post> getClosedPostsByClient(String clientId, int first, int max)
	{
		Criteria criteria = this.sessionFactory.getCurrentSession().createCriteria(Post.class);
		criteria.setProjection(Projections.distinct((Projections.projectionList().add(Projections.id()).add(Projections.property("postId")))));
		criteria.add(Restrictions.isNull("deleteDate"))
				.add(Restrictions.isNotNull("closeDate"))
				.add(Restrictions.eq("client.userid", clientId));
		criteria.addOrder(Order.desc("createDate"));
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
			//get all the id's corresponding to the projection, 
			//then apply distinct root entity
            criteria = this.sessionFactory.getCurrentSession().createCriteria(Post.class);
            criteria.add(Restrictions.in("postId", longList));
            criteria.setFetchMode("postProfile", FetchMode.JOIN);
            criteria.addOrder(Order.desc("createDate"));
            criteria.setResultTransformer(Criteria.DISTINCT_ROOT_ENTITY);
        } 
		else
		{
		//no results, so let's ommit the second query to the DB
	         return new ArrayList<Post>();
        }

		return criteria.list();
		
	}
	
	@Override
	public long countClosedPostByClient(String clientId)
	{
		long count = (Long)this.sessionFactory.getCurrentSession().createCriteria(Post.class)
				.add(Restrictions.isNull("deleteDate"))
				.add(Restrictions.isNotNull("closeDate"))
				.add(Restrictions.eq("client.userid", clientId))
				.setProjection(Projections.rowCount())
				.uniqueResult();
		return count;
	}
	
	public List<Post> getSavedPostsByClient(String clientId, int first, int max)
	{
		Criteria criteria = this.sessionFactory.getCurrentSession().createCriteria(Post.class);
		criteria.setProjection(Projections.distinct((Projections.projectionList().add(Projections.id()).add(Projections.property("postId")))));
		criteria.add(Restrictions.isNull("published"))
				.add(Restrictions.isNull("deleteDate"))
				.add(Restrictions.eq("client.userid", clientId));
		criteria.addOrder(Order.desc("createDate"));
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
			//get all the id's corresponding to the projection, 
			//then apply distinct root entity
            criteria = this.sessionFactory.getCurrentSession().createCriteria(Post.class);
            criteria.add(Restrictions.in("postId", longList));
            criteria.setFetchMode("postProfile", FetchMode.JOIN);
            criteria.addOrder(Order.desc("createDate"));
            criteria.setResultTransformer(Criteria.DISTINCT_ROOT_ENTITY);
        } 
		else
		{
		//no results, so let's ommit the second query to the DB
	         return new ArrayList<Post>();
        }

		return criteria.list();
		
	}
	
	public long countSavedPostByClient(String clientId)
	{
		long count = (Long)this.sessionFactory.getCurrentSession().createCriteria(Post.class)
				.add(Restrictions.isNull("published"))
				.add(Restrictions.isNull("deleteDate"))
				.add(Restrictions.eq("client.userid", clientId))
				.setProjection(Projections.rowCount())
				.uniqueResult();
		return count;
	}
	
	
	
	@Override
	public List<Post> getPostsByIndustryUsingConsultantId(String consultantId, int first, int max)
	{
		List<Integer> indList = new ArrayList<>();
		List<Registration> reg =  this.sessionFactory.getCurrentSession().createCriteria(Registration.class)
				.add(Restrictions.eq("userid", consultantId))
				.list();
		if(reg != null && !reg.isEmpty())
		{
			Set<Industry> inds = reg.get(0).getIndustries();
			Iterator<Industry> it = inds.iterator();
			while(it.hasNext())
			{
				indList.add(it.next().getId());
			}
		}
		
		
		Criteria criteria = this.sessionFactory.getCurrentSession().createCriteria(Post.class);
		criteria.setProjection(Projections.distinct((Projections.projectionList().add(Projections.id()).add(Projections.property("postId")))));
		criteria.add(Restrictions.isNull("deleteDate")).add(Restrictions.isNotNull("published"));
		
		criteria.createAlias("client", "clientAlias");
		criteria.createAlias("clientAlias.industries", "indAlias");
		criteria.add(Restrictions.in("indAlias.id", indList));
		criteria.addOrder(Order.desc("createDate"));
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
			//get all the id's corresponding to the projection, 
			//then apply distinct root entity
            criteria = this.sessionFactory.getCurrentSession().createCriteria(Post.class);
            criteria.add(Restrictions.in("postId", longList));
            criteria.setFetchMode("postProfile", FetchMode.JOIN);
            criteria.setFetchMode("postConsultants", FetchMode.JOIN);
            criteria.addOrder(Order.desc("createDate"));
            criteria.setResultTransformer(Criteria.DISTINCT_ROOT_ENTITY);
        } 
		else
		{
		//no results, so let's ommit the second query to the DB
	         return new ArrayList<Post>();
        }

		return criteria.list();
		
	}

	@Override
	public long countPostsByIndustryUsingConsultantId(String consultantId)
	{
		List<Integer> indList = new ArrayList<>();
		List<Registration> reg =  this.sessionFactory.getCurrentSession().createCriteria(Registration.class).add(Restrictions.eq("userid", consultantId)).list();
		if(reg != null && !reg.isEmpty())
		{
			Set<Industry> inds = reg.get(0).getIndustries();
			Iterator<Industry> it = inds.iterator();
			while(it.hasNext())
			{
				indList.add(it.next().getId());
			}
		}
		
		long count = (Long)this.sessionFactory.getCurrentSession().createCriteria(Post.class)
					.add(Restrictions.isNull("deleteDate")).add(Restrictions.isNotNull("published"))
					.createAlias("client", "clientAlias")
					.createAlias("clientAlias.industries", "indAlias")
					.add(Restrictions.in("indAlias.id", indList))
					.setProjection(Projections.rowCount())
					.uniqueResult();
		return count;
	}
	
	public List<Post> getPostsByIndustryId(int industryId, int first, int max)
	{
		
		Criteria criteria = this.sessionFactory.getCurrentSession().createCriteria(Post.class);
		criteria.setProjection(Projections.distinct((Projections.projectionList().add(Projections.id()).add(Projections.property("postId")))));
		criteria.add(Restrictions.isNull("deleteDate")).add(Restrictions.isNotNull("published"));
		
		criteria.createAlias("client", "clientAlias");
		criteria.createAlias("clientAlias.industries", "indAlias");
		criteria.add(Restrictions.eq("indAlias.id", industryId));
		criteria.addOrder(Order.desc("createDate"));
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
			//get all the id's corresponding to the projection, 
			//then apply distinct root entity
            criteria = this.sessionFactory.getCurrentSession().createCriteria(Post.class);
            criteria.add(Restrictions.in("postId", longList));
            criteria.setFetchMode("postProfile", FetchMode.JOIN);
            criteria.setFetchMode("postConsultants", FetchMode.JOIN);
            criteria.addOrder(Order.desc("createDate"));
            criteria.setResultTransformer(Criteria.DISTINCT_ROOT_ENTITY);
        } 
		else
		{
		//no results, so let's ommit the second query to the DB
	         return new ArrayList<Post>();
        }

		return criteria.list();
		
	}

	public long countPostsByIndustryId(int industryId)
	{
		
		long count = (Long)this.sessionFactory.getCurrentSession().createCriteria(Post.class)
					.add(Restrictions.isNull("deleteDate")).add(Restrictions.isNotNull("published"))
					.createAlias("client", "clientAlias")
					.createAlias("clientAlias.industries", "indAlias")
					.add(Restrictions.eq("indAlias.id", industryId))
					.setProjection(Projections.rowCount())
					.uniqueResult();
		return count;
	}

	
	public List<Post> getPostsBySubmittedProfilesByConsultantId(String consultantId, int first, int max)
	{
		Criteria criteria = this.sessionFactory.getCurrentSession().createCriteria(Post.class);
		criteria.setProjection(Projections.distinct((Projections.projectionList().add(Projections.id()).add(Projections.property("postId")))));
		criteria.add(Restrictions.isNull("deleteDate"));
		criteria.add(Restrictions.eq("isActive", true));
		criteria.createAlias("postConsultants", "pcAlias");
		criteria.createAlias("pcAlias.consultant", "consAlias");
        criteria.add(Restrictions.eq("consAlias.userid",consultantId));
        criteria.addOrder(Order.desc("createDate"));
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
			criteria = this.sessionFactory.getCurrentSession().createCriteria(Post.class);
			criteria.add(Restrictions.in("postId", longList));
			criteria.setFetchMode("postProfile", FetchMode.JOIN);
			criteria.addOrder(Order.desc("createDate"));
			criteria.setResultTransformer(Criteria.DISTINCT_ROOT_ENTITY);
			
		}
		else
		{
			return new ArrayList<Post>();
		}
		
		
       
		return criteria.list();
	}

	public long countPostsBySubmittedProfilesByConsultantId(String consultantId)
	{
		Criteria criteria = this.sessionFactory.getCurrentSession().createCriteria(Post.class);
		criteria.setProjection(Projections.distinct((Projections.projectionList().add(Projections.id()).add(Projections.property("postId")))));
		criteria.add(Restrictions.isNull("deleteDate"));
		criteria.add(Restrictions.eq("isActive", true));
		
		criteria.createAlias("postConsultants", "pcAlias");
		criteria.createAlias("pcAlias.consultant", "consAlias");
        criteria.add(Restrictions.eq("consAlias.userid",consultantId));
        criteria.addOrder(Order.desc("createDate"));
        
		List<Object[]> idList = criteria.list();
		//get the id's from the projection
        List<Long> longList = new ArrayList<Long>();
        for (Object[] long1 : idList) {
            Object[] record = long1;
            longList.add((Long) record[0]);
        }

		if (longList.size() > 0)
		{
			long count = (Long)this.sessionFactory.getCurrentSession().createCriteria(Post.class)
					.add(Restrictions.in("postId",longList))
					.setResultTransformer(Criteria.DISTINCT_ROOT_ENTITY)
					.setProjection(Projections.rowCount())
					.uniqueResult();
			return count;
			
		}
		return 0;
		
	}

	
	public List<Post> getAllPostsBySubmittedProfilesByConsultantId(String consultantId, int first, int max)
	{
		Criteria criteria = this.sessionFactory.getCurrentSession().createCriteria(Post.class);
		criteria.setProjection(Projections.distinct((Projections.projectionList().add(Projections.id()).add(Projections.property("postId")))));
		criteria.add(Restrictions.isNull("deleteDate"));
		criteria.createAlias("postConsultants", "pcAlias");
		criteria.createAlias("pcAlias.consultant", "consAlias");
        criteria.add(Restrictions.eq("consAlias.userid",consultantId));
        criteria.addOrder(Order.desc("createDate"));
        
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
			criteria = this.sessionFactory.getCurrentSession().createCriteria(Post.class);
			criteria.add(Restrictions.in("postId", longList));
			criteria.setFetchMode("postProfile", FetchMode.JOIN);
			criteria.addOrder(Order.desc("createDate"));
			criteria.setResultTransformer(Criteria.DISTINCT_ROOT_ENTITY);
			
		}
		else
		{
			return new ArrayList<Post>();
		}
		
		
       
		return criteria.list();
	}

	public long countAllPostsBySubmittedProfilesByConsultantId(String consultantId)
	{
		Criteria criteria = this.sessionFactory.getCurrentSession().createCriteria(Post.class);
		criteria.setProjection(Projections.distinct((Projections.projectionList().add(Projections.id()).add(Projections.property("postId")))));
		criteria.add(Restrictions.isNull("deleteDate"));
		criteria.createAlias("postConsultants", "pcAlias");
		criteria.createAlias("pcAlias.consultant", "consAlias");
        criteria.add(Restrictions.eq("consAlias.userid",consultantId));
        criteria.addOrder(Order.desc("createDate"));
        
		List<Object[]> idList = criteria.list();
		//get the id's from the projection
        List<Long> longList = new ArrayList<Long>();
        for (Object[] long1 : idList) {
            Object[] record = long1;
            longList.add((Long) record[0]);
        }

		if (longList.size() > 0)
		{
			long count = (Long)this.sessionFactory.getCurrentSession().createCriteria(Post.class)
					.add(Restrictions.in("postId",longList))
					.setResultTransformer(Criteria.DISTINCT_ROOT_ENTITY)
					.setProjection(Projections.rowCount())
					.uniqueResult();
			return count;
			
		}
		return 0;

	}

	public List<Post> getInactivePostsBySubmittedProfilesByConsultantId(String consultantId, int first, int max)
	{
		Criteria criteria = this.sessionFactory.getCurrentSession().createCriteria(Post.class);
		criteria.setProjection(Projections.distinct((Projections.projectionList().add(Projections.id()).add(Projections.property("postId")))));
		Disjunction or = Restrictions.disjunction();
		or.add(Restrictions.isNotNull("deleteDate"));
		or.add(Restrictions.eq("isActive", false));
		criteria.add(or);
		criteria.createAlias("postConsultants", "pcAlias");
		criteria.createAlias("pcAlias.consultant", "consAlias");
        criteria.add(Restrictions.eq("consAlias.userid",consultantId));
        criteria.addOrder(Order.desc("createDate"));
        
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
			criteria = this.sessionFactory.getCurrentSession().createCriteria(Post.class);
			criteria.add(Restrictions.in("postId", longList));
			criteria.setFetchMode("postProfile", FetchMode.JOIN);
			criteria.addOrder(Order.desc("createDate"));
			criteria.setResultTransformer(Criteria.DISTINCT_ROOT_ENTITY);
			
		}
		else
		{
			return new ArrayList<Post>();
		}
		
		
       
		return criteria.list();
	}

	public long countInactivePostsBySubmittedProfilesByConsultantId(String consultantId)
	{
		Criteria criteria = this.sessionFactory.getCurrentSession().createCriteria(Post.class);
		Disjunction or = Restrictions.disjunction();
		or.add(Restrictions.isNotNull("deleteDate"));
		or.add(Restrictions.eq("isActive", false));
		criteria.add(or);
		criteria.createAlias("postConsultants", "pcAlias");
		criteria.createAlias("pcAlias.consultant", "consAlias");
        criteria.add(Restrictions.eq("consAlias.userid",consultantId))
        
        .setResultTransformer(Criteria.DISTINCT_ROOT_ENTITY)
		.setProjection(Projections.rowCount());
				
		return (Long)criteria.uniqueResult();
	}

	public List<Post> getPostsBySubmittedProfilesByConsultantId(String consultantId, String clientId, int first, int max)
	{
		Criteria criteria = this.sessionFactory.getCurrentSession().createCriteria(Post.class);
		criteria.setProjection(Projections.distinct((Projections.projectionList().add(Projections.id()).add(Projections.property("postId")))));
		criteria.add(Restrictions.isNull("deleteDate"));
		criteria.add(Restrictions.eq("isActive", true));
		criteria.createAlias("postConsultants", "pcAlias");
		criteria.createAlias("pcAlias.consultant", "consAlias");
        criteria.add(Restrictions.eq("consAlias.userid",consultantId));
        criteria.add(Restrictions.eq("client.userid",clientId));
        
        criteria.addOrder(Order.desc("createDate"));
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
			criteria = this.sessionFactory.getCurrentSession().createCriteria(Post.class);
			criteria.add(Restrictions.in("postId", longList));
			criteria.setFetchMode("postProfile", FetchMode.JOIN);
			criteria.addOrder(Order.desc("createDate"));
			criteria.setResultTransformer(Criteria.DISTINCT_ROOT_ENTITY);
			
		}
		else
		{
			return new ArrayList<Post>();
		}
		
		
       
		return criteria.list();
	}

	public long countPostsBySubmittedProfilesByConsultantId(String consultantId, String clientId)
	{
		Criteria criteria = this.sessionFactory.getCurrentSession().createCriteria(Post.class);
		criteria.setProjection(Projections.distinct((Projections.projectionList().add(Projections.id()).add(Projections.property("postId")))));
		criteria.add(Restrictions.isNull("deleteDate"));
		criteria.add(Restrictions.eq("isActive", true));
		
		criteria.createAlias("postConsultants", "pcAlias");
		criteria.createAlias("pcAlias.consultant", "consAlias");
        criteria.add(Restrictions.eq("consAlias.userid",consultantId));
        criteria.add(Restrictions.eq("client.userid",clientId));
        
        criteria.addOrder(Order.desc("createDate"));
        
		List<Object[]> idList = criteria.list();
		//get the id's from the projection
        List<Long> longList = new ArrayList<Long>();
        for (Object[] long1 : idList) {
            Object[] record = long1;
            longList.add((Long) record[0]);
        }

		if (longList.size() > 0)
		{
			long count = (Long)this.sessionFactory.getCurrentSession().createCriteria(Post.class)
					.add(Restrictions.in("postId",longList))
					.setResultTransformer(Criteria.DISTINCT_ROOT_ENTITY)
					.setProjection(Projections.rowCount())
					.uniqueResult();
			return count;
			
		}
		return 0;
		
	}

	
	public List<Post> getAllPostsBySubmittedProfilesByConsultantId(String consultantId, String clientId, int first, int max)
	{
		Criteria criteria = this.sessionFactory.getCurrentSession().createCriteria(Post.class);
		criteria.setProjection(Projections.distinct((Projections.projectionList().add(Projections.id()).add(Projections.property("postId")))));
		criteria.add(Restrictions.isNull("deleteDate"));
		criteria.createAlias("postConsultants", "pcAlias");
		criteria.createAlias("pcAlias.consultant", "consAlias");
        criteria.add(Restrictions.eq("consAlias.userid",consultantId));
        criteria.add(Restrictions.eq("client.userid",clientId));
        
        criteria.addOrder(Order.desc("createDate"));
        
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
			criteria = this.sessionFactory.getCurrentSession().createCriteria(Post.class);
			criteria.add(Restrictions.in("postId", longList));
			criteria.setFetchMode("postProfile", FetchMode.JOIN);
			criteria.addOrder(Order.desc("createDate"));
			criteria.setResultTransformer(Criteria.DISTINCT_ROOT_ENTITY);
			
		}
		else
		{
			return new ArrayList<Post>();
		}
		
		
       
		return criteria.list();
	}

	public long countAllPostsBySubmittedProfilesByConsultantId(String consultantId, String clientId)
	{
		Criteria criteria = this.sessionFactory.getCurrentSession().createCriteria(Post.class);
		criteria.setProjection(Projections.distinct((Projections.projectionList().add(Projections.id()).add(Projections.property("postId")))));
		criteria.add(Restrictions.isNull("deleteDate"));
		criteria.createAlias("postConsultants", "pcAlias");
		criteria.createAlias("pcAlias.consultant", "consAlias");
        criteria.add(Restrictions.eq("consAlias.userid",consultantId));
        criteria.add(Restrictions.eq("client.userid",clientId));
        
        criteria.addOrder(Order.desc("createDate"));
        
		List<Object[]> idList = criteria.list();
		//get the id's from the projection
        List<Long> longList = new ArrayList<Long>();
        for (Object[] long1 : idList) {
            Object[] record = long1;
            longList.add((Long) record[0]);
        }

		if (longList.size() > 0)
		{
			long count = (Long)this.sessionFactory.getCurrentSession().createCriteria(Post.class)
					.add(Restrictions.in("postId",longList))
					.setResultTransformer(Criteria.DISTINCT_ROOT_ENTITY)
					.setProjection(Projections.rowCount())
					.uniqueResult();
			return count;
			
		}
		return 0;

	}

	public List<Post> getInactivePostsBySubmittedProfilesByConsultantId(String consultantId, String clientId, int first, int max)
	{
		Criteria criteria = this.sessionFactory.getCurrentSession().createCriteria(Post.class);
		criteria.setProjection(Projections.distinct((Projections.projectionList().add(Projections.id()).add(Projections.property("postId")))));
		Disjunction or = Restrictions.disjunction();
		or.add(Restrictions.isNotNull("deleteDate"));
		or.add(Restrictions.eq("isActive", false));
		criteria.add(or);
		criteria.createAlias("postConsultants", "pcAlias");
		criteria.createAlias("pcAlias.consultant", "consAlias");
        criteria.add(Restrictions.eq("consAlias.userid",consultantId));
        criteria.add(Restrictions.eq("client.userid",clientId));
        
        criteria.addOrder(Order.desc("createDate"));
        
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
			criteria = this.sessionFactory.getCurrentSession().createCriteria(Post.class);
			criteria.add(Restrictions.in("postId", longList));
			criteria.setFetchMode("postProfile", FetchMode.JOIN);
			criteria.addOrder(Order.desc("createDate"));
			criteria.setResultTransformer(Criteria.DISTINCT_ROOT_ENTITY);
			
		}
		else
		{
			return new ArrayList<Post>();
		}
		
		
       
		return criteria.list();
	}

	public long countInactivePostsBySubmittedProfilesByConsultantId(String consultantId, String clientId)
	{
		Criteria criteria = this.sessionFactory.getCurrentSession().createCriteria(Post.class);
		Disjunction or = Restrictions.disjunction();
		or.add(Restrictions.isNotNull("deleteDate"));
		or.add(Restrictions.eq("isActive", false));
		criteria.add(or);
		criteria.createAlias("postConsultants", "pcAlias");
		criteria.createAlias("pcAlias.consultant", "consAlias");
		criteria.add(Restrictions.eq("client.userid",clientId));
        criteria.add(Restrictions.eq("consAlias.userid",consultantId))
        
        .setResultTransformer(Criteria.DISTINCT_ROOT_ENTITY)
		.setProjection(Projections.rowCount());
				
		return (Long)criteria.uniqueResult();
	}

	
}
