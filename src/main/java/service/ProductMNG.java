package service;

import java.io.IOException;
import java.util.Enumeration;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

import DAO.ProductRepository;
import DTO.Product;
import Exception.DuplicatedProductException;

/**
 * Servlet implementation class ProductMNG
 */
@WebServlet("/productMNG")
public class ProductMNG extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ProductMNG() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		response.getWriter().append("Served at: ").append(request.getContextPath());
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		request.setCharacterEncoding("UTF-8");
		String filename="";
		String realFolder="C:\\Users\\ITPS\\eclipse-workspace\\.metadata\\.plugins\\org.eclipse.wst.server.core\\tmp0\\wtpwebapps\\WebMarket\\images2";//프로젝트의 절대경로 지정
		int maxSize=5*1024*1024;
		String encType="UTF-8";
		
		MultipartRequest multi=new MultipartRequest(request, realFolder,maxSize,encType,new DefaultFileRenamePolicy());
		
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
		
		Enumeration<String> files= multi.getFileNames();
		String fileName=files.nextElement();
		fileName=multi.getFilesystemName(fileName);//실제로 서버에 저장된 파일의 이름을 가져옴
		
		Product product=new Product(
				productId,name,unitPrice,description,manufaturer,
				category,unitInStock,condition,fileName);
		
		ProductRepository pr=ProductRepository.getInstance();
		try {
			//상품정보 저장
			pr.addProduct(product);
			
			//상품코드가 중복되지 않아서 성공적으로 상품 정보를 저장했다면
			//상품 목록 페이지로 이동
			response.sendRedirect("/WebMarket/Products.jsp?active=Products");
			//상품 목록 페이지로 이동->RequestDispatcher를 사용해서 포워딩을 함->제어만 이동(url바뀌지 않음)
//			RequestDispatcher dis=request.getRequestDispatcher("/Products.jsp");
//			dis.forward(request, response);
		} catch (DuplicatedProductException e) {
			//상품 코드가 중복됐다면
			//상품 코드 중복 페이지로 이동->페이지 자체가 이동(url바뀜)
			response.sendRedirect("/WebMarket/error/duplicate.jsp?active=addProduct");
		}
		
	}

}
