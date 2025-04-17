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
		System.out.println("ProductRegisterHandler접근 성공");
		// POST 요청일 때, 폼에서 입력 받은 데이터를 받는다
		String name = request.getParameter("productName");
		String description = request.getParameter("productDescription");
		String price = request.getParameter("productPrice");
		String quantity = request.getParameter("productQuantity");
		System.out.println("name : " + name);
		System.out.println("description : " + description);
		System.out.println("price : " + price);
		System.out.println("quantity : " + quantity);

		// ProductDTO 객체 생성
		ProductDTO product = new ProductDTO();
		product.setProductName(name);
		product.setProductDescription(description);
		product.setProductPrice(price);
		product.setProductQuantity(quantity);

		// ProductDAO를 통해 데이터베이스에 추가
		int result = productDAO.insertProduct(product);
		System.out.println("result : " + result);

		// 결과에 따라 성공적으로 추가된 후 제품 목록 페이지로 리다이렉트
		if (result > 0) {
			request.getSession().setAttribute("productRegisterSuccess", true );
		} else {
			// 실패시 에러 메시지를 설정하고 등록 페이지로 이동
			request.getSession().setAttribute("errorMessage", true);
		}
		return "/WEB-INF/product/productRegister.jsp"; // 다시 제품 등록 폼으로 돌아감
	}
}
