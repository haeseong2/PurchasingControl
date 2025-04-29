package purchase.controller;

import java.net.URLEncoder;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import product.dao.ProductDAO;
import requestManagement.dao.RequestDAO;
import requestManagement.dto.RequestDTO;
import view.command.CommandHandler;

public class SettleHandler implements CommandHandler {

	@Override
	public String process(HttpServletRequest request, HttpServletResponse response) throws Exception {
		System.out.println("SettleHandler 접근 성공");

		String requestId = request.getParameter("requestId");
		String requestQuantity = request.getParameter("requestQuantity");
		String user = (String) request.getSession().getAttribute("user");
		System.out.println("requestId : " + requestId);
		System.out.println("user : " + user);

		RequestDAO dao = new RequestDAO();
		ProductDAO dao2 = new ProductDAO();

		int settleupdate = dao.settleupdate(requestId);
		System.out.println("settleupdate : " + settleupdate);

		if (settleupdate == 1) {
			int settleInsert = dao.settleInsert(requestId, user, requestQuantity);
			System.out.println("settleInsert : " + settleInsert);

			if (settleInsert == 1) {
				dao.completeSettle(requestId);
				HttpSession session = request.getSession();
				session.setAttribute("settleSuccess", true);

				RequestDTO reqDto = dao.getRequestById(requestId);
				if (reqDto != null) {
					String productId = reqDto.getProductId();
					// 2) decreaseQuantity 호출
					int decreaseResult = dao2.decreaseQuantity(productId, requestQuantity);
					System.out.println("decreaseQuantity 결과: " + decreaseResult);
				} else {
					System.err.println("재고 차감 실패: 요청 정보 조회 불가 (requestId=" + requestId + ")");
				}

				 // 페이지 번호 받아서 리다이렉트 처리
		        String pageNoStr = request.getParameter("pageNo");
		        
		        String keyword = request.getParameter("keyword");
		        
		        if (pageNoStr == null) pageNoStr = "1";
		        
		        String redirectUrl = "requestcheck.do?pageNo=" + pageNoStr;
                if (keyword != null && !keyword.trim().isEmpty()) {
                    redirectUrl += "&keyword=" + URLEncoder.encode(keyword, "UTF-8");
                }

                response.sendRedirect(redirectUrl);

				/* response.sendRedirect("requestcheck.do?pageNo=" + pageNoStr); */
		        return null;  // 리다이렉트 했으므로 JSP 경로 리턴 안함
			}
		} else {

		}
		return "/WEB-INF/requestManagement/PurchaseRequestDetails.jsp";
	}

}
