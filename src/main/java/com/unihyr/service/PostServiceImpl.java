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
}
