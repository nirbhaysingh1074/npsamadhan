package com.unihyr.controller;

import java.io.File;
import java.io.IOException;
import java.security.Principal;
import java.util.Date;
import java.util.HashSet;
import java.util.Iterator;
import java.util.Set;
import java.util.UUID;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.validation.Valid;

import org.apache.commons.fileupload.servlet.ServletFileUpload;
import org.apache.commons.io.FilenameUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.unihyr.constraints.GeneralConfig;
import com.unihyr.domain.CandidateProfile;
import com.unihyr.domain.Post;
import com.unihyr.domain.PostConsultant;
import com.unihyr.domain.PostProfile;
import com.unihyr.domain.Registration;
import com.unihyr.model.CandidateProfileModel;
import com.unihyr.model.PostModel;
import com.unihyr.service.PostConsultnatService;
import com.unihyr.service.PostProfileService;
import com.unihyr.service.PostService;
import com.unihyr.service.ProfileService;
import com.unihyr.service.RegistrationService;

@Controller
public class ConsultantController
{
	@Autowired
	ProfileService profileService;
	@Autowired
	RegistrationService registrationService;
	@Autowired
	PostService postService;
	@Autowired
	PostProfileService postProfileService;
	@Autowired
	PostConsultnatService postConsultnatService;

	@RequestMapping(value = "/uploadprofile", method = RequestMethod.GET)
	public String uploadprofile(ModelMap map, HttpServletRequest request, @RequestParam long pid)
	{
		Post post = postService.getPost(pid);
		if(post != null)
		{
			map.addAttribute("post", post);
			System.out.println("Hello to all from uploadprofile");
			
			CandidateProfileModel model = new CandidateProfileModel();
			model.setPost(post);
			map.addAttribute("uploadProfileForm", model);
			return "uploadprofile";
		}
		return "redirect:consdashboard";
	}

