package com.unihyr.dao;

import java.util.List;

import com.unihyr.domain.GlobalRating;

public interface GlobalRatingDao {

	public GlobalRating getGlobalRatingById(String id);
	
	public long addGlobalRating(GlobalRating rating);
	public List<GlobalRating> getGlobalRatingList();
}
