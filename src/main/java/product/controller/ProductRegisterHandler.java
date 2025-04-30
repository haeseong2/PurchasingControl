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
		
		// ProductDTO オブジェクトを作成
		ProductDTO product = new ProductDTO();
		product.setProductName(productName);
		product.setProductDescription(productDescription);
		product.setProductPrice(productPrice);
		product.setProductQuantity(productQuantity);

		// ProductDAOを使用してデータベースに追加
		int result = productDAO.insertProduct(product);
		System.out.println("result : " + result);

		// 結果に応じて、成功した場合は製品一覧ページにリダイレクト
		if (result > 0) {
			request.setAttribute("productRegisterSuccess", true);
		} else {
			// 失敗した場合はエラーメッセージを設定し、登録ページに戻る
			request.setAttribute("errorMessage", true);
		}
		return "/WEB-INF/product/productRegister.jsp"; // 再度製品登録フォームに戻る
	}
}
