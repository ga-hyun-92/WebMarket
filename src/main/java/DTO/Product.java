package DTO;

import java.io.Serializable;

//주로 사용하는 패키지
//dto- 데이터를 저장하거나 저장된 데이터를 받아오는 클래스를 넣어둠
//dao- dto를 사용해서 데이터베이스에 데이터를 저장하거나 추가하거나 수정하는 등의 역할을 하는 클래스를 넣어둠

public class Product implements Serializable{

	private static final long serialVersionUID = -3889460466461175832L;

	private String productId;		//상품 아이디
	private String name;			//상품명
	private int unitPrice;			//상품 가격
	private String description;		//상품 설명
	private String manufacturer;	//제조사
	private String category;		//분류
	private long unitsInStock;		//재고 수
	private String conditions;		//신상품 or 중고품 or 재생품
	
	public Product(String productId,String name,int unitPrice) {
		setProductId(productId);
		setName(name);
		setUnitPrice(unitPrice);
	}
	

	
	public Product(String productId,String name,String unitPrice,String description, String manufaturer, 
					String category,String unitInStock,String condition) 
	{
//		if (productId.length()==0) throw new IllegalArgumentException("상품 코드 공란");
		this.productId=productId;
		this.name=name;
		this.unitPrice=Integer.parseInt(unitPrice);
		this.description=description;
		this.manufacturer=manufaturer;
		this.category=category;
		this.unitsInStock=Integer.parseInt(unitInStock);
		this.conditions=condition;
	}
	
	public String getProductId() {
		return productId;
	}
	public void setProductId(String productId) {
		this.productId = productId;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public int getUnitPrice() {
		return unitPrice;
	}
	public void setUnitPrice(int unitPrice) {
		this.unitPrice = unitPrice;
	}
	public String getDescription() {
		return description;
	}
	public void setDescription(String description) {
		this.description = description;
	}
	public String getManufacturer() {
		return manufacturer;
	}
	public void setManufacturer(String manufacturer) {
		this.manufacturer = manufacturer;
	}
	public String getCategory() {
		return category;
	}
	public void setCategory(String category) {
		this.category = category;
	}
	public long getUnitsInStock() {
		return unitsInStock;
	}
	public void setUnitsInStock(long unitsInStock) {
		this.unitsInStock = unitsInStock;
	}
	public String getConditions() {
		return conditions;
	}
	public void setConditions(String conditions) {
		this.conditions = conditions;
	}
	
	
}
