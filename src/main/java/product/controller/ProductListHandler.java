package product.controller;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import product.dao.ProductDAO;
import product.dto.ProductDTO;
import product.dto.ProductPageDTO;
import view.command.CommandHandler;

public class ProductListHandler implements CommandHandler {
	private ProductDAO dao = new ProductDAO();
	private int size = 10;

	public ProductPageDTO getProductPage(int pageNum) {
		int firstRow = 0;
		int endRow = 0;
		List<ProductDTO> productList = new ArrayList<ProductDTO>();
		try {
			int total = dao.selectCount();
			if (total > 0) {
				firstRow = (pageNum - 1) * size + 1;
				endRow = pageNum * size;
				productList = dao.selectProduct(firstRow, endRow);
			}
			return new ProductPageDTO(total, pageNum, size, productList);
		} catch (Exception e) {
			e.printStackTrace();
			return new ProductPageDTO(0, pageNum, size, productList);
		}
	}

	@Override
	public String process(HttpServletRequest request, HttpServletResponse response) throws Exception {
		System.out.println("ProductListHandler 접근 성공");
		request.setCharacterEncoding("UTF-8");
		// ProductDAO dao = new ProductDAO();

		// List<ProductDTO> product = dao.selectProduct();
		// System.out.println("product : " + product);

		// request.setAttribute("product", product);

		String pageNoVal = request.getParameter("pageNo");
		int pageNo = 1;
		if (pageNoVal != null && !pageNoVal.isEmpty()) {
			pageNo = Integer.parseInt(pageNoVal);
		}
		/*
		 * if(pageNoVal != null) { pageNo = Integer.parseInt(pageNoVal); }
		 */
		ProductPageDTO productPage = this.getProductPage(pageNo);
		request.setAttribute("productPage", productPage);
		request.setAttribute("product", productPage.getProductList());

		return "/WEB-INF/product/productList.jsp";

	}

}
