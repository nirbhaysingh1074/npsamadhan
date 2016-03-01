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
	
	public List<PostConsultant> getInterestedPostForConsultantByClient(String consultantId, String clientId)
	{
		return this.postConsultnatDao.getInterestedPostForConsultantByClient(consultantId, clientId);
	}
}
