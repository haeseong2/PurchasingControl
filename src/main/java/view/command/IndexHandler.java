package view.command;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import view.model.dao.IndexDAO;
import view.model.dto.IndexDTO;

public class IndexHandler implements CommandHandler {

    @Override
    public String process(HttpServletRequest request, HttpServletResponse response) throws Exception {
		System.out.println("ProductListHandler 접근 성공");
        request.setCharacterEncoding("UTF-8");
        IndexDAO dao = new IndexDAO();
        
		List<IndexDTO> requestResult = dao.requestResult();
        System.out.println("requestResult : "+ requestResult);
        
        request.setAttribute("requestResult", requestResult);
		return "index.jsp";
        }
}

