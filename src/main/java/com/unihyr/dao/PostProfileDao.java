package com.unihyr.dao;

import java.util.List;

import com.unihyr.domain.CandidateProfile;
import com.unihyr.domain.Post;
import com.unihyr.domain.PostProfile;

public interface PostProfileDao
{
	public long addPostProfile(PostProfile postProfile);
	
	public boolean updatePostProfile(PostProfile postProfile);
	
	public PostProfile getPostProfile(long ppid);
	
	public PostProfile getPostProfile(long postid, long profileId);
	
	public List<PostProfile> getPostProfileByClient(String clientId, int first, int max);
	
	public long countPostProfileByClient(String clientId);
	
	public List<PostProfile> getPostProfileByPost(long postId, int first, int max);
	
	public long countPostProfileByPost(long postId);
	
	public List<PostProfile> getPostProfileByClientAndConsultant(String clientId, String consultantId, int first, int max);
	
	public long countPostProfileByClientAndConsultant(String clientId, String consultantId);
	
	public List<PostProfile> getPostProfileByClientPostAndConsultant(String clientId, String consultantId, long postId, int first, int max);
	
	public long countPostProfileByClientPostAndConsultant(String clientId, String consultantId, long postId);
	

	
	
	
	public List<PostProfile> getProfileListByConsultantIdInRange(String consultantId, int first, int max);

	public List<PostProfile> getProfileListByConsultantIdAndPostIdInRange(String consultantId, long postId, int first, int max);

	public long countProfileListByConsultantIdInRange(String consultantId);

	public long countProfileListByConsultantIdAndPostIdInRange(String consultantId, long postId);
	
	public long countAllProfileListByConsultantIdInRange(String consultantId);
	
	public boolean checkPostProfileAvailability(long postId, String email, String contact);
	
	
	public List<PostProfile> getAllPostProfile(int first, int max);
}
