<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/config.jsp" %>
<%
	String active=request.getParameter("active");

	String clientIP=request.getRemoteAddr();
	boolean isAdmin=adminIP.equals(clientIP);
	
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
					<li <%=welcomClass %>><a class="navbar-brand" href="<%=WELCOME_PAGE_URL%>">Home</a></li>
					<!-- ./welcome.jsp 는?? 현재 경로에서 welcome.jsp를 찾아라!!즉 상대경로임 -->
					<!-- /WebMarket/welcome.jsp 는?? 절대경로임-->
					<li <%=productsClass %>><a class="navbar-brand" href="<%=PRODUCTS_PAGE_URL%>">상품목록</a></li>
						
					<% if(isAdmin){ %>
					<li <%=addProductClass %>><a class="navbar-brand" href="<%=PRODUCT_ADD_PAGE_URL%>">상품등록</a></li>
					<% } %>
					
					<li><a class="navbar-brand" href="#">메뉴3</a></li>
				</ul>
			</div>
		</div>
	</nav>