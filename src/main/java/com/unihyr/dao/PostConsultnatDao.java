package com.unihyr.dao;

import java.util.List;

import com.unihyr.domain.Post;
import com.unihyr.domain.PostConsultant;

public interface PostConsultnatDao
{
	public List<PostConsultant> getInterestedPostForConsultantByClient(String consultantId, String clientId);
}
