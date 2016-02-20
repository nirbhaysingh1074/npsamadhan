package com.unihyr.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import com.unihyr.dao.LoginInfoDao;
import com.unihyr.domain.LoginInfo;
import com.unihyr.model.RegistrationForm;

@Service
@Transactional
public class LoginInfoServiceImpl implements LoginInfoService
{
	@Autowired private LoginInfoDao loginInfoDao;
	
	@Override
	public LoginInfo findUserById(String userid)
	{
		return loginInfoDao.findUserById(userid);
	}
	
	@Override
	public void addLoginInfo(LoginInfo login, RegistrationForm form) {
		loginInfoDao.addLoginInfo(login,form);
	}
	
	@Override
	public void updateLoginInfo(LoginInfo loginInfo)
	{
		loginInfoDao.updateLoginInfo(loginInfo);
	}
}
