package requestManagement.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import product.dao.ProductDAO;
import product.dto.ProductDTO;
import requestManagement.dao.RequestDAO;
import requestManagement.dto.RequestDTO;
import view.command.CommandHandler;

public class RequestHandler implements CommandHandler {

	@Override
	public String process(HttpServletRequest request, HttpServletResponse response) throws Exception {
		request.setCharacterEncoding("UTF-8");
		System.out.println("RequestHandler アクセス成功");
		HttpSession session = request.getSession();

		String id = (String) session.getAttribute("user");
		String requestStatus = request.getParameter("requestStatus");
		String productId = request.getParameter("productId");
		String quantity = request.getParameter("quantity");
		String reason = request.getParameter("reason");

		System.out.println("id : " + id);
		System.out.println("requestStatus :" + requestStatus);
		System.out.println("productId :" + productId);
		System.out.println("quantity :" + quantity);
		System.out.println("reason :" + reason);

		// 1) モーダルから送られた元のURL
		String originalUrl = request.getParameter("originalUrl");
		if (originalUrl == null || originalUrl.trim().isEmpty()) {
			// デフォルト値1を設定
			originalUrl = request.getContextPath() + "/list.do?pageNo=1";
		}

		RequestDTO req = new RequestDTO();
		req.setId(id);
		req.setRequestStatus(requestStatus);
		req.setProductId(productId);
		req.setRequestQuantity(quantity);
		req.setRequestReason(reason);

		RequestDAO dao = new RequestDAO();
		int result = dao.insertRequest(req);
		System.out.println("result : " + result);

		String pageNo = request.getParameter("pageNo");
		if (pageNo == null || pageNo.trim().isEmpty()) {
			pageNo = "1"; // デフォルト値1を設定
		}


		if (result > 0) {
			session.setAttribute("requestSuccess", true);
			response.sendRedirect(originalUrl);
		} else {
			session.setAttribute("requestFail", true);
			System.out.println("在庫の減算はできません");
			response.sendRedirect(originalUrl);
		}
		return null;
	}
}
