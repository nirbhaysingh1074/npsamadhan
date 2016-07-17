package com.unihyr.model;

import java.util.Date;
import java.util.HashSet;
import java.util.Set;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.Lob;
import javax.persistence.ManyToOne;
import javax.persistence.Table;

import org.hibernate.validator.constraints.NotBlank;
import org.springframework.web.multipart.MultipartFile;

import com.unihyr.domain.Post;
import com.unihyr.domain.Registration;

public class CandidateProfileModel
{

	private long profileId;

	@NotBlank(message = "{NotBlank.consForm.name}")
	private String name;

	@NotBlank(message = "{NotBlank.consForm.email}")
	private String email;

	@NotBlank(message = "{NotBlank.consForm.currentRole}")
	private String currentRole;

	private String willingToRelocate;

	private int noticePeriod;

	@Column
	private Integer experience;
	
	@NotBlank(message = "{NotBlank.consForm.contact}")
	private String contact;

	@NotBlank(message = "{NotBlank.consForm.currentOrganization}")
	private String currentOrganization;

	private Long currentCTC;

	private Long expectedCTC;

	@NotBlank(message = "{NotBlank.consForm.currentLocation}")
	private String currentLocation;

	private String ctcComments;

	private String dateofbirth;

	private String qualification_ug;

	private String qualification_pg;

	private String jdID;

	private String resumePath;

	private String consultantId;

	private String countryCode;
	
	private MultipartFile resumeFile;

	public Integer getExperience()
	{
		return experience;
	}

	public void setExperience(Integer experience)
	{
		this.experience = experience;
	}

	public String getCountryCode()
	{
		return countryCode;
	}

	public void setCountryCode(String countryCode)
	{
		this.countryCode = countryCode;
	}

	public String getQualification_ug()
	{
		return qualification_ug;
	}

	public void setQualification_ug(String qualification_ug)
	{
		this.qualification_ug = qualification_ug;
	}

	public String getQualification_pg()
	{
		return qualification_pg;
	}

	public void setQualification_pg(String qualification_pg)
	{
		this.qualification_pg = qualification_pg;
	}

	public String getDateofbirth()
	{
		return dateofbirth;
	}

	public void setDateofbirth(String dateofbirth)
	{
		this.dateofbirth = dateofbirth;
	}

	public String getCtcComments()
	{
		return ctcComments;
	}

	public void setCtcComments(String ctcComments)
	{
		this.ctcComments = ctcComments;
	}

	public String getCurrentLocation()
	{
		return currentLocation;
	}

	public void setCurrentLocation(String currentLocation)
	{
		this.currentLocation = currentLocation;
	}

	public String getConsultantId()
	{
		return consultantId;
	}

	public void setConsultantId(String consultantId)
	{
		this.consultantId = consultantId;
	}

	public long getProfileId()
	{
		return profileId;
	}

	public void setProfileId(long profileId)
	{
		this.profileId = profileId;
	}

	public String getName()
	{
		return name;
	}

	public void setName(String name)
	{
		this.name = name;
	}

	public String getEmail()
	{
		return email;
	}

	public void setEmail(String email)
	{
		this.email = email;
	}

	public String getCurrentRole()
	{
		return currentRole;
	}

	public void setCurrentRole(String currentRole)
	{
		this.currentRole = currentRole;
	}

	public String getWillingToRelocate()
	{
		return willingToRelocate;
	}

	public void setWillingToRelocate(String willingToRelocate)
	{
		this.willingToRelocate = willingToRelocate;
	}

	public String getContact()
	{
		return contact;
	}

	public void setContact(String contact)
	{
		this.contact = contact;
	}

	public String getCurrentOrganization()
	{
		return currentOrganization;
	}

	public void setCurrentOrganization(String currentOrganization)
	{
		this.currentOrganization = currentOrganization;
	}

	public int getNoticePeriod()
	{
		return noticePeriod;
	}

	public void setNoticePeriod(int noticePeriod)
	{
		this.noticePeriod = noticePeriod;
	}

	public Long getCurrentCTC()
	{
		return currentCTC;
	}

	public void setCurrentCTC(Long currentCTC)
	{
		this.currentCTC = currentCTC;
	}

	public Long getExpectedCTC()
	{
		return expectedCTC;
	}

	public void setExpectedCTC(Long expectedCTC)
	{
		this.expectedCTC = expectedCTC;
	}

	public String getJdID()
	{
		return jdID;
	}

	public void setJdID(String jdID)
	{
		this.jdID = jdID;
	}

	public String getResumePath()
	{
		return resumePath;
	}

	public void setResumePath(String resumePath)
	{
		this.resumePath = resumePath;
	}

	public MultipartFile getResumeFile()
	{
		return resumeFile;
	}

	public void setResumeFile(MultipartFile resumeFile)
	{
		this.resumeFile = resumeFile;
	}

	private Post post;

	public Post getPost()
	{
		return post;
	}

	public void setPost(Post post)
	{
		this.post = post;
	}

	@Lob
	private String screeningNote;
	@Lob
	private String resumeText;

	public String getScreeningNote()
	{
		return screeningNote;
	}

	public void setScreeningNote(String screeningNote)
	{
		this.screeningNote = screeningNote;
	}

	public String getResumeText()
	{
		return resumeText;
	}

	public void setResumeText(String resumeText)
	{
		this.resumeText = resumeText;
	}

}
