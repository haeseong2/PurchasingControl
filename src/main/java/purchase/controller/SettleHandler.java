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
		System.out.println("SettleHandler アクセス成功");

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
					// 2) decreaseQuantity 呼び出し
					int decreaseResult = dao2.decreaseQuantity(productId, requestQuantity);
					System.out.println("decreaseQuantity 結果: " + decreaseResult);
				} else {
					System.err.println("在庫減少失敗: リクエスト情報取得不可 (requestId=" + requestId + ")");
				}

				 // ページ番号を受け取ってリダイレクト処理
		        String pageNoStr = request.getParameter("pageNo");
		        
		        String keyword = request.getParameter("keyword");
		        
		        if (pageNoStr == null) pageNoStr = "1";
		        
		        String redirectUrl = "requestcheck.do?pageNo=" + pageNoStr;
                if (keyword != null && !keyword.trim().isEmpty()) {
                    redirectUrl += "&keyword=" + URLEncoder.encode(keyword, "UTF-8");
                }

                response.sendRedirect(redirectUrl);

		        return null;  // リダイレクトしたので、JSPパスを返さない
			}
		} else {

		}
		return "/WEB-INF/requestManagement/PurchaseRequestDetails.jsp";
	}

}
