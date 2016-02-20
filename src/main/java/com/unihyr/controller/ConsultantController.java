package com.unihyr.controller;

import java.io.File;
import java.io.IOException;
import java.security.Principal;
import java.util.Date;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;
import javax.validation.Valid;

import org.apache.commons.io.FilenameUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import com.unihyr.domain.CandidateProfile;
import com.unihyr.model.CandidateProfileModel;
import com.unihyr.model.PostModel;
import com.unihyr.service.ProfileService;
import com.unihyr.service.RegistrationService;

@Controller
public class ConsultantController
{
	@Autowired
	ProfileService profileService;
	@Autowired
	RegistrationService registrationService;

	@RequestMapping(value = "/uploadprofile", method = RequestMethod.GET)
	public String uploadprofile(ModelMap map)
	{
		System.out.println("Hello to all from uploadprofile");
		map.addAttribute("uploadProfileForm", new CandidateProfileModel());
		return "uploadprofile";
	}

	@RequestMapping(value = "/uploadprofile", method = RequestMethod.POST)
	public String consultant_uploadProfile(@ModelAttribute(value = "uploadProfileForm") @Valid CandidateProfileModel model, BindingResult result, ModelMap map, HttpServletRequest request, Principal principal)
	{
		if (result.hasErrors())
		{
			map.addAttribute("uploadProfileForm", new CandidateProfileModel());
			return "uploadprofile";
		} else
		{
			System.out.println("form submitted successfully");
			CandidateProfile profile = new CandidateProfile();
			profile.setName(model.getName());
			profile.setEmail(model.getEmail());
			profile.setContact(model.getContact());
			profile.setCurrentCTC(model.getCurrentCTC());
			profile.setExpectedCTC(model.getExpectedCTC());
			profile.setCurrentOrganization(model.getCurrentOrganization());
			profile.setNoticePeriod(model.getNoticePeriod());
			profile.setJdID(model.getJdID());
			profile.setCurrentRole(model.getCurrentRole());
			profile.setWillingToRelocate(model.getWillingToRelocate());
			profile.setResumePath(model.getResumePath());
			profile.setRegistration(registrationService.getRegistationByUserId("amar@silvereye.co"));
			Date date = new Date();
			java.sql.Date dt = new java.sql.Date(date.getTime());
			profile.setDate(dt);
			
			MultipartFile jdfile = model.getJdFile();
	        String jdfilename=jdfile.getOriginalFilename();
	        String jdnewfilename=null;
	        
	        MultipartFile resumefile = model.getResumeFile();
	        String resumefilename=resumefile.getOriginalFilename();
	        String resumeNewfilename=null;
	        
	        try
	        {
	        	if (!(jdfilename.equals("")) || !(resumefilename.equals("")))
	        	{
	        		if(!(jdfilename.equals("")))
	        		{
	        			jdnewfilename=jdfilename.replace(" ", "-");
	        			jdnewfilename = UUID.randomUUID().toString()+jdnewfilename;
	        			profile.setJdID(jdnewfilename);
	        			File img = new File (System.getProperty("catalina.base")+"/unihyr_uploads/profile/"+principal.getName()+"/"+jdnewfilename);
	        			if(!img.exists())
	        			{
	        				img.mkdirs();
	        			}
	        			jdfile.transferTo(img);			
	        			
	        		}
	        		if(!(resumefilename.equals("")))
	        		{
	        			resumeNewfilename=resumefilename.replace(" ", "-");
	        			resumeNewfilename = UUID.randomUUID().toString()+resumeNewfilename;
	        			profile.setResumePath(resumeNewfilename);
	        			File img = new File (System.getProperty("catalina.base")+"/unihyr_uploads/profile/"+principal.getName()+"/"+resumeNewfilename);
	        			if(!img.exists())
	        			{
	        				img.mkdirs();
	        			}
	        			resumefile.transferTo(img);			
	        		}
	        		
	        	}
	        }
		    catch (IOException ie)
			        {
				ie.printStackTrace();
			}
			
			
			
			profileService.uploadProfile(profile);
		}
		return "redirect:home";
	}

	@RequestMapping(value = "/cons_your_positions", method = RequestMethod.GET)
	public String cons_your_positions(ModelMap map)
	{
		System.out.println("Hello to all from uploadprofile");
		map.addAttribute("clientList", profileService.getDistinctClientListByConsultantId("amar@silvereye.co"));
		return "cons_your_positions";
	}

	@RequestMapping(value = "/profilelistbyconsidclientid", method = RequestMethod.GET)
	public String profilelistbyconsidclientid(ModelMap map, @RequestParam String clientId, @RequestParam String postId,
			@RequestParam String pageNo)
	{
		System.out.println("Hello to all from uploadprofile");
		if (clientId != null && clientId.equals("1") && postId != null && postId.equals("0"))
		{
			map.addAttribute("profileList",
					profileService.getProfileListByConsultantIdInRange("amar@silvereye.co", 0, 0));
		} else if (clientId != null && clientId.equals("1") && postId != null && (!postId.equals("0")))
		{
			map.addAttribute("profileList", profileService
					.getProfileListByConsultantIdAndPostIdInRange("amar@silvereye.co", postId, 0, 0));
		} else if (clientId != null && (!clientId.equals("1")) && postId != null && postId.equals("0"))
		{
			map.addAttribute("profileList", profileService
					.getProfileListByConsultantIdAndClientInRange("amar@silvereye.co", clientId, 0, 0));
		} else
		{
			map.addAttribute("profileList", profileService
					.getProfileListByConsultantIdAndClientAndPostIdInRange("amar@silvereye.co", clientId,postId, 0, 0));
		}
		return "profilelistbyconsidclientid";
	}

	@RequestMapping(value = "/cons_leftside_postlist", method = RequestMethod.GET)
	public String cons_leftside_postlist(ModelMap map, @RequestParam String clientId, @RequestParam String postId,
			@RequestParam Integer pageNo)
	{
		System.out.println("Hello to all from uploadprofile");
		if (clientId.equals("1"))
		{
			map.addAttribute("postList", profileService.getPostListByConsultantIdInRange("amar@silvereye.co", 0, 0));
		} else
		{
			map.addAttribute("postList",
					profileService.getPostListByConsultantIdAndClientInRange("amar@silvereye.co", clientId, 0, 0));
		}
		return "cons_leftside_postlist";
	}

	@RequestMapping(value = "/consnewposts", method = RequestMethod.GET)
	public String consnewposts(ModelMap map, HttpServletRequest request)
	{
		return "consnewposts";
	}

	@RequestMapping(value = "/consdashboard", method = RequestMethod.GET)
	public String consdashboard(ModelMap map)
	{
		return "consdashboard";
	}
}
