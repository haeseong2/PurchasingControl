package product.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import product.dao.ProductDAO;
import product.dto.ProductDTO;
import view.command.CommandHandler;

public class ProductRegisterHandler implements CommandHandler {

	private ProductDAO productDAO = new ProductDAO();

	@Override
	public String process(HttpServletRequest request, HttpServletResponse response) throws Exception {
		request.setCharacterEncoding("UTF-8");
        String productName     	    = request.getParameter("productName");
        String productPrice    	    = request.getParameter("productPrice");
        String productQuantity 	    = request.getParameter("productQuantity");
        String productDescription   = request.getParameter("productDescription"); 
		
		// ProductDTO 객체 생성
		ProductDTO product = new ProductDTO();
		product.setProductName(productName);
		product.setProductDescription(productDescription);
		product.setProductPrice(productPrice);
		product.setProductQuantity(productQuantity);

		// ProductDAO를 통해 데이터베이스에 추가
		int result = productDAO.insertProduct(product);
		System.out.println("result : " + result);

		// 결과에 따라 성공적으로 추가된 후 제품 목록 페이지로 리다이렉트
		if (result > 0) {
			request.setAttribute("productRegisterSuccess", true);
		} else {
			// 실패시 에러 메시지를 설정하고 등록 페이지로 이동
			request.setAttribute("errorMessage", true);
		}
		return "/WEB-INF/product/productRegister.jsp"; // 다시 제품 등록 폼으로 돌아감
	}
}
