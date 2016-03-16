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
	
	public long countPosts();
	
	public List<Post> getPosts(int first, int max);
	
	public List<Post> getActivePostsByClient(String clientId);
	
	public List<Post> getActivePostsByClient(String clientId, int first, int max);
	
	public long countActivePostByClient(String clientId);
	
	public List<Post> getAllPostsByClient(String clientId, int first, int max);
	
	public long countAllPostByClient(String clientId);
	
	public List<Post> getPublishedPostsByClient(String clientId, int first, int max);
	
	public long countPublishedPostByClient(String clientId);
	
	public List<Post> getClosedPostsByClient(String clientId, int first, int max);
	
	public long countClosedPostByClient(String clientId);
	
	public List<Post> getSavedPostsByClient(String clientId, int first, int max);
	
	public long countSavedPostByClient(String clientId);
	
	public List<Post> getPostsByIndustryUsingConsultantId(String consultantId, int first, int max);

	public long countPostsByIndustryUsingConsultantId(String consultantId);

	public List<Post> getPostsByIndustryId(int industryId, int first, int max);

	public long countPostsByIndustryId(int industryId);

	public List<Post> getPostsBySubmittedProfilesByConsultantId(String consultantId, int first, int max);

	public long countPostsBySubmittedProfilesByConsultantId(String consultantId);

	public List<Post> getAllPostsBySubmittedProfilesByConsultantId(String consultantId, int first, int max);

	public long countAllPostsBySubmittedProfilesByConsultantId(String consultantId);

	public List<Post> getInactivePostsBySubmittedProfilesByConsultantId(String consultantId, int first, int max);

	public long countInactivePostsBySubmittedProfilesByConsultantId(String consultantId);

	public List<Post> getPostsBySubmittedProfilesByConsultantId(String consultantId, String clientId, int first, int max);

	public long countPostsBySubmittedProfilesByConsultantId(String consultantId, String clientId);

	public List<Post> getAllPostsBySubmittedProfilesByConsultantId(String consultantId, String clientId, int first, int max);

	public long countAllPostsBySubmittedProfilesByConsultantId(String consultantId, String clientId);

	public List<Post> getInactivePostsBySubmittedProfilesByConsultantId(String consultantId, String clientId, int first, int max);

	public long countInactivePostsBySubmittedProfilesByConsultantId(String consultantId, String clientId);

	
	
	
}
