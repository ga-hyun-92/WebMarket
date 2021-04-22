<%@page import="DAO.ProductRepository"%>
<%@page import="DTO.Product"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("UTF-8");

	String productId=request.getParameter("productId");
	String name=request.getParameter("name");
	String unitPrice=request.getParameter("unitPrice");
	int unitPrice_i=Integer.parseInt(unitPrice);
	String description=request.getParameter("description");
	String manufaturer=request.getParameter("manufaturer");
	String category=request.getParameter("category");
	String unitInStock=request.getParameter("unitInStock"); 
	int unitInStock_i=Integer.parseInt(unitInStock); 
	String condition=request.getParameter("condition");
	
	Product product=new Product(
								productId,name,unitPrice,description,manufaturer,
								category,unitInStock,condition);
	
	//상품정보 저장
	//ProductRepository 객체의 생성을 제한(싱글턴 패턴)
	ProductRepository pr=ProductRepository.getInstance();
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<%
	try{
		
		if(productId.length()==0)			 			throw new IllegalArgumentException("상품 코드 공란");
		else if(name.length()==0)						throw new IllegalArgumentException("상품명 공란"); 		
		else if(unitPrice.length()==0)					throw new IllegalArgumentException("가격 공란"); 		
		else if(unitInStock.length()==0)				throw new IllegalArgumentException("재고 수 공란");
		else if(description.length()==0)				throw new IllegalArgumentException("상품 정보 공란");
		else if(productId.length() !=5)					throw new IllegalArgumentException("상품 코드는 5자이어야 합니다");
		else if(name.length()>255)						throw new IllegalArgumentException("상품명은 255자 이하이어야 합니다");
		else if(unitPrice_i<0 || unitPrice_i>10000000)	throw new IllegalArgumentException("가격은 0원 이상 1천만원 이하여야 합니다");
		else if(unitInStock_i<0)						throw new IllegalArgumentException("재고수는 0개 이상이어야 합니다.");
		else {
%>
			<p>상품코드: <%=productId %> </p>
			<p>상품명: <%=name %> </p>
			<p>상품가격: <%=unitPrice %> </p>
			<p>상세정보: <%=description %> </p>
<%	
	}
	
		
	} catch(IllegalArgumentException e){
		//상품의 정보를 올바르게 입력하지 않았을 경우
		//1.상품의 정보를 입력하지 않았다
		//2.상품 코드는 5자여야합니다.
		//3.상품명은 255자 이하여야합니다.
		//4.가격은 0원 이상 1천만원 이하여야 합니다.
		//5.재고수는 0개 이상이어야 합니다.
		out.println("<p>상품정보가 올바르지 않습니다<a href=\"./addProduct.jsp\">되돌아가기</a></p>");
	}

%>


</body>
</html>