package requestManagement.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

import requestManagement.dto.RequestDTO;
import view.model.dto.UserDTO;

public class RequestDAO {
    private Connection getConnection() throws Exception {
        Context initContext = new InitialContext();
        Context envContext  = (Context)initContext.lookup("java:/comp/env");
        DataSource ds = (DataSource)envContext.lookup("jdbc/purchase");
        return ds.getConnection();
    }
    
    // 요청 테이블 인서트 작업
    public int insertRequest(RequestDTO request) {
    	System.out.println("RequestDAO 접근 성공");
        int result = 0;
        String sql = "INSERT INTO PURCHASE_REQUEST (REQUEST_ID, USER_ID, PRODUCT_ID, REQUEST_QUANTITY, REQUEST_DATE, REQUEST_STATUS, REQUEST_REASON) " +
                     "VALUES (REQ_SEQ.nextVal, ?, ?, ?, SYSDATE, ?, ?)";
        try (Connection conn = getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setString(1, request.getId());
            pstmt.setString(2, request.getProductId());
            pstmt.setString(3, request.getRequestQuantity());
            pstmt.setString(4, request.getRequestStatus());
            pstmt.setString(5, request.getRequestReason());

            result = pstmt.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return result;
    }
    
    public boolean select(String id, String password) {
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
