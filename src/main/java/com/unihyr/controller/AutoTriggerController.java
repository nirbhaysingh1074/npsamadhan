package com.unihyr.controller;

import java.util.Date;
import java.util.Iterator;
import java.util.List;
import java.util.Timer;
import java.util.concurrent.TimeUnit;

import javax.annotation.PostConstruct;

import org.apache.commons.lang.time.DateUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.ApplicationContext;
import org.springframework.stereotype.Component;

import com.unihyr.constraints.GeneralConfig;
import com.unihyr.domain.ConfigVariables;
import com.unihyr.domain.Post;
import com.unihyr.domain.PostProfile;
import com.unihyr.service.ConfigVariablesService;
import com.unihyr.service.MailService;
import com.unihyr.service.PostProfileService;
import com.unihyr.service.PostService;
import com.unihyr.util.ApplicationContextProvider;

/**
 * @author silvereye
 * A controller to check whether any post is idle for particular days and perform action if idle.
 */
@Component
public class AutoTriggerController
{

	@Autowired 
	private PostProfileService postProfileService;
	@Autowired 
	private PostService postService;
	@Autowired 
	private MailService mailService;
	

	/**
	 * method to check that if any post is idle or not 
	 * @return true if post is idle, false if post is active
	 */
	public boolean checkPostIdle()
	{
		List<Post> list = postService.getAllActivePosts();
		for (Post post : list)
		{
			List<PostProfile> profileList = postProfileService.getPostProfileByPostForStartup(post.getPostId(), 0, 1, "submitted",
					"submitted", "rejected", "desc");
			Date today = new Date();
			Date submitted = null;
			if (profileList.isEmpty())
				submitted = post.getVerifyDate();
			else
				submitted = profileList.get(0).getSubmitted();
			long diff = today.getTime() - submitted.getTime();
			if (diff > GeneralConfig.PostDaysOut)
			{
				mailService.sendMail(post.getClient().getUserid(), "Reminder on post",
						"Your post is idle for more than " + GeneralConfig.PostDaysOut);
				System.out.println("Days: " + TimeUnit.DAYS.convert(diff, TimeUnit.MILLISECONDS));
			}
		}
		return false;
	}
}
