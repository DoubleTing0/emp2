<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "java.sql.*" %>
<%@ page import = "java.util.*" %>
<%@ page import = "vo.*" %>
<%
	// 1. controller
	
	// session 유효성 검증 코드 후 필요하다면 redirect
	if(session.getAttribute("loginEmp") == null) {
		
		response.sendRedirect(request.getContextPath() + "/loginForm.jsp");
		return;
	}
	
		

	// request 유효성 검증	
	// 정석으로 풀어서 쓴 것
	Object objLoginEmp = session.getAttribute("loginEmp");
	Employee loginEmp = (Employee) objLoginEmp;
	
	int currentPage = 1;
	if(request.getParameter("currentPage") != null) {
		currentPage = Integer.parseInt(request.getParameter("currentPage"));
	}
	
	String sort = "ASC";
	if(request.getParameter("sort") != null && request.getParameter("sort").equals("DESC")) {
		sort = "DESC";
	}
	
	
	
	
	
	
	
	// 2. model
	
	
	// page 처리 변수 선언 및 초기화
	int rowPerPage = 10;
	int beginRow = (currentPage - 1) * rowPerPage;
	
	int previousPage = (((currentPage - 1) / rowPerPage) * rowPerPage) - 9;
	int nextPage = (((currentPage - 1) / rowPerPage) * rowPerPage) + 11;
	
	int pageList = 0;
	
	
	// lastPage 알고리즘 코드
	
	
	
	
	// DB 접속 준비
	String driver = "org.mariadb.jdbc.Driver";
	String dbUrl = "jdbc:mariadb://localhost:3306/employees";
	String dbUser = "root";
	String dbPw = "java1234";
	
	// 드라이버 로딩
	Class.forName(driver);
	
	// DB 접속
	Connection conn = DriverManager.getConnection(dbUrl, dbUser, dbPw);
	
	// count
	
	// cntSql
	/* 
		SELECT COUNT(emp_no) cnt 
		FROM employees
	*/
	String cntSql = "SELECT COUNT(emp_no) cnt FROM employees";
	
	// cntSql 실행할 객체 생성
	PreparedStatement cntStmt = conn.prepareStatement(cntSql);
	
	// ResultSet 에 저장
	ResultSet cntRs = cntStmt.executeQuery();
	
	int count = 0;
	if(cntRs.next()) {
		count = cntRs.getInt("cnt");
	}
	
	int lastPage = count / rowPerPage;
	if((count % rowPerPage) != 0) {
		lastPage += 1;
	}
	
	
	
	// 2-2 list
	
	// 오름차순
	/*
		SELECT emp_no empNo, first_name firstName, last_name lastName
				, gender, birth_date birthDate, hire_date hireDate
		FROM employees
		ORDER BY first_name ASC
		LIMIT ?, ?
	*/
	String listSql = "SELECT emp_no empNo, first_name firstName, last_name lastName, gender, birth_date birthDate, hire_date hireDate FROM employees ORDER BY first_name ASC LIMIT ?, ?";
	
	
	if(sort.equals("DESC")) {
		// 내림차순
		/*
			SELECT emp_no empNo, first_name firstName, last_name lastName
				, gender, birth_date birthDate, hire_date hireDate 
			FROM employees
			ORDER BY first_name ASC
			LIMIT ?, ?
		*/
		listSql = "SELECT emp_no empNo, first_name firstName, last_name lastName, gender, birth_date birthDate, hire_date hireDate FROM employees ORDER BY first_name DESC LIMIT ?, ?";
	}
	
	// listSql 실행할 객체 생성
	PreparedStatement listStmt = conn.prepareStatement(listSql);

	listStmt.setInt(1, beginRow);
	listStmt.setInt(2, rowPerPage);
	
	// ResultSet 에 저장
	ResultSet listRs = listStmt.executeQuery();

	// 일반적인 사용을 위해 ArrayList 에 저장
	ArrayList<Employee> empList = new ArrayList<Employee>();
	while(listRs.next()) {
		Employee emp = new Employee();
		emp.setEmpNo(listRs.getInt("empNo"));
		emp.setFirstName(listRs.getString("firstName"));
		emp.setLastName(listRs.getString("lastName"));
		emp.setGender(listRs.getString("gender"));
		emp.setBirthDate(listRs.getString("birthDate"));
		emp.setHireDate(listRs.getString("hireDate"));
		empList.add(emp);
	}
	
	// DB 종료
	listRs.close();
	listStmt.close();
	conn.close();
	
	
