package com.unihyr.service;

import java.util.List;

import com.unihyr.domain.PostConsultant;

public interface PostConsultnatService
{
	public List<PostConsultant> getInterestedPostForConsultantByClient(String consultantId, String clientId, String string);
	public List<PostConsultant> getInterestedConsultantByPost(long postId);
	List<PostConsultant> getInterestedConsultantSortedByPost(long postId, String sortParam, String order);
	public void updatePostConsultant(PostConsultant postConsultant);
	public List<PostConsultant> getInterestedPostByConsIdandPostId(String consName, long postId, String string);
}
