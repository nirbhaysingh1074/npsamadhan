package com.unihyr.dao;

import java.util.List;

import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.unihyr.domain.GlobalRating;
import com.unihyr.domain.Industry;

@Repository
public class GlobalRatingDaoImpl implements GlobalRatingDao {

	@Autowired
	SessionFactory sessionFactory;

	@Override
	public GlobalRating getGlobalRatingById(String id) {
		// TODO Auto-generated method stub
		return (GlobalRating) sessionFactory.getCurrentSession().get(GlobalRating.class, id);
	}

	@Override
	public long addGlobalRating(GlobalRating rating) {
		// TODO Auto-generated method stub
		try {
			sessionFactory.getCurrentSession().save(rating);
			return rating.getSn();
		} catch (Exception e) {
			e.printStackTrace();
			return 0;
		}
	}

	@Override
	public List<GlobalRating> getGlobalRatingList() {
		// TODO Auto-generated method stub
		return sessionFactory.getCurrentSession().createCriteria(GlobalRating.class).list();
	}

}
