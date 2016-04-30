package com.unihyr.controller;

import java.io.File;
import java.io.IOException;
import java.security.Principal;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Collection;
import java.util.Date;
import java.util.HashMap;
import java.util.HashSet;
import java.util.Iterator;
import java.util.LinkedList;
import java.util.List;
import java.util.ListIterator;
import java.util.Set;
import java.util.TreeMap;
import java.util.UUID;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.validation.Valid;

import org.apache.commons.fileupload.servlet.ServletFileUpload;
import org.apache.commons.io.FilenameUtils;
import org.hibernate.criterion.Restrictions;
import org.hsqldb.lib.StringUtil;
import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.util.StringUtils;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.unihyr.constraints.DateFormats;
import com.unihyr.constraints.GeneralConfig;
import com.unihyr.constraints.Roles;
import com.unihyr.domain.BillingDetails;
import com.unihyr.domain.CandidateProfile;
import com.unihyr.domain.GlobalRating;
import com.unihyr.domain.Industry;
import com.unihyr.domain.Inbox;
import com.unihyr.domain.Post;
import com.unihyr.domain.PostConsultant;
import com.unihyr.domain.PostProfile;
import com.unihyr.domain.RatingParameter;
import com.unihyr.domain.Registration;
import com.unihyr.model.CandidateProfileModel;
import com.unihyr.model.PostModel;
import com.unihyr.service.BillingService;
import com.unihyr.service.GlobalRatingService;
import com.unihyr.service.InboxService;
import com.unihyr.service.IndustryService;
import com.unihyr.service.MailService;
import com.unihyr.service.PostConsultnatService;
import com.unihyr.service.PostProfileService;
import com.unihyr.service.PostService;
import com.unihyr.service.ProfileService;
import com.unihyr.service.RatingParameterService;
import com.unihyr.service.RegistrationService;
/**
 * Controls all the request of UniHyr Consultant which includes add/edit post, manage 
 * postions and perform actions on submitted profiles for particular post
 * actions like shortlist/offer/offer accept/reject
 * @author Rohit Tiwari
 */
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
	@Autowired
	IndustryService industryService;
	@Autowired
	GlobalRatingService globalRatingService;
	@Autowired
	RatingParameterService ratingParamService;

	@Autowired
	InboxService inboxService;
	@Autowired
	private BillingService billingService;

	@Autowired
	private PostConsultnatService postConsultantService;
	@Autowired
	private RatingParameterService ratingParameterService;
	@Autowired
	private MailService mailService;

	@RequestMapping(value = "/uploadprofile", method = RequestMethod.GET)
	public String uploadprofile(ModelMap map, HttpServletRequest request,Principal principal , @RequestParam long pid)
	{
		Post post = postService.getPost(pid);
		
		Calendar cal = Calendar.getInstance();
		cal.add(Calendar.WEEK_OF_MONTH, -1);
		SimpleDateFormat df = new SimpleDateFormat("MM-dd-yyyy");
		try
		{
			
			Date rowDate = df.parse(df.format(cal.getTime()));
			long quata =  postProfileService.countPostProfilesForPostByDate(post.getPostId(), principal.getName(), rowDate);
			if(post != null && post.isActive() )
			{
				if(post.getProfileParDay() == 0 || post.getProfileParDay() > quata)
				{
					map.addAttribute("quataExceed", false);
				}
				else
				{
					map.addAttribute("quataExceed", true);
				}
				map.addAttribute("post", post);
				System.out.println("Hello to all from uploadprofile");
				
				CandidateProfileModel model = new CandidateProfileModel();
				model.setPost(post);
				map.addAttribute("uploadProfileForm", model);
				return "uploadprofile";
			}
		} 
		catch (ParseException e)
		{
			// TODO Auto-generated catch block
			e.printStackTrace();
		} 
		return "redirect:consdashboard";
	}

	@RequestMapping(value = "/uploadprofile", method = RequestMethod.POST)
	public String consultant_uploadProfile(@ModelAttribute(value = "uploadProfileForm") @Valid CandidateProfileModel model, BindingResult result, ModelMap map, HttpServletRequest request, Principal principal)
	{
		boolean email_st = postProfileService.checkPostProfileAvailability(model.getPost().getPostId(), model.getEmail(), null);
		boolean contact_st = postProfileService.checkPostProfileAvailability(model.getPost().getPostId(), null, model.getContact());
		
		MultipartFile resumefile = model.getResumeFile();
        String resumefilename=resumefile.getOriginalFilename();
        String resumeNewfilename=null;
        
		boolean valid = true;
		List<String> uploadMsg = new ArrayList<>();
		
		Post post = postService.getPost(model.getPost().getPostId());
		SimpleDateFormat df = new SimpleDateFormat("MM-dd-yyyy");
		try
		{
			
			Date rowDate = df.parse(df.format(new Date()));
			long quata =  postProfileService.countPostProfilesForPostByDate(post.getPostId(), principal.getName(), rowDate);
			
			if(post.getProfileParDay() == 0 || post.getProfileParDay() > quata)
			{
				map.addAttribute("quataExceed", false);
			}
			else
			{
				map.addAttribute("quataExceed", true);
				map.addAttribute("post", post);
				return "uploadprofile";
			}
		}
		catch(Exception e)
		{
			e.printStackTrace();
		}
		if(!(resumefilename.equals("")))
		{
			String extension=FilenameUtils.getExtension(resumefilename);
			System.out.println("file extenson="+extension);
			if (!GeneralConfig.filetype.contains(extension))
			{
				System.out.println("inside file extension check");
				map.addAttribute("fileuploaderror","true");
				uploadMsg.add("File type must be Doc, Docx or PDF. ");
				valid = false;
			}
			if (resumefile.getSize()>GeneralConfig.filesize)
			{
				map.addAttribute("fileuploaderror","true");
				uploadMsg.add("File size must not be greater than 1 Mb.");
				valid = false;
			}        			
			
		}
		
		
		if (result.hasErrors() || email_st || contact_st || !valid)
		{
			if(email_st)
			{
				map.addAttribute("profileExist_email", "Profile with this email alreadt uploaded for this post !");
			}
			if(contact_st)
			{
				map.addAttribute("profileExist_contact", "Profile with this contact already uploaded for this post !");
			}
			
			map.addAttribute("post", post);
			map.addAttribute("uploadMsg", uploadMsg);
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
			profile.setCurrentRole(model.getCurrentRole());
			profile.setScreeningNote(model.getScreeningNote());
			profile.setWillingToRelocate(model.getWillingToRelocate());
			profile.setResumeText(model.getResumeText());
			profile.setResumePath(model.getResumePath());
			profile.setCtcComments(model.getCtcComments());
			profile.setCurrentLocation(model.getCurrentLocation());
			profile.setRegistration(registrationService.getRegistationByUserId(principal.getName()));
			Date date = new Date();
			java.sql.Date dt = new java.sql.Date(date.getTime());
			profile.setDate(dt);
			profile.setPublished(dt);

			
			PostProfile pp = null;
			if(post != null)
			{
				pp = new PostProfile();
				pp.setSubmitted(dt);
				pp.setPost(post);
			}
			else
			{
				return "redirect:consdashboard";
			}
			
			
	        
	        
	        try
	        {
        		if(!(resumefilename.equals("")))
        		{
        			resumeNewfilename=resumefilename.replace(" ", "-");
        			
        			
        			
        			
        			resumeNewfilename = UUID.randomUUID().toString()+resumeNewfilename;
        			profile.setResumePath(resumeNewfilename);
        			File img = new File (GeneralConfig.UploadPath+resumeNewfilename);
        			if(!img.exists())
        			{
        				img.mkdirs();
        			}
        			resumefile.transferTo(img);			
        		}
        		
        		long prid = profileService.uploadProfile(profile);
        		
        		profile.setProfileId(prid);
        		pp.setProfile(profile);
        		long ppid = postProfileService.addPostProfile(pp);
        		map.addAttribute("upload_success", true);
        		return "redirect:consapplicantinfo?ppid="+ppid;
        		
	        }
		    catch (IOException ie)
			        {
				ie.printStackTrace();
			}
			
			
		}
		return "redirect:cons_your_positions";
	}

	@RequestMapping(value = "/cons_your_positions", method = RequestMethod.GET)
	public String cons_your_positions(ModelMap map, HttpServletRequest request,Principal principal)
	{
		Registration cons = registrationService.getRegistationByUserId(principal.getName());
		if(cons.getAdmin() != null)
		{
			cons = cons.getAdmin();
		}

		map.addAttribute("totalActive", postService.countPostsFilteredForConsultant(cons.getUserid(), null,null, null));
		map.addAttribute("totalprofiles", postProfileService.countSubmittedProfileByClientOrConsultant(null, cons.getUserid()));
		map.addAttribute("totalshortlist", postProfileService.countShortListedProfileByClientOrConsultant(null, cons.getUserid()));
		map.addAttribute("totaljoin", postProfileService.countJoinedProfileByClientOrConsultant(null, cons.getUserid()));
		map.addAttribute("totalpartner", postProfileService.countPartnerByClientOrConsultant(null, cons.getUserid()));

		String pid = request.getParameter("pid");
		System.out.println("pid : " + pid);
		if(pid != null && pid.length() > 0)
		{
			Post post = postService.getPost(Long.parseLong(pid));
			if(post != null)
			{
				Registration client = post.getClient();
				if(post.getClient().getAdmin() != null)
				{
					client = post.getClient().getAdmin();
				}
				map.addAttribute("postConsList", postConsultnatService.getInterestedPostForConsultantByClient(cons.getUserid(), client.getUserid(),"percentile"));
				
				map.addAttribute("selClient", client);
				
				map.addAttribute("profileList", postProfileService.getPostProfileByClientPostAndConsultant(client.getUserid(), cons.getUserid(), post.getPostId(), 0, GeneralConfig.rpp_cons,"submitted","submitted"));
				map.addAttribute("totalCount", postProfileService.countPostProfileByClientPostAndConsultant(client.getUserid(), cons.getUserid(), post.getPostId(),"submitted"));
				map.addAttribute("postSelected",post.getPostId());
				map.addAttribute("rpp", GeneralConfig.rpp_cons);
				map.addAttribute("pn", 1);
			}
		}
		System.out.println("Hello to all from uploadprofile");
		map.addAttribute("clientList", registrationService.getClientsByIndustyForConsultant(cons.getUserid()));
		

		
		return "cons_your_positions";
	}

	@RequestMapping(value = "/profilelistbyconsidclientid", method = RequestMethod.GET)
	public String profilelistbyconsidclientid(ModelMap map, @RequestParam String clientId, @RequestParam String postId,
			@RequestParam String pageNo, Principal principal,HttpServletRequest request)
	{
		int pn=Integer.parseInt(pageNo);

		String sortParam = request.getParameter("sortParam");
		pn = (pn - 1) * GeneralConfig.rpp_cons;

		if(clientId != null && clientId.length() > 0  && postId != null && postId.length() > 0)
		{
			map.addAttribute("profileList", postProfileService.getPostProfileByClientPostAndConsultant(clientId, principal.getName(), Long.parseLong(postId), pn, GeneralConfig.rpp_cons,"submitted",sortParam));
			map.addAttribute("totalCount", postProfileService.countPostProfileByClientPostAndConsultant(clientId, principal.getName(), Long.parseLong(postId),sortParam));
			map.addAttribute("postSelected",postId);
		}
		else
		{
			map.addAttribute("totalCount", 0);
			map.addAttribute("postSelected",postId);
		}
		map.addAttribute("rpp", GeneralConfig.rpp_cons);
		map.addAttribute("pn", Integer.parseInt(pageNo));
		map.addAttribute("sortParam", sortParam);
		return "profilelistbyconsidclientid";
	}

	@RequestMapping(value = "/cons_leftside_postlist", method = RequestMethod.GET)
	public String cons_leftside_postlist(ModelMap map, @RequestParam String clientId, Principal principal)
	{
		Registration cons = registrationService.getRegistationByUserId(principal.getName());
		if(cons.getAdmin() != null)
		{
			cons = cons.getAdmin();
		}
		if(clientId != null && clientId.trim().length() > 0 && !clientId.equals("1"))
		{
			List<PostConsultant> pcList=postConsultnatService.getInterestedPostForConsultantByClient(cons.getUserid(), clientId,"percentile");
			map.addAttribute("postConsList", pcList);
		}
		return "cons_leftside_postlist";
	}
	
	@RequestMapping(value = "/consnewposts", method = RequestMethod.GET)
	public String consnewposts(ModelMap map, HttpServletRequest request,Principal principal)
	{
		List<Industry> indList = new ArrayList<Industry>();
			Set<Industry> inds =  registrationService.getRegistationByUserId(principal.getName()).getIndustries();
			Iterator<Industry> it = inds.iterator();
			while(it.hasNext())
			{
				indList.add(it.next());
			}
		
		map.addAttribute("indList",indList);
		return "consnewposts";
	}
	@RequestMapping(value = "/consnewpostslist", method = RequestMethod.GET)
	public String consnewpostslist(ModelMap map, HttpServletRequest request ,Principal principal, @RequestParam int sel_industry)
	{
		System.out.println("sel_industry : " + sel_industry);
		int rpp = GeneralConfig.rpp;
		int pn = Integer.parseInt(request.getParameter("pn"));
		String sortParam = request.getParameter("sortParam");
		if(sel_industry > 0)
		{
			//map.addAttribute("postList", postService.getPostsByIndustryId(sel_industry, (pn - 1) * rpp, rpp,sortParam));
			map.addAttribute("postList", postService.getPostsByIndustryId(sel_industry, 0, 1000,sortParam));
			map.addAttribute("totalCount", postService.countPostsByIndustryId(sel_industry));
		}
		else
		{
			//map.addAttribute("postList", postService.getPostsByIndustryUsingConsultantId(principal.getName(), (pn - 1) * rpp, rpp,sortParam));
			map.addAttribute("postList", postService.getPostsByIndustryUsingConsultantId(principal.getName(), 0, 1000,sortParam));
			map.addAttribute("totalCount", postService.countPostsByIndustryUsingConsultantId(principal.getName()));
		}
		map.addAttribute("rpp", rpp);
		map.addAttribute("pn", pn);
		map.addAttribute("sortParam", sortParam);
		return "consnewpostslist";
	}
	@RequestMapping(value = "/consdashboard", method = RequestMethod.GET)
	public String consdashboard(ModelMap map, Principal principal)
	{
		Registration reg = registrationService.getRegistationByUserId(principal.getName());
		if(reg != null)
		{
			if(reg.getAdmin() != null)
			{
				reg = reg.getAdmin();
			}
			
			map.addAttribute("totalActive", postService.countPostsFilteredForConsultant(reg.getUserid(), null,null, null));
			map.addAttribute("totalprofiles", postProfileService.countSubmittedProfileByClientOrConsultant(null, reg.getUserid()));
			map.addAttribute("totalshortlist", postProfileService.countShortListedProfileByClientOrConsultant(null, reg.getUserid()));
			map.addAttribute("totaljoin", postProfileService.countJoinedProfileByClientOrConsultant(null, reg.getUserid()));
			map.addAttribute("totalpartner", postProfileService.countPartnerByClientOrConsultant(null, reg.getUserid()));

			return "consdashboard";
		}
		return "redirect:login";
	}
	@RequestMapping(value = "/consDashboardList", method = RequestMethod.GET)
	public String consDashboardList(ModelMap map, HttpServletRequest request ,Principal principal)
	{
		int rpp = GeneralConfig.rpp;
		int pn = Integer.parseInt(request.getParameter("pn"));
		String db_post_status = request.getParameter("db_post_status");
		String db_sel_client = request.getParameter("db_sel_client");
		String db_sel_loc = request.getParameter("db_sel_loc");
		
		String sortParam = request.getParameter("sortParam");
		
		Registration consultant = registrationService.getRegistationByUserId(principal.getName());
		if(consultant.getAdmin() != null)
		{
			consultant = consultant.getAdmin(); 
		}
		
		
		// get post list by consultant (by passing client id(optional) , status(optional) , location(optional), sorted by parameter start count and maximum rows)
		map.addAttribute("postList", postService.getPostsFilteredForConsultant(consultant.getUserid(), db_sel_client,db_post_status, db_sel_loc, (pn - 1) * rpp, rpp,sortParam));
		map.addAttribute("totalCount", postService.countPostsFilteredForConsultant(consultant.getUserid(), db_sel_client,db_post_status, db_sel_loc));
		 
		map.addAttribute("clientList", registrationService.getClientsByIndustyForConsultant(consultant.getUserid()));
		map.addAttribute("locList", postService.getLocationsByConsultant(consultant.getUserid()));
		if(db_sel_client != null && db_sel_client.length() > 0)
		{
			map.addAttribute("selClient", registrationService.getRegistationByUserId(db_sel_client));
		}
		map.addAttribute("db_post_status", db_post_status);
		map.addAttribute("db_sel_loc", db_sel_loc);
		
		map.addAttribute("rpp", rpp);
		map.addAttribute("pn", pn);
		map.addAttribute("sortParam", sortParam);

		return "consDashboardList";
	}
	
	@RequestMapping(value = "/consultantaccount", method = RequestMethod.GET)
	public String consultantaccount(ModelMap map, HttpServletRequest request ,Principal principal)
	{
		map.addAttribute("registration", registrationService.getRegistationByUserId(principal.getName()));
		map.addAttribute("co-users", registrationService.getCoUsersByUserid(principal.getName()));
		map.addAttribute("status", request.getParameter("status"));
		return "consultantAccount";
	}
	
	
	@RequestMapping(value = "/consprofilecenter", method = RequestMethod.GET)
	public String consProfileCenter(ModelMap map, HttpServletRequest request ,Principal principal)
	{
		
		return "consProfileCenter";
	}
	
	@RequestMapping(value = "/consprofilecenterlist", method = RequestMethod.GET)
	public String consProfileCenterList(ModelMap map, HttpServletRequest request ,Principal principal)
	{
		
		String pageno = request.getParameter("pn");
		int pn = 1;
		try
		{
			pn = Integer.parseInt(pageno);	
		} catch (NumberFormatException e)
		{
			e.printStackTrace();
		}
		
		map.addAttribute("ppList", postProfileService.getPostProfileByConsForCenter(principal.getName(), (pn-1)*GeneralConfig.rpp, GeneralConfig.rpp));
		map.addAttribute("totalCount", postProfileService.countPostProfileByConsForCenter(principal.getName()));
		map.addAttribute("pn", pn);
		map.addAttribute("rpp", GeneralConfig.rpp);
		return "consProfileCenterList";
	}
	
	
	
	
	@RequestMapping(value = "/consBulkInterest", method = RequestMethod.GET)
	public @ResponseBody String consBulkInterest(ModelMap map, HttpServletRequest request, Principal principal)
	{

		JSONObject object = new JSONObject();
		String pids = request.getParameter("pids");
		if(pids != null && pids.length() > 0)
		{
			String[] ids = pids.split(",");
			try
			{
				System.out.println("value is " +pids);
				for(String pid : ids)
				{
		Post post = postService.getPost(Long.parseLong(pid.trim()));
		JSONObject obj = new JSONObject();
		if(post != null)
		{
			PostConsultant pc = new PostConsultant();

			long trTime1 = 0;
			long srRatio1 = 0;
			long crRatio1 = 0;
			long trTime2 = 0;
			long srRatio2 = 0;
			long crRatio2 = 0;
			int counter1=0;
			int counter2=0;
			Date date = new Date();
			java.sql.Date dt = new java.sql.Date(date.getTime());
			
			pc.setCreateDate(dt);
			pc.setPost(post);
			Registration consultant=registrationService.getRegistationByUserId(principal.getName());

			Set<Industry> industry = consultant.getIndustries();
			Iterator<Industry> inIterator = industry.iterator();
			Industry in = null;
			while (inIterator.hasNext())
			{
				in = (Industry) inIterator.next();
			}
			pc.setConsultant(consultant);
			List<GlobalRating> rating=globalRatingService.getGlobalRatingListByIndustryAndConsultantRange(in.getId(),consultant.getUserid(), 0, GeneralConfig.globalRatingMaxRows1);
			counter1=rating.size()/GeneralConfig.NoOfRatingParams;
			int N=counter1;
			int i=0,j=0,k=0;
			for (GlobalRating globalRating : rating)
			{
				RatingParameter param = globalRating.getRatingParameter();
				switch (param.getName())
				{
				case "turnaroundtime":
				{
					trTime1 += globalRating.getRatingParamValue()*(N-i);
					i++;
					break;
				}
				case "shortlistRatio":
				{
					srRatio1 += globalRating.getRatingParamValue()*(N-j);
					j++;
					break;
				}
				case "closureRate":
				{
					crRatio1 += globalRating.getRatingParamValue()*(N-k);
					k++;
					break;
				}
				default:
					break;
				}
			}
			int div=(N*(N+1))/2;
			
			if(div > 0)
			{
				pc.setTurnAround(trTime1/div);
				pc.setShortlistRatio(srRatio1/div);
				pc.setClosureRatio(crRatio1/div);
				
			}
			else
			{
				pc.setTurnAround(0);
				pc.setShortlistRatio(0);
				pc.setClosureRatio(0);
				
			}
						
			
			post.getPostConsultants().add(pc);
			post.setPostConsultants(post.getPostConsultants());
			postService.updatePost(post);

			List<PostConsultant> pcList=postConsultnatService.getInterestedPostByConsIdandPostId(principal.getName(), post.getPostId(),"turnAround");
			int count=0;
			for (PostConsultant postConsultant : pcList)
			{
				count++;
				postConsultant.setPercentileTr(count*100/pcList.size());
				postConsultnatService.updatePostConsultant(postConsultant);
			}
			
			List<PostConsultant> srRatio=postConsultnatService.getInterestedPostByConsIdandPostId(principal.getName(), post.getPostId(),"shortlistRatio");
			 count=0;
			for (PostConsultant postConsultant : srRatio)
			{
				count++;
				postConsultant.setPercentileSh(count*100/pcList.size());
				postConsultnatService.updatePostConsultant(postConsultant);
			}
			
			List<PostConsultant> clRatio=postConsultnatService.getInterestedPostByConsIdandPostId(principal.getName(), post.getPostId(),"closureRatio");
			 count=0;
				List<RatingParameter> ratingparam=ratingParamService.getRatingParameterList();
			for (PostConsultant postConsultant : clRatio)
			{
				count++;
				postConsultant.setPercentileCl(count*100/pcList.size());
				postConsultnatService.updatePostConsultant(postConsultant);
				postConsultant.setPercentile(((postConsultant.getPercentileTr()*ratingparam.get(0).getWeightage())/100)+
						((postConsultant.getPercentileSh()*ratingparam.get(1).getWeightage())/100)+
						((postConsultant.getPercentileCl()*ratingparam.get(2).getWeightage())/100));

				postConsultnatService.updatePostConsultant(postConsultant);
			}
			
		}
				}
		object.put("status", "success");
		return object.toJSONString();
	}
	catch(Exception e)
	{
		e.printStackTrace();
	}
}


object.put("status", "failed");
return object.toJSONString();
	}
	
	
	@RequestMapping(value = "/consapplicantinfo", method = RequestMethod.GET)
	public String consApplicantInfo(ModelMap map, HttpServletRequest request ,Principal principal, @RequestParam long ppid)
	{
		PostProfile postProfile = postProfileService.getPostProfile(ppid);
		map.addAttribute("postProfile", postProfile);
		
		map.addAttribute("msgList", inboxService.getInboxMessages(ppid, 0, 10));
		inboxService.setViewedByConsultant(ppid);
		return "consApplicantInfo";
	}
	
	@RequestMapping(value = "/consviewjd", method = RequestMethod.GET)
	public String viewConsPostDetail(ModelMap map, HttpServletRequest request ,Principal principal)
	{
		String pid = request.getParameter("pid");
		if(pid != null && pid.trim().length() > 0)
		{
			Post post = postService.getPost(Long.parseLong(pid));
			if(post != null)
			{
				map.addAttribute("post", post);
				return "viewConsPostDetail";
			}
			
		}
		return "redirect:consdashboard";
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
	
	@RequestMapping(value = "/conscheckapplicantbyemail", method = RequestMethod.GET)
	public @ResponseBody String consCheckApplicantAvailabilityByEmail(ModelMap map, HttpServletRequest request ,Principal principal, @RequestParam long pid)
	{
		String email = request.getParameter("email");
		JSONObject obj = new JSONObject();
		if(email != null && email.trim().length() > 0)
		{
			obj.put("status", postProfileService.checkPostProfileAvailability(pid, email, null));
			return obj.toJSONString();
		}
		obj.put("status", false);
		return obj.toJSONString();
	}
	@RequestMapping(value = "/conscheckapplicantbycontact", method = RequestMethod.GET)
	public @ResponseBody String consCheckApplicantAvailabilityByContact(ModelMap map, HttpServletRequest request ,Principal principal, @RequestParam long pid)
	{
		String contact = request.getParameter("contact");
		JSONObject obj = new JSONObject();
		if(contact != null && contact.trim().length() > 0)
		{
			obj.put("status", postProfileService.checkPostProfileAvailability(pid, null, contact));
			return obj.toJSONString();
		}
		obj.put("status", false);
		return obj.toJSONString();
	}
	
	@RequestMapping(value = "/sendInboxMsg", method = RequestMethod.GET)
	public @ResponseBody String sendInboxMsg(ModelMap map, HttpServletRequest request ,Principal principal, @RequestParam long ppid)
	{
		String msg_text = request.getParameter("msg_text");
		JSONObject obj = new JSONObject();
		if(msg_text != null && msg_text.trim().length() > 0 )
		{
			Inbox msg = new Inbox();
			
			Date date = new Date();
			java.sql.Date dt = new java.sql.Date(date.getTime());
			
			PostProfile pp = postProfileService.getPostProfile(ppid);
			if(pp != null)
			{
				msg.setMessage(msg_text);
				msg.setCreateDate(dt);
				msg.setPostProfile(pp);
				if(request.isUserInRole(Roles.ROLE_CON_MANAGER.toString()) || request.isUserInRole(Roles.ROLE_CON_USER.toString()))
				{
					msg.setConsultant(principal.getName());
					String cont= "<div class='mag msg_receiver'><h2>"+principal.getName()+"</h2><p>"
							+msg_text+ "<span>("+DateFormats.getTimeValue(dt)+")</span>"
							+ " </p>"
							+ "</div>";
					obj.put("msg_text", cont);
					
				}
				else if(request.isUserInRole(Roles.ROLE_EMP_MANAGER.toString()) || request.isUserInRole(Roles.ROLE_EMP_USER.toString()))
				{
					msg.setClient(principal.getName());
					String cont= "<div class='mag msg_sender'><h2>"+principal.getName()+"</h2><p>"
							+msg_text+ "<span>("+DateFormats.getTimeValue(dt)+")</span>"
							+ " </p>"
							+ "</div>";
					obj.put("msg_text", cont);
				}
				long id = inboxService.addInboxMessage(msg);
				obj.put("status", true);
				return obj.toJSONString();
				
			}
		}
		obj.put("status", false);
		return obj.toJSONString();
	}
	

	@RequestMapping(value = "/consBulkClose", method = RequestMethod.GET)
	public @ResponseBody String consBulkClose(ModelMap map, HttpServletRequest request, Principal principal)
	{
		JSONObject object = new JSONObject();
		String pids = request.getParameter("pids");
		if (pids != null && pids.length() > 0)
		{
			String[] ids = pids.split(",");
			try
			{
				for (String pid : ids)
				{
					Post post = postService.getPost(Long.parseLong(pid.trim()));
					if (post != null)
					{
						if(post.getCloseRequestConsultant()!=null){
							if(post.getCloseRequestConsultant().indexOf(principal.getName())<0)
						post.setCloseRequestConsultant(post.getCloseRequestConsultant()+","+principal.getName());
								
								
						}else{
							post.setCloseRequestConsultant(principal.getName());	
						}
						postService.updatePost(post);
					}
				}
				object.put("status", "success");
				return object.toJSONString();
			} catch (Exception e)
			{
				e.printStackTrace();
			}
		}

		object.put("status", "failed");
		return object.toJSONString();
	}

	@RequestMapping(value = "/consacceptoffer", method = RequestMethod.GET)
	public @ResponseBody String consacceptoffer(ModelMap map, HttpServletRequest request, Principal principal)
	{

		String subject = "Subject";
		String content = "Content";
		boolean st = false;
		JSONObject obj = new JSONObject();
		try
		{
			long ppid = Long.parseLong(request.getParameter("ppid"));
			String ppstatus  = request.getParameter("ppstatus"); 
			PostProfile pp = postProfileService.getPostProfile(ppid);
			
			if(pp != null)
			{
				Date date = new Date();
				java.sql.Date dt = new java.sql.Date(date.getTime());
				
				if(ppstatus.equals("join_accept"))
				{
					pp.setJoinDate(dt);

					BillingDetails billingDetailscl =billingService.getBillingDetailsById(pp.getPpid());
					billingDetailscl.setJoiningDate(dt);
					
					long payDay=Long.parseLong(pp.getPost().getClient().getPaymentDays()+"");
					billingDetailscl.setPaymentDueDateForAd(new java.sql.Date(
							dt.getTime() + (payDay) * 24 * 60 * 60 * 1000));
					
					try{
					billingDetailscl.setPaymentDueDateForCo(new java.sql.Date(
							dt.getTime() + (payDay) * 24 * 60 * 60 * 1000
									+ (Long.parseLong(pp.getProfile().getRegistration().getPaymentDays()+"")) * 24 * 60 * 60 * 1000));
					}catch(Exception e){
						e.printStackTrace();
					}
					billingService.updateBillingDetails(billingDetailscl);
					Post post=pp.getPost();
					try{
					if(post.getNoOfPosts()<=(post.getNoOfPostsFilled()+1))
					{
					post.setNoOfPostsFilled(post.getNoOfPosts());
					postService.updatePost(post);	
					closePost(pp.getPpid());
					}else{
						post.setNoOfPostsFilled(post.getNoOfPostsFilled()+1);
						postService.updatePost(post);	
							
					}
					}catch(Exception e){
					post.setNoOfPosts(0);
					postService.updatePost(post);	
					}

					mailService.sendMail(pp.getProfile().getRegistration().getUserid(), subject, content);
					obj.put("status", "join_accept");
				}
				else if(ppstatus.equals("join_reject"))
				{
					String rej_reason = request.getParameter("rej_reason");
					pp.setJoinDropDate(dt);
					pp.setRejectReason(rej_reason);

					st=mailService.sendMail(pp.getProfile().getRegistration().getUserid(), subject, content);
					obj.put("status", "join_reject");
				}
				else
				{
					obj.put("status", "failed");
				}
				
				postProfileService.updatePostProfile(pp);
				return obj.toJSONString();
				
			}
			
			
		} catch (Exception e)
		{
			// TODO: handle exception
		}
		obj.put("status", "failed");
		
		return obj.toJSONString();
	}
	@RequestMapping(value = "/consviewuser", method = RequestMethod.GET)
	public String clientViewUser(ModelMap map, Principal principal, @RequestParam String uid)
	{
		Registration reg = registrationService.getRegistationByUserId(uid);
		if(reg != null)
		{
			map.addAttribute("registration", reg);
			return "consViewUser";
		}
		return "redirect:clientdashboard";

	}
	
	@RequestMapping(value = "/consmessages", method = RequestMethod.GET)
	public @ResponseBody String consmessages(ModelMap map, HttpServletRequest request ,Principal principal)
	{
		JSONObject object = new JSONObject();
		List<Inbox> mList = inboxService.getMessageByConsultant(principal.getName(), 0, 100);
		JSONArray array = new JSONArray();
		JSONObject jm = null;
		try
		{
			for(Inbox m : mList)
			{
				jm = new JSONObject();
				jm.put("cons", m.getPostProfile().getPost().getClient().getOrganizationName());
				jm.put("ptitle", m.getPostProfile().getPost().getTitle());
				jm.put("message", m.getMessage());
				jm.put("ppid", m.getPostProfile().getPpid());
				
				array.add(jm);
			}
			object.put("mList", array);
			object.put("status", true);
			return object.toJSONString();
			
		} 
		catch (Exception e)
		{
			e.printStackTrace();
		}
		object.put("status", false);
		return object.toJSONString();

	}
	
	

	
	public String closePost(long postId)
	{
		List<PostConsultant> postConsultants = postConsultantService.getInterestedConsultantByPost(postId);
		List<RatingParameter> ratingParams = ratingParameterService.getRatingParameterList();
		Registration consultant = null;
		Post post = null;
		int counter = 0;
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
			
			counter = 0;
			
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
						count++;
					}
					GlobalRating newGlobalRating = new GlobalRating();
					Date date = new Date();
					java.sql.Date dt = new java.sql.Date(date.getTime());
					newGlobalRating.setCreateDate(dt);
					newGlobalRating.setIndustryId(in.getId());
					newGlobalRating.setRatingParameter(ratingParameter);
					long turTime=0;
					if (totalSubmitted == 0)
					{
						turTime = 0;
					} else{
						turTime=turnaround/count;
					}
					newGlobalRating.setRatingParamValue(turTime);
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
					long shrTime=0;
					if (totalSubmitted == 0)
					{
						shrTime = 0;
					} else
					{
					 shrTime=(totalShortlisted * 100 / totalSubmitted) ;
					}
					newGlobalRating.setRatingParamValue(shrTime);
					newGlobalRating.setRegistration(consultant);
					globalRatingService.addGlobalRating(newGlobalRating);
					break;
				}
				case "closureRate":
				{
					long totalRecruited = postProfileService.countRecruitedProfileListByConsultantIdAndPostId(
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
					long clrTime=0;
					if (totalSubmitted == 0)
					{
						clrTime = 0;
					} else
					{
					clrTime=(totalRecruited * 100 / totalSubmitted) ;
					}
						
					newGlobalRating.setRatingParamValue(clrTime);
					newGlobalRating.setRegistration(consultant);
					globalRatingService.addGlobalRating(newGlobalRating);
					break;
				}
				default:
					break;
				}
			}
		}
		post = postService.getPost(postId);
		Set<Industry> industry = registrationService.getRegistationByUserId(post.getClient().getUserid())
				.getIndustries();
		Iterator<Industry> inIterator = industry.iterator();
		Industry in = null;
		while (inIterator.hasNext())
		{
			in = (Industry) inIterator.next();
		}
		
		
		for (RatingParameter ratingParameter : ratingParams)
		{
			switch (ratingParameter.getName())
			{
			case "turnaroundtime":
			{
				GlobalRating newGlobalRating = new GlobalRating();
				Date date = new Date();
				java.sql.Date dt = new java.sql.Date(date.getTime());
				newGlobalRating.setCreateDate(dt);
				newGlobalRating.setIndustryId(in.getId());
				newGlobalRating.setRatingParameter(ratingParameter);
				newGlobalRating.setRatingParamValue(0);
				break;
			}
			case "shortlistRatio":
			{
				
				break;
			}
			case "closureRate":
			{
				
				break;
			}
			default:
				break;
			}
		}
		
		
		
		
		return null;
	}
}
