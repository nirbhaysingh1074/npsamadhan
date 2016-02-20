package com.unihyr.service;

import java.util.List;

import javax.transaction.Transactional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.unihyr.dao.GlobalRatingDao;
import com.unihyr.dao.ProfileDao;
import com.unihyr.domain.CandidateProfile;
import com.unihyr.domain.GlobalRating;

@Service
@Transactional
public class GlobalRatingServiceImpl implements GlobalRatingService {

	@Autowired GlobalRatingDao globalRatingDao;
	
	@Override
	public GlobalRating getGlobalRatingById(String id) {
		// TODO Auto-generated method stub
		return globalRatingDao.getGlobalRatingById(id);
	}

	@Override
	public long addGlobalRating(GlobalRating rating) {
		// TODO Auto-generated method stub
		return globalRatingDao.addGlobalRating(rating);
	}

	@Override
	public List<GlobalRating> getGlobalRatingList() {
		// TODO Auto-generated method stub
		return null;
	}

	
}
