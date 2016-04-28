package com.unihyr.service;

public interface MailService
{
	public boolean sendMail(String to,String subject,  String content);
}
