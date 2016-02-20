package com.unihyr.dao;

import java.math.BigInteger;
import java.util.List;

import org.hibernate.FetchMode;
import org.hibernate.Query;
import org.hibernate.SQLQuery;
import org.hibernate.SessionFactory;
import org.hibernate.criterion.Restrictions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.unihyr.domain.CandidateProfile;
import com.unihyr.domain.Industry;
import com.unihyr.domain.Post;
import com.unihyr.domain.Registration;

@Repository
@SuppressWarnings("unchecked")
public class ProfileDaoImpl implements ProfileDao
{

	@Autowired
	private SessionFactory sessionFactory;

	@Override
	public long uploadProfile(CandidateProfile profile)
	{
		// TODO Auto-generated method stub
		try
		{
			sessionFactory.getCurrentSession().save(profile);
			this.sessionFactory.getCurrentSession().flush();
			return profile.getProfileId();
		} catch (Exception e)
		{
			e.printStackTrace();
			return 0;
		}
	}

	@Override
	public boolean updateProfile(CandidateProfile profile)
	{
		// TODO Auto-generated method stub
		try
		{
			sessionFactory.getCurrentSession().update(profile);
			this.sessionFactory.getCurrentSession().flush();
			return true;
		} catch (Exception e)
		{
			e.printStackTrace();
			return false;
		}

	}

	@Override
	public CandidateProfile getProfile(long id)
	{
		// TODO Auto-generated method stub
		List<CandidateProfile> list = (List<CandidateProfile>) this.sessionFactory.getCurrentSession()
				.createCriteria(CandidateProfile.class).add(Restrictions.eq("profileId", id))
				.setFetchMode("postionList", FetchMode.JOIN).list();
		if (!list.isEmpty())
		{
			return list.get(0);
		}
		return null;
	}

	@Override
	public List<Post> getPostListByConsultantIdInRange(String consultantId, int first, int max)
	{
		SQLQuery query = this.sessionFactory.getCurrentSession().createSQLQuery("SELECT distinct post.*  "
				+ "FROM post INNER JOIN profile_posts ON "
				+ "post.postId=profile_posts.postId  where profile_posts.profileId IN(select candidateprofile.profileId from candidateprofile where candidateprofile.consultantId=:consultantId)");
		// query.setInteger("age", 32);
		query.setString("consultantId", consultantId);
		query.addEntity(Post.class);
		System.out.println();

		return (List<Post>) query.list();
	}

	@Override
	public List<Registration> getDistinctClientListByConsultantId(String consultantId)
	{
		SQLQuery query = this.sessionFactory.getCurrentSession()
				.createSQLQuery("SELECT distinct registration.*  " + "FROM registration INNER JOIN post ON "
						+ "post.clientId=registration.userid  where post.postId "
						+ "IN(select profile_posts.postId from candidateprofile "
						+ " INNER JOIN profile_posts ON candidateprofile.profileId=profile_posts.profileId where candidateProfile.consultantId=:consultantId )");
		// query.setInteger("age", 32);
		query.setString("consultantId", consultantId);
		query.addEntity(Registration.class);
		System.out.println();

		return (List<Registration>) query.list();
	}

	@Override
	public List<CandidateProfile> getProfileListByConsultantIdInRange(String consultantId, int first, int max)
	{
		SQLQuery query = this.sessionFactory.getCurrentSession().createSQLQuery("SELECT distinct candidateprofile.* "
				+ "FROM candidateprofile  where candidateprofile.consultantId=:consultantId");
		// query.setInteger("age", 32);
		query.setString("consultantId", consultantId);
		query.addEntity(CandidateProfile.class);
		System.out.println();

		return (List<CandidateProfile>) query.list();
	}

	@Override
	public List<Post> getPostListByConsultantIdAndClientInRange(String consultantId, String clientId, int first,
			int max)
	{
		SQLQuery query = this.sessionFactory.getCurrentSession()
				.createSQLQuery("SELECT DISTINCT post . * " + "FROM post "
						+ "INNER JOIN profile_posts ON post.postId = profile_posts.postId "
						+ "WHERE profile_posts.profileId " + "IN ( " + "SELECT candidateprofile.profileId "
						+ "FROM candidateprofile " + "WHERE candidateprofile.consultantId = :consultantId" + ") "
						+ "AND post.clientId = :clientId");
		// query.setInteger("age", 32);
		query.setString("consultantId", consultantId);
		query.setString("clientId", clientId);
		query.addEntity(Post.class);
		System.out.println();

		return (List<Post>) query.list();
	}

