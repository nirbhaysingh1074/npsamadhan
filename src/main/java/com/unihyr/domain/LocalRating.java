package com.unihyr.domain;

import java.util.Date;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.Lob;
import javax.persistence.ManyToOne;
import javax.persistence.Table;

@Entity
@Table(name="localRating")
public class LocalRating 
{
	@Id
	@Column(nullable=false)
	@GeneratedValue(strategy=GenerationType.AUTO)
	private long sn;
	
	@ManyToOne(cascade={CascadeType.ALL})
    @JoinColumn(name="ratingParamId", referencedColumnName="id")
	private RatingParameter ratingParameter;
	
	
	@ManyToOne(cascade={CascadeType.ALL})
    @JoinColumn(name="postId", referencedColumnName="postId")
	private Post post;
	
	
	@ManyToOne(cascade={CascadeType.ALL})
    @JoinColumn(name="consultantId", referencedColumnName="userId")
	private Registration registration;
	
	
	
	@Column(nullable=false)
	private String value;
	
	@Column(nullable=false)
	private Date dateOfRecord;
	
	@Column
	private int recordCount;

	public long getSn() {
		return sn;
	}

	public void setSn(long sn) {
		this.sn = sn;
	}

	public RatingParameter getRatingParameter() {
		return ratingParameter;
	}

	public void setRatingParameter(RatingParameter ratingParameter) {
		this.ratingParameter = ratingParameter;
	}

	public Post getPost() {
		return post;
	}

	public void setPost(Post post) {
		this.post = post;
	}

	public Registration getRegistration() {
		return registration;
	}

	public void setRegistration(Registration registration) {
		this.registration = registration;
	}

	public String getValue() {
		return value;
	}

	public void setValue(String value) {
		this.value = value;
	}

	public Date getDateOfRecord() {
		return dateOfRecord;
	}

	public void setDateOfRecord(Date dateOfRecord) {
		this.dateOfRecord = dateOfRecord;
	}

	public int getRecordCount() {
		return recordCount;
	}

	public void setRecordCount(int recordCount) {
		this.recordCount = recordCount;
	}
	

	
	
	
	
}
