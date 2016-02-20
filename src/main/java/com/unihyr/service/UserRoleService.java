package com.unihyr.service;

import com.unihyr.domain.UserRole;

public interface UserRoleService 
{
	public UserRole getRoleByUserId(String userid);
	
	public int addUserRole(UserRole userrole, String role);
}
