<%@page import="DTO.Product"%>
<%@page import="DAO.ProductRepository"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>장바구니</title>
	<!-- 합쳐지고 최소화된 최신 CSS -->
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">
	<!-- 부가적인 테마 -->
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap-theme.min.css">
	<!-- 부트스트랩을 위한 jQuery -->>
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
	<!-- 합쳐지고 최소화된 최신 자바스크립트 -->
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.min.js"></script>
</head>
<body>
	<%@ include file="header.jsp" %>
	<div class="jumbotron">
		<div class="container">
			<h1 class="display-3">상품정보</h1>
		</div>
	</div>	
	
	<div class="container">
		<div class="row">
			<table width="100%">
				<tr>
					<td align="left">
						<a href="/WebMarket/cart/delete/all" class="btn btn-danger">삭제하기</a>
					</td>
					<td align="right">
						<a href="/WebMarket/cart/order" class="btn btn-success">주문하기</a>
					</td>
				</tr>
			</table>
		</div>
		<div style="padding-top: 50px;">
			<table class="table table-hover">
				<tr>
					<th>상품</th>
					<th>가격</th>
					<th>소계</th>
					<th>비고</th>
				</tr>
				
				<%
					ProductRepository pr =ProductRepository.getInstance();
					//pr을 활용해서 상품의 상세정보를 가져옴.
					
					ArrayList<String> elementList=(ArrayList<String>) session.getAttribute("goodsList");
					
					//비어있는 장바구니 만들기
					if(elementList==null){
						elementList=new ArrayList<String>();
					}
					
					//장바구니에 넣은 상품의 가격 합계
					int total=0;
					
					if(elementList.size()==0){
					%>
						<tr>
							<th colspan="4" style="text-align: center;">장바구니에 담긴 상품이 없습니다.</th>
						</tr>
					<% 	
					}
					
					for(String productId : elementList){
						//장바구니에 넣은 n번째 상품의 정보 
						Product product=pr.getProduct(productId);
						
						total+=product.getUnitPrice();
				%>
				<tr>
					<td><%=product.getName() %></td>
					<td><%=product.getUnitPrice() %></td>
					<td>1 X <%=product.getUnitPrice() %></td>
					<td>
						<a href="#" onclick="removeCart('<%=product.getProductId()%>')" class="badge badge-danger">삭제</a>
					</td>
				</tr>
				<%
					}
				%>
				<tr>
					<th colspan="2">총액</th>
					<th colspan="2"><%=total %></th>
				</tr>
			</table>
		</div>
	</div>
	
	
	<%@ include file="footer.jsp" %>
	
	<script>
	//사용자가 이 페이지로 접근하기 위해 주소 표시줄에 입력한 프로토콜 명
	//http 또는 https
	var protocol = location.protocol;
	//사용자가 이 페이지로 접근하기 위해 주소 표시줄에 입력한 도메인 명(도메인은 집주소와 같음)
	var domain =location.hostname;
	//사용자가 이 페이지로 접근하기 위해 주소 표시줄에 입력한 포트 번호
	//단, 포트번호는 없을 수 있음/ 포트 번호가 없다는 건 프로토콜의 기본 포트 번호를 사용했다는 것
	//기본 포트 번호- http의 경우, 80번이 기본 포트 번호/ https의 경우, 443번이 기본 포트 번호
	var port=location.port;
	
	//http://192.168.2.31:8081
	//http://localhost:8081  ->내 컴퓨터에 있는 8081번으로 접근해라
	//http://127.0.0.1:8081  ->내 컴퓨터에 있는 8081번으로 접근해라
	var THIS_SITE_FULL_DOMAIN = protocol+"//"+domain;
	
	if(port.length !=0 ){
		//포트번호를 입력하고 이 페이지에 접근했다면
		THIS_SITE_FULL_DOMAIN += (":"+port);
	}

		function removeCart(productId){
			//jQuery-> $로 표시
			$.ajax({
				//서블릿 주소
				url: THIS_SITE_FULL_DOMAIN+"/WebMarket/cart/delete",
				//삭제할 상품의 아이디를 전달
				data: "productId="+productId,
				success: function(){
					alert("상품을 삭제했습니다");
					//자바스크립트 코드 reload-> 페이지 새로고침
					locaiton.reload();
				},
				error: function(){
					alert("상품을 삭제하지 못했습니다.\n잠시후 다시 시도해주세요/")
				}
			})
		}
	
	</script>
</body>
</html>