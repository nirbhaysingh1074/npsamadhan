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
	public long countPosts()
	{
		return this.postDao.countPosts();
	}
	@Override
	public List<Post> getPosts(int first, int max) 
	{
		return this.postDao.getPosts(first, max);
	}
	@Override
	public List<Post> getActivePostsByClient(String userid)
	{
		return this.postDao.getActivePostsByClient(userid);
	}
	
	@Override
	public List<Post> getActivePostsByClient(String userid, int first, int max)
	{
		return this.postDao.getActivePostsByClient(userid, first, max);
	}
	
	@Override
	public long countActivePostByClient(String userid)
	{
		return this.postDao.countActivePostByClient(userid);
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
	public List<Post> getPublishedPostsByClient(String userid, int first, int max)
	{
		return this.postDao.getPublishedPostsByClient(userid, first, max);
	}
	
	@Override
	public long countPublishedPostByClient(String userid)
	{
		return this.postDao.countPublishedPostByClient(userid);
	}

	
	@Override
	public List<Post> getClosedPostsByClient(String userid, int first, int max)
	{
		return this.postDao.getClosedPostsByClient(userid, first, max);
	}
	
	@Override
	public long countClosedPostByClient(String userid)
	{
		return this.postDao.countClosedPostByClient(userid);
	}
	
	public List<Post> getSavedPostsByClient(String clientId, int first, int max)
	{
		return this.postDao.getSavedPostsByClient(clientId, first, max);
	}
	
	public long countSavedPostByClient(String clientId)
	{
		return this.postDao.countSavedPostByClient(clientId);
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
	public List<Post> getPostsByIndustryId(int industryId, int first, int max)
	{
		return this.postDao.getPostsByIndustryId(industryId, first, max);
	}

	@Override
	public long countPostsByIndustryId(int industryId)
	{
		return this.postDao.countPostsByIndustryId(industryId);
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

	@Override
	public List<Post> getPostsBySubmittedProfilesByConsultantId(String consultantId, String clientId, int first, int max)
	{
		return this.postDao.getPostsBySubmittedProfilesByConsultantId(consultantId, clientId, first, max);
	}

	@Override
	public long countPostsBySubmittedProfilesByConsultantId(String consultantId, String clientId)
	{
		return this.postDao.countPostsBySubmittedProfilesByConsultantId(consultantId, clientId);
	}

	@Override
	public List<Post> getAllPostsBySubmittedProfilesByConsultantId(String consultantId, String clientId, int first, int max)
	{
		return this.postDao.getAllPostsBySubmittedProfilesByConsultantId(consultantId, clientId, first, max);
	}

	@Override
	public long countAllPostsBySubmittedProfilesByConsultantId(String consultantId, String clientId)
	{
		return this.postDao.countAllPostsBySubmittedProfilesByConsultantId(consultantId, clientId);
	}

	@Override
	public List<Post> getInactivePostsBySubmittedProfilesByConsultantId(String consultantId, String clientId, int first, int max)
	{
		return this.postDao.getInactivePostsBySubmittedProfilesByConsultantId(consultantId, clientId, first, max);
	}

	@Override
	public long countInactivePostsBySubmittedProfilesByConsultantId(String consultantId, String clientId)
	{
		return this.postDao.countInactivePostsBySubmittedProfilesByConsultantId(consultantId, clientId);
	}

}
