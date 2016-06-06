package com.unihyr.dao;

import java.util.HashMap;
import java.util.List;

import com.unihyr.domain.Industry;

public interface IndustryDao 
{
	public int addIndustry(Industry industry);
	
	public void updateIndustry(Industry industry);
	
	public Industry getIndustry(int id);
	
	public List<Industry> getIndustryList();
	
	public List<Industry> getIndustryList(int first, int max);

	public List<Industry> getIndustryByName(String industry);
}
