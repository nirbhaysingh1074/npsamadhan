package com.unihyr.service;

import java.util.List;
import java.util.UUID;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.unihyr.dao.RegistrationDao;
import com.unihyr.domain.Registration;

@Service
@Transactional
public class RegistrationServiceImpl implements RegistrationService
{
	
	
	
	@Autowired private RegistrationDao registrationDao;
	
	@Override
	public Registration getRegistationByUserId(String userid)
	{
		return registrationDao.getRegistationByUserId(userid);
	}
	
	@Override
	public void update(Registration registration)
	{
		registrationDao.update(registration);
	}
	
	
	
	@Override
	public int countUsers()
	{
		return registrationDao.countUsers();
	}

	@Override
	public List<Registration> getRegistrations(int first, int max)
	{
		return registrationDao.getRegistrations(first, max);
	}
	
	@Override
	public List<Registration> getConsultantsByClient(String clientId)
	{
		return this.registrationDao.getConsultantsByClient(clientId);
	}
	
	@Override
	public List<Registration> getConsultantsByPost(long postId)
	{
		return this.registrationDao.getConsultantsByPost(postId);
	}
}
