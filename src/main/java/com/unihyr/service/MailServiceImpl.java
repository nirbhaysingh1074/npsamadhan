package com.unihyr.service;

import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
@Transactional
public class MailServiceImpl implements MailService
{
	@Autowired private JavaMailSender mailSender;
	
	
	public boolean sendMail(String to, String subject, String content)
	{
		try
		{
			MimeMessage mimeMessage = mailSender.createMimeMessage();
		    MimeMessageHelper message=new MimeMessageHelper(mimeMessage, true);
		    message.setBcc(InternetAddress.parse(to));
//		    message.setRecipients(Message.RecipientType.BCC,InternetAddress.parse(to));
		    message.setSubject(subject);
		    mimeMessage.setContent(content, "text/html");
		    mailSender.send(mimeMessage);
		    return true;
		}
		catch(MessagingException me)
		{
			me.printStackTrace();
		}
		return false;
	}
}
