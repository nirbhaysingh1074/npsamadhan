package com.unihyr.domain;

import java.util.Date;
import java.util.Set;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.OneToMany;
import javax.persistence.Table;
import javax.persistence.UniqueConstraint;

@Entity
@Table(name="postprofile", uniqueConstraints={ @UniqueConstraint( columnNames = { "postId", "profileId" } ) } )
public class PostProfile
{
	@Id
	@Column(nullable=false)
	@GeneratedValue(strategy=GenerationType.AUTO)
	private long ppid;
	
	@ManyToOne  
    @JoinColumn(name = "postId" , nullable= false)
	private Post post;
	
	@ManyToOne  
    @JoinColumn(name = "profileId"  , nullable= false)
	private CandidateProfile profile;
	
	@Column(nullable=false)
	private Date submitted;
	
	@Column
	private Date accepted;
	
	@Column
	private Date rejected;

	public long getPpid()
	{
		return ppid;
	}

	public void setPpid(long ppid)
	{
		this.ppid = ppid;
	}

	public Post getPost()
	{
		return post;
	}

	public void setPost(Post post)
	{
		this.post = post;
	}

	public Date getSubmitted()
	{
		return submitted;
	}

	public void setSubmitted(Date submitted)
	{
		this.submitted = submitted;
	}

	public Date getAccepted()
	{
		return accepted;
	}

	public void setAccepted(Date accepted)
	{
		this.accepted = accepted;
	}

	public Date getRejected()
	{
		return rejected;
	}

	public void setRejected(Date rejected)
	{
		this.rejected = rejected;
	}

	public CandidateProfile getProfile()
	{
		return profile;
	}

	public void setProfile(CandidateProfile profile)
	{
		this.profile = profile;
	}
	
	@OneToMany(mappedBy="postProfile", cascade=CascadeType.ALL)  
	private Set<Inbox> messages;

	public Set<Inbox> getMessages()
	{
		return messages;
	}

	public void setMessages(Set<Inbox> messages)
	{
		this.messages = messages;
	}
	
	
	
}
