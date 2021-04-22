<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	String active=request.getParameter("active");
	String welcomClass="";
	String productsClass="";
	String addProductClass="";
	if(active==null || active.equals("welcome")){
		welcomClass="class=\"active\"";
	} else if(active.equals("Products")){
		productsClass="class=\"active\"";
	} else if(active.equals("addProduct")){
		addProductClass="class=\"active\"";
	}
%>


	<nav class="navbar navbar-fixed-top navbar-inverse">
		<div class="container">
			<div class="collapse navbar-collapse" id="navbar">
				<ul class="nav navbar-nav">
					<li <%=welcomClass %>><a class="navbar-brand" href="./welcome.jsp?active=welcome">Home</a></li>
					<li <%=productsClass %>><a class="navbar-brand" href="./Products.jsp?active=Products">상품목록</a></li>
					<li <%=addProductClass %>><a class="navbar-brand" href="./addProduct.jsp?active=addProduct">상품등록</a></li>
					<li><a class="navbar-brand" href="#">메뉴3</a></li>
				</ul>
			</div>
		</div>
	</nav>