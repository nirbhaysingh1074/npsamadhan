package com.unihyr.dao;

import java.util.HashMap;
import java.util.List;

import com.unihyr.domain.GlobalRatingPercentile;

public interface GlobalRatingPercentileDao {

	public GlobalRatingPercentile getGlobalRatingById(String id);
	
	public long addGlobalRating(GlobalRatingPercentile rating);
	public List<GlobalRatingPercentile> getGlobalRatingList();

	public  List<GlobalRatingPercentile>  getGlobalRatingListByIndustryAndConsultant(int industryId,String consultantId);

	long updateGlobalRating(GlobalRatingPercentile rating);

	public List<GlobalRatingPercentile> getGlobalRatingListByIndustryAndConsultantRange(int industryId, String consultantId,
			int first,int max);

	List<String> getGlobalRatingListByIndustry(int industryId);
}
