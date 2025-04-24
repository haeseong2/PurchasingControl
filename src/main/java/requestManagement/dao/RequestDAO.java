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
		System.out.println("RequestDAO insertRequest 접근 성공");
		int result = 0;
		String sql = "INSERT INTO PURCHASE_REQUEST (REQUEST_ID, USER_ID, PRODUCT_ID, REQUEST_QUANTITY, REQUEST_DATE, REQUEST_STATUS, REQUEST_REASON) "
				+ "VALUES (REQ_SEQ.nextVal, ?, ?, ?, SYSDATE, ?, ?)";
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

	//요청확인
	public List<RequestDTO> requestCheck(String id) throws Exception {
	    System.out.println("RequestDAO requestCheck 접근 성공");
	    String sql = "SELECT UI.USER_NAME, PR.PRODUCT_ID, P.PRODUCT_NAME, PR.REQUEST_QUANTITY, PR.REQUEST_DATE, PR.REQUEST_STATUS, PR.REQUEST_REASON, PR.REJECT_REASON, PR.REQUEST_ID, PR.USER_ID " +
	                 "FROM PURCHASE_REQUEST PR " +
	                 "INNER JOIN USER_INFO UI ON UI.USER_ID = PR.USER_ID " +
	                 "INNER JOIN PRODUCT P ON P.PRODUCT_ID = PR.PRODUCT_ID " +
	                 "WHERE PR.USER_ID = ?";
	    List<RequestDTO> requestList = new ArrayList<>();

	    try (Connection conn = getConnection(); 
	         PreparedStatement pstmt = conn.prepareStatement(sql)) {

	        pstmt.setString(1, id);
	        try (ResultSet rs = pstmt.executeQuery()) {
	            while (rs.next()) {
	                RequestDTO req = new RequestDTO();
	                req.setUserName(rs.getString("USER_NAME")); 
	                req.setProductId(rs.getString("PRODUCT_ID"));
	                req.setProdoctName(rs.getString("PRODUCT_NAME"));
	                req.setRequestQuantity(rs.getString("REQUEST_QUANTITY"));
	                req.setRequestDate(rs.getDate("REQUEST_DATE"));
	                req.setRequestStatus(rs.getString("REQUEST_STATUS"));
	                req.setRequestReason(rs.getString("REQUEST_REASON"));
	                req.setRejectReason(rs.getString("REJECT_REASON"));
	                req.setRequestId(rs.getString("REQUEST_ID"));
	                req.setId(rs.getString("USER_ID"));
	                requestList.add(req);
	            }
	        } catch (Exception e) {
	            e.printStackTrace(); // 예외 처리
	        }
	    } catch (SQLException e) {
	        e.printStackTrace();
	        throw new Exception("Database error during request check.");
	    }

	    return requestList;
	}

	//요청 승인
	public List<RequestDTO> adminCheck() {
		System.out.println("RequestDAO adminCheck 접근 성공");
		String sql = "SELECT " +
		         "PR.REQUEST_ID, PR.USER_ID, UI.USER_NAME, PR.PRODUCT_ID, " +
	             "P.PRODUCT_NAME, PR.REQUEST_QUANTITY, PR.REQUEST_DATE, " +
	             "PR.REQUEST_REASON, PR.REQUEST_STATUS " +
	             "FROM PURCHASE_REQUEST PR " +
	             "INNER JOIN USER_INFO UI ON UI.USER_ID = PR.USER_ID " +
	             "INNER JOIN PRODUCT P ON P.PRODUCT_ID = PR.PRODUCT_ID " +
	             "WHERE PR.REQUEST_STATUS = '0'";

		List<RequestDTO> adminList = new ArrayList<>();

		try (Connection conn = getConnection(); 
			 PreparedStatement pstmt = conn.prepareStatement(sql)) {

			try (ResultSet rs = pstmt.executeQuery()) {
				while (rs.next()) {
					RequestDTO req = new RequestDTO();
					req.setRequestId(rs.getString("REQUEST_ID"));
					req.setId(rs.getString("USER_ID"));
					req.setUserName(rs.getString("USER_NAME"));
					req.setProductId(rs.getString("PRODUCT_ID"));
					req.setProdoctName(rs.getString("PRODUCT_NAME"));
					req.setRequestQuantity(rs.getString("REQUEST_QUANTITY"));
					req.setRequestDate(rs.getDate("REQUEST_DATE"));
					req.setRequestReason(rs.getString("REQUEST_REASON"));
					req.setRequestStatus(rs.getString("REQUEST_STATUS"));
					adminList.add(req);
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return adminList;
	}

	//승인 확인
	public int approvalCheck(String requestId) {
		System.out.println("approvalCheck 접근 성공");
		String sql = "UPDATE Purchase_Request SET request_status = '1' WHERE request_id = ?";
		int result = 0;

		try (Connection conn = getConnection(); 
			 PreparedStatement pstmt = conn.prepareStatement(sql)) {

			pstmt.setString(1, requestId);
			result = pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return result;
	}

	
	public RequestDTO getRequestById(String requestId) {
		System.out.println("getRequestById 접근 성공");
		String sql = "SELECT * FROM purchase_request WHERE request_id = ?";
	    RequestDTO dto = null;

	    try (Connection conn = getConnection();
	         PreparedStatement pstmt = conn.prepareStatement(sql)) {
	        
	        pstmt.setString(1, requestId);
	        ResultSet rs = pstmt.executeQuery();

	        if (rs.next()) {
	            dto = new RequestDTO();
	            dto.setRequestId(rs.getString("REQUEST_ID"));
	            dto.setId(rs.getString("USER_ID")); 
	            dto.setProductId(rs.getString("PRODUCT_ID"));
	            dto.setRequestQuantity(rs.getString("REQUEST_QUANTITY"));
	            dto.setRequestDate(rs.getDate("REQUEST_DATE"));
	            dto.setRequestStatus(rs.getString("REQUEST_STATUS"));
	        }
	    } catch (Exception e) {
	        e.printStackTrace();
	    }

	    return dto;
	}

	//정산 요청
	public int settleupdate(String requestId) {
		System.out.println("settleupdate 접근 성공");
		String sql = "UPDATE PURCHASE_REQUEST SET request_status ='1' WHERE request_id = ?";
		
		int result = 0;
		
		try (Connection conn = getConnection(); 
			 PreparedStatement pstmt = conn.prepareStatement(sql)) {

				pstmt.setString(1, requestId);
				result = pstmt.executeUpdate();
			} catch (Exception e) {
				e.printStackTrace();
			}
			return result;
		}

	//정산
	public int settleInsert(String requestId, String user, String requestQuantity) {
		System.out.println("settleInsert 접근 성공");
	    String sql = "INSERT INTO Purchase_Settlement \r\n"
	            + "(settlement_id, request_id, user_id, total_amount, settlement_date, settlement_status) \r\n"
	            + "VALUES (SET_SEQ.nextVal, ?, ?, ?, SYSDATE, 1)";
		int result = 0;		
		try (Connection conn = getConnection(); 
			 PreparedStatement pstmt = conn.prepareStatement(sql)) {

				pstmt.setString(1, requestId);
				pstmt.setString(2, user);
				pstmt.setString(3, requestQuantity);
				result = pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
			}
		return result;
		}

	//정산 성공
	public int completeSettle(String requestId) {
		System.out.println("completeSettle 접근 성공");
		String sql = "UPDATE PURCHASE_REQUEST SET request_status = '3' WHERE request_id = ?";
		int result = 0;
		try (Connection conn = getConnection(); 
			 PreparedStatement pstmt = conn.prepareStatement(sql)) {

				pstmt.setString(1, requestId);
				result = pstmt.executeUpdate();
				
				//업데이트 성공 실패 콘솔 출력
				if(result > 0) {
					System.out.println("request_status가 3으로 업데이트 됨");
				} else {
					System.out.println("request_status 업데이트 실패. requestId : " + requestId);
				}
		} catch (Exception e) {
			e.printStackTrace();
			}
			return result;
		}

	//거절요청
	public int rejectRequest(String requestId, String rejectReason) {
		System.out.println("rejectRequest 접근 성공");
		String sql = "UPDATE PURCHASE_REQUEST SET REQUEST_STATUS = '2', REJECT_REASON = ? WHERE REQUEST_ID = ?";
		
		int reject = 0;
		try (Connection conn = getConnection(); 
			 PreparedStatement pstmt = conn.prepareStatement(sql)) {

			pstmt.setString(1, rejectReason);
			pstmt.setString(2, requestId);
			
			reject = pstmt.executeUpdate();
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		return reject;
	}


	public int resendUpdate(String requestId, String quantity, String reason) {
	    System.out.println("resendupdate 접근 성공");
	    String sql = "UPDATE PURCHASE_REQUEST SET REQUEST_STATUS = '0', request_quantity =?, request_reason =? WHERE REQUEST_ID = ?";
	    int result = 0;

	    try (Connection conn = getConnection(); 
	         PreparedStatement pstmt = conn.prepareStatement(sql)) {

	    	pstmt.setString(1, quantity);
	    	pstmt.setString(2, reason);
	        pstmt.setString(3, requestId);
	        result = pstmt.executeUpdate();

	        System.out.println("update result: " + result);  // 결과 출력

	    } catch (Exception e) {
	        e.printStackTrace();
	    }

	    return result;
	}




}