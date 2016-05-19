package com.unihyr.service;

import java.util.HashMap;
import java.util.List;

import com.unihyr.domain.GlobalRating;

public interface GlobalRatingService
{
	public GlobalRating getGlobalRatingById(String id);

	public long addGlobalRating(GlobalRating rating);

	public List<GlobalRating> getGlobalRatingList();

	public List<GlobalRating> getGlobalRatingListByIndustryAndConsultant(int industryId,String consultantId, int ratingId);

	long updateGlobalRating(GlobalRating rating);

	List<GlobalRating> getGlobalRatingListByIndustryAndConsultantRange(int industryId, String consultantId, int first,int max);
}
