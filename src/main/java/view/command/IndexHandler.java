package view.command;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;  // 세션을 사용하기 위해 추가

import view.model.dao.UserDAO;
import view.model.dto.UserDTO;

public class IndexHandler implements CommandHandler {

    @Override
    public String process(HttpServletRequest request, HttpServletResponse response) throws Exception {
    	System.out.println("indexHandler 접근 성공");
    	request.setCharacterEncoding("UTF-8");


            return "index.jsp"; // 로그인 실패 후 index 페이지로 리다이렉트
        }
}

