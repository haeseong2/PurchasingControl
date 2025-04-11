package view.command;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;  // 세션을 사용하기 위해 추가

import view.model.dao.UserDAO;
import view.model.dto.UserDTO;

public class LoginHandler implements CommandHandler {

    @Override
    public String process(HttpServletRequest request, HttpServletResponse response) throws Exception {
        request.setCharacterEncoding("UTF-8");

        String username = request.getParameter("username");
        String password = request.getParameter("password");

        UserDAO dao = new UserDAO();
        UserDTO user = dao.getUserByIdAndPw(username, password);
        boolean success = dao.login(username, password);

        if (success && user != null) {
            HttpSession session = request.getSession();
            session.setAttribute("user", username);  // 사용자 아이디 저장
            session.setAttribute("userRole", user.getUserStatus());  // "0" or "1"을 int로 변환하여 저장

            request.setAttribute("loginSuccess", true);
            return "index.jsp";
        } else {
            // 로그인 실패 시 로그인 실패 메시지 전달
            request.setAttribute("loginFail", true);
            request.setAttribute("error", "아이디 또는 비밀번호가 틀립니다");
            return "index.jsp"; // 로그인 실패 후 index 페이지로 리다이렉트
        }
    }
}

