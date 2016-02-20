package com.unihyr.model;


import javax.persistence.Lob;
import javax.validation.constraints.Min;

import org.hibernate.validator.constraints.NotBlank;
import org.springframework.web.multipart.MultipartFile;

import com.unihyr.domain.Industry;

public class PostModel 
{
	private long postId;
	
	@NotBlank(message="{NotBlank.postForm.title}")
	private String title;
	
	@NotBlank(message="{NotBlank.postForm.location}")
	private String location;
	
	@NotBlank(message="{NotBlank.postForm.function}")
	private String function;
	
	private int exp_min;
	
	private int exp_max;
	
	private int ctc_min;
	
	private int ctc_max;
	

	@NotBlank(message="{NotBlank.postForm.criteria}")
	private String criteria;
	
	@Lob
	private String comment;
	
	private String uploadjd;
	
	@Lob
	private String additionDetail;
	
	private MultipartFile file;
	
	public long getPostId() {
		return postId;
	}

	public void setPostId(long postId) {
		this.postId = postId;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public String getLocation() {
		return location;
	}

	public void setLocation(String location) {
		this.location = location;
	}

	public String getFunction() {
		return function;
	}

	public void setFunction(String function) {
		this.function = function;
	}

	public int getExp_min() {
		return exp_min;
	}

	public void setExp_min(int exp_min) {
		this.exp_min = exp_min;
	}

	public int getExp_max() {
		return exp_max;
	}

	public void setExp_max(int exp_max) {
		this.exp_max = exp_max;
	}

	public int getCtc_min() {
		return ctc_min;
	}

	public void setCtc_min(int ctc_min) {
		this.ctc_min = ctc_min;
	}

	public int getCtc_max() {
		return ctc_max;
	}

	public void setCtc_max(int ctc_max) {
		this.ctc_max = ctc_max;
	}

	public String getCriteria() {
		return criteria;
	}

	public void setCriteria(String criteria) {
		this.criteria = criteria;
	}

	public String getComment() {
		return comment;
	}

	public void setComment(String comment) {
		this.comment = comment;
	}

	public String getUploadjd() {
		return uploadjd;
	}

	public void setUploadjd(String uploadjd) {
		this.uploadjd = uploadjd;
	}

	public String getAdditionDetail() {
		return additionDetail;
	}

	public void setAdditionDetail(String additionDetail) {
		this.additionDetail = additionDetail;
	}

	public MultipartFile getFile()
	{
		return file;
	}

	public void setFile(MultipartFile file)
	{
		this.file = file;
	}
	
}	
