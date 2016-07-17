package com.unihyr.service;

import java.util.List;


import com.unihyr.domain.Qualification;

/**
 * To perform all actions regarding qualification like add, edit, delete qualification details.
 * @author silvereye
 */
public interface QualificationService
{
	/**
	 * to save new qualification to database
	 * @param qualification to be saved
	 * @return true if saved successfully, false if error occurred
	 */
	Boolean addQualification(Qualification qualification);
	
	/**
	 * to update details of particular Qualification
	 * @param qualification object of Qualification with updated values
	 * @return true if updated successfully, false if not
	 */
	Boolean editQualification(Qualification qualification);
	/**
	 * to delete details of particular Qualification
	 * @param qualification object of Qualification to be deleted
	 * @return true if updated successfully, false if not
	 */
	Boolean deleteQualification(Qualification qualification);
	/**
	 * method to get all type of qualifications
	 * @return list of qualification from database
	 */
	List<Qualification> getAllQualification();

	List<Qualification>  getAllUGQualification(); 
	List<Qualification>  getAllPGQualification(); 
}
