package com.unihyr.dao;

import java.util.List;

import com.unihyr.domain.Registration;

public interface RegistrationDao
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
	
	public List<Registration> getClientList(int first, int max);
	
	public List<Registration> getConsultantList(int first, int max);
	
	public List<Registration> getCoUsersByUserid(String userid);
	
	public List<Registration> getConsultantsByClientIndustry(String clientId);
	
	public List<Registration> getClientAndConsultantAdminList(int first, int max);

	Registration getRegistrationsByName(String userName);

	public void insertUserIndustryMap(int industryId, int registrationId);
}
