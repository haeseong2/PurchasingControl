package requestManagement.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.websocket.Session;

import product.dao.ProductDAO;
import product.dto.ProductDTO;
import requestManagement.dao.RequestDAO;
import requestManagement.dto.RequestDTO;
import view.command.CommandHandler;

public class RequestHandler implements CommandHandler {

	@Override
	public String process(HttpServletRequest request, HttpServletResponse response) throws Exception {
		System.out.println("RequestHandler 접근 성공");
		HttpSession session = request.getSession();
		
		String id = (String) session.getAttribute("user");
		String requestStatus = request.getParameter("requestStatus");
		String productId = request.getParameter("productId");
		String quantity = request.getParameter("quantity");
		String reason = request.getParameter("reason");

		System.out.println("id : "+ id);
		System.out.println("requestStatus :" + requestStatus);
		System.out.println("productId :" + productId);
		System.out.println("quantity :" + quantity);
		System.out.println("reason :" + reason);

		RequestDTO req = new RequestDTO();
		req.setId(id);
		req.setRequestStatus(requestStatus);
		req.setProductId(productId);
		req.setRequestQuantity(quantity);
		req.setRequestReason(reason);

		RequestDAO dao = new RequestDAO();
		int result = dao.insertRequest(req);

		System.out.println("result : " + result);
		
		if (result > 0) {
			request.setAttribute("requestSuccess", true); // 요청 성공 시
			ProductDAO dao2 = new ProductDAO();
			List<ProductDTO>product = null;
	        product = dao2.selectProduct();
	        System.out.println("product : "+ product);
	        
	        request.setAttribute("product", product);
		} else {
			request.setAttribute("requestFail", true); // 실패 시
		}

		return "/WEB-INF/product/productList.jsp";

	}
}
