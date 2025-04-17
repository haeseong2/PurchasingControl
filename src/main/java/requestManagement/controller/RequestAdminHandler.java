package requestManagement.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import requestManagement.dao.RequestDAO;
import requestManagement.dto.RequestDTO;
import view.command.CommandHandler;

public class RequestAdminHandler implements CommandHandler {

	@Override
	public String process(HttpServletRequest request, HttpServletResponse response) throws Exception {
		System.out.println("RequestAdminHandler 접근 성공");
		request.setCharacterEncoding("UTF-8");
		
		RequestDAO dao = new RequestDAO();
		
		List<RequestDTO> adminCheck = dao.adminCheck();
		System.out.println("adminCheck : " + adminCheck);
		
		request.setAttribute("adminCheck", adminCheck);
		return "/WEB-INF/requestManagement/PurchaseAdminRequest.jsp";
	}

}
