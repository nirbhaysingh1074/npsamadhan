package com.unihyr.controller;

import java.io.File;
import java.io.IOException;
import java.security.Principal;
import java.util.Date;
import java.util.HashSet;
import java.util.Iterator;
import java.util.List;
import java.util.Set;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import javax.validation.Valid;

import org.apache.commons.fileupload.servlet.ServletFileUpload;
import org.apache.commons.io.FilenameUtils;
import org.hibernate.Session;
import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
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

import com.google.gson.JsonSerializationContext;
import com.unihyr.constraints.GeneralConfig;
import com.unihyr.constraints.Roles;
import com.unihyr.domain.CandidateProfile;
import com.unihyr.domain.Industry;
import com.unihyr.domain.LoginInfo;
import com.unihyr.domain.Post;
import com.unihyr.domain.PostProfile;
import com.unihyr.domain.Registration;
import com.unihyr.domain.UserRole;
import com.unihyr.model.ClientRegistrationModel;
import com.unihyr.model.PostModel;
import com.unihyr.service.IndustryService;
import com.unihyr.service.LoginInfoService;
import com.unihyr.service.PostProfileService;
import com.unihyr.service.PostService;
import com.unihyr.service.ProfileService;
import com.unihyr.service.RegistrationService;
import com.unihyr.service.UserRoleService;

import scala.sys.process.processInternal;

@Controller
public class ClientController
{
	@Autowired
	private IndustryService industryService;
	@Autowired
	private PostService postService;
	@Autowired
	private RegistrationService registrationService;
	@Autowired
	private LoginInfoService loginInfoService;
	@Autowired
	private UserRoleService userRoleService;
	@Autowired
	private ProfileService profileService;
	@Autowired
	private PostProfileService postProfileService;

	
	
	@RequestMapping(value = "/clientdashboard", method = RequestMethod.GET)
	public String clientDashboard(ModelMap map, Principal principal)
	{
		
		
		
		map.addAttribute("totalposts", postService.countAllPostByClient(principal.getName()));
		map.addAttribute("totalprofiles", postProfileService.countPostProfileByClient(principal.getName()));
		map.addAttribute("totalActive", postService.countPostByClient(principal.getName()));
		return "clientDashboard";
	}
	
	@RequestMapping(value = "/clientDashboardList", method = RequestMethod.GET)
	public String clientDashboardList(ModelMap map, HttpServletRequest request ,Principal principal)
	{
		int rpp = GeneralConfig.rpp;
		int pn = Integer.parseInt(request.getParameter("pn"));
		String db_post_status = request.getParameter("db_post_status");
		if(db_post_status.equals("all"))
		{
			map.addAttribute("postList", postService.getAllPostsByClient(principal.getName(), (pn - 1) * rpp, rpp));
			map.addAttribute("totalCount", postService.countAllPostByClient(principal.getName()));
		}
		else if(db_post_status.equals("active"))
		{
			map.addAttribute("postList", postService.getPostsByClient(principal.getName(), (pn - 1) * rpp, rpp));
			map.addAttribute("totalCount", postService.countPostByClient(principal.getName()));
		}
		else if(db_post_status.equals("inactive"))
		{
			map.addAttribute("postList", postService.getAllInactivePostsByClient(principal.getName(), (pn - 1) * rpp, rpp));
			map.addAttribute("totalCount", postService.countAllInactivePostByClient(principal.getName()));
		}
		else if(db_post_status.equals("deleted"))
		{
			map.addAttribute("postList", postService.getDeletedPostsByClient(principal.getName(), (pn - 1) * rpp, rpp));
			map.addAttribute("totalCount", postService.countDeletedPostByClient(principal.getName()));
		}
		
		map.addAttribute("rpp", rpp);
		map.addAttribute("pn", pn);

		return "clientDashboardList";
	}

	

	@RequestMapping(value = "/clientaddpost", method = RequestMethod.GET)
	public String addPost(ModelMap map)
	{
		map.addAttribute("postForm", new PostModel());
		return "addPost";
	}

