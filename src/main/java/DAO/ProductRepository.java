package DAO;

import java.util.ArrayList;
import java.util.List;

import DTO.Product;

public class ProductRepository {
	private List<Product> listOfProducts;
	{
		listOfProducts=new ArrayList<Product>();
	}
	
	public ProductRepository() {
		Product phone=new Product("P1234","iPhone 6s",800000);
		phone.setDescription("4.7-inch,1334X750 Retina HD display, 8-megapixel iSight Camera");
		phone.setCategory("Smart Phone");
		phone.setManufacturer("Apple");
		phone.setUnitsInStock(1000);
		phone.setConditions("New");
		
		Product notebook=new Product("P1235","LG PC 그램",150000);
		notebook.setDescription("4.7-inch,1334X750 Retina HD display, 8-megapixel iSight Camera");
		notebook.setCategory("Smart Phone");
		notebook.setManufacturer("LG");
		notebook.setUnitsInStock(1000);
		notebook.setConditions("Refurbished");
		
		Product tablet=new Product("P1236", "Galaxy Tab 5", 900000);
		tablet.setDescription("4.7-inch,1334X750 Retina HD display, 8-megapixel iSight Camera");
		tablet.setCategory("Tablet");
		tablet.setManufacturer("Samsung");
		tablet.setUnitsInStock(10000);
		tablet.setConditions("Old");
		
		listOfProducts.add(phone);
		listOfProducts.add(notebook);
		listOfProducts.add(tablet);
	}
	
	public ArrayList<Product> getAlleProducts(){
		return (ArrayList<Product>) listOfProducts;
	}
	

	
	
}
