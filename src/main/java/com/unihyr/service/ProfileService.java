package com.unihyr.service;

import java.util.List;

import com.unihyr.domain.CandidateProfile;
import com.unihyr.domain.Post;
import com.unihyr.domain.Registration;

public interface ProfileService
{

	public long uploadProfile(CandidateProfile profile);

	public boolean updateProfile(CandidateProfile profile);

	public CandidateProfile getProfile(long id);

	public List<Registration> getDistinctClientListByConsultantId(String consultantId);

	public List<CandidateProfile> getProfileList(int first, int max);
	
	public List<CandidateProfile> getProfilesByPost(String clientId);
	
	public List<CandidateProfile> getProfilesByPost(String clientId, int first, int max);
	
	public long countProfilesByPost(String clientId);
	
	public List<CandidateProfile> getProfilesByPost(long postId, int first, int max);
	
	public long countProfilesByPost(long postId);

	public List<CandidateProfile> getProfilesByPostAndConsultant(String clientId, String consultid, long postId, int first, int max);
	
	public long countProfilesByPostAndConsultant(String clientId, String consultid, long postId);

	public List<CandidateProfile> getProfilesByConsultant(String clientId, String consultid, int first, int max);
	
	public long countProfilesByConsultant(String clientId, String consultid);

	public List<CandidateProfile> getProfileListByConsultantIdInRange(String consultantId, int first, int max);

	public List<Post> getPostListByConsultantIdInRange(String consultantId, int first, int max);

	/*public List<Registration> getDistinctClientListByConsultantIdAndClient(String consultantId, String profileId);
*/
	public List<CandidateProfile> getProfileListByConsultantIdAndClientInRange(String consultantId, String profileId,
			int first, int max);

	public List<Post> getPostListByConsultantIdAndClientInRange(String consultantId, String profileId, int first,
			int max);

	public  List<CandidateProfile>  getProfileListByConsultantIdAndPostIdInRange(String consultantId, String postId, int i, int j);

	public  List<CandidateProfile>  getProfileListByConsultantIdAndClientAndPostIdInRange(String consultantId, String clientId, String postId,
			int i, int j);
}
