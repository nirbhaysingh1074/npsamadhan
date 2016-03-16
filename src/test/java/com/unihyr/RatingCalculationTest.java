package com.unihyr;

import static org.junit.Assert.assertEquals;

import java.util.Date;
import java.util.List;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import com.unihyr.domain.LocalRating;
import com.unihyr.domain.Post;
import com.unihyr.domain.RatingCalculation;
import com.unihyr.domain.RatingParameter;
import com.unihyr.service.RatingCalculationService;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations =
{ "/dispatcher-servlet.xml" })
public class RatingCalculationTest
{
@Autowired RatingCalculationService ratingCalculationService;

	
	@Test
	public void insertCalculation(){/*
		List<RatingParameter> ratingParams = ratingCalculationService.getRatingParameterList();
		if (ratingParams != null)
		{
			for (RatingParameter ratingParameter : ratingParams)
			{
				RatingCalculation lRating = new RatingCalculation();
				Date date = new Date();
				java.sql.Date dt = new java.sql.Date(date.getTime());
				lRating.setCandidateProfile(candidateProfile);
				lRating.setPost(post);
				lRating.setRatingParameter(ratingParameter);
				lRating.setRegistration(registration);
			}
		}
		assertEquals(true, true);
	*/}
}
