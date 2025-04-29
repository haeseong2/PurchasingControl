package purchase.controller;

import java.net.URLEncoder;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

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
			System.out.println("요청 승인 성공");
			
			String pageNoStr = request.getParameter("pageNo");
			
			 String keyword = request.getParameter("keyword");
			
            int pageNo = 1;
            if (pageNoStr != null && !pageNoStr.isEmpty()) {
                pageNo = Integer.parseInt(pageNoStr);
            }
			
            int size = 10;
            int startRow = ((pageNo - 1) * size) + 1;
            int endRow   = startRow + size - 1;
            
			List<RequestDTO> adminCheck = dao.adminCheck(startRow, endRow);
			System.out.println("adminCheck : " + adminCheck);
			request.setAttribute("adminCheck", adminCheck);

			RequestDTO approvedRequest = dao.getRequestById(requestId);
			System.out.println("approvedRequest : " + approvedRequest);

			if (approvedRequest != null) {
				request.setAttribute("approveSuccess", true);
				request.setAttribute("approvedRequest", approvedRequest);
				
				String redirectUrl = "requestAdmin.do?pageNo=" + pageNo;
                if (keyword != null && !keyword.trim().isEmpty()) {
                    redirectUrl += "&keyword=" + URLEncoder.encode(keyword, "UTF-8");
                }
                response.sendRedirect(redirectUrl);
				
                /*response.sendRedirect("requestAdmin.do?pageNo=" + pageNo);*/
	            return null;
			}else {
				request.setAttribute("approveSuccess", false);
				return "/WEB-INF/requestManagement/PurchaseAdminRequest.jsp";
			}
		}
		return null;
	}

}
