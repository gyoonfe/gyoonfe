package com.gyoontar.security;

import java.util.Collection;
import java.util.stream.Collectors;

import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.User;

import com.gyoontar.domain.MemberVO;

import lombok.Getter;

@Getter
public class CustomUser extends User {

	private static final long serialVersionUID = 1L;
	
	private MemberVO member;
	
	public CustomUser(String username, String password, Collection<? extends GrantedAuthority> authorities) {
		super(username, password, authorities);
	}
	
	public CustomUser(MemberVO vo) {
		super(vo.getUserid(), vo.getPass(), vo.getAuthList().stream()
				.map(auth -> new SimpleGrantedAuthority(auth.getAuth())).collect(Collectors.toList()));
				// AuthVO 인스턴스를 GrantedAuthority 객체로 변환하는 과정
		
		this.member = vo; // 변견 후, CustomUserDetailsService에서 CustomUser를 반환하도록 함.
	}
	
}
