package com.unihyr.dao;

import java.util.List;

import org.hibernate.Criteria;
import org.hibernate.FetchMode;
import org.hibernate.SessionFactory;
import org.hibernate.criterion.Order;
import org.hibernate.criterion.Projections;
import org.hibernate.criterion.Restrictions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.unihyr.domain.Post;

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
				.setFetchMode("profileList", FetchMode.JOIN)
				.setResultTransformer(Criteria.DISTINCT_ROOT_ENTITY)
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
				.setFetchMode("profileList", FetchMode.JOIN)
				.setResultTransformer(Criteria.DISTINCT_ROOT_ENTITY)
				.list();
	}
	
	@Override
	public List<Post> getPosts(int first, int max)
	{
		return this.sessionFactory.getCurrentSession().createCriteria(Post.class)
				.add(Restrictions.isNull("deleteDate")).addOrder(Order.desc("createDate"))
				.setFetchMode("profileList", FetchMode.JOIN)
				.setFirstResult(first).setMaxResults(max)
				.setResultTransformer(Criteria.DISTINCT_ROOT_ENTITY)
				.list();
	}
	
	public List<Post> getPostsByClient(String userid)
	{
		return this.sessionFactory.getCurrentSession().createCriteria(Post.class)
				.add(Restrictions.isNull("deleteDate")).add(Restrictions.eq("client.userid", userid))
				.setFetchMode("profileList", FetchMode.JOIN).addOrder(Order.desc("createDate"))
				.setResultTransformer(Criteria.DISTINCT_ROOT_ENTITY)
				.list();
	}
	
	
	public List<Post> getPostsByClient(String userid, int first, int max)
	{
		return this.sessionFactory.getCurrentSession().createCriteria(Post.class)
				.add(Restrictions.isNull("deleteDate")).add(Restrictions.eq("client.userid", userid))
				.addOrder(Order.desc("createDate")).setFetchMode("profileList", FetchMode.JOIN)
				.setFirstResult(first).setMaxResults(max)
				.setResultTransformer(Criteria.DISTINCT_ROOT_ENTITY)
				.list();
	}
	
	
	@Override
	public long countPostByClient(String userid)
	{
		long count = (Long)this.sessionFactory.getCurrentSession().createCriteria(Post.class)
				.add(Restrictions.isNull("deleteDate")).add(Restrictions.eq("client.userid", userid))
				.setProjection(Projections.rowCount())
				.uniqueResult();
		return count;
	}
	
}
