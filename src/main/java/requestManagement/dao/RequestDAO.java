package requestManagement.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

import requestManagement.dto.RequestDTO;

public class RequestDAO {
	private Connection getConnection() throws Exception {
		Context initContext = new InitialContext();
		Context envContext = (Context) initContext.lookup("java:/comp/env");
		DataSource ds = (DataSource) envContext.lookup("jdbc/purchase");
		return ds.getConnection();
	}

	// 요청 테이블 인서트 작업
	public int insertRequest(RequestDTO request) {
		System.out.println("RequestDAO 접근 성공");
		int result = 0;
		String sql = "INSERT INTO PURCHASE_REQUEST (REQUEST_ID, USER_ID, PRODUCT_ID, REQUEST_QUANTITY, REQUEST_DATE, REQUEST_STATUS, REQUEST_REASON) "
				+ "VALUES (REQ_SEQ.nextVal, ?, ?, ?, SYSDATE, ?, ?)";
		try (Connection conn = getConnection(); PreparedStatement pstmt = conn.prepareStatement(sql)) {
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

	public List<RequestDTO> requestCheck(String id) throws Exception {
    	System.out.println("RequestDAO 접근 성공");
        String sql = "SELECT * FROM PURCHASE_REQUEST WHERE USER_ID = ?";
        List<RequestDTO> requestList = new ArrayList<>();
        
        try (Connection conn = getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)){ 
        	
        	pstmt.setString(1, id);
        	try(ResultSet rs = pstmt.executeQuery()){
        	while (rs.next()) {
        		RequestDTO req = new RequestDTO();
				req.setRequestId(rs.getString("REQUEST_ID"));
        		req.setId(rs.getString("USER_ID"));
				req.setProductId(rs.getString("PRODUCT_ID"));
				req.setRequestQuantity(rs.getString("REQUEST_QUANTITY"));
				req.setRequestStatus(rs.getString("REQUEST_STATUS"));
				requestList.add(req);
			}
        } catch (Exception e) {
            e.printStackTrace();
        }
        return requestList;
    }

}
}
