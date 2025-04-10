package product.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import product.dao.ProductDAO;
import product.dto.ProductDTO;
import view.command.CommandHandler;

public class ProductListHandler implements CommandHandler {
	@Override
	public String process(HttpServletRequest request, HttpServletResponse response) throws Exception {
		System.out.println("ProductListHandler 접근 성공");
        request.setCharacterEncoding("UTF-8");
        ProductDAO dao = new ProductDAO();
        List<ProductDTO>product = null;
        product = dao.selectProduct();
        System.out.println("product : "+ product);
        
        request.setAttribute("product", product);
		return "/WEB-INF/product/productList.jsp";

    }
	
	
}
