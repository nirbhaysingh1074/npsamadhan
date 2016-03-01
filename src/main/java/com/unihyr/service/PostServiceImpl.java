package com.unihyr.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.unihyr.dao.PostDao;
import com.unihyr.domain.Post;

@Service
@Transactional
public class PostServiceImpl implements PostService 
{
	@Autowired private PostDao postDao; 
	
	@Override
	public long addPost(Post post) 
	{
		return this.postDao.addPost(post);
	}

	@Override
	public void updatePost(Post post) 
	{
		this.postDao.updatePost(post);
	}

	@Override
	public Post getPost(long postId) 
	{
		return this.postDao.getPost(postId);
	}

	@Override
	public List<Post> getPosts() 
	{
		return this.postDao.getPosts();
	}

	@Override
	public List<Post> getPosts(int first, int max) 
	{
		return this.postDao.getPosts(first, max);
	}
	@Override
	public List<Post> getPostsByClient(String userid)
	{
		return this.postDao.getPostsByClient(userid);
	}
	
	@Override
	public List<Post> getPostsByClient(String userid, int first, int max)
	{
		return this.postDao.getPostsByClient(userid, first, max);
	}
	
	@Override
	public long countPostByClient(String userid)
	{
		return this.postDao.countPostByClient(userid);
	}
	
	@Override
	public List<Post> getAllPostsByClient(String userid, int first, int max)
	{
		return this.postDao.getAllPostsByClient(userid, first, max);
	}
	
	@Override
	public long countAllPostByClient(String userid)
	{
		return this.postDao.countAllPostByClient(userid);
	}
	
	@Override
	public List<Post> getAllInactivePostsByClient(String userid, int first, int max)
	{
		return this.postDao.getAllInactivePostsByClient(userid, first, max);
	}
	
	@Override
	public long countAllInactivePostByClient(String userid)
	{
		return this.postDao.countAllInactivePostByClient(userid);
	}

	
	@Override
	public List<Post> getDeletedPostsByClient(String userid, int first, int max)
	{
		return this.postDao.getDeletedPostsByClient(userid, first, max);
	}
	
	@Override
	public long countDeletedPostByClient(String userid)
	{
		return this.postDao.countDeletedPostByClient(userid);
	}
	@Override
	public List<Post> getPostsByIndustryUsingConsultantId(String consultantId, int first, int max)
	{
		
		return this.postDao.getPostsByIndustryUsingConsultantId(consultantId, first, max);
	}

	@Override
	public long countPostsByIndustryUsingConsultantId(String name)
	{
		
		return this.postDao.countPostsByIndustryUsingConsultantId(name);
	}
	
	@Override
	public List<Post> getPostsBySubmittedProfilesByConsultantId(String consultantId, int first, int max)
	{
		return this.postDao.getPostsBySubmittedProfilesByConsultantId(consultantId, first, max);
	}

	@Override
	public long countPostsBySubmittedProfilesByConsultantId(String consultantId)
	{
		return this.postDao.countPostsBySubmittedProfilesByConsultantId(consultantId);
	}

	@Override
	public List<Post> getAllPostsBySubmittedProfilesByConsultantId(String consultantId, int first, int max)
	{
		return this.postDao.getAllPostsBySubmittedProfilesByConsultantId(consultantId, first, max);
	}

	@Override
	public long countAllPostsBySubmittedProfilesByConsultantId(String consultantId)
	{
		return this.postDao.countAllPostsBySubmittedProfilesByConsultantId(consultantId);
	}

	@Override
	public List<Post> getInactivePostsBySubmittedProfilesByConsultantId(String consultantId, int first, int max)
	{
		return this.postDao.getInactivePostsBySubmittedProfilesByConsultantId(consultantId, first, max);
	}

	@Override
	public long countInactivePostsBySubmittedProfilesByConsultantId(String consultantId)
	{
		return this.postDao.countInactivePostsBySubmittedProfilesByConsultantId(consultantId);
	}

	
}
