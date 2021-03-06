<%@page import="java.util.Enumeration"%>
<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@page import="Exception.DuplicatedProductException"%>
<%@page import="DAO.ProductRepository"%>
<%@page import="DTO.Product"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ include file="/config.jsp"%>

<%
	request.setCharacterEncoding("UTF-8");
	

	String filename="";
	//프로젝트의 절대 경로
	String realFolder="C:\\Users\\ITPS\\eclipse-workspace\\.metadata\\.plugins\\org.eclipse.wst.server.core\\tmp0\\wtpwebapps\\WebMarket\\images2";
	//업로드될 파일의 최대 크기:5MB
	int maxSize=5*1024*1024;
	//인코딩 유형
	String encType="UTF-8";
	
	MultipartRequest multi=new MultipartRequest(request,realFolder,maxSize,encType,new DefaultFileRenamePolicy());
	
	
	String productId=multi.getParameter("productId");
	String name=multi.getParameter("name");
	String unitPrice=multi.getParameter("unitPrice");
	int unitPrice_i=Integer.parseInt(unitPrice);
	String description=multi.getParameter("description");
	String manufaturer=multi.getParameter("manufaturer");
	String category=multi.getParameter("category");
	String unitInStock=multi.getParameter("unitInStock"); 
	int unitInStock_i=Integer.parseInt(unitInStock); 
	String condition=multi.getParameter("condition");
	
	Enumeration files=multi.getFileNames();
	String fileName=(String)files.nextElement();
	fileName=multi.getFilesystemName(fileName);
	
	Product product=new Product(
			productId,name,unitPrice,description,manufaturer,
			category,unitInStock,condition,fileName);
	
	//상품정보 저장
	//ProductRepository 객체의 생성을 제한(싱글턴 패턴)
	ProductRepository pr=ProductRepository.getInstance();
	try{
		
		pr.addProduct(product);
		
		//상품 코드가 중복되지 않아서 성공적으로 상품정보를 저장했다면
		response.sendRedirect(PRODUCTS_PAGE_URL);
	}catch(DuplicatedProductException e){
		//상품 코드가 중복된다면
		response.sendRedirect(DUPLICATE_PRODUCT_PAGE_URL);
	}
	
	
	
	
	
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