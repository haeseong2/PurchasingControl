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
		System.out.println("ProductSearchHandler アクセス成功");
		request.setCharacterEncoding("UTF-8");

		// 入力値を取得
		String keyword = request.getParameter("keyword");

		List<ProductDTO> searchResult = null;

		if (keyword == null || keyword.trim().isEmpty()) {
			// 検索語がない場合、空のリストを返す
			searchResult = new ArrayList<>();
		} else {
			// 検索語がある場合、検索結果を取得
			ProductSearchDAO dao = new ProductSearchDAO();
			searchResult = dao.searchProduct(keyword);
		}

		System.out.println("result : " + searchResult);
		System.out.println("keyword : " + keyword);

		// searchResultをJSPに渡す
		request.setAttribute("searchResult", searchResult);

		return "/WEB-INF/product/productList.jsp";
	}
}
