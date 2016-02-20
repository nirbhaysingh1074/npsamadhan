package com.unihyr.service;

import java.util.List;

import com.unihyr.domain.LocalRating;

public interface LocalRatingService
{

	public LocalRating getLocalRatingById(String id);
	
	public int addLocalRating(LocalRating rating);
	public List<LocalRating> getGlobalRatingList();

}
