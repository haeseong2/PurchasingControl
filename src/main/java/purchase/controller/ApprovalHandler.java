package purchase.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import requestManagement.dao.RequestDAO;
import requestManagement.dto.RequestDTO;
import view.command.CommandHandler;

public class ApprovalHandler implements CommandHandler {

	@Override
	public String process(HttpServletRequest request, HttpServletResponse response) throws Exception {
		System.out.println("ApprovalHandler 접근 성공");

		String requestId = request.getParameter("requestId");
		System.out.println("requestId : " + requestId);

		RequestDAO dao = new RequestDAO();
		int result 	   = dao.approvalCheck(requestId);

		if (result == 1) {
			List<RequestDTO> adminCheck = dao.adminCheck();
			System.out.println("adminCheck : " + adminCheck);
			request.setAttribute("adminCheck", adminCheck);

			RequestDTO approvedRequest = dao.getRequestById(requestId);
			System.out.println("approvedRequest : " + approvedRequest);

			if (approvedRequest != null) {
				request.setAttribute("approveSuccess", true);
				request.setAttribute("approvedRequest", approvedRequest);
				return "/WEB-INF/requestManagement/PurchaseAdminRequest.jsp";
			}else {
				request.setAttribute("approveSuccess", false);
				return "/WEB-INF/requestManagement/PurchaseAdminRequest.jsp";
			}
		}
		return null;
	}

}
