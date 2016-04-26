package com.unihyr.service;

import org.springframework.transaction.annotation.Transactional;

import com.unihyr.dao.PostProfileDao;
import com.unihyr.domain.PostProfile;

import java.util.Date;
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
	public List<PostProfile> getPostProfileByPost(long postId, int first, int max,String sortParam,String filterBy)
	{
		return this.postProfileDao.getPostProfileByPost(postId, first, max,sortParam, filterBy);
	}
	
	@Override
	public long countPostProfileByPost(long postId,String filterBy)
	{
		return this.postProfileDao.countPostProfileByPost(postId,filterBy);
	}
	
	@Override
	public List<PostProfile> getPostProfileByClientAndConsultant(String clientId, String consultantId, int first, int max,String sortParam,String filterBy)
	{
		return this.postProfileDao.getPostProfileByClientAndConsultant(clientId, consultantId, first, max,sortParam,filterBy);
	}
	
	@Override
	public long countPostProfileByClientAndConsultant(String clientId, String consultantId,String sortParam)
	{
		return this.postProfileDao.countPostProfileByClientAndConsultant(clientId, consultantId,sortParam);
	}
	@Override
	public List<PostProfile> getPostProfileByClientPostAndConsultant(String clientId, String consultantId, long postId, int first, int max,String sortParam,String filterBy)
	{
		return this.postProfileDao.getPostProfileByClientPostAndConsultant(clientId, consultantId, postId, first, max,sortParam,filterBy);
	}
	
	@Override
	public long countPostProfileByClientPostAndConsultant(String clientId, String consultantId, long postId,String filterBy)
	{
		return this.postProfileDao.countPostProfileByClientPostAndConsultant(clientId, consultantId, postId, filterBy);
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

	@Override
	public List<PostProfile> getPostProfileByPost(long postId)
	{
		// TODO Auto-generated method stub
		return this.postProfileDao.getPostProfileByPost(postId);
	}

	@Override
	public List<PostProfile> getProfileListByConsultantIdAndPostIdInRangeAsc(String consultantId, long postId,
			int first, int max)
	{
		// TODO Auto-generated method stub
		return this.postProfileDao.getProfileListByConsultantIdAndPostIdInRangeAsc(consultantId,postId,first,max);
	}

	@Override
	public long countProfileListByConsultantIdAndPostId(String consultantId, long postId)
	{
		// TODO Auto-generated method stub
		return this.postProfileDao.countProfileListByConsultantIdAndPostId(consultantId, postId);
	}

	@Override
	public long countShortlistedProfileListByConsultantIdAndPostId(String consultantId, long postId)
	{
		// TODO Auto-generated method stub
		return this.postProfileDao.countShortlistedProfileListByConsultantIdAndPostId(consultantId, postId);
	}
	
	public List<PostProfile> getAllPostProfile(int first, int max)
	{
		return this.postProfileDao.getAllPostProfile(first, max);
	}

	@Override
	public long countRecruitedProfileListByConsultantIdAndPostId(String userid, long postId)
	{
		// TODO Auto-generated method stub
		return this.postProfileDao.countRecruitedProfileListByConsultantIdAndPostId(userid,postId);
	}
	
	public long countPostProfilesForPostByDate(long pid, String consid, Date date)
	{
		return this.postProfileDao.countPostProfilesForPostByDate(pid,consid, date);
	}
	
	public long countSubmittedProfileByClientOrConsultant(String client, String consultant)
	{
		return this.postProfileDao.countSubmittedProfileByClientOrConsultant(client, consultant);
	}
	
	public long countShortListedProfileByClientOrConsultant(String client, String consultant)
	{
		return this.postProfileDao.countShortListedProfileByClientOrConsultant(client, consultant);
	}
	
	public long countJoinedProfileByClientOrConsultant(String client, String consultant)
	{
		return this.postProfileDao.countJoinedProfileByClientOrConsultant(client, consultant);
	}
	
	public long countPartnerByClientOrConsultant(String client, String consultant)
	{
		return this.postProfileDao.countPartnerByClientOrConsultant(client, consultant);
	}
	
	
}
