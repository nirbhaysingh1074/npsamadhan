package com.unihyr.dao;

import java.util.HashMap;
import java.util.List;

import com.unihyr.domain.GlobalRating;

public interface GlobalRatingDao {

	public GlobalRating getGlobalRatingById(String id);
	
	public long addGlobalRating(GlobalRating rating);
	public List<GlobalRating> getGlobalRatingList();

	public  List<GlobalRating>  getGlobalRatingListByIndustryAndConsultant(int industryId,int consultantId);

	long updateGlobalRating(GlobalRating rating);

	public List<GlobalRating> getGlobalRatingListByIndustryAndConsultantRange(int industryId, int consultantId,
			int first,int max);
}
