package com.unihyr.service;

import java.util.List;

import com.unihyr.domain.Post;

public interface PostService
{
	public long addPost(Post post);
	
	public void updatePost(Post post);
	
	public Post getPost(long postId);
	
	public List<Post> getPosts();
	
	public long countPosts();
	
	public List<Post> getPosts(int first, int max);
	
	public List<Post> getActivePostsByClient(String userid);
	
	public List<Post> getActivePostsByClient(String userid, int first, int max);
	
	public long countActivePostByClient(String userid);

	
	public List<Post> getAllPostsByClient(String userid, int first, int max);
	
	public long countAllPostByClient(String userid);
	
	public List<Post> getPublishedPostsByClient(String userid, int first, int max);
	
	public long countPublishedPostByClient(String userid);

	public List<Post> getClosedPostsByClient(String userid, int first, int max);
	
	public long countClosedPostByClient(String userid);

	public List<Post> getSavedPostsByClient(String clientId, int first, int max);
	
	public long countSavedPostByClient(String clientId);
	
	public List<Post> getPostsByIndustryUsingConsultantId(String consultantId, int first, int max);

	public long countPostsByIndustryUsingConsultantId(String name);
	
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
