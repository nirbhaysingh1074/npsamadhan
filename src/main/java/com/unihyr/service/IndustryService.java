package com.unihyr.service;

import java.util.List;

import com.unihyr.domain.Industry;

public interface IndustryService 
{
	public int addIndustry(Industry industry);
	
	public void updateIndustry(Industry industry);
	
	public Industry getIndustry(int id);
	
	public List<Industry> getIndustryList();
	
	public List<Industry> getIndustryList(int first, int max);

}
