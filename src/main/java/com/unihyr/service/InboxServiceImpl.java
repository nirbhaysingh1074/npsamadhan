package com.unihyr.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.unihyr.dao.InboxDao;
import com.unihyr.domain.Inbox;

@Service
@Transactional
public class InboxServiceImpl implements InboxService
{
	@Autowired private InboxDao inboxDao;
	
	public long addInboxMessage(Inbox inbox)
	{
		return this.inboxDao.addInboxMessage(inbox);
	}
	
	public boolean updateInboxMessage(Inbox inbox)
	{
		return this.inboxDao.updateInboxMessage(inbox);
	}
	
	public List<Inbox> getInboxMessages(long ppid, int first, int max)
	{
		return this.inboxDao.getInboxMessages(ppid, first, max);
	}
	
	public boolean setViewedByClient(long ppid)
	{
		return this.inboxDao.setViewedByClient(ppid);
	}
	
	public boolean setViewedByConsultant(long ppid)
	{
		return this.inboxDao.setViewedByConsultant(ppid);
	}
}
