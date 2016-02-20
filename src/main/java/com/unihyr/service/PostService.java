package com.unihyr.service;

import java.util.List;

import com.unihyr.domain.Post;

public interface PostService
{
	public long addPost(Post post);
	
	public void updatePost(Post post);
	
	public Post getPost(long postId);
	
	public List<Post> getPosts();
	
	public List<Post> getPosts(int first, int max);
	
	public List<Post> getPostsByClient(String userid);
	
	public List<Post> getPostsByClient(String userid, int first, int max);
	
	public long countPostByClient(String userid);

}
