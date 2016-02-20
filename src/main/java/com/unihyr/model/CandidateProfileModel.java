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

import org.springframework.web.multipart.MultipartFile;

import com.unihyr.domain.Post;
import com.unihyr.domain.Registration;

public class CandidateProfileModel {

	private long profileId;

	private String name;

	private String email;

	private String currentRole;

	private String willingToRelocate;

	private String noticePeriod;

	private String contact;

	private String currentOrganization;

	private String currentCTC;
	private String expectedCTC;

	private Date date;

	private String jdID;

	private String resumePath;

	private String consultantId;
	private Set<Post> postionList = new HashSet<Post>();

	private MultipartFile jdFile;
	
	private MultipartFile resumeFile;
	
	
	public Set<Post> getPostionList()
	{
		return postionList;
	}

	public void setPostionList(Set<Post> postionList)
	{
		this.postionList = postionList;
	}

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

	public Date getDate() {
		return date;
	}

	public void setDate(Date date) {
		this.date = date;
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
	
}
