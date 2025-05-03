package requestManagement.controller;

import java.net.URLEncoder;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import requestManagement.dao.RequestDAO;
import view.command.CommandHandler;

public class ResendRequestHandler implements CommandHandler {

	@Override
	public String process(HttpServletRequest request, HttpServletResponse response) throws Exception {
		System.out.println("ResendRequestHandler アクセス成功");

		request.setCharacterEncoding("UTF-8");
		
		String requestId = request.getParameter("requestIdHidden");
		String quantity = request.getParameter("quantity");
		String reason = request.getParameter("reason");
		System.out.println("requestId : " + requestId);
		System.out.println("quantity : " + quantity);
		System.out.println("reason : " + reason);

		HttpSession session = request.getSession();
		String userId = (String) session.getAttribute("user");
		System.out.println("userId : " + userId);

		RequestDAO dao = new RequestDAO();
		int result = dao.resendUpdate(requestId, quantity, reason);

		if (result > 0) {
			request.setCharacterEncoding("UTF-8");
			session.setAttribute("resendRequestSuccess", true);
		} else {
			request.setCharacterEncoding("UTF-8");
			session.setAttribute("resendRequestFail", true);
		}

		String pageNoVal = request.getParameter("pageNo");
		String keyword = request.getParameter("keyword");
		
		int pageNo = 1;
		if (pageNoVal != null && !pageNoVal.isEmpty()) {
			pageNo = Integer.parseInt(pageNoVal);
		}
		
		String redirectUrl = "requestcheck.do?pageNo=" + pageNo;

		if (keyword != null && !keyword.trim().isEmpty()) {
			redirectUrl += "&keyword=" + URLEncoder.encode(keyword, "UTF-8");
		}

		response.sendRedirect(redirectUrl);
		return null;
	}
}
