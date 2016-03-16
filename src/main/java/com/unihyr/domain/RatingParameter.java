package com.unihyr.domain;

import java.util.Date;
import java.util.HashSet;
import java.util.Set;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.OneToMany;
import javax.persistence.Table;

import org.hibernate.annotations.NotFound;

@Entity
@Table(name = "ratingParameter")
public class RatingParameter
{
	@Id
	@Column(nullable = false)
	@GeneratedValue(strategy = GenerationType.AUTO)
	private int id;

	@Column(nullable = false, unique = true)
	private String name;

	@Column(nullable = false)
	private Date createDate;

	@Column
	private Date modifyDate;

	@Column
	private Date deleteDate;
	
	@Column
	private double weightage;

	public double getWeightage()
	{
		return weightage;
	}

	public void setWeightage(double weightage)
	{
		this.weightage = weightage;
	}

	public int getId()
	{
		return id;
	}

	public void setId(int id)
	{
		this.id = id;
	}

	public String getName()
	{
		return name;
	}

	public void setName(String name)
	{
		this.name = name;
	}

	public Date getCreateDate()
	{
		return createDate;
	}

	public void setCreateDate(Date createDate)
	{
		this.createDate = createDate;
	}

	public Date getModifyDate()
	{
		return modifyDate;
	}

	public void setModifyDate(Date modifyDate)
	{
		this.modifyDate = modifyDate;
	}

	public Date getDeleteDate()
	{
		return deleteDate;
	}

	public void setDeleteDate(Date deleteDate)
	{
		this.deleteDate = deleteDate;
	}

}
