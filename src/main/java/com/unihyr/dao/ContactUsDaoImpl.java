package com.unihyr.dao;

import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.unihyr.domain.ContactUs;
@Repository
public class ContactUsDaoImpl implements ContactUsDao
{

	@Autowired SessionFactory sessionFactory;
	
	@Override
	public long addContactUsDetails(ContactUs contactUs)
	{
		this.sessionFactory.getCurrentSession().save(contactUs);
		return contactUs.getContactusid();
	}

}
