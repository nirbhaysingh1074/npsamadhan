package com.unihyr.service;

import javax.transaction.Transactional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.unihyr.dao.ContactUsDao;
import com.unihyr.domain.ContactUs;

@Service
@Transactional
public class ContactUsServiceImpl implements ContactUsService
{
	@Autowired ContactUsDao contactUsDao;
	
	public long addContactUsDetails(ContactUs contactUs){
		return contactUsDao.addContactUsDetails(contactUs);
	}
}
