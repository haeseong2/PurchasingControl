package purchase.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import requestManagement.dao.RequestDAO;
import requestManagement.dto.RequestDTO;
import view.command.CommandHandler;

public class SettleHandler implements CommandHandler {

	@Override
	public String process(HttpServletRequest request, HttpServletResponse response) throws Exception {
		System.out.println("SettleHandler 접근 성공");
		
		String requestId = request.getParameter("requestId");
		String user = (String) request.getSession().getAttribute("user");
		System.out.println("requestId : " + requestId);
		System.out.println("user : " + user);
		
		RequestDAO dao = new RequestDAO();
		int settleupdate = dao.settleupdate(requestId);
		System.out.println("settleupdate : " + settleupdate);
		
		if(settleupdate == 1) {
			int settleInsert = dao.settleInsert(requestId, user);
			System.out.println("settleInsert : " + settleInsert);
			
			if(settleInsert == 1) {
				dao.completeSettle(requestId);
				
				HttpSession session = request.getSession();
				session.setAttribute("settleSuccess", true);
				session.setAttribute("settleSuccessmessage", "success");
				session.setAttribute("settledRequestId", requestId);
				System.out.println("settleSuccess : " + session.getAttribute("settleSuccess"));
				System.out.println("settledRequestId : " + session.getAttribute("settledRequestId"));
			}
		}else {

		}
		return "/WEB-INF/requestManagement/PurchaseRequestDetails.jsp";
	}

}
