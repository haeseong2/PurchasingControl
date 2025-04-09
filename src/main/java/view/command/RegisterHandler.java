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
        
        // 
        if(status.equals("관리자")) {
        	status = "0";
        }else {
        	status = "1";
        }

        UserDTO user = new UserDTO();
        user.setId(id);
        user.setUserName(name);
        user.setUserEmail(email);
        user.setPassword(password); // 비밀번호 설정
        user.setUserStatus(status); // 상태 설정

        UserDAO dao = new UserDAO();
        int result = dao.insertUser(user);

        if (result > 0) {
            request.setAttribute("registerSuccess", true);  // 회원가입 성공 시
        } else {
            request.setAttribute("registerFail", true);  // 실패 시
        }

        return "index.jsp";  // 다시 index로 돌아가서 메시지 처리
    }
}
