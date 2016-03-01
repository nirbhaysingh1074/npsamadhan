package com.unihyr.dao;

import java.util.List;

import org.hibernate.SessionFactory;
import org.hibernate.criterion.Restrictions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCrypt;
import org.springframework.stereotype.Repository;

import com.unihyr.domain.LoginInfo;
import com.unihyr.model.RegistrationForm;

@Repository
public class LoginInfoDaoImpl implements LoginInfoDao 
{
	@Autowired private SessionFactory sessionFactory;
	
	@Override
	public LoginInfo findUserById(String userid)
	{
		List<LoginInfo> logList = this.sessionFactory.getCurrentSession().createCriteria(LoginInfo.class).add(Restrictions.eq("userid", userid)).list();
		if(!logList.isEmpty())
		{
			return logList.get(0);
		}
		return null;
	}
	@Override
	public void addLoginInfo(LoginInfo login, RegistrationForm form) {
		String rawpwd=login.getPassword();
		System.out.println("rawpwd in logindao="+rawpwd);
		String encryptedpwd=BCrypt.hashpw(rawpwd, BCrypt.gensalt());
		System.out.println("encrypted pwd in logindao="+encryptedpwd);
		
		login.setPassword(encryptedpwd);
		login.setIsactive("false");
		this.sessionFactory.getCurrentSession().save(login);
		System.out.println("User added successfully");
	}
	
	@Override
	public void updateLoginInfo(LoginInfo loginInfo)
	{
		this.sessionFactory.getCurrentSession().update(loginInfo);
		this.sessionFactory.getCurrentSession().flush();
	}
	
	@Override
	public boolean checkUser(String userid, String password)
	{
		List<LoginInfo> logList = this.sessionFactory.getCurrentSession().createCriteria(LoginInfo.class).add(Restrictions.eq("userid", userid)).list();
		if(!logList.isEmpty())
		{
			return BCrypt.checkpw(password, logList.get(0).getPassword());
		}
		return false;
	}
	
	public boolean updatePassword(String userid, String password)
	{
		List<LoginInfo> logList = this.sessionFactory.getCurrentSession().createCriteria(LoginInfo.class).add(Restrictions.eq("userid", userid)).list();
		if(!logList.isEmpty())
		{
			LoginInfo info = logList.get(0);
			boolean status = BCrypt.checkpw(password, info.getPassword());
			if(status)
			{
				String encryptedpwd=BCrypt.hashpw(password, BCrypt.gensalt());
				info.setPassword(encryptedpwd);
				this.sessionFactory.getCurrentSession().update(info);
				return true;
			}
			
		}
		return false;
	}
	
}
