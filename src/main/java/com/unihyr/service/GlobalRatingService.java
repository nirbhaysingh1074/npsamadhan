package com.unihyr.service;

import java.util.List;

import com.unihyr.domain.GlobalRating;

public interface GlobalRatingService 
{
	public GlobalRating getGlobalRatingById(String id);
	
	public long addGlobalRating(GlobalRating rating);
	public List<GlobalRating> getGlobalRatingList();
}
