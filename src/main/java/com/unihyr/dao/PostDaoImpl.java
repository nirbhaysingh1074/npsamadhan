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
	
	@Override
	public List<Post> getPosts(int first, int max)
	{
		return this.sessionFactory.getCurrentSession().createCriteria(Post.class)
				.add(Restrictions.isNull("deleteDate")).addOrder(Order.desc("createDate"))
				.setFetchMode("postProfile", FetchMode.JOIN)
				.setFirstResult(first).setMaxResults(max)
				.setResultTransformer(Criteria.DISTINCT_ROOT_ENTITY)
				.list();
	}
	
	public List<Post> getPostsByClient(String userid)
	{
		return this.sessionFactory.getCurrentSession().createCriteria(Post.class)
				.add(Restrictions.isNull("deleteDate")).add(Restrictions.eq("client.userid", userid))
				.setFetchMode("postProfile", FetchMode.JOIN).addOrder(Order.desc("createDate"))
				.setResultTransformer(Criteria.DISTINCT_ROOT_ENTITY)
				.list();
	}
	
	
	public List<Post> getPostsByClient(String userid, int first, int max)
	{
		Criteria criteria = this.sessionFactory.getCurrentSession().createCriteria(Post.class);
		criteria.setProjection(Projections.distinct((Projections.projectionList().add(Projections.id()).add(Projections.property("postId")))));
		criteria.add(Restrictions.isNull("deleteDate")).add(Restrictions.isNotNull("published")).add(Restrictions.eq("client.userid", userid));
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
	public long countPostByClient(String userid)
	{
		long count = (Long)this.sessionFactory.getCurrentSession().createCriteria(Post.class)
				.add(Restrictions.isNull("deleteDate")).add(Restrictions.isNotNull("published")).add(Restrictions.eq("client.userid", userid))
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
		
		
//		return this.sessionFactory.getCurrentSession().createCriteria(Post.class)
//				.add(Restrictions.eq("client.userid", userid))
//				.addOrder(Order.desc("createDate"))
//				.setFetchMode("postProfile", FetchMode.JOIN)
//				.setFirstResult(first).setMaxResults(max)
//				.setResultTransformer(Criteria.DISTINCT_ROOT_ENTITY)
//				.list();
	}
	
	@Override
	public long countAllPostByClient(String userid)
	{
		long count = (Long)this.sessionFactory.getCurrentSession().createCriteria(Post.class)
				.add(Restrictions.isNull("deleteDate")).add(Restrictions.eq("client.userid", userid))
				.setProjection(Projections.rowCount())
				.uniqueResult();
		return count;
	}
	
	@Override
	public List<Post> getAllInactivePostsByClient(String userid, int first, int max)
	{
		
		Criteria criteria = this.sessionFactory.getCurrentSession().createCriteria(Post.class);
		criteria.setProjection(Projections.distinct((Projections.projectionList().add(Projections.id()).add(Projections.property("postId")))));
		criteria.add(Restrictions.isNull("deleteDate")).add(Restrictions.isNull("published")).add(Restrictions.eq("client.userid", userid));
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
		
		
		
		
//		return this.sessionFactory.getCurrentSession().createCriteria(Post.class)
//				.add(Restrictions.isNull("published")).add(Restrictions.eq("client.userid", userid))
//				.addOrder(Order.desc("createDate"))
//				.setFetchMode("postProfile", FetchMode.JOIN)
//				.setFirstResult(first).setMaxResults(max)
//				.setResultTransformer(Criteria.DISTINCT_ROOT_ENTITY)
//				.list();
	}
	
	@Override
	public long countAllInactivePostByClient(String userid)
	{
		long count = (Long)this.sessionFactory.getCurrentSession().createCriteria(Post.class)
				.add(Restrictions.isNull("published")).add(Restrictions.eq("client.userid", userid))
				.setProjection(Projections.rowCount())
				.uniqueResult();
		return count;
	}

	@Override
	public List<Post> getDeletedPostsByClient(String userid, int first, int max)
	{
		Criteria criteria = this.sessionFactory.getCurrentSession().createCriteria(Post.class);
		criteria.setProjection(Projections.distinct((Projections.projectionList().add(Projections.id()).add(Projections.property("postId")))));
		criteria.add(Restrictions.isNotNull("deleteDate")).add(Restrictions.eq("client.userid", userid));
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
	public long countDeletedPostByClient(String userid)
	{
		long count = (Long)this.sessionFactory.getCurrentSession().createCriteria(Post.class)
				.add(Restrictions.isNotNull("deleteDate")).add(Restrictions.eq("client.userid", userid))
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
	public long countPostsByIndustryUsingConsultantId(String name)
	{
		List<Integer> indList = new ArrayList<>();
		List<Registration> reg =  this.sessionFactory.getCurrentSession().createCriteria(Registration.class).add(Restrictions.eq("userid", name)).list();
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
	
	public List<Post> getPostsBySubmittedProfilesByConsultantId(String consultantId, int first, int max)
	{
		Criteria criteria = this.sessionFactory.getCurrentSession().createCriteria(Post.class);
		criteria.setProjection(Projections.distinct((Projections.projectionList().add(Projections.id()).add(Projections.property("postId")))));
		criteria.add(Restrictions.isNull("deleteDate")).add(Restrictions.isNotNull("published"));
		
		criteria.createAlias("postProfile", "ppAlias");
		criteria.createAlias("ppAlias.profile", "prAlias");
		criteria.createAlias("prAlias.registration", "regAlias");
        criteria.add(Restrictions.eq("regAlias.userid",consultantId));
        
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
		criteria.add(Restrictions.isNull("deleteDate")).add(Restrictions.isNotNull("published"));
		criteria.createAlias("postProfile", "ppAlias")
				.createAlias("ppAlias.profile", "prAlias")
				.createAlias("prAlias.registration", "regAlias")
		        .add(Restrictions.eq("regAlias.userid",consultantId));
        
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
		criteria.createAlias("postProfile", "ppAlias");
		criteria.createAlias("ppAlias.profile", "prAlias");
		criteria.createAlias("prAlias.registration", "regAlias");
        criteria.add(Restrictions.eq("regAlias.userid",consultantId));
        
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
		criteria.createAlias("postProfile", "ppAlias")
		.createAlias("ppAlias.profile", "prAlias")
		.createAlias("prAlias.registration", "regAlias")
        .add(Restrictions.eq("regAlias.userid",consultantId));
        
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
		or.add(Restrictions.isNull("published"));
		criteria.add(or);
		criteria.createAlias("postProfile", "ppAlias");
		criteria.createAlias("ppAlias.profile", "prAlias");
		criteria.createAlias("prAlias.registration", "regAlias");
        criteria.add(Restrictions.eq("regAlias.userid",consultantId));
        
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
				or.add(Restrictions.isNull("published"));
				criteria.add(or);
				criteria.createAlias("postProfile", "ppAlias")
				.createAlias("ppAlias.profile", "prAlias")
				.createAlias("prAlias.registration", "regAlias")
		        .add(Restrictions.eq("regAlias.userid",consultantId))
		        .setResultTransformer(Criteria.DISTINCT_ROOT_ENTITY)
				.setProjection(Projections.rowCount());
				
		return (Long)criteria.uniqueResult();
	}

	
}
