package com.unihyr.dao;

import java.util.List;

import javax.persistence.Entity;
import javax.persistence.Table;

import com.unihyr.domain.Post;


public interface PostDao 
{
	public long addPost(Post post);
	
	public void updatePost(Post post);
	
	public Post getPost(long postId);
	
	public List<Post> getPosts();
	
	public List<Post> getPosts(int first, int max);
	
	public List<Post> getPostsByClient(String userid);
	
	public List<Post> getPostsByClient(String userid, int first, int max);
	
	public long countPostByClient(String userid);
	
	public List<Post> getAllPostsByClient(String userid, int first, int max);
	
	public long countAllPostByClient(String userid);
	
	public List<Post> getAllInactivePostsByClient(String userid, int first, int max);
	
	public long countAllInactivePostByClient(String userid);
	
	public List<Post> getDeletedPostsByClient(String userid, int first, int max);
	
	public long countDeletedPostByClient(String userid);
	
	public List<Post> getPostsByIndustryUsingConsultantId(String consultantId, int first, int max);

	public long countPostsByIndustryUsingConsultantId(String name);

	public List<Post> getPostsBySubmittedProfilesByConsultantId(String consultantId, int first, int max);

	public long countPostsBySubmittedProfilesByConsultantId(String consultantId);

	public List<Post> getAllPostsBySubmittedProfilesByConsultantId(String consultantId, int first, int max);

	public long countAllPostsBySubmittedProfilesByConsultantId(String consultantId);

	public List<Post> getInactivePostsBySubmittedProfilesByConsultantId(String consultantId, int first, int max);

	public long countInactivePostsBySubmittedProfilesByConsultantId(String consultantId);

	
	
	
	
}
