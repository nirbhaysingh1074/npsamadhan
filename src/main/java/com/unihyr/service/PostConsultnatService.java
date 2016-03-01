package com.unihyr.service;

import java.util.List;

import com.unihyr.domain.PostConsultant;

public interface PostConsultnatService
{
	public List<PostConsultant> getInterestedPostForConsultantByClient(String consultantId, String clientId);
}
