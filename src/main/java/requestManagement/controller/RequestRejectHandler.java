package requestManagement.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import requestManagement.dao.RequestDAO;
import requestManagement.dto.RequestDTO;
import view.command.CommandHandler;

public class RequestRejectHandler implements CommandHandler {

    @Override
    public String process(HttpServletRequest request, HttpServletResponse response) throws Exception {
        System.out.println("RequestRejectHandler 접근 성공");
        request.setCharacterEncoding("UTF-8");

        String requestId = request.getParameter("requestId");
        String rejectReason = request.getParameter("rejectReason");
        System.out.println("requestId : " + requestId);
        System.out.println("requestIdHidden : " + rejectReason);
        
        if (requestId == null || requestId.isEmpty()) {
            request.setAttribute("error", "잘못된 요청입니다.");
            return "/error.jsp";
        }

        RequestDAO dao = new RequestDAO();
        int rejected = dao.rejectRequest(requestId, rejectReason); // ✅ 수정된 부분
        System.out.println("rejected : " +  rejected);
        
        if (rejected == 1) {
            System.out.println("요청 반려 성공");
            
			List<RequestDTO> adminCheck = dao.adminCheck();
			System.out.println("adminCheck : " + adminCheck);
			
			request.setAttribute("adminCheck", adminCheck);
            request.setAttribute("rejectSuccess", true);
        } else {
            System.out.println("요청 반려 실패");
            request.setAttribute("error", "요청 반려에 실패했습니다");
        }

        return "/WEB-INF/requestManagement/PurchaseAdminRequest.jsp"; // ✅ 슬래시 빠져 있었음
    }
}