package com.unihyr.service;

import org.springframework.transaction.annotation.Transactional;

import com.unihyr.dao.PostProfileDao;
import com.unihyr.domain.PostProfile;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
@Transactional
public class PostProfileServiceImpl implements PostProfileService
{
	@Autowired private PostProfileDao postProfileDao;
	@Override
	public long addPostProfile(PostProfile postProfile)
	{
		return this.postProfileDao.addPostProfile(postProfile);
	}
	
	@Override
	public boolean updatePostProfile(PostProfile postProfile)
	{
		return this.postProfileDao.updatePostProfile(postProfile);
	}
	
	@Override
	public PostProfile getPostProfile(long ppid)
	{
		return this.postProfileDao.getPostProfile(ppid);
	}
	
	@Override
	public PostProfile getPostProfile(long postid, long profileId)
	{
		return this.postProfileDao.getPostProfile(postid, profileId);
	}
	
	@Override
	public List<PostProfile> getPostProfileByClient(String clientId, int first, int max)
	{
		return this.postProfileDao.getPostProfileByClient(clientId, first, max);
	}
	
	@Override
	public long countPostProfileByClient(String clientId)
	{
		return this.postProfileDao.countPostProfileByClient(clientId);
	}
	
	@Override
	public List<PostProfile> getPostProfileByPost(long postId, int first, int max)
	{
		return this.postProfileDao.getPostProfileByPost(postId, first, max);
	}
	
	@Override
	public long countPostProfileByPost(long postId)
	{
		return this.postProfileDao.countPostProfileByPost(postId);
	}
	
	@Override
	public List<PostProfile> getPostProfileByClientAndConsultant(String clientId, String consultantId, int first, int max)
	{
		return this.postProfileDao.getPostProfileByClientAndConsultant(clientId, consultantId, first, max);
	}
	
	@Override
	public long countPostProfileByClientAndConsultant(String clientId, String consultantId)
	{
		return this.postProfileDao.countPostProfileByClientAndConsultant(clientId, consultantId);
	}
	@Override
	public List<PostProfile> getPostProfileByClientPostAndConsultant(String clientId, String consultantId, long postId, int first, int max)
	{
		return this.postProfileDao.getPostProfileByClientPostAndConsultant(clientId, consultantId, postId, first, max);
	}
	
	@Override
	public long countPostProfileByClientPostAndConsultant(String clientId, String consultantId, long postId)
	{
		return this.postProfileDao.countPostProfileByClientPostAndConsultant(clientId, consultantId, postId);
	}
	
	
	@Override
	public List<PostProfile> getProfileListByConsultantIdInRange(String consultantId, int first, int max)
	{
		return this.postProfileDao.getProfileListByConsultantIdInRange(consultantId, first, max);
	}

	@Override
	public List<PostProfile> getProfileListByConsultantIdAndPostIdInRange(String consultantId, long postId, int first, int max)
	{
		return this.postProfileDao.getProfileListByConsultantIdAndPostIdInRange(consultantId, postId, first, max);
	}

	@Override
	public long countProfileListByConsultantIdInRange(String consultantId)
	{
		return this.postProfileDao.countProfileListByConsultantIdInRange(consultantId);
	}

	@Override
	public long countProfileListByConsultantIdAndPostIdInRange(String consultantId, long postId)
	{
		return this.postProfileDao.countProfileListByConsultantIdAndPostIdInRange(consultantId, postId);
	}

	public long countAllProfileListByConsultantIdInRange(String consultantId)
	{
		return this.postProfileDao.countAllProfileListByConsultantIdInRange(consultantId);
	}
	
	@Override
	public boolean checkPostProfileAvailability(long postId, String email, String contact)
	{
		return this.postProfileDao.checkPostProfileAvailability(postId, email, contact);
	}
	
	public List<PostProfile> getAllPostProfile(int first, int max)
	{
		return this.postProfileDao.getAllPostProfile(first, max);
	}
}