	@RequestMapping(value = "/uploadprofile", method = RequestMethod.POST)
	public String consultant_uploadProfile(@ModelAttribute(value = "uploadProfileForm") @Valid CandidateProfileModel model, BindingResult result, ModelMap map, HttpServletRequest request, Principal principal)
	{
		if (result.hasErrors())
		{
			map.addAttribute("post", postService.getPost(model.getPost().getPostId()));
			return "uploadprofile";
		} 
		else
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
			profile.setRegistration(registrationService.getRegistationByUserId(principal.getName()));
			Date date = new Date();
			java.sql.Date dt = new java.sql.Date(date.getTime());
			profile.setDate(dt);
			
			profile.setPublished(dt);

			Post post = postService.getPost(model.getPost().getPostId());
			PostProfile pp = null;
			if(post != null)
			{
				pp = new PostProfile();
				pp.setSubmitted(dt);
				pp.setPost(post);
			}
			
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
			
			
			
			long prid = profileService.uploadProfile(profile);
			profile.setProfileId(prid);
			pp.setProfile(profile);
			postProfileService.addPostProfile(pp);
		}
		return "redirect:cons_your_positions";
	}

	@RequestMapping(value = "/cons_your_positions", method = RequestMethod.GET)
	public String cons_your_positions(ModelMap map, HttpServletRequest request,Principal principal)
	{
		String pid = request.getParameter("pid");
		System.out.println("pid : " + pid);
		System.out.println("Hello to all from uploadprofile");
		map.addAttribute("clientList", profileService.getDistinctClientListByConsultantId(principal.getName()));
		return "cons_your_positions";
	}

	@RequestMapping(value = "/profilelistbyconsidclientid", method = RequestMethod.GET)
	public String profilelistbyconsidclientid(ModelMap map, @RequestParam String clientId, @RequestParam String postId,
			@RequestParam String pageNo, Principal principal)
	{
		int pn=Integer.parseInt(pageNo);
		
		pn = (pn - 1) * GeneralConfig.rpp_cons;

		if(clientId != null && clientId.length() > 0  && postId != null && postId.length() > 0)
		{
			map.addAttribute("profileList", postProfileService.getPostProfileByClientPostAndConsultant(clientId, principal.getName(), Long.parseLong(postId), pn, GeneralConfig.rpp_cons));
			map.addAttribute("totalCount", postProfileService.countPostProfileByClientPostAndConsultant(clientId, principal.getName(), Long.parseLong(postId)));
			map.addAttribute("postSelected",postId);
		}
		else
		{
			map.addAttribute("totalCount", 0);
			map.addAttribute("postSelected",postId);
		}
		map.addAttribute("rpp", GeneralConfig.rpp_cons);
		map.addAttribute("pn", Integer.parseInt(pageNo));
		return "profilelistbyconsidclientid";
	}

	@RequestMapping(value = "/cons_leftside_postlist", method = RequestMethod.GET)
	public String cons_leftside_postlist(ModelMap map, @RequestParam String clientId, Principal principal)
	{
		if(clientId != null && clientId.trim().length() > 0 && !clientId.equals("1"))
		{
			map.addAttribute("postConsList", postConsultnatService.getInterestedPostForConsultantByClient(principal.getName(), clientId));
		}
		
		
		return "cons_leftside_postlist";
	}
	
	@RequestMapping(value = "/consnewposts", method = RequestMethod.GET)
	public String consnewposts(ModelMap map, HttpServletRequest request)
	{
		return "consnewposts";
	}
	@RequestMapping(value = "/consnewpostslist", method = RequestMethod.GET)
	public String consnewpostslist(ModelMap map, HttpServletRequest request ,Principal principal)
	{
		int rpp = GeneralConfig.rpp;
		int pn = Integer.parseInt(request.getParameter("pn"));
		map.addAttribute("postList", postService.getPostsByIndustryUsingConsultantId(principal.getName(), (pn - 1) * rpp, rpp));
		map.addAttribute("totalCount", postService.countPostsByIndustryUsingConsultantId(principal.getName()));
		map.addAttribute("rpp", rpp);
		map.addAttribute("pn", pn);
		return "consnewpostslist";
	}
	@RequestMapping(value = "/consdashboard", method = RequestMethod.GET)
	public String consdashboard(ModelMap map, Principal principal)
	{
		map.addAttribute("totalProfiles", profileService.countAllProfileListByConsultantIdInRange(principal.getName()));
		map.addAttribute("sendProfiles", postProfileService.countAllProfileListByConsultantIdInRange(principal.getName()));
		map.addAttribute("totalActive", profileService.countProfileListByConsultantIdInRange(principal.getName()));
		return "consdashboard";
	}
	@RequestMapping(value = "/consDashboardList", method = RequestMethod.GET)
	public String consDashboardList(ModelMap map, HttpServletRequest request ,Principal principal)
	{
		int rpp = GeneralConfig.rpp;
		int pn = Integer.parseInt(request.getParameter("pn"));
		String db_post_status = request.getParameter("db_post_status");
		if(db_post_status.equals("active"))
		{
			map.addAttribute("postList", postService.getPostsBySubmittedProfilesByConsultantId(principal.getName(), (pn - 1) * rpp, rpp));
			map.addAttribute("totalCount", postService.countPostsBySubmittedProfilesByConsultantId(principal.getName()));
		}
		else if(db_post_status.equals("inactive"))
		{
			map.addAttribute("postList", postService.getInactivePostsBySubmittedProfilesByConsultantId(principal.getName(), (pn - 1) * rpp, rpp));
			map.addAttribute("totalCount", postService.countInactivePostsBySubmittedProfilesByConsultantId(principal.getName()));
		}
		else 
		{
			map.addAttribute("postList", postService.getAllPostsBySubmittedProfilesByConsultantId(principal.getName(), (pn - 1) * rpp, rpp));
			map.addAttribute("totalCount", postService.countAllPostsBySubmittedProfilesByConsultantId(principal.getName()));
		}
		
		map.addAttribute("rpp", rpp);
		map.addAttribute("pn", pn);

		return "consDashboardList";
	}
	
	@RequestMapping(value = "/consultantaccount", method = RequestMethod.GET)
	public String consultantaccount(ModelMap map, HttpServletRequest request ,Principal principal)
	{
		map.addAttribute("status", request.getParameter("status"));
		return "consultantAccount";
	}
	
	
	@RequestMapping(value = "/consPostInterest", method = RequestMethod.GET)
	public @ResponseBody String clientPostInterest(ModelMap map, HttpServletRequest request, Principal principal, @RequestParam long pid)
	{
		System.out.println("pid : " + pid);
		Post post = postService.getPost(pid);
		if(post != null)
		{
			PostConsultant pc = new PostConsultant();
			
			Date date = new Date();
			java.sql.Date dt = new java.sql.Date(date.getTime());
			
			pc.setCreateDate(dt);
			pc.setPost(post);
			pc.setConsultant(registrationService.getRegistationByUserId(principal.getName()));
			post.getPostConsultants().add(pc);
			post.setPostConsultants(post.getPostConsultants());
			postService.updatePost(post);
			return "success";
		}
		return "failed";
	}
	
	
	
	
	
	
	
	private Set<String> allowedImageExtensions;
	@RequestMapping(value = "/consultant.uploadLogo", method = RequestMethod.POST)
    public @ResponseBody String ajaxFileUpload(MultipartHttpServletRequest request, HttpServletRequest req, Principal principal)throws ServletException
    {   
		
		this.allowedImageExtensions = new HashSet<String>();
		this.allowedImageExtensions.add("png");
		this.allowedImageExtensions.add("jpg");
		this.allowedImageExtensions.add("jpeg");
		this.allowedImageExtensions.add("gif");
		this.allowedImageExtensions.add("PNG");
		this.allowedImageExtensions.add("JPG");
		this.allowedImageExtensions.add("JPEG");
		this.allowedImageExtensions.add("GIF");
		
		MultipartFile mpf = null;
		int flag=0;
		Iterator<String> itr=request.getFileNames();
		while(itr.hasNext()){
		mpf=request.getFile(itr.next());
		flag++;
        boolean isMultipart=ServletFileUpload.isMultipartContent(request);
        System.out.println("is file " + isMultipart + " file name " + mpf.getOriginalFilename());
		}
		if(flag > 0 && mpf != null && mpf.getOriginalFilename() != null && mpf.getOriginalFilename() != "")
		{
			String filename=null;
			
			filename=mpf.getOriginalFilename().replace(" ", "-");
			String imageextension=FilenameUtils.getExtension(filename);
			try
			{
				if(!this.allowedImageExtensions.contains(imageextension)){
        			return "failed";
        		}
				
				File dl = new File(System.getProperty("catalina.base")+"/unihyr_uploads/"+principal.getName()+"/logo/"+filename);
				String datafile=System.getProperty("catalina.base")+"/unihyr_uploads/"+principal.getName()+"/logo/"+filename;
				System.out.println("PATH="+datafile);
				if(!dl.exists()){
					System.out.println("in not file"+dl.getAbsolutePath());
					dl.mkdirs();
				}
				filename= "/unihyr_uploads/"+principal.getName()+"/logo/"+filename;
				mpf.transferTo(dl);
				Registration registration = registrationService.getRegistationByUserId(principal.getName());
				registration.setLogo(filename);
				request.getSession().setAttribute("registration", registration);
				registrationService.update(registration);
			}
			catch(IOException e)
			{
				
			}
			return filename;
		}
		return "failed";
    }
	
}
