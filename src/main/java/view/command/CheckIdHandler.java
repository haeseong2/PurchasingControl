package view.command;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import view.model.dao.UserDAO;
import view.model.dao.IndexDAO;
import view.model.dto.IndexDTO;
import view.model.dto.IndexPageDTO;

import java.util.List;

public class CheckIdHandler implements CommandHandler {

    @Override
    public String process(HttpServletRequest request, HttpServletResponse response) throws Exception {
        String id = request.getParameter("id");
        System.out.println("중복확인 ID: " + id);

        UserDAO dao = new UserDAO();
        boolean isDuplicate = dao.isIdDuplicate(id);
        
        request.setAttribute("enteredId", id);

        request.setAttribute("idCheckResult", isDuplicate ? "duplicate" : "available");

        // ✅ index.jsp에서 모달을 조건부로 띄우기 위해 index 페이지 데이터도 세팅
        IndexDAO iDao = new IndexDAO();
        int pageNo = 1;
        int size = 10;

        int total = iDao.selectCount();
        int firstRow = (pageNo - 1) * size + 1;
        int endRow = pageNo * size;

        List<IndexDTO> indexList = iDao.selectIndex(firstRow, endRow);
        IndexPageDTO indexPage = new IndexPageDTO(total, pageNo, size, indexList);
        List<IndexDTO> requestResult = iDao.requestResult();

        request.setAttribute("indexPage", indexPage);
        request.setAttribute("index", indexList);
        request.setAttribute("requestResult", requestResult);

        // ✅ index.jsp로 돌아가 회원가입 모달 + 중복확인 모달 동시에 띄움
        return "index.jsp";
    }
}