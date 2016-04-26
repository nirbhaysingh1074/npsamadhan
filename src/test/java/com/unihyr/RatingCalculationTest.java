package com.unihyr;

import static org.junit.Assert.assertEquals;

import java.util.Date;
import java.util.Iterator;
import java.util.List;
import java.util.Set;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.unihyr.dao.RatingParameterDao;
import com.unihyr.domain.GlobalRating;
import com.unihyr.domain.Industry;
import com.unihyr.domain.LocalRating;
import com.unihyr.domain.Post;
import com.unihyr.domain.PostConsultant;
import com.unihyr.domain.PostProfile;
import com.unihyr.domain.RatingCalculation;
import com.unihyr.domain.RatingParameter;
import com.unihyr.domain.Registration;
import com.unihyr.service.GlobalRatingService;
import com.unihyr.service.PostConsultnatService;
import com.unihyr.service.PostProfileService;
import com.unihyr.service.PostService;
import com.unihyr.service.RatingCalculationService;
import com.unihyr.service.RatingParameterService;
import com.unihyr.service.RegistrationService;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations =
{ "/dispatcher-servlet.xml" })
public class RatingCalculationTest
{
	@Autowired
	RatingCalculationService ratingCalculationService;
	@Autowired
	GlobalRatingService globalRatingService;
	@Autowired
	PostProfileService postProfileService;
	@Autowired
	PostConsultnatService postConsultantService;
	@Autowired
	RatingParameterService ratingParameterService;
	@Autowired
	RegistrationService registrationService;

	public static void addGlobalRating(long value){
		
	}
	
	
	@Test
	public void afterClosePost()
	{
		List<PostConsultant> postConsultants = postConsultantService.getInterestedConsultantByPost(2);
		List<RatingParameter> ratingParams = ratingParameterService.getRatingParameterList();
		Registration consultant = null;
		Post post = null;
		int counter = 0;
		long trTime = 0;
		long srRatio = 0;
		long crRatio = 0;
		for (PostConsultant postConsultatnt : postConsultants)
		{
			consultant = postConsultatnt.getConsultant();
			post = postConsultatnt.getPost();
			Set<Industry> industry = registrationService.getRegistationByUserId(post.getClient().getUserid())
					.getIndustries();
			Iterator<Industry> inIterator = industry.iterator();
			Industry in = null;
			while (inIterator.hasNext())
			{
				in = (Industry) inIterator.next();
			}
			List<GlobalRating> gList = globalRatingService.getGlobalRatingListByIndustryAndConsultantRange(in.getId(),
					consultant.getUserid(), 0, 10);
			counter = 0;
			trTime = 0;
			srRatio = 0;
			crRatio = 0;
			for (GlobalRating globalRating : gList)
			{
				RatingParameter param = globalRating.getRatingParameter();
				switch (param.getName())
				{
				case "turnaroundtime":
				{
					trTime += globalRating.getRatingParamValue();
					counter++;
					break;
				}
				case "shortlistRatio":
				{
					srRatio += globalRating.getRatingParamValue();
					break;
				}
				case "closureRate":
				{
					crRatio += globalRating.getRatingParamValue();
					break;
				}
				default:
					break;
				}
			}

			long publishtime = post.getCreateDate().getTime();
			long turnaround = 0;
			long totalSubmitted = postProfileService.countProfileListByConsultantIdAndPostId(consultant.getUserid(),
					post.getPostId());
			for (RatingParameter ratingParameter : ratingParams)
			{
				switch (ratingParameter.getName())
				{
				case "turnaroundtime":
				{
					int count = 0;
					List<PostProfile> postProfilesList = postProfileService
							.getProfileListByConsultantIdAndPostIdInRangeAsc(consultant.getUserid(), post.getPostId(),
									0, 3);
					for (PostProfile postProfile2 : postProfilesList)
					{
						long profileTime = postProfile2.getProfile().getDate().getTime();
						turnaround += profileTime - publishtime;
						publishtime = profileTime;
						System.out.println(turnaround);
						count++;
					}
					GlobalRating newGlobalRating = new GlobalRating();
					Date date = new Date();
					java.sql.Date dt = new java.sql.Date(date.getTime());
					newGlobalRating.setCreateDate(dt);
					newGlobalRating.setIndustryId(in.getId());
					newGlobalRating.setRatingParameter(ratingParameter);

					if(totalSubmitted==0){
						trTime = ( trTime) / (counter );
					}else{
					trTime = (turnaround / count + trTime) / (counter + 1);
					}newGlobalRating.setRatingParamValue(trTime);
					newGlobalRating.setRegistration(consultant);
					globalRatingService.addGlobalRating(newGlobalRating);
					break;
				}
				case "shortlistRatio":
				{
					long totalShortlisted = postProfileService.countShortlistedProfileListByConsultantIdAndPostId(
							consultant.getUserid(), post.getPostId());
					GlobalRating newGlobalRating = new GlobalRating();
					Date date = new Date();
					java.sql.Date dt = new java.sql.Date(date.getTime());
					newGlobalRating.setCreateDate(dt);
					while (inIterator.hasNext())
					{
						in = (Industry) inIterator.next();
					}
					newGlobalRating.setIndustryId(in.getId());
					newGlobalRating.setRatingParameter(ratingParameter);
					if(totalSubmitted==0){
						srRatio = (srRatio) / (counter);
					}else{
					srRatio = ((totalShortlisted * 100 / totalSubmitted) + srRatio) / (counter + 1);
					}
					newGlobalRating.setRatingParamValue(srRatio);
					newGlobalRating.setRegistration(consultant);
					globalRatingService.addGlobalRating(newGlobalRating);
					break;
				}
				case "closureRate":
				{

					GlobalRating newGlobalRating = new GlobalRating();
					Date date = new Date();
					java.sql.Date dt = new java.sql.Date(date.getTime());
					newGlobalRating.setCreateDate(dt);
					while (inIterator.hasNext())
					{
						in = (Industry) inIterator.next();
					}
					newGlobalRating.setIndustryId(in.getId());
					newGlobalRating.setRatingParameter(ratingParameter);
					if(totalSubmitted==0){
						crRatio = (crRatio) / (counter);
					}else{
					crRatio = ((1 * 100 / totalSubmitted) + crRatio) / (counter + 1);
					}
					newGlobalRating.setRatingParamValue(crRatio);
					newGlobalRating.setRegistration(consultant);
					globalRatingService.addGlobalRating(newGlobalRating);
					break;
				}
				default:
					break;
				}
			}
			
		}
	}
}
