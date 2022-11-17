<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "java.sql.*" %>
<%@ page import = "java.util.*" %>
<%
	// 인코딩 : UTF-8
	request.setCharacterEncoding("UTF-8");
%>

<%
	// 1. controller
	
	// 세션 유효성 검증 코드 후 필요하다면 redirect
	// 이미 로그인이 되어있다면 empList redirect
	if(session.getAttribute("loginEmp") != null) {
		
		response.sendRedirect(request.getContextPath() + "/empList.jsp");
		return;
	}

	// request
	
	String loginMsg = request.getParameter("loginMsg");

%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>Emp 로그인</title>
		
		<script type = "text/javascript">
			<%
				if(loginMsg != null) {
					System.out.println(123);
			%>
						alert("<%=loginMsg %>");
			<%
				}
			%>
		</script>	
		
		
	</head>
	
	<body>
		<div>
			<div>
				<h1>로그인</h1>
			</div>
		
			<div>
				<form action = "<%=request.getContextPath() %>/loginAction.jsp" method = "post">
					<div>
						<table>
							<tr>
								<th>empNo</th>
								<td>
									<input type = "text" name = "empNo">
								</td>
							</tr>
							
							<tr>
								<th>firstName</th>
								<td>
									<input type = "text" name = "firstName">
								</td>
							</tr>
							
							<tr>
								<th>lastName</th>
								<td>
									<input type = "text" name = "lastName">
								</td>
							</tr>
							
						</table>
					</div>
				
					<div>
						<button type = "submit">로그인</button>
					</div>
				</form>
				
		
			</div>
			
				
		
		</div>
	</body>
</html>