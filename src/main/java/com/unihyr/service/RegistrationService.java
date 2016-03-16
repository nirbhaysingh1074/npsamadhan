package com.unihyr.service;

import java.util.List;
import java.util.UUID;

import com.unihyr.domain.Registration;

public interface RegistrationService 
{
	public Registration getRegistationByUserId(String userid);
	
	public int countUsers();
	
	public List<Registration> getRegistrations(int first, int max);
	
	public void update(Registration registration);

	public List<Registration> getConsultantsByClient(String clientId);
	
	public List<Registration> getConsultantsByPost(long postId);
	
	public List<Registration> getClientsByIndustyForConsultant(String consultantId);
	
	public long countConsultantList();
	
	public long countClientsList();
	
}
