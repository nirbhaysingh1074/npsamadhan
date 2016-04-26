package com.unihyr.dao;

import com.unihyr.domain.LoginInfo;
import com.unihyr.model.RegistrationForm;

public interface LoginInfoDao 
{
	public LoginInfo findUserById(String userid);
	
	public void addLoginInfo(LoginInfo loginInfo, RegistrationForm form);
	
	public void updateLoginInfo(LoginInfo loginInfo);
	
	public boolean checkUser(String userid, String password);
	
	public boolean updatePassword(String userid, String oldPassword, String password);
	
}
