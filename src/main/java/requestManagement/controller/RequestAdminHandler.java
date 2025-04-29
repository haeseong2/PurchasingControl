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

	/*
	 * public RequestPageDTO getRequestAdminPage(String id, int pageNum) { int
	 * firstRow = 0; int endRow = 0; int total = dao.selectCount(id);
	 * List<RequestDTO> requestList = new ArrayList<>(); try { if (total > 0) {
	 * firstRow = (pageNum - 1) * size + 1; endRow = pageNum * size; requestList =
	 * dao.adminCheck(firstRow, endRow); } return new RequestPageDTO(total, pageNum,
	 * size, requestList); } catch (Exception e) { e.printStackTrace(); return new
	 * RequestPageDTO(total, pageNum, size, requestList); } }
	 */
	@Override
	public String process(HttpServletRequest request, HttpServletResponse response) throws Exception {
		System.out.println("RequestAdminHandler 접근 성공");
		request.setCharacterEncoding("UTF-8");

		String keyword = request.getParameter("keyword");
		System.out.println("검색할 요청자 이름 : " + keyword);

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
			// 검색어가 있을 때 (상태 0 + 이름 검색)
			total = dao.selectCountByKeyword(keyword);
			list = dao.adminCheckSearch(keyword, firstRow, endRow);
		} else {
			// 검색어 없을 때 (상태 0 기준)
			total = dao.selectAllCount();
			list = dao.adminCheck(firstRow, endRow);
		}

		// ← 빈 페이지일 때 이전 페이지로 Redirect
		if (list.isEmpty() && total > 0 && pageNo > 1) {
			// keyword가 있을 경우 queryString에 포함
			StringBuilder redirectUrl = new StringBuilder("requestAdmin.do?pageNo=" + (pageNo - 1));
			if (keyword != null && !keyword.trim().isEmpty()) {
				redirectUrl.append("&keyword=").append(URLEncoder.encode(keyword, "UTF-8"));
			}
			response.sendRedirect(redirectUrl.toString());
			return null; // forward 막기
		}

		requestPage = new RequestPageDTO(total, pageNo, size, list);
		request.setAttribute("requestPage", requestPage);
		request.setAttribute("adminCheck", requestPage.getRequestList());

		return "/WEB-INF/requestManagement/PurchaseAdminRequest.jsp";
	}

}
