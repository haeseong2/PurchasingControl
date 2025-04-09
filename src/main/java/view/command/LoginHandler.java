package view.command;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;  // 세션을 사용하기 위해 추가
import view.model.dao.UserDAO;

public class LoginHandler implements CommandHandler {

    @Override
    public String process(HttpServletRequest request, HttpServletResponse response) throws Exception {
        request.setCharacterEncoding("UTF-8");

        String username = request.getParameter("username");
        String password = request.getParameter("password");

        UserDAO dao = new UserDAO();
        boolean success = dao.login(username, password);

        if (success) {
            // 로그인 성공 시 세션에 사용자 정보를 저장
            HttpSession session = request.getSession();
            session.setAttribute("user", username);  // 로그인한 사용자 정보 세션에 저장

            request.setAttribute("loginSuccess", true);
            return "index.jsp"; // 로그인 성공 후 index 페이지로 리다이렉트
        } else {
            // 로그인 실패 시 로그인 실패 메시지 전달
            request.setAttribute("loginFail", true);
            return "index.jsp"; // 로그인 실패 후 index 페이지로 리다이렉트
        }
    }
}

