package view.controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import view.model.dao.UserDAO;

public class LoginServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // GET 요청으로 접근 시 로그인 페이지로 포워딩 (또는 에러 처리 가능)
        request.getRequestDispatcher("/WEB-INF/view/login.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String username = request.getParameter("username");
        String password = request.getParameter("password");

        UserDAO dao = new UserDAO();
        boolean isValid = dao.validateUser(username, password);

        response.setContentType("text/plain");
        response.setCharacterEncoding("UTF-8");

        if (isValid) {
            HttpSession session = request.getSession();
            session.setAttribute("user", username);
            response.getWriter().write("success");
        } else {
            response.getWriter().write("fail");
        }
    }
}
