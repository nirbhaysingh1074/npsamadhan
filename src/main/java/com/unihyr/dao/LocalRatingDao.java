package com.unihyr.dao;

import java.util.List;

import com.unihyr.domain.LocalRating;

public interface LocalRatingDao {

	public LocalRating getLocalRatingById(String id);
	
	public int addLocalRating(LocalRating rating);
	public List<LocalRating> getLocalRatingList();
}
