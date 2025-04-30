package requestManagement.controller;

import java.net.URLEncoder;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import requestManagement.dao.RequestDAO;
import requestManagement.dto.RequestDTO;
import requestManagement.dto.RequestPageDTO;
import view.command.CommandHandler;

public class RequestAdminHandler implements CommandHandler {
	private RequestDAO dao = new RequestDAO();
	private int size = 10;

	@Override
	public String process(HttpServletRequest request, HttpServletResponse response) throws Exception {
		System.out.println("RequestAdminHandler アクセス成功");
		request.setCharacterEncoding("UTF-8");

		String keyword = request.getParameter("keyword");
		System.out.println("検索する申請者の名前 : " + keyword);

		String pageNoVal = request.getParameter("pageNo");
		int pageNo = 1;
		if (pageNoVal != null && !pageNoVal.isEmpty()) {
			try {
				pageNo = Integer.parseInt(pageNoVal);
			} catch (NumberFormatException e) {
				e.printStackTrace();
			}
		}

		RequestPageDTO requestPage;
		int total;
		List<RequestDTO> list;
		int firstRow = (pageNo - 1) * size + 1;
		int endRow = pageNo * size;

		if (keyword != null && !keyword.trim().isEmpty()) {
			// 検索語がある場合 (ステータス0 + 名前検索)
			total = dao.selectCountByKeyword(keyword);
			list = dao.adminCheckSearch(keyword, firstRow, endRow);
		} else {
			// 検索語がない場合 (ステータス0基準)
			total = dao.selectAllCount();
			list = dao.adminCheck(firstRow, endRow);
		}

		// ← 空のページの場合、前のページに Redirect
		if (list.isEmpty() && total > 0 && pageNo > 1) {
			// keywordがある場合はqueryStringに含める
			StringBuilder redirectUrl = new StringBuilder("requestAdmin.do?pageNo=" + (pageNo - 1));
			if (keyword != null && !keyword.trim().isEmpty()) {
				redirectUrl.append("&keyword=").append(URLEncoder.encode(keyword, "UTF-8"));
			}
			response.sendRedirect(redirectUrl.toString());
			return null; // forward 防ぐ
		}

		requestPage = new RequestPageDTO(total, pageNo, size, list);
		request.setAttribute("requestPage", requestPage);
		request.setAttribute("adminCheck", requestPage.getRequestList());

		return "/WEB-INF/requestManagement/PurchaseAdminRequest.jsp";
	}

}
