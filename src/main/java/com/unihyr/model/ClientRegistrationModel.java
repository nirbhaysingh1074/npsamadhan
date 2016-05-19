package com.unihyr.model;

import java.util.HashSet;
import java.util.Set;

import javax.persistence.Column;
import javax.persistence.Lob;
import javax.validation.constraints.Min;
import javax.validation.constraints.NotNull;
import javax.validation.constraints.Pattern;

import org.hibernate.validator.constraints.Length;
import org.hibernate.validator.constraints.NotBlank;
import org.hibernate.validator.constraints.NotEmpty;
import org.springframework.format.annotation.NumberFormat;
import org.springframework.format.annotation.NumberFormat.Style;

import com.unihyr.domain.Industry;

public class ClientRegistrationModel 
{
	@NotBlank(message="{NotBlank.regForm.userid}")
	private String userid;
	
	@NotBlank(message="{NotBlank.regForm.org}")
	private String organizationName;
	
	
//	@Pattern(regexp="(?=.*\\d)(?=.*[a-z]).{6,20}",message="{Pattern.regForm.password}")
	private String password;
	
//	@NotNull(message="{NotNull.regForm.repassword}")
	private String repassword;
	
	@NotBlank(message="{NotBlank.regForm.office}")
	private String officeLocations;
	
	private String hoAddress;
	
	@Min(value=1  ,message="{Min.regForm.noofpeoples}")
	private int noofpeoples;
	
	@Min(value=1 ,message="{Min.regForm.revenue}")
	private int revenue;
	
	@Length(max=10,min=10,message="{Length.regForm.contact}")
//    @NotEmpty(message="{NotEmpty.regForm.contact}")
	@NumberFormat(style=Style.NUMBER)
	private String contact;
	
	
	private Industry industry ;
	
	
	private int usersRequired;

	private String websiteUrl;
	
	private String officeAddress;
	
	public String getUserid() {
		return userid;
	}

	public void setUserid(String userid) {
		this.userid = userid;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public String getRepassword() {
		return repassword;
	}

	public void setRepassword(String repassword) {
		this.repassword = repassword;
		matchPassword();
	}

	private void matchPassword() {
	    if(this.password == null || this.repassword == null){
	        return;
	    }else if(!(this.password.equals(this.repassword))){
	    	System.out.println("in checkpassword");
	        this.repassword = null;
	    }
	}
	
	
	public String getOfficeLocations() {
		return officeLocations;
	}

	public void setOfficeLocations(String officeLocations) {
		this.officeLocations = officeLocations;
	}

	public int getNoofpeoples() {
		return noofpeoples;
	}

	public void setNoofpeoples(int noofpeoples) {
		this.noofpeoples = noofpeoples;
	}

	public int getRevenue() {
		return revenue;
	}

	public void setRevenue(int revenue) {
		this.revenue = revenue;
	}

	public String getContact() {
		return contact;
	}

	public void setContact(String contact) {
		this.contact = contact;
	}

	

	public Industry getIndustry() {
		return industry;
	}

	public void setIndustry(Industry industry) {
		this.industry = industry;
	}

	public String getOrganizationName() {
		return organizationName;
	}

	public void setOrganizationName(String organizationName) {
		this.organizationName = organizationName;
	}

	public String getHoAddress() {
		return hoAddress;
	}

	public void setHoAddress(String hoAddress) {
		this.hoAddress = hoAddress;
	}

	public int getUsersRequired() {
		return usersRequired;
	}

	public void setUsersRequired(int usersRequired) {
		this.usersRequired = usersRequired;
	}

	public String getWebsiteUrl()
	{
		return websiteUrl;
	}

	public void setWebsiteUrl(String websiteUrl)
	{
		this.websiteUrl = websiteUrl;
	}
	
	@Lob
	private String about;

	public String getAbout()
	{
		return about;
	}

	public void setAbout(String about)
	{
		this.about = about;
	}

	@Lob
	public String getOfficeAddress()
	{
		return officeAddress;
	}

	public void setOfficeAddress(String officeAddress)
	{
		this.officeAddress = officeAddress;
	}
	
	
	
}
