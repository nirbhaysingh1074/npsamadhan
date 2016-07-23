package com.unihyr.service;

import java.io.File;

import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.io.FileSystemResource;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.unihyr.constraints.GeneralConfig;

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
		    message.setCc(InternetAddress.parse(GeneralConfig.admin_email));
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
	
	@Override
	public boolean sendMail(String to, String subject, String content, String pathToStore, File attachement)
	{
		try
		{
			MimeMessage mimeMessage = mailSender.createMimeMessage();
		    MimeMessageHelper message=new MimeMessageHelper(mimeMessage, true);
		    message.setBcc(InternetAddress.parse(to));
		    message.setCc(InternetAddress.parse(GeneralConfig.admin_email));
		    message.setText(content,true);

		    FileSystemResource file = new FileSystemResource(attachement);
		    message.addAttachment(pathToStore, file);
		    message.setSubject(subject);
		    //mimeMessage.setContent(content, "multipart/alternative");
		    mailSender.send(mimeMessage);
		    return true;
		    

		
//				  BodyPart messageBodyPart = new MimeBodyPart();
//	  
//			      BodyPart messageBodyPart1 = new MimeBodyPart();  
//			        // messageBodyPart1.setText(cnt);  
//			         messageBodyPart1.setContent(cnt,"text/html; charset=UTF-8");
//			         Multipart multipart = new MimeMultipart();  
//			         multipart.addBodyPart(messageBodyPart1);
//			        
//			        for(int i=0; i< atchfile.size(); i++ )
//			        {
//			        	
//			         MimeBodyPart messageBodyPart2 = new MimeBodyPart();  
//			         
//			       //  String filename = "C:\\Users\\nirbhay\\AppData\\Local\\Temp\\"+atchnewfile.get(i);
//			         
//			         String filename = filePath+atchnewfile.get(i);
//			         DataSource source = new FileDataSource(filename);
//			         messageBodyPart2.setDataHandler(new DataHandler(source));  
//			         messageBodyPart2.setFileName(atchfile.get(i)); 
//			         
//			         multipart.addBodyPart(messageBodyPart2);
//			        
//			        
//			        }
//			        
//			         message.setContent(multipart , "multipart/alternative");  
//				 
//			         
//				
//			    Transport.send(message);
		    
		    
		    
		    
		}
		catch(MessagingException me)
		{
			me.printStackTrace();
		}
		return false;
	}
}