	@RequestMapping(value = "/clientaddpost", method = RequestMethod.POST)
	public String client_addPost(@ModelAttribute(value = "postForm") @Valid PostModel model, BindingResult result,
			ModelMap map, HttpServletRequest request, Principal principal)
	{
		if (result.hasErrors())
		{
			return "addPost";
		} else
		{
			System.out.println("form submitted successfully");

			Post post = new Post();
			post.setTitle(model.getTitle());
			post.setLocation(model.getLocation());
			post.setFunction(model.getFunction());
			post.setExp_min(model.getExp_min());
			post.setExp_max(model.getExp_max());
			post.setCtc_min(model.getCtc_min());
			post.setCtc_max(model.getCtc_max());
			post.setCriteria(model.getCriteria());
			post.setComment(model.getComment());
			post.setUploadjd(model.getUploadjd());
			post.setAdditionDetail(model.getAdditionDetail());
			
			Date date = new Date();
			java.sql.Date dt = new java.sql.Date(date.getTime());
			
			String btn_response = request.getParameter("btn_response");
			if(btn_response.equals("Publish"))
			{
				post.setPublished(dt);
			}
			post.setCreateDate(dt);
			post.setClient(registrationService.getRegistationByUserId(principal.getName()));
			
			
			MultipartFile imagefile = model.getFile();
	        String filename=imagefile.getOriginalFilename();
	        String newfilename=null;
	        long pid  = 0;
	        try
	        {
	        	if (!(filename.equals("")))
	        	{
	        	    newfilename=filename.replace(" ", "-");
	        		String imageextension=FilenameUtils.getExtension(newfilename);
	        		System.out.println("file extension="+imageextension);
	        		post.setUploadjd(newfilename);
	        		pid = postService.addPost(post);
	        		File img = new File (System.getProperty("catalina.base")+"/unihyr_uploads/post/"+pid+"/"+newfilename);
	        		if(!img.exists())
	        		{
	        			img.mkdirs();
	        		}
	        		imagefile.transferTo(img);			
	        	}
	        	else
	        	{
	        		pid = postService.addPost(post);
	        	}
			    
		    }
		    catch (IOException ie)
			        {
				ie.printStackTrace();
			}
			
		}
		return "redirect:clientyourpost";
	}

	@RequestMapping(value = "/clienteditpost", method = RequestMethod.GET)
	public String editPost(ModelMap map, @RequestParam long pid)
	{
		Post post = postService.getPost(pid);
		if (post != null)
		{
			PostModel model = new PostModel();

			model.setPostId(post.getPostId());
			model.setTitle(post.getTitle());
			model.setLocation(post.getLocation());
			model.setFunction(post.getFunction());
			model.setExp_min(post.getExp_min());
			model.setExp_max(post.getExp_max());
			model.setCtc_min(post.getCtc_min());
			model.setCtc_max(post.getCtc_max());
			model.setCriteria(post.getCriteria());
			model.setComment(post.getComment());
			model.setUploadjd(post.getUploadjd());
			model.setAdditionDetail(post.getAdditionDetail());
			map.addAttribute("postForm", model);
			return "editPost";
		}
		return "redirect:clientyourpost";
	}

	@RequestMapping(value = "/clienteditpost", method = RequestMethod.POST)
	public String client_editPost(@ModelAttribute(value = "postForm") @Valid PostModel model, BindingResult result,
			ModelMap map, HttpServletRequest request, Principal principal)
	{
		if (result.hasErrors())
		{
			return "editPost";
		} else
		{
			System.out.println("form submitted successfully");
			String btn_response = request.getParameter("btn_response");
			System.out.println("btn_response : " + btn_response);
			
			Post post = postService.getPost(model.getPostId());
			if (post != null)
			{
				post.setTitle(model.getTitle());
				post.setLocation(model.getLocation());
				post.setFunction(model.getFunction());
				post.setExp_min(model.getExp_min());
				post.setExp_max(model.getExp_max());
				post.setCtc_min(model.getCtc_min());
				post.setCtc_max(model.getCtc_max());
				post.setCriteria(model.getCriteria());
				post.setComment(model.getComment());
				post.setUploadjd(model.getUploadjd());
				post.setAdditionDetail(model.getAdditionDetail());
				Date date = new Date();
				java.sql.Date dt = new java.sql.Date(date.getTime());

				if(btn_response.equals("Publish") && post.getPublished() == null)
				{
					post.setPublished(dt);
				}
				else
				{
					post.setPublished(null);
				}
				post.setModifyDate(dt);
				if(!post.getClient().getUserid().endsWith(principal.getName()))
				{
					post.setLastModifier(registrationService.getRegistationByUserId(principal.getName()));
				}
				
				
				
				MultipartFile imagefile = model.getFile();
		        String filename=imagefile.getOriginalFilename();
		        String newfilename=null;
		        try
		        {
		        	if (!(filename.equals("")))
		        	{
		        	    newfilename=filename.replace(" ", "-");
		        		String imageextension=FilenameUtils.getExtension(newfilename);
		        		System.out.println("file extension="+imageextension);
		        		post.setUploadjd(newfilename);
		        		postService.updatePost(post);
		        		File img = new File (System.getProperty("catalina.base")+"/unihyr_uploads/post/"+post.getPostId()+"/"+newfilename);
		        		if(!img.exists())
		        		{
		        			img.mkdirs();
		        		}
		        		imagefile.transferTo(img);			
		        	}
		        	else
		        	{
		        		postService.updatePost(post);
		        	}
				    
			    }
			    catch (IOException ie)
				        {
					ie.printStackTrace();
				}
				
			}
		}
		return "redirect:clientyourpost";
	}

	@RequestMapping(value = "/clientyourpost", method = RequestMethod.GET)
	public String yourPost(ModelMap map, HttpServletRequest request)
	{
		return "yourPosts";
	}

