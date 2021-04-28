/**
 * 
 */

function checkAddProduct(){
	
	var productId=document.getElementById("productId");
	var name=document.getElementById("name");
	var unitPrice=document.getElementById("unitPrice");
	var unitInStock=document.getElementById("unitInStock");
	
	//P로 시작, 숫자로 끝나도록, 최소 4자, 최대 11자
	var regExpProductId=/^P[0-9]{4,11}$/;
	if(!regExpProductId.test(productId.value)){
		alert("[상품코드]\n최소 4자에서 최대 11자까지 입력하세요");
		productId.focus();
		return false;
	}
	
	if(name.value.length<4||name.value.length>12){
		alert("[상품명]\n최소 4자에서 최대 12자까지 입력하세요");
		name.focus();
		return false;
	}
	
	if(unitPrice.value.length==0||isNaN(unitPrice.value)){
		alert("[가격]\n숫자만 입력하세요");
		unitPrice.focus();
		return false;
	}
	
	if(isNaN(unitInStock.value)){
		alert("[재고]\n숫자만 입력하세요");
		unitInStock.focus();
		return false;
	}
	
	document.newProduct.submit();
}