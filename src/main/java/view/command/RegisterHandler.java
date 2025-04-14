package view.command;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import view.model.dao.UserDAO;
import view.model.dto.UserDTO;

public class RegisterHandler implements CommandHandler {

    @Override
    public String process(HttpServletRequest request, HttpServletResponse response) throws Exception {
        System.out.println("RegisterHandler 접근 성공");
        
        String id       = request.getParameter("id");
        String name     = request.getParameter("name");
        String email    = request.getParameter("email");
        String password = request.getParameter("password");
        String status   = request.getParameter("role"); 
        String dept     = request.getParameter("department");

        UserDTO user = new UserDTO();
        user.setId(id);
        user.setUserName(name);
        user.setUserEmail(email);
        user.setPassword(password);
        user.setUserStatus(status);
        user.setDepartmentId(dept);

        UserDAO dao = new UserDAO();
        int result = dao.insertUser(user);

        if (result > 0) {
            request.setAttribute("registerSuccess", true);
        } else {
            request.setAttribute("registerFail", true);
        }

        return "index.jsp";
    }
}
