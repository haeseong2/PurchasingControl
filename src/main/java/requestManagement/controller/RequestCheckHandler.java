package requestManagement.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import requestManagement.dao.RequestDAO;
import requestManagement.dto.RequestDTO;
import view.command.CommandHandler;

public class RequestCheckHandler implements CommandHandler {

	@Override
	public String process(HttpServletRequest request, HttpServletResponse response) throws Exception {
		System.out.println("RequestCheckHandler 접근 성공");
        request.setCharacterEncoding("UTF-8");
        
        String id = (String) request.getSession().getAttribute("user");
        System.out.println("로그인한 사용자 ID: " + id);
        
        RequestDAO dao = new RequestDAO();
        List<RequestDTO>checkResult = null;
        checkResult = dao.requestCheck(id);
        
        
        System.out.println("RequestCheckList : "+ checkResult);
        
        request.setAttribute("checkResult", checkResult);
		return "/WEB-INF/requestManagement/PurchaseRequestDetails.jsp";

    }
}
