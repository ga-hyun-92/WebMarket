package DAO;

import java.util.ArrayList;
import java.util.List;

import DTO.Product;
import Exception.DuplicatedProductException;

public class ProductRepository {
	private List<Product> listOfProducts;
	{
		listOfProducts=new ArrayList<Product>();
	}
	
	//클래스의 멤버 변수로 자기 자신을 갖고 있음
	private static ProductRepository productRepository;
	static {
		productRepository=new ProductRepository();
	}
	
	//클래스 멤버 변수로 선언되어있는 자기 자신(이 클래스의 인스턴스)을
	//반환하는 메서드
	//메서드를 통해서 클래스 인스턴스를 얻어서 사용하는 방법: 싱글턴 패턴
	public static ProductRepository getInstance() {
		return productRepository;
	}
	
	//생성자의 접근 제어자가 private인 생성자의 의미??
	//클래스의 외부에서 인스턴스를 만들수 없음
	private ProductRepository() {
		Product phone=new Product("P1234","iPhone 6s",800000);
		phone.setDescription("4.7-inch,1334X750 Retina HD display, 8-megapixel iSight Camera");
		phone.setCategory("Smart Phone");
		phone.setManufacturer("Apple");
		phone.setUnitsInStock(1000);
		phone.setConditions("New");
		phone.setImagePath("P1234.jpg");
		
		Product notebook=new Product("P1235","LG PC 그램",1500000);
		notebook.setDescription("13.3-inch,IPS LED display, 5rd Generation Intel Core processors");
		notebook.setCategory("notebook");
		notebook.setManufacturer("LG");
		notebook.setUnitsInStock(1000);
		notebook.setConditions("Refurbished");
		notebook.setImagePath("P1235.jpg");
		
		Product tablet=new Product("P1236", "Galaxy Tab 5", 900000);
		tablet.setDescription("212.8*125.6*6.6mm,Super AMOLED display, Octa-Core processor");
		tablet.setCategory("Tablet");
		tablet.setManufacturer("Samsung");
		tablet.setUnitsInStock(10000);
		tablet.setConditions("Old");
		tablet.setImagePath("P1235.jpg");
		
		listOfProducts.add(phone);
		listOfProducts.add(notebook);
		listOfProducts.add(tablet);
	}
	
	public ArrayList<Product> getAlleProducts(){
		return (ArrayList<Product>) listOfProducts;
	}
	
	public Product getProduct(String productId) {
		Product product=null;
		//사용자가 원하는 상품의 상세 정보를 가져오는 코드
		//product 객체에 저장하는 코드
		//먼저는 사용자가 원하는 상품을 Id로 찾는다.
		for(Product nthProduct:listOfProducts) {
			String nthProductId=nthProduct.getProductId();
			
			if (nthProductId.equals(productId)) {
				product=nthProduct;
				break;
			}
		}
		
		return product;
	}
	
	//상품추가
	public void addProduct(Product product) throws DuplicatedProductException{	
		
		for(Product nthProduct:listOfProducts) {
			String nthProductId=nthProduct.getProductId();
			
			if (nthProductId.equals(product.getProductId())) {
				throw new DuplicatedProductException(product.getProductId()+"가 중복되었음");
			}
		}
		
		listOfProducts.add(product);
		
	}
		
	
}
