package com.unihyr.domain;

import java.io.Serializable;
import java.util.Date;
import java.util.HashSet;
import java.util.Set;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.Lob;
import javax.persistence.ManyToMany;
import javax.persistence.ManyToOne;
import javax.persistence.OneToMany;
import javax.persistence.OneToOne;
import javax.persistence.Table;

@Entity
@Table(name="post")
public class Post implements Serializable
{
	
	
	/**
	 * 
	 */
	private static final long serialVersionUID = 7878507665232547622L;

	@Id
	@Column(nullable=false)
	@GeneratedValue(strategy=GenerationType.AUTO)
	private long postId;
	
	@Column
	private String jobCode;
	
	@Column(nullable=false)
	private String title;
	
	@Column(nullable=false)
	private String location;
	
	@Column(nullable=false)
	private String function;
	
	@Column(nullable=false)
	private int exp_min;
	
	@Column(nullable=false)
	private int exp_max;
	
	@Column(nullable=false)
	private int ctc_min;
	
	@Column(nullable=false)
	private int ctc_max;
	
	@Column
	private String criteria;
	
	@Column
	@Lob
	private String comment;
	
	@Column
	private String uploadjd;
	
	@Column
	@Lob
	private String additionDetail;
	
	@Column
	private Date published;
	
	@Column(columnDefinition = "boolean default fasle" ,nullable=false)
	private boolean isActive;
	
	@Column
	private Date closeDate;
	
	
	
	public long getPostId() {
		return postId;
	}

	public void setPostId(long postId) {
		this.postId = postId;
	}

	public String getJobCode()
	{
		return jobCode;
	}

	public void setJobCode(String jobCode)
	{
		this.jobCode = jobCode;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public String getLocation() {
		return location;
	}

	public void setLocation(String location) {
		this.location = location;
	}

	public String getFunction() {
		return function;
	}

	public void setFunction(String function) {
		this.function = function;
	}

	public int getExp_min() {
		return exp_min;
	}

	public void setExp_min(int exp_min) {
		this.exp_min = exp_min;
	}

	public int getExp_max() {
		return exp_max;
	}

	public void setExp_max(int exp_max) {
		this.exp_max = exp_max;
	}

	public int getCtc_min() {
		return ctc_min;
	}

	public void setCtc_min(int ctc_min) {
		this.ctc_min = ctc_min;
	}

	public int getCtc_max() {
		return ctc_max;
	}

	public void setCtc_max(int ctc_max) {
		this.ctc_max = ctc_max;
	}

	public String getCriteria() {
		return criteria;
	}

	public void setCriteria(String criteria) {
		this.criteria = criteria;
	}

	public String getComment() {
		return comment;
	}

	public void setComment(String comment) {
		this.comment = comment;
	}

	public String getUploadjd() {
		return uploadjd;
	}

	public void setUploadjd(String uploadjd) {
		this.uploadjd = uploadjd;
	}

	public String getAdditionDetail() {
		return additionDetail;
	}

	public void setAdditionDetail(String additionDetail) {
		this.additionDetail = additionDetail;
	}

	
	public Date getPublished() {
		return published;
	}

	public void setPublished(Date published) {
		this.published = published;
	}

//	public Set<CandidateProfile> getProfileList()
//	{
//		return profileList;
//	}
//
//	public void setProfileList(Set<CandidateProfile> profileList)
//	{
//		this.profileList = profileList;
//	}



	@ManyToOne(cascade = { CascadeType.ALL })
	@JoinColumn(name = "clientId", referencedColumnName = "userid" , nullable=false)
	private Registration client;
	
	
//	@Column
//	private String lastModifier;

	@ManyToOne(cascade = { CascadeType.ALL })
	@JoinColumn(name = "lastModifier", referencedColumnName = "userid")
	private Registration lastModifier;
	
	
	@Column
	private Date createDate;
	
	@Column
	private Date modifyDate;
	
	@Column
	private Date deleteDate;

	

	
	public Registration getClient()
	{
		return client;
	}

	public void setClient(Registration client)
	{
		this.client = client;
	}

	public Registration getLastModifier()
	{
		return lastModifier;
	}

	public void setLastModifier(Registration lastModifier)
	{
		this.lastModifier = lastModifier;
	}

	public Date getCreateDate() {
		return createDate;
	}

	public void setCreateDate(Date createDate) {
		this.createDate = createDate;
	}

	public Date getModifyDate() {
		return modifyDate;
	}

	public void setModifyDate(Date modifyDate) {
		this.modifyDate = modifyDate;
	}

	public Date getDeleteDate() {
		return deleteDate;
	}

	public void setDeleteDate(Date deleteDate) {
		this.deleteDate = deleteDate;
	}
	
	
	public boolean isActive()
	{
		return isActive;
	}

	public void setActive(boolean isActive)
	{
		this.isActive = isActive;
	}

	public Date getCloseDate()
	{
		return closeDate;
	}

	public void setCloseDate(Date closeDate)
	{
		this.closeDate = closeDate;
	}

	@OneToMany(mappedBy="post", cascade=CascadeType.ALL)  
	private Set<PostProfile> postProfile;

	public Set<PostProfile> getPostProfile()
	{
		return postProfile;
	}

	public void setPostProfile(Set<PostProfile> postProfile)
	{
		this.postProfile = postProfile;
	}

	
	@OneToMany(mappedBy="post", cascade=CascadeType.ALL)  
	private Set<PostConsultant> postConsultants;


	public Set<PostConsultant> getPostConsultants()
	{
		return postConsultants;
	}

	public void setPostConsultants(Set<PostConsultant> postConsultants)
	{
		this.postConsultants = postConsultants;
	}

	
	
}
