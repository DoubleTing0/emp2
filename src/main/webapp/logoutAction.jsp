<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	
	// 1. controller
	
	//session 유효성 검증 코드 후 필요하다면 redirect
		
	session.invalidate();
	response.sendRedirect(request.getContextPath() + "/loginForm.jsp");
%>
