<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "java.sql.*" %>
<%@ page import = "java.util.*" %>
<%@ page import = "java.net.*" %>
<%@ page import = "vo.*" %>
<%
	// 인코딩 : UTF-8
	request.setCharacterEncoding("UTF-8");
%>
<%
	// 1. controller

	

	// request 유효성 검증
	
	String strEmpNo = request.getParameter("empNo");
	String firstName = request.getParameter("firstName");
	String lastName = request.getParameter("lastName");
	
	if(strEmpNo == null || firstName == null || lastName == null 
			|| strEmpNo.equals("") || firstName.equals("") || lastName.equals("")) {
		
		String loginMsg = URLEncoder.encode("모든 항목을 올바르게 입력해주세요.", "UTF-8");
		response.sendRedirect(request.getContextPath() + "/loginForm.jsp?loginMsg=" + loginMsg);
		return;
	}
	
	// empNo int 형변환
	int empNo = Integer.parseInt(strEmpNo);
	
	// VO setter 호출
	Employee employee = new Employee();
	employee.setEmpNo(empNo);
	employee.setFirstName(firstName);
	employee.setLastName(lastName);
	
	// 2. model
	
	// DB 접속 준비
	String driver = "org.mariadb.jdbc.Driver";
	String dbUrl = "jdbc:mariadb://localhost:3306/employees";
	String dbUser = "root";
	String dbPw = "java1234";
	
	// 드라이버 로딩
	Class.forName(driver);
	
	// DB 접속
	Connection conn = DriverManager.getConnection(dbUrl, dbUser, dbPw);
	
	
	// loginSql
	/*
		SELECT emp_no empNo, emp_lastname lastName
		FROM employee
		WHERE emp_no = ? AND emp_firstname = ? AND emp_lastName = ?
	*/
	
	String loginSql = "SELECT emp_no empNo, last_name lastName FROM employees WHERE emp_no = ? AND first_name = ? AND last_Name = ?";
	
	// loginSql 실행할 객체 생성
	PreparedStatement loginStmt = conn.prepareStatement(loginSql);
	
	// getter 사용
	loginStmt.setInt(1, employee.getEmpNo());
	loginStmt.setString(2, employee.getFirstName());
	loginStmt.setString(3, employee.getLastName());
	
	// ResultSet 에 저장
	ResultSet loginRs = loginStmt.executeQuery();
	
	String targetUrl = "/loginForm.jsp";
	if(loginRs.next()) {
		// 로그인 성공
		Employee loginEmp = new Employee();
		loginEmp.setEmpNo(loginRs.getInt("empNo"));
		loginEmp.setLastName(loginRs.getString("lastName"));
		
		// 키 : "loginEmp", 값 Object object = loginEmp;
		session.setAttribute("loginEmp", loginEmp); 
		
		
		targetUrl = "/empList.jsp";
		
		
	}
	
	// targetUrl redirect
	response.sendRedirect(request.getContextPath() + targetUrl);
	
	
	
	
	// 3. view
	
	
	
%>
