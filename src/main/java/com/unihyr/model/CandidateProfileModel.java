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

public class CandidateProfileModel {

	private long profileId;

	@NotBlank(message="{NotBlank.consForm.name}")
	private String name;

	@NotBlank(message="{NotBlank.consForm.email}")
	private String email;

	@NotBlank(message="{NotBlank.consForm.currentRole}")
	private String currentRole;

	private String willingToRelocate;

	@NotBlank(message="{NotBlank.consForm.noticePeriod}")
	private String noticePeriod;

	@NotBlank(message="{NotBlank.consForm.contact}")
	private String contact;

	@NotBlank(message="{NotBlank.consForm.currentOrganization}")
	private String currentOrganization;

	private String currentCTC;
	private String expectedCTC;

	private String jdID;

	private String resumePath;

	private String consultantId;
	
	private MultipartFile jdFile;
	
	private MultipartFile resumeFile;
	
	public String getConsultantId() {
		return consultantId;
	}

	public void setConsultantId(String consultantId) {
		this.consultantId = consultantId;
	}

	public long getProfileId() {
		return profileId;
	}

	public void setProfileId(long profileId) {
		this.profileId = profileId;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getCurrentRole() {
		return currentRole;
	}

	public void setCurrentRole(String currentRole) {
		this.currentRole = currentRole;
	}

	public String getWillingToRelocate() {
		return willingToRelocate;
	}

	public void setWillingToRelocate(String willingToRelocate) {
		this.willingToRelocate = willingToRelocate;
	}

	public String getExpectedCTC() {
		return expectedCTC;
	}

	public void setExpectedCTC(String expectedCTC) {
		this.expectedCTC = expectedCTC;
	}

	public String getNoticePeriod() {
		return noticePeriod;
	}

	public void setNoticePeriod(String noticePeriod) {
		this.noticePeriod = noticePeriod;
	}

	public String getContact() {
		return contact;
	}

	public void setContact(String contact) {
		this.contact = contact;
	}

	public String getCurrentOrganization() {
		return currentOrganization;
	}

	public void setCurrentOrganization(String currentOrganization) {
		this.currentOrganization = currentOrganization;
	}

	public String getCurrentCTC() {
		return currentCTC;
	}

	public void setCurrentCTC(String currentCTC) {
		this.currentCTC = currentCTC;
	}

	
	public String getJdID() {
		return jdID;
	}

	public void setJdID(String jdID) {
		this.jdID = jdID;
	}

	public String getResumePath() {
		return resumePath;
	}

	public void setResumePath(String resumePath) {
		this.resumePath = resumePath;
	}

	public MultipartFile getJdFile()
	{
		return jdFile;
	}

	public void setJdFile(MultipartFile jdFile)
	{
		this.jdFile = jdFile;
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
	
	
}
