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
        System.out.println("RequestCheckHandler アクセス成功");
        request.setCharacterEncoding("UTF-8");

        String id = (String) request.getSession().getAttribute("user");
        String keyword = request.getParameter("keyword");
        System.out.println("ログイン中のユーザー ID: " + id);
        System.out.println("検索する申請者の名前 : " + keyword);

        String pageNoVal = request.getParameter("pageNo");
        int pageNo = 1;
        if (pageNoVal != null && !pageNoVal.isEmpty()) {
            pageNo = Integer.parseInt(pageNoVal);
        }
        
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
