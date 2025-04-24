package product.controller;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import product.dao.ProductSearchDAO;
import product.dto.ProductDTO;
import view.command.CommandHandler;

public class ProductSearchHandler implements CommandHandler {
	@Override
	public String process(HttpServletRequest request, HttpServletResponse response) throws Exception {
		System.out.println("ProductSearchHandler 접근 성공");
		request.setCharacterEncoding("UTF-8");

		// 입력 값 받기
		String keyword = request.getParameter("keyword");

		List<ProductDTO> searchResult = null;

		if (keyword == null || keyword.trim().isEmpty()) {
			// 검색어가 없을 때 빈 리스트 전달
			searchResult = new ArrayList<>();
		} else {
			// 검색어가 있을 때 검색 결과
			ProductSearchDAO dao = new ProductSearchDAO();
			searchResult = dao.searchProduct(keyword);
		}

		System.out.println("result : " + searchResult);
		System.out.println("keyword : " + keyword);

		// searchResult를 JSP로 전달
		request.setAttribute("searchResult", searchResult);

		return "/WEB-INF/product/productList.jsp";
	}
}
