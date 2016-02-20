package com.unihyr.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.unihyr.dao.IndustryDao;
import com.unihyr.domain.Industry;

@Service
@Transactional
public class IndustryServiceImpl implements IndustryService
{
	@Autowired private IndustryDao industryDao; 
	
	
	@Override
	public int addIndustry(Industry industry) 
	{
		return this.industryDao.addIndustry(industry);
	}

	@Override
	public void updateIndustry(Industry industry) 
	{
		this.industryDao.updateIndustry(industry);
	}

	@Override
	public Industry getIndustry(int id) 
	{
		return this.industryDao.getIndustry(id);
	}

	@Override
	public List<Industry> getIndustryList() 
	{
		return this.industryDao.getIndustryList();
	}

	@Override
	public List<Industry> getIndustryList(int first, int max) 
	{
		return this.industryDao.getIndustryList(first, max);
	}
	
}
