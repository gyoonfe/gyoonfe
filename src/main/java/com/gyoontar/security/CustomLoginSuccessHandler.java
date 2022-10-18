package com.gyoontar.security;

import java.io.IOException;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.security.core.Authentication;
import org.springframework.security.core.userdetails.User;
import org.springframework.security.web.authentication.AuthenticationSuccessHandler;

import lombok.extern.log4j.Log4j;

@Log4j
public class CustomLoginSuccessHandler implements AuthenticationSuccessHandler{
	
	@Override
	public void onAuthenticationSuccess(HttpServletRequest request, HttpServletResponse response, Authentication auth)
			throws IOException, ServletException {
		
		log.warn("LOGIN SUCCESS !!!");
		
		List<String> roleNames = new ArrayList<>();
		
		auth.getAuthorities().forEach(authority -> {
			roleNames.add(authority.getAuthority());
		});
		
		log.warn("ROLE NAMES : " + roleNames);
		//Session 추가
		User user = (User)auth.getPrincipal();
		HttpSession session = request.getSession();
		session.setAttribute("session_role", roleNames);
		session.setAttribute("session_userid", user.getUsername());
		session.setAttribute("seesion_pass", user.getPassword());
		
		
		if(roleNames.contains("ROLE_ADMIN")) {
			response.sendRedirect("/");
			return;
			//만약 사용자가 ROLE_ADMIN 권한을 가졌다면 로그인 후에 바로 '/sample/admin'으로 이동하게 하는 방식입니다.
		}
		
		if(roleNames.contains("ROLE_MEMBER")) {
			response.sendRedirect("/");
			return;
		}
		
		response.sendRedirect("/");
		
	}
}
