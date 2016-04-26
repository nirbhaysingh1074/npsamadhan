package com.unihyr.dao;

import java.util.List;

import com.unihyr.domain.Post;
import com.unihyr.domain.PostConsultant;

public interface PostConsultnatDao
{
	public List<PostConsultant> getInterestedPostForConsultantByClient(String consultantId, String clientId, String sortParam);


	public List<PostConsultant> getInterestedConsultantByPost(long postId);


	List<PostConsultant> getInterestedConsultantSortedByPost(long postId, String sortParam, String order);


	public void updatePostConsultant(PostConsultant postConsultant);


	public List<PostConsultant> getInterestedPostByConsIdandPostId(String consName, long postId, String ratingParam);
}
