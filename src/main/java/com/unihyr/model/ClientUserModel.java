package com.unihyr.model;

import javax.validation.constraints.NotNull;
import javax.validation.constraints.Pattern;

import org.hibernate.validator.constraints.NotBlank;

public class ClientUserModel
{
	@NotBlank(message="{NotBlank.cuForm.userid}")
	private String userid;
	
	@NotBlank(message="{NotBlank.cuForm.name}")
	private String name;
	
	@Pattern(regexp="(?=.*\\d)(?=.*[a-z]).{6,20}",message="{Pattern.regForm.password}")
	private String password;
	
	@NotNull(message="{NotNull.regForm.repassword}")
	private String repassword;

	public String getUserid()
	{
		return userid;
	}

	public void setUserid(String userid)
	{
		this.userid = userid;
	}

	public String getName()
	{
		return name;
	}

	public void setName(String name)
	{
		this.name = name;
	}

	public String getPassword()
	{
		return password;
	}

	public void setPassword(String password)
	{
		this.password = password;
	}

	public String getRepassword()
	{
		return repassword;
	}

	public void setRepassword(String repassword)
	{
		this.repassword = repassword;
	}

	
}
