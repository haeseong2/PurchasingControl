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
		System.out.println("ResendRequestHandler 접근 성공");

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
			/* request.setAttribute("resendRequestSuccess", true); */
			request.setCharacterEncoding("UTF-8");
			session.setAttribute("resendRequestSuccess", true);
		} else {
			/* request.setAttribute("resendRequestFail", true); */
			request.setCharacterEncoding("UTF-8");
			session.setAttribute("resendRequestFail", true);
		}

		/*
		 * // 현재 페이지 번호 받기, 기본은 1페이지 String pageNoVal = request.getParameter("pageNo");
		 * int pageNo = 1; if (pageNoVal != null && !pageNoVal.isEmpty()) { pageNo =
		 * Integer.parseInt(pageNoVal); }
		 * 
		 * int size = 10; // 한 페이지에 보여줄 데이터 수 int startRow = (pageNo - 1) * size + 1;
		 * int endRow = pageNo * size;
		 * 
		 * int total = dao.selectCount(userId); List<RequestDTO> checkResult =
		 * dao.requestCheck(userId, startRow, endRow);
		 * 
		 * // RequestPageDTO 생성 (페이징 정보 포함) RequestPageDTO requestPage = new
		 * RequestPageDTO(total, pageNo, size, checkResult);
		 * 
		 * 
		 * request.setAttribute("checkResult", checkResult);
		 * request.setAttribute("requestPage", requestPage);
		 * 
		 * return "/WEB-INF/requestManagement/PurchaseRequestDetails.jsp";
		 */

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
		/* response.sendRedirect("requestcheck.do?pageNo=" + pageNo); */
		return null;
	}
}