	@RequestMapping(value = "/loadclientposts", method = RequestMethod.GET)
	public String loadclientposts(ModelMap map, HttpServletRequest request ,Principal principal)
	{
		int rpp = GeneralConfig.rpp;
		int pn = Integer.parseInt(request.getParameter("pn"));
		map.addAttribute("postList", postService.getAllPostsByClient(principal.getName(), (pn - 1) * rpp, rpp));
		map.addAttribute("totalCount", postService.countAllPostByClient(principal.getName()));
		map.addAttribute("rpp", rpp);
		map.addAttribute("pn", pn);

		return "clientPost";
	}

	@RequestMapping(value = "/clientpostapplicants", method = RequestMethod.GET)
	public String clientpostapplicants(ModelMap map, HttpServletRequest request, Principal principal)
	{
		List<Registration> cons = registrationService.getConsultantsByClient(principal.getName());
		map.addAttribute("consList",cons);
		
		
		
		
		map.addAttribute("postsList", postService.getPostsByClient(principal.getName()));
		return "clientPostApplicants";
	}

	@RequestMapping(value = "/postapplicantlist", method = RequestMethod.GET)
	public String postApplicantList(ModelMap map, HttpServletRequest request, Principal principal)
	{
		int rpp = GeneralConfig.rpp;
		int pn = Integer.parseInt(request.getParameter("pn"));
		int pid = Integer.parseInt(request.getParameter("pid"));
		String conid = request.getParameter("conid");
		if(pid == 0 && (conid == null || conid.trim().length() == 0))
		{
			map.addAttribute("ppList", postProfileService.getPostProfileByClient(principal.getName(),(pn - 1) * rpp, rpp));
			map.addAttribute("totalCount", postProfileService.countPostProfileByClient(principal.getName()));
		}
		else if(pid > 0 && (conid != null && conid.trim().length() > 0))
		{
			map.addAttribute("ppList", postProfileService.getPostProfileByClientPostAndConsultant(principal.getName(), conid, pid ,(pn - 1) * rpp, rpp));
			map.addAttribute("totalCount", postProfileService.countPostProfileByClientPostAndConsultant(principal.getName(), conid, pid));
		}
		else if(pid == 0 && (conid != null && conid.trim().length() > 0))
		{
			map.addAttribute("ppList", postProfileService.getPostProfileByClientAndConsultant(principal.getName(), conid, (pn - 1) * rpp, rpp));
			map.addAttribute("totalCount", postProfileService.countPostProfileByClientAndConsultant(principal.getName(), conid));
		}
		else
		{
			map.addAttribute("ppList", postProfileService.getPostProfileByPost(pid,(pn - 1) * rpp, rpp));
			map.addAttribute("totalCount", postProfileService.countPostProfileByPost(pid));
		}
		map.addAttribute("rpp", rpp);
		map.addAttribute("pn", pn);
		return "postApplicantList";
	}
	
	
	
	
	
	
	
	
	@RequestMapping(value = "/clientacceptreject", method = RequestMethod.GET)
	public @ResponseBody String clientacceptreject(ModelMap map, HttpServletRequest request, Principal principal)
	{
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
				
				if(ppstatus.equals("accept"))
				{
					pp.setAccepted(dt);
					obj.put("status", "accepted");
				}
				else if(ppstatus.equals("reject"))
				{
					pp.setRejected(dt);
					obj.put("status", "rejected");
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
	
	@RequestMapping(value = "/postConsultantList", method = RequestMethod.GET)
	public @ResponseBody String postConsultantList(ModelMap map, HttpServletRequest request, Principal principal)
	{
		int pid = Integer.parseInt(request.getParameter("pid"));
		List<Registration> list = null;
		if(pid == 0 )
		{
			list = registrationService.getConsultantsByClient(principal.getName());
		}
		else
		{
			list = registrationService.getConsultantsByPost(pid);
		}
		JSONObject obj = new JSONObject();
		
		JSONArray cons = new JSONArray();
		if(list != null && !list.isEmpty())
		{
			JSONObject jsonCon = null;
			for(Registration con : list)
			{
				jsonCon = new JSONObject();
				jsonCon.put("conid", con.getUserid());
				jsonCon.put("cname", con.getConsultName());
				cons.add(jsonCon);
			}
		}
		obj.put("consList", cons);
		
		return obj.toJSONString();
	}

	@RequestMapping(value = "/viewPostDetail", method = RequestMethod.GET)
	public String viewPostDetail(ModelMap map, HttpServletRequest request ,Principal principal)
	{
		String pid = request.getParameter("pid");
		if(pid != null && pid.trim().length() > 0)
		{
			Post post = postService.getPost(Long.parseLong(pid));
			if(post != null)
			{
				map.addAttribute("post", post);
				return "viewPostDetail";
			}
			
		}
		return "error";
	}
	
	@RequestMapping(value = "/clientaccount", method = RequestMethod.GET)
	public String clientAccount(ModelMap map, HttpServletRequest request ,Principal principal)
	{
		map.addAttribute("status", request.getParameter("status"));
		return "clientAccount";
	}
	
	private Set<String> allowedImageExtensions;
	@RequestMapping(value = "/client.uploadLogo", method = RequestMethod.POST)
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
