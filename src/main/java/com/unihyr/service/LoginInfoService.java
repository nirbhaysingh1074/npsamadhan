package com.unihyr.service;

import com.unihyr.domain.LoginInfo;
import com.unihyr.model.RegistrationForm;

public interface LoginInfoService 
{
	public LoginInfo findUserById(String userid);
	
	public void addLoginInfo(LoginInfo login, RegistrationForm form);
	
	public void updateLoginInfo(LoginInfo loginInfo);
	
	public boolean checkUser(String userid, String password);
	
	public boolean updatePassword(String userid, String password);
}
