package com.unihyr.service;

import java.util.List;

import javax.transaction.Transactional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.unihyr.dao.PostConsultnatDao;
import com.unihyr.domain.PostConsultant;

@Service
@Transactional
public class PostConsultnatServiceImpl implements PostConsultnatService
{
	@Autowired private PostConsultnatDao postConsultnatDao;
	
	public List<PostConsultant> getInterestedPostForConsultantByClient(String consultantId, String clientId,String sortParam)
	{
		return this.postConsultnatDao.getInterestedPostForConsultantByClient(consultantId, clientId,sortParam);
	}

	@Override
	public List<PostConsultant> getInterestedConsultantByPost(long postId)
	{
		// TODO Auto-generated method stub
		return this.postConsultnatDao.getInterestedConsultantByPost(postId);
		}
	@Override
	public List<PostConsultant> getInterestedConsultantSortedByPost(long postId, String sortParam, String order)
	{
		// TODO Auto-generated method stub
		return this.postConsultnatDao.getInterestedConsultantSortedByPost(postId,sortParam,order);
		}

	@Override
	public void updatePostConsultant(PostConsultant postConsultant)
	{
		// TODO Auto-generated method stub
		this.postConsultnatDao.updatePostConsultant(postConsultant);
	}

	@Override
	public List<PostConsultant> getInterestedPostByConsIdandPostId(String consName, long postId, String ratingParam)
	{
		// TODO Auto-generated method stub
		return this.postConsultnatDao.getInterestedPostByConsIdandPostId(consName, postId, ratingParam);
	}
}
