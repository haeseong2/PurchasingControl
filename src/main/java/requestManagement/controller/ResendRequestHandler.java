package requestManagement.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import requestManagement.dao.RequestDAO;
import requestManagement.dto.RequestDTO;
import view.command.CommandHandler;

public class ResendRequestHandler implements CommandHandler {

    @Override
    public String process(HttpServletRequest request, HttpServletResponse response) throws Exception {
        System.out.println("ResendRequestHandler 접근 성공");

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
        int result = dao.resendUpdate(requestId,quantity,reason);

        // ✅ 재요청 처리 결과에 따라 메시지 처리
        if (result > 0) {
            request.setAttribute("resendRequestSuccess", true);
        } else {
            request.setAttribute("resendRequestFail", true);
        }

        // ✅ 리스트 다시 조회해서 setAttribute로 넣어주기
        List<RequestDTO> checkResult = dao.requestCheck(userId);
        request.setAttribute("checkResult", checkResult);

        // ✅ 리스트 페이지로 포워딩
        return "/WEB-INF/requestManagement/PurchaseRequestDetails.jsp";
    }
}