%>	
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>사원 관리</title>
		
		
		<!-- Bootstrap5를 참조한다 시작-->
		
		<!-- Latest compiled and minified CSS -->
		<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.1/dist/css/bootstrap.min.css" rel="stylesheet">
		
		<!-- Latest compiled JavaScript -->
		<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.1/dist/js/bootstrap.bundle.min.js"></script>
		
		<!-- Bootstrap5를 참조한다 끝-->
		
		
	</head>
	
	<body>
		<div>
			<div>
				<h3><%=loginEmp.getLastName() %>(<%=loginEmp.getEmpNo() %>)님 반갑습니다.</h3>
				<a href = "<%=request.getContextPath() %>/logoutAction.jsp">로그아웃</a>
			</div>
		
		
		<div>
			<table>
				<tr>
					<th>사원 번호</th>
					<th>
						<sapn>사원 이름</sapn>
						<%
							if(sort.equals("ASC")) {
						%>
								<a href = "<%=request.getContextPath() %>/empList.jsp?currentPage=<%=currentPage %>&sort=DESC">내림차순</a>
						<%								
							} else {
						%>
								<a href = "<%=request.getContextPath() %>/empList.jsp?currentPage=<%=currentPage %>&sort=ASC">오름차순</a>
								
						<%
							}
						
						%>
					</th>
					<th>성별</th>
					<th>생일</th>
					<th>고용일</th>
				</tr>
				
					<%
						for(Employee e : empList) {
					%>
							<tr>
								<td><%=e.getEmpNo() %></td>
								<td><%=e.getFirstName() + " " + e.getLastName() %></td>
								<%
									if(e.getGender().equals("F")) {
								%>
										<td>&#128103;</td>
								<%
									} else {
								%>
										<td>&#128102;</td>
								<%
									}
								%>
								<td><%=e.getBirthDate() %></td>
								<td><%=e.getHireDate() %></td>
							</tr>
					<%
						}
					%>
				
			
			
			
			</table>
		
		</div>
		
		
		
		
		<ul class="pagination">
			
			<!-- 페이지 처음 -->
			<li class="page-item">
				<a class="page-link" href="<%=request.getContextPath() %>/empList.jsp?currentPage=1">
					<span>처음</span>
				</a>
			</li>
			
			
			<!-- 페이지 이전(-10의 1페이지) -->
			<%
				
				if(previousPage > 0) {
			%>
					<li class="page-item">
						<a class="page-link" href="<%=request.getContextPath() %>/empList.jsp?currentPage=<%=previousPage %>">
							<span>이전</span>
						</a>
					</li>
			<%
				}
			%>		
		
		  
		  	<!-- 페이지 1 ~ 9 -->
			<%
		  	
		  	for(int x=1; x<=10; x+=1) {
		  		pageList = (((currentPage - 1) / 10) * 10) + x;
			%>		
					<!-- 현재페이지만 구분하기 위한 active 속성 조건문-->
					<li 
						<%
							if(currentPage == pageList) {
						%>
								class = "page-item active"
						<%
							} else {
						%>
								class = "page-item"
						<%						
							}
						%>
					>
					
							<!-- 마지막 페이지까지만 출력하기 위한 조건문 -->					
							<%
								if(pageList <= lastPage) {
							%>
									<a class="page-link" href="<%=request.getContextPath() %>/empList.jsp?currentPage=<%=pageList %>">
										<span><%=pageList %></span>
									</a>
							<%
								}
							%>
					</li>
			<%  		
		  		
			}
		  
			%>
		  
		  	<!-- 페이지 다음 -->
			<%
				if(nextPage <= lastPage) {
			%>
					<li class="page-item">
						<a class="page-link" href="<%=request.getContextPath() %>/empList.jsp?currentPage=<%=nextPage %>">
							<span>다음</span>
						</a>
					</li>
			<%
				}
			%>
			
			
			<!-- 페이지 마지막 -->
			<li class="page-item">
				<a class="page-link" href="<%=request.getContextPath() %>/empList.jsp?currentPage=<%=lastPage%>">
					<span>마지막</span>
				</a>
			</li>
			
		  
		</ul>
		
		
		
		
		
		
		
		
		</div>
	</body>
</html>