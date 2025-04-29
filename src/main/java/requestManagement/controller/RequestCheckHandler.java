package requestManagement.controller;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import requestManagement.dao.RequestDAO;
import requestManagement.dto.RequestDTO;
import requestManagement.dto.RequestPageDTO;
import view.command.CommandHandler;

public class RequestCheckHandler implements CommandHandler {
    private RequestDAO dao = new RequestDAO();
    private int size = 10;

    public RequestPageDTO getRequestPage(String id, int pageNum) {
        int firstRow = 0;
        int endRow = 0;
        int total = dao.selectCount(id);
        List<RequestDTO> requestList = new ArrayList<>();
        try {
            if (total > 0) {
                firstRow = (pageNum - 1) * size + 1;
                endRow = pageNum * size;
                requestList = dao.requestCheck(id, firstRow, endRow);
            }
            return new RequestPageDTO(total, pageNum, size, requestList);
        } catch (Exception e) {
            e.printStackTrace();
            return new RequestPageDTO(total, pageNum, size, requestList);
        }
    }
    
    public RequestPageDTO getRequestPageByKeyword(String id, String keyword, int pageNum) {
        int firstRow = (pageNum - 1) * size + 1;
        int endRow = pageNum * size;
        int total = dao.selectCountByUserAndKeyword(id, keyword); // <-- id, keyword 기준 총 갯수
        List<RequestDTO> requestList = new ArrayList<>();
        try {
            if (total > 0) {
                requestList = dao.checkResultSearch(id, keyword, firstRow, endRow);
            }
            return new RequestPageDTO(total, pageNum, size, requestList);
        } catch (Exception e) {
            e.printStackTrace();
            return new RequestPageDTO(total, pageNum, size, requestList);
        }
    }

    @Override
    public String process(HttpServletRequest request, HttpServletResponse response) throws Exception {
        System.out.println("RequestCheckHandler 접근 성공");
        request.setCharacterEncoding("UTF-8");

        String id = (String) request.getSession().getAttribute("user");
        String keyword = request.getParameter("keyword");
        System.out.println("로그인한 사용자 ID: " + id);
        System.out.println("검색할 요청자 이름 : " + keyword);

        String pageNoVal = request.getParameter("pageNo");
        int pageNo = 1;
        if (pageNoVal != null && !pageNoVal.isEmpty()) {
            pageNo = Integer.parseInt(pageNoVal);
        }

		/*
		 * if (keyword != null && !keyword.trim().isEmpty()) { // 검색어가 있을 때는 기존 검색 메서드
		 * 호출 (페이징 없이 전체 검색 결과) List<RequestDTO> checkResultSearch =
		 * dao.checkResultSearch(id, keyword); System.out.println("checkResultSearch : "
		 * + checkResultSearch); request.setAttribute("checkResult", checkResultSearch);
		 * // 페이징 객체는 빈 리스트로 세팅하거나 null로 처리해도 무방 request.setAttribute("requestPage", new
		 * RequestPageDTO(checkResultSearch.size(), 1, size, checkResultSearch)); } else
		 * { // 검색어 없을 때만 페이징 처리 RequestPageDTO requestPage = this.getRequestPage(id,
		 * pageNo); request.setAttribute("requestPage", requestPage);
		 * request.setAttribute("checkResult", requestPage.getRequestList()); }
		 */
        
        if (keyword != null && !keyword.trim().isEmpty()) {
            RequestPageDTO requestPage = this.getRequestPageByKeyword(id, keyword, pageNo);
            request.setAttribute("requestPage", requestPage);
            request.setAttribute("checkResult", requestPage.getRequestList());
        } else {
            RequestPageDTO requestPage = this.getRequestPage(id, pageNo);
            request.setAttribute("requestPage", requestPage);
            request.setAttribute("checkResult", requestPage.getRequestList());
        }

        return "/WEB-INF/requestManagement/PurchaseRequestDetails.jsp";
    }
}
