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
import javax.persistence.ManyToMany;
import javax.persistence.ManyToOne;
import javax.persistence.OneToMany;
import javax.persistence.OneToOne;
import javax.persistence.PrimaryKeyJoinColumn;
import javax.persistence.Table;

@Entity
@Table(name="registration")
public class Registration implements Serializable
{
	/**
	 * 
	 */
	private static final long serialVersionUID = 8719433485080003372L;
	
	private int lid;
	
	
	private String userid;
	
	
	private Date regdate;

	
	private Date modification_date;
	
	
	private LoginInfo log;
	
	
//	------------------ common Data --------------
	
	
	private String officeLocations;
	
	private String hoAddress;
	
	private int noofpeoples;
	
	private int revenue;
	
	private String contact;
	
	private String logo;
	
	
	private Set<Industry> industries = new HashSet<>();
	
	
//	------------------ Client Data -------------- 
	
	@Column
	private String organizationName;
	
	@Column
	private int usersRequired;
	
	@ManyToOne(cascade =
		{ CascadeType.ALL })
		@JoinColumn(name = "profile_id", referencedColumnName = "profileId")
	private CandidateProfile candidateProfile;
	
	
	
	
	
	
	
	
//	------------------ Consultant Data -------------- 	
	
	@Column
	private String consultName;
	
	@Column
	private String founderName;
	
	@Column
	private String founderContact;
	
	
	
	@Column
	private int yearsInIndusrty;

	@Id
	@Column(nullable=false)
	@GeneratedValue(strategy=GenerationType.AUTO)
	public int getLid() {
		return lid;
	}

	public void setLid(int lid) {
		this.lid = lid;
	}

	@Column(nullable=false)
	public String getUserid() {
		return userid;
	}

	public void setUserid(String userid) {
		this.userid = userid;
	}

	@Column(nullable=false)
	public Date getRegdate() {
		return regdate;
	}

	public void setRegdate(Date regdate) {
		this.regdate = regdate;
	}

	@Column
	public Date getModification_date() {
		return modification_date;
	}

	public void setModification_date(Date modification_date) {
		this.modification_date = modification_date;
	}

	@OneToOne(fetch = FetchType.LAZY)
	@PrimaryKeyJoinColumn
	public LoginInfo getLog() {
		return log;
	}

	public void setLog(LoginInfo log) {
		this.log = log;
	}

	@Column
	public String getOfficeLocations() {
		return officeLocations;
	}

	public void setOfficeLocations(String officeLocations) {
		this.officeLocations = officeLocations;
	}

	@Column
	public String getHoAddress() {
		return hoAddress;
	}

	public void setHoAddress(String hoAddress) {
		this.hoAddress = hoAddress;
	}

	@Column(nullable=false)
	public int getNoofpeoples() {
		return noofpeoples;
	}

	public void setNoofpeoples(int noofpeoples) {
		this.noofpeoples = noofpeoples;
	}
	
	@Column(nullable=false)
	public int getRevenue() {
		return revenue;
	}

	public void setRevenue(int revenue) {
		this.revenue = revenue;
	}

	@Column
	public String getContact() {
		return contact;
	}

	
	public void setContact(String contact) {
		this.contact = contact;
	}

	@ManyToMany(mappedBy="registration", fetch = FetchType.LAZY)
	public Set<Industry> getIndustries() {
		return industries;
	}

	public void setIndustries(Set<Industry> industries) {
		this.industries = industries;
	}

	
	@Column
	public String getOrganizationName() {
		return organizationName;
	}

	public void setOrganizationName(String organizationName) {
		this.organizationName = organizationName;
	}

	@Column(nullable=false)
	public int getUsersRequired() {
		return usersRequired;
	}

	public void setUsersRequired(int usersRequired) {
		this.usersRequired = usersRequired;
	}

	public String getConsultName() {
		return consultName;
	}

	public void setConsultName(String consultName) {
		this.consultName = consultName;
	}

	public int getYearsInIndusrty() {
		return yearsInIndusrty;
	}

	public void setYearsInIndusrty(int yearsInIndusrty) {
		this.yearsInIndusrty = yearsInIndusrty;
	}

	public String getFounderName()
	{
		return founderName;
	}

	public void setFounderName(String founderName)
	{
		this.founderName = founderName;
	}

	public String getFounderContact()
	{
		return founderContact;
	}

	public void setFounderContact(String founderContact)
	{
		this.founderContact = founderContact;
	}

	public String getLogo()
	{
		return logo;
	}

	public void setLogo(String logo)
	{
		this.logo = logo;
	}

	
	
	
	
	
	
	
}
