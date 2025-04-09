package view.model.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;
import view.model.dto.UserDTO;

public class UserDAO {

    private Connection getConnection() throws Exception {
        Context initContext = new InitialContext();
        Context envContext  = (Context)initContext.lookup("java:/comp/env");
        DataSource ds = (DataSource)envContext.lookup("jdbc/purchase");
        return ds.getConnection();
    }

    public int insertUser(UserDTO user) {
        int result = 0;
        String sql = "INSERT INTO USER_INFO (USER_ID, USER_NAME, USER_EMAIL, USER_STATUS, DEPARTMENT_ID, USER_CREATED, USER_PW) " +
                     "VALUES (?, ?, ?, ?, ?, SYSDATE, ?)";
        try (Connection conn = getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setString(1, user.getId());
            pstmt.setString(2, user.getUserName());
            pstmt.setString(3, user.getUserEmail());
            pstmt.setString(4, user.getUserStatus());  // 변경된 부분: getStatus() -> getUserStatus()
            pstmt.setString(5, user.getDepartmentId());
            pstmt.setString(6, user.getPassword());    // 변경된 부분: getPw() -> getPassword()

            result = pstmt.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return result;
    }

    public boolean login(String id, String password) {
        boolean isValid = false;
        String sql = "SELECT * FROM USER_INFO WHERE USER_ID = ? AND USER_PW = ?";
        try (Connection conn = getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setString(1, id);
            pstmt.setString(2, password);  // 변경된 부분: pw -> password
            ResultSet rs = pstmt.executeQuery();
            isValid = rs.next();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return isValid;
    }
}