	@Override
	public List<CandidateProfile> getProfileListByConsultantIdAndClientInRange(String consultantId, String clientId,
			int first, int max)
	{
		SQLQuery query = this.sessionFactory.getCurrentSession()
				.createSQLQuery("SELECT DISTINCT candidateprofile . * "
						+ "FROM candidateprofile INNER JOIN profile_posts "
						+ "ON candidateprofile.profileId = profile_posts.profileId " 
						+ "WHERE profile_posts.postId IN "
						+ "( SELECT post.postId FROM post " 
						+ "WHERE post.clientId = :clientId) "
						+ "AND candidateprofile.consultantId = :consultantId");
		// query.setInteger("age", 32);
		query.setString("clientId", clientId);
		query.setString("consultantId", consultantId);
		query.addEntity(CandidateProfile.class);
		System.out.println();
		return (List<CandidateProfile>) query.list();
	}

	@Override
	public List<CandidateProfile> getProfileList(int first, int max)
	{
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public List<CandidateProfile> getProfileListByConsultantIdAndPostIdInRange(String consultantId, String postId,
			int i, int j)
	{
		SQLQuery query = this.sessionFactory.getCurrentSession()
				.createSQLQuery("SELECT DISTINCT candidateprofile . * "
						+ "FROM candidateprofile INNER JOIN profile_posts "
						+ "ON candidateprofile.profileId = profile_posts.profileId " 
						+ "WHERE profile_posts.postId IN "
						+ "( SELECT post.postId FROM post " 
						+ "WHERE post.postId = :postId) "
						+ "AND candidateprofile.consultantId = :consultantId");
		// query.setInteger("age", 32);
		query.setString("postId", postId);
		query.setString("consultantId", consultantId);
		query.addEntity(CandidateProfile.class);
		System.out.println();
		return (List<CandidateProfile>) query.list();
	}

	@Override
	public List<CandidateProfile> getProfileListByConsultantIdAndClientAndPostIdInRange(String consultantId,
			String clientId, String postId, int i, int j)
	{
		SQLQuery query = this.sessionFactory.getCurrentSession()
				.createSQLQuery("SELECT DISTINCT candidateprofile . * "
						+ "FROM candidateprofile INNER JOIN profile_posts "
						+ "ON candidateprofile.profileId = profile_posts.profileId " 
						+ "WHERE profile_posts.postId IN "
						+ "( SELECT post.postId FROM post " 
						+ "WHERE post.clientId = :clientId and post.postId=:postId) "
						+ "AND candidateprofile.consultantId = :consultantId");
		// query.setInteger("age", 32);
		query.setString("clientId", clientId);
		query.setString("postId", postId);
		query.setString("consultantId", consultantId);
		query.addEntity(CandidateProfile.class);
		System.out.println();
		return (List<CandidateProfile>) query.list();
	}

	@Override
	public List<CandidateProfile> getProfilesByPost(String clientId)
	{
		String hql = "select pr.* from candidateProfile pr INNER JOIN profile_posts pp ON pr.profileId = pp.profileId AND pp.postId in(SELECT po.postId FROM post po LEFT JOIN registration reg ON reg.userid = po.clientId AND reg.userid LIKE :clientId)";
		SQLQuery query=this.sessionFactory.getCurrentSession().createSQLQuery(hql);          
		query.setParameter("clientId",clientId);
		query.addEntity(CandidateProfile.class);
		List<CandidateProfile> list = (List<CandidateProfile>)query.list();
		return list;
	}
	
	@Override
	public List<CandidateProfile> getProfilesByPost(String clientId, int first, int max)
	{
		String hql = "select pr.* from candidateProfile pr INNER JOIN profile_posts pp ON pr.profileId = pp.profileId AND pp.postId in(SELECT po.postId FROM post po LEFT JOIN registration reg ON reg.userid = po.clientId AND reg.userid LIKE :clientId)";
		SQLQuery query=this.sessionFactory.getCurrentSession().createSQLQuery(hql);          
		query.setParameter("clientId",clientId);
		query.addEntity(CandidateProfile.class).setFirstResult(first).setMaxResults(max);
		List<CandidateProfile> list = (List<CandidateProfile>)query.list();
		return list;
	}
	
	@Override
	public long countProfilesByPost(String clientId)
	{
		String sql = "select count(*) from candidateProfile pr INNER JOIN profile_posts pp ON pr.profileId = pp.profileId AND pp.postId in(SELECT po.postId FROM post po LEFT JOIN registration reg ON reg.userid = po.clientId AND reg.userid LIKE :clientId)";
		SQLQuery query=this.sessionFactory.getCurrentSession().createSQLQuery(sql);          
		query.setParameter("clientId",clientId);
		BigInteger count = (BigInteger)query.uniqueResult();
		return count.longValue();
	}
	
	@Override
	public List<CandidateProfile> getProfilesByPost(long postId, int first, int max)
	{
		String hql = "select pr.* from candidateProfile pr INNER JOIN profile_posts pp ON pr.profileId = pp.profileId AND pp.postId = :postId";
		SQLQuery query=this.sessionFactory.getCurrentSession().createSQLQuery(hql);          
		query.setParameter("postId",postId);
		query.addEntity(CandidateProfile.class).setFirstResult(first).setMaxResults(max);
		List<CandidateProfile> list = (List<CandidateProfile>)query.list();
		return list;
	}
	
	@Override
	public long countProfilesByPost(long postId)
	{
		String sql = "select count(*) from candidateProfile pr INNER JOIN profile_posts pp ON pr.profileId = pp.profileId AND pp.postId = :postId";
		SQLQuery query=this.sessionFactory.getCurrentSession().createSQLQuery(sql);          
		query.setParameter("postId",postId);
		BigInteger count = (BigInteger)query.uniqueResult();
		return count.longValue();
	}

	@Override
	public List<CandidateProfile> getProfilesByPostAndConsultant(String clientId, String consultid, long postId, int first, int max)
	{
		String hql = "select pr.* from candidateProfile pr INNER JOIN profile_posts pp ON pr.profileId = pp.profileId AND pr.consultantId=:consultid AND pp.postId = :postId AND pp.postId in(SELECT po.postId FROM post po LEFT JOIN registration reg ON reg.userid = po.clientId AND reg.userid LIKE :clientId)";
		SQLQuery query=this.sessionFactory.getCurrentSession().createSQLQuery(hql);          
		query.setParameter("postId",postId);
		query.setParameter("consultid",consultid);
		query.setParameter("clientId",clientId);
		query.addEntity(CandidateProfile.class).setFirstResult(first).setMaxResults(max);
		List<CandidateProfile> list = (List<CandidateProfile>)query.list();
		return list;
	}
	
	@Override
	public long countProfilesByPostAndConsultant(String clientId, String consultid, long postId)
	{
		String sql = "select count(*) from candidateProfile pr INNER JOIN profile_posts pp ON pr.profileId = pp.profileId AND pr.consultantId=:consultid AND pp.postId = :postId AND pp.postId in(SELECT po.postId FROM post po LEFT JOIN registration reg ON reg.userid = po.clientId AND reg.userid LIKE :clientId)";
		SQLQuery query=this.sessionFactory.getCurrentSession().createSQLQuery(sql);          
		query.setParameter("postId",postId);
		query.setParameter("consultid",consultid);
		query.setParameter("clientId",clientId);
		BigInteger count = (BigInteger)query.uniqueResult();
		return count.longValue();
	}

	@Override
	public List<CandidateProfile> getProfilesByConsultant(String clientId, String consultid, int first, int max)
	{
		String hql = "select pr.* from candidateProfile pr INNER JOIN profile_posts pp ON pr.profileId = pp.profileId AND pr.consultantId=:consultid AND pp.postId in(SELECT po.postId FROM post po LEFT JOIN registration reg ON reg.userid = po.clientId AND reg.userid LIKE :clientId)";
		SQLQuery query=this.sessionFactory.getCurrentSession().createSQLQuery(hql);          
		query.setParameter("consultid",consultid);
		query.setParameter("clientId",clientId);
		query.addEntity(CandidateProfile.class).setFirstResult(first).setMaxResults(max);
		List<CandidateProfile> list = (List<CandidateProfile>)query.list();
		return list;
	}
	
	@Override
	public long countProfilesByConsultant(String clientId, String consultid)
	{
		String sql = "select count(*) from candidateProfile pr INNER JOIN profile_posts pp ON pr.profileId = pp.profileId AND pr.consultantId=:consultid AND pp.postId in(SELECT po.postId FROM post po LEFT JOIN registration reg ON reg.userid = po.clientId AND reg.userid LIKE :clientId)";
		SQLQuery query=this.sessionFactory.getCurrentSession().createSQLQuery(sql);          
		query.setParameter("consultid",consultid);
		query.setParameter("clientId",clientId);
		BigInteger count = (BigInteger)query.uniqueResult();
		return count.longValue();
	}

}
