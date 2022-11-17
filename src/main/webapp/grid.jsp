<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%
	int a = 21;
	int b = 0;
	
		// 다음 b+11   이전 b-9
		for(int y =1; y<=10; y+=1) {
			b = (((a - 1) / 10 ) * 10) - 9;
		
			System.out.print(b + " ");
			
			
		}
			System.out.println("");
			
	


%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title></title>
		
		<!-- Bootstrap5를 참조한다 시작-->
		
		<!-- Latest compiled and minified CSS -->
		<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.1/dist/css/bootstrap.min.css" rel="stylesheet">
		
		<!-- Latest compiled JavaScript -->
		<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.1/dist/js/bootstrap.bundle.min.js"></script>
		
		<!-- Bootstrap5를 참조한다 끝-->
		
	</head>
	
	<body>
		
		<div class="container">
			<div class="row">
				<div class="col-2 bg-info">
					Column1
				</div>
				<div class="col-8 bg-danger">
					Column2
				</div>
				<div class="col-2 bg-primary">
					Column3
				</div>
			</div>
			
			<div class="row">
				<div class="col-2 bg-info">
					Column1
				</div>
				<div class="col-8 bg-danger">
					Column2
				</div>
				<div class="col-2 bg-primary">
					Column3
				</div>
			</div>
		</div>
				
		
	</body>
</html>