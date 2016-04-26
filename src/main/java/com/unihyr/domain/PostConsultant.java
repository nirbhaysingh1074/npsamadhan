package com.unihyr.domain;

import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;
import javax.persistence.UniqueConstraint;


@Entity
@Table(name="postconsultant", uniqueConstraints={ @UniqueConstraint( columnNames = { "postId", "lid" } ) } )
public class PostConsultant
{
	@Id
	@Column(nullable=false)
	@GeneratedValue(strategy=GenerationType.AUTO)
	private long pcid;
	
	@ManyToOne  
    @JoinColumn(name = "postId" , nullable= false)
	private Post post;
	
	@ManyToOne  
    @JoinColumn(name = "lid")
	private Registration consultant;

	@Column(nullable = false)
	private double turnAround;
	
	@Column(nullable = false)
	private double shortlistRatio;
	
	@Column(nullable = false)
	private double closureRatio;
	
	@Column(nullable = false)
	private double percentileTr;
	
	@Column(nullable = false)
	private double percentileSh;
	
	@Column(nullable = false)
	private double percentileCl;
	
	@Column(nullable = false)
	private double percentile;
	
	private Date createDate;

	
	public double getPercentileTr()
	{
		return percentileTr;
	}

	public void setPercentileTr(double percentileTr)
	{
		this.percentileTr = percentileTr;
	}

	public double getPercentileSh()
	{
		return percentileSh;
	}

	public void setPercentileSh(double percentileSh)
	{
		this.percentileSh = percentileSh;
	}

	public double getPercentileCl()
	{
		return percentileCl;
	}

	public void setPercentileCl(double percentileCl)
	{
		this.percentileCl = percentileCl;
	}

	public double getPercentile()
	{
		return percentile;
	}

	public void setPercentile(double percentile)
	{
		this.percentile = percentile;
	}

	public double getTurnAround()
	{
		return turnAround;
	}

	public void setTurnAround(double turnAround)
	{
		this.turnAround = turnAround;
	}

	public double getShortlistRatio()
	{
		return shortlistRatio;
	}

	public void setShortlistRatio(double shortlistRatio)
	{
		this.shortlistRatio = shortlistRatio;
	}

	public double getClosureRatio()
	{
		return closureRatio;
	}

	public void setClosureRatio(double closureRatio)
	{
		this.closureRatio = closureRatio;
	}

	public long getPcid()
	{
		return pcid;
	}

	public void setPcid(long pcid)
	{
		this.pcid = pcid;
	}

	public Post getPost()
	{
		return post;
	}

	public void setPost(Post post)
	{
		this.post = post;
	}

	public Registration getConsultant()
	{
		return consultant;
	}

	public void setConsultant(Registration consultant)
	{
		this.consultant = consultant;
	}

	public Date getCreateDate()
	{
		return createDate;
	}

	public void setCreateDate(Date createDate)
	{
		this.createDate = createDate;
	}
}
