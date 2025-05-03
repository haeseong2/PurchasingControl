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
	
	
	/**
	 * メソッド名: insertRequest
	 * 役割: 購入リクエストテーブル（Purchase_Request）に新しいリクエスト情報を挿入する。
	 * 作成者: [イ·グァンフン]
	 * 作成日: [作成日]
	 */
	public int insertRequest(RequestDTO request) {
		System.out.println("RequestDAO insertRequest アクセス成功");
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
	
	/**
	 * メソッド名: selectCount
	 * 役割: 指定されたユーザーIDに基づいて、購入リクエストテーブル（PURCHASE_REQUEST）内の該当リクエストの件数を取得する。
	 * 作成者: [イ·グァンフン]
	 * 作成日: [作成日]
	 */
    public int selectCount(String id) {
		System.out.println("RequestDAO selectCount アクセス成功");
        String sql = "SELECT COUNT(*) FROM PURCHASE_REQUEST WHERE USER_ID = ?";
        try (Connection conn = getConnection();
	             PreparedStatement pstmt = conn.prepareStatement(sql); 
	            ) {
        	pstmt.setString(1, id);
        	ResultSet rs = pstmt.executeQuery();
            return rs.next() ? rs.getInt(1) : 0;
        } catch (Exception e) {
			e.printStackTrace();
			return 0;
		}
    }

    /**
     * メソッド名: selectAllCount
     * 役割: 購入リクエストテーブル（PURCHASE_REQUEST）のリクエストステータスが '0' のすべてのリクエストの件数を取得する。
     * 作成者: [イ·グァンフン]
     * 作成日: [作成日]
     */
    public int selectAllCount() {
		System.out.println("RequestDAO selectAllCount アクセス成功");
        String sql = "SELECT COUNT(*) FROM PURCHASE_REQUEST WHERE REQUEST_STATUS = '0'";
        try (Connection conn = getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql);
             ResultSet rs = pstmt.executeQuery()) {
            return rs.next() ? rs.getInt(1) : 0;
        } catch (Exception e) {
            e.printStackTrace();
            return 0;
        }
    }
    
    /**
     * メソッド名: requestCheck
     * 役割: 指定されたユーザーIDに基づいて、購入リクエスト情報をページネーションを使って取得する。
     * 作成者: [チェ・ジェヨン]
     * 作成日: [2025年０４月13日］
     * */
	public List<RequestDTO> requestCheck(String id, int startRow, int endRow) throws Exception {
	    System.out.println("RequestDAO requestCheck アクセス成功");
	    String sql = "SELECT * FROM ( " +
	    	    "  SELECT ROWNUM AS rnum, a.* FROM ( " +
	    	    "    SELECT UI.USER_NAME, PR.PRODUCT_ID, P.PRODUCT_NAME, PR.REQUEST_QUANTITY, " +
	    	    "           PR.REQUEST_DATE, PR.REQUEST_STATUS, PR.REQUEST_REASON, PR.REJECT_REASON, " +
	    	    "           PR.REQUEST_ID, PR.USER_ID " +
	    	    "    FROM PURCHASE_REQUEST PR " +
	    	    "    INNER JOIN USER_INFO UI ON UI.USER_ID = PR.USER_ID " +
	    	    "    INNER JOIN PRODUCT P ON P.PRODUCT_ID = PR.PRODUCT_ID " +
	    	    "    WHERE PR.USER_ID = ? " +
	    	    "    ORDER BY PR.REQUEST_DATE DESC " +  
	    	    "  ) a WHERE ROWNUM <= ? " +  // endRow
	    	    ") WHERE rnum >= ?";  
	    List<RequestDTO> requestList = new ArrayList<>();

	    try (Connection conn = getConnection(); 
	         PreparedStatement pstmt = conn.prepareStatement(sql)) {

	        pstmt.setString(1, id);
	        pstmt.setInt(2, endRow);      
	        pstmt.setInt(3, startRow);    
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
	            e.printStackTrace(); 
	        }
	    } catch (SQLException e) {
	        e.printStackTrace();
	        throw new Exception("Database error during request check.");
	    }

	    return requestList;
	}

	/**
	 * メソッド名: adminCheck
	 * 役割: 管理者が確認できる、購入リクエストの一覧をページネーションを使って取得する。リクエストステータスが「0」のものに限る。
	 * 作成者: [チェ・ジェヨン]
	 * 作成日: [2025年０４月13日]
	 */
	public List<RequestDTO> adminCheck(int startRow, int endRow) {
	    System.out.println("RequestDAO adminCheck アクセス成功");
	    String sql = 
	        "SELECT * FROM ( " +
	        "  SELECT ROWNUM AS rnum, a.* FROM ( " +
	        "    SELECT PR.REQUEST_ID, PR.USER_ID, UI.USER_NAME, PR.PRODUCT_ID, " +
	        "           P.PRODUCT_NAME, PR.REQUEST_QUANTITY, PR.REQUEST_DATE, " +
	        "           PR.REQUEST_REASON, PR.REQUEST_STATUS " +
	        "    FROM PURCHASE_REQUEST PR " +
	        "    INNER JOIN USER_INFO UI ON UI.USER_ID = PR.USER_ID " +
	        "    INNER JOIN PRODUCT P ON P.PRODUCT_ID = PR.PRODUCT_ID " +
	        "    WHERE PR.REQUEST_STATUS = '0' " +
	        "    ORDER BY PR.REQUEST_DATE DESC " +
	        "  ) a WHERE ROWNUM <= ? " +  // endRow
	        ") WHERE rnum >= ?";          // startRow

	    List<RequestDTO> adminList = new ArrayList<>();

	    try (Connection conn = getConnection(); 
	         PreparedStatement pstmt = conn.prepareStatement(sql)) {

	        pstmt.setInt(1, endRow);  
	        pstmt.setInt(2, startRow);

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

	
	/**
	 * メソッド名: approvalCheck
	 * 役割: 指定されたリクエストIDに対して、購入リクエストのステータスを「1」に更新する（承認処理）。
	 * 作成者: [チェ・ジェヨン]
	 * 作成日: [2025年０４月13日]
	 */
	public int approvalCheck(String requestId) {
		System.out.println("approvalCheck アクセス成功");
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

	
	/**
	 * メソッド名: getRequestById
	 * 役割: 指定されたリクエストIDに基づいて購入リクエストの詳細を取得する。
	 * 作成者: [チェ・ジェヨン]
	 * 作成日: [2025年０４月13日]
	 */
	public RequestDTO getRequestById(String requestId) {
		System.out.println("getRequestById アクセス成功");
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
	

	/**
	 * メソッド名: settleupdate
	 * 役割: 指定されたリクエストIDに基づいて、リクエストのステータスを'1'に更新する。
	 * 作成者: [チェ・ジェヨン]
	 * 作成日: [2025年04月13日]
	 */
	public int settleupdate(String requestId) {
		System.out.println("settleupdate アクセス成功");
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

	
	/**
	 * メソッド名: settleInsert
	 * 役割: 指定されたリクエストID、ユーザーID、リクエスト数量に基づいて、購入決済情報をデータベースに挿入する。
	 * 作成者: [チェ・ジェヨン]
	 * 作成日: [2025年04月13日]
	 */
	public int settleInsert(String requestId, String user, String requestQuantity) {
		System.out.println("settleInsert アクセス成功");
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

	
	/**
	 * メソッド名: completeSettle
	 * 役割: 指定されたリクエストIDに基づいて、購入リクエストのステータスを「3」に更新する。
	 * 作成者: [チェ・ジェヨン]
	 * 作成日: [2025年04月13日]
	 */
	public int completeSettle(String requestId) {
		System.out.println("completeSettle アクセス成功");
		String sql = "UPDATE PURCHASE_REQUEST SET request_status = '3' WHERE request_id = ?";
		int result = 0;
		try (Connection conn = getConnection(); 
			 PreparedStatement pstmt = conn.prepareStatement(sql)) {

				pstmt.setString(1, requestId);
				result = pstmt.executeUpdate();
				
				//update 成功失敗コンソール出力
				if(result > 0) {
					System.out.println("request_statusが3にupdateされました");
				} else {
					System.out.println("request_statusのupdateに失敗しました。requestId : " + requestId);
				}
		} catch (Exception e) {
			e.printStackTrace();
			}
			return result;
		}

	/**
	 * メソッド名: rejectRequest
	 * 役割: 指定されたリクエストIDに基づいて、購入リクエストのステータスを「2」に更新し、拒否理由を設定する。
	 * 作成者: [チェ・ジェヨン]
	 * 作成日: [2025年04月13日]
	 */
	public int rejectRequest(String requestId, String rejectReason) {
		System.out.println("rejectRequest アクセス成功");
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


	/**
	 * メソッド名: resendUpdate
	 * 役割: 指定されたリクエストIDに基づいて、購入リクエストのステータスを「0」に更新し、リクエスト数量と理由を再設定する。
	 * 作成者: [チェ・ジェヨン]
	 * 作成日: [2025年04月13日]
	 */
	public int resendUpdate(String requestId, String quantity, String reason) {
	    System.out.println("resendupdate アクセス成功");
	    String sql = "UPDATE PURCHASE_REQUEST SET REQUEST_STATUS = '0', request_quantity =?, request_reason =? WHERE REQUEST_ID = ?";
	    int result = 0;

	    try (Connection conn = getConnection(); 
	         PreparedStatement pstmt = conn.prepareStatement(sql)) {

	    	pstmt.setString(1, quantity);
	    	pstmt.setString(2, reason);
	        pstmt.setString(3, requestId);
	        result = pstmt.executeUpdate();

	        System.out.println("update result: " + result); 

	    } catch (Exception e) {
	        e.printStackTrace();
	    }

	    return result;
	}


	/**
	 * メソッド名: checkResultSearch
	 * 役割: ユーザーIDとキーワードに基づいて、ユーザーの購入リクエストを検索し、リクエスト情報をリストとして返す。
	 * 作成者: [チェ・ジェヨン]
	 * 作成日: [2025年04月13日]
	 */
	public List<RequestDTO> checkResultSearch(String id, String keyword) throws Exception {
		System.out.println("RequestDAO checkResultSearch アクセス成功");
	    String sql = "SELECT UI.USER_NAME, PR.PRODUCT_ID, P.PRODUCT_NAME, PR.REQUEST_QUANTITY, PR.REQUEST_DATE, PR.REQUEST_STATUS, PR.REQUEST_REASON, PR.REJECT_REASON, PR.REQUEST_ID, PR.USER_ID " +
	                 "FROM PURCHASE_REQUEST PR " +
	                 "INNER JOIN USER_INFO UI ON UI.USER_ID = PR.USER_ID " +
	                 "INNER JOIN PRODUCT P ON P.PRODUCT_ID = PR.PRODUCT_ID " +
	                 "WHERE PR.USER_ID = ?" +
	                 "AND UI.USER_NAME LIKE ?";
	    List<RequestDTO> requestList = new ArrayList<>();

	    try (Connection conn = getConnection(); 
	         PreparedStatement pstmt = conn.prepareStatement(sql)) {
	        keyword = "%" + keyword + "%";
	        pstmt.setString(1, id);
	        pstmt.setString(2, keyword);
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
	
	
	
	/**
	 * メソッド名: checkResultSearch
	 * 役割: ユーザーIDとキーワードに基づいて、購入リクエストを検索し、指定されたページ範囲のリクエスト情報を返す。
	 *       このメソッドはページング機能をサポートしており、リクエストの検索結果を指定された行数の範囲で返します。
	 * 作成者: [チェ・ジェヨン]
	 * 作成日: [2025年04月13日]
	 */
	public List<RequestDTO> checkResultSearch(String id, String keyword, int startRow, int endRow) throws Exception {
	    System.out.println("RequestDAO checkResultSearch(ページング) アクセス成功");
	    String sql = "SELECT * FROM ( " +
	                 "  SELECT ROWNUM AS rnum, a.* FROM ( " +
	                 "    SELECT UI.USER_NAME, PR.PRODUCT_ID, P.PRODUCT_NAME, PR.REQUEST_QUANTITY, PR.REQUEST_DATE, " +
	                 "           PR.REQUEST_STATUS, PR.REQUEST_REASON, PR.REJECT_REASON, PR.REQUEST_ID, PR.USER_ID " +
	                 "    FROM PURCHASE_REQUEST PR " +
	                 "    INNER JOIN USER_INFO UI ON UI.USER_ID = PR.USER_ID " +
	                 "    INNER JOIN PRODUCT P ON P.PRODUCT_ID = PR.PRODUCT_ID " +
	                 "    WHERE PR.USER_ID = ? " +
	                 "      AND UI.USER_NAME LIKE ? " +
	                 "    ORDER BY PR.REQUEST_DATE DESC " +
	                 "  ) a WHERE ROWNUM <= ? " +
	                 ") WHERE rnum >= ?";
	    
	    List<RequestDTO> requestList = new ArrayList<>();

	    try (Connection conn = getConnection();
	         PreparedStatement pstmt = conn.prepareStatement(sql)) {

	        pstmt.setString(1, id);
	        pstmt.setString(2, "%" + keyword + "%");
	        pstmt.setInt(3, endRow);
	        pstmt.setInt(4, startRow);

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
	        }
	    }
	    return requestList;
	}

	
	/**
	 * メソッド名: selectCountByKeyword
	 * 役割: 指定されたキーワードに基づいて、購入リクエストの件数を検索します。
	 *       ユーザー名がキーワードに部分一致するリクエストを対象にし、リクエスト状態が「0」（未処理）のものをカウントします。
	 * 作成者: [チェ・ジェヨン]
	 * 作成日: [2025年04月13日]
	 */
	public int selectCountByKeyword(String keyword) {
		System.out.println("RequestDAO selectCountByKeyword アクセス成功");
	    String sql = "SELECT COUNT(*) FROM PURCHASE_REQUEST PR " +
	                 "INNER JOIN USER_INFO UI ON UI.USER_ID = PR.USER_ID " +
	                 "WHERE PR.REQUEST_STATUS = '0' AND UI.USER_NAME LIKE ?";

	    try (Connection conn = getConnection();
	         PreparedStatement pstmt = conn.prepareStatement(sql)) {
	        pstmt.setString(1, "%" + keyword + "%");
	        try (ResultSet rs = pstmt.executeQuery()) {
	            if (rs.next()) {
	                return rs.getInt(1);
	            }
	        }
	    } catch (Exception e) {
	        e.printStackTrace();
	    }
	    return 0;
	}
	
	
	/**
	 * メソッド名: selectCountByUserAndKeyword
	 * 役割: 指定されたユーザーIDとキーワードに基づいて、購入リクエストの件数を検索します。
	 *       ユーザーIDが一致し、かつユーザー名がキーワードに部分一致するリクエストをカウントします。
	 * 作成者: [チェ・ジェヨン]
	 * 作成日: [2025年04月13日]
	 */
	public int selectCountByUserAndKeyword(String id, String keyword) {
		System.out.println("RequestDAO selectCountByUserAndKeyword アクセス成功");
	    String sql = "SELECT COUNT(*) FROM PURCHASE_REQUEST PR " +
	                 "INNER JOIN USER_INFO UI ON UI.USER_ID = PR.USER_ID " +
	                 "WHERE PR.USER_ID = ? " +
	                 "AND UI.USER_NAME LIKE ?";
	    try (Connection conn = getConnection();
	         PreparedStatement pstmt = conn.prepareStatement(sql)) {
	        pstmt.setString(1, id);
	        pstmt.setString(2, "%" + keyword + "%");
	        try (ResultSet rs = pstmt.executeQuery()) {
	            if (rs.next()) {
	                return rs.getInt(1);
	            }
	        }
	    } catch (Exception e) {
	        e.printStackTrace();
	    }
	    return 0;
	}

	
	
	/**
	 * メソッド名: adminCheckSearch
	 * 役割: 管理者が購入リクエストを検索するためのメソッド。検索キーワードとページングに基づいて、購入リクエストのリストを返す。
	 *       ユーザー名がキーワードに部分一致し、リクエストステータスが「0」である購入リクエストを検索。
	 *       結果はページングされ、開始行と終了行を指定して結果を取得します。
	 * 作成者: [チェ・ジェヨン]
	 * 作成日: [2025年04月13日]
	 */
	public List<RequestDTO> adminCheckSearch(String keyword, int startRow, int endRow) {
	    System.out.println("RequestDAO adminCheckSearch(ページング) アクセス成功");
	    String sql = 
	        "SELECT * FROM ( " +
	        "  SELECT ROWNUM AS rnum, a.* FROM ( " +
	        "    SELECT PR.REQUEST_ID, PR.USER_ID, UI.USER_NAME, PR.PRODUCT_ID, " +
	        "           P.PRODUCT_NAME, PR.REQUEST_QUANTITY, PR.REQUEST_DATE, " +
	        "           PR.REQUEST_REASON, PR.REQUEST_STATUS " +
	        "    FROM PURCHASE_REQUEST PR " +
	        "    INNER JOIN USER_INFO UI ON UI.USER_ID = PR.USER_ID " +
	        "    INNER JOIN PRODUCT P ON P.PRODUCT_ID = PR.PRODUCT_ID " +
	        "    WHERE PR.REQUEST_STATUS = '0' " +
	        "      AND UI.USER_NAME LIKE ? " +
	        "    ORDER BY PR.REQUEST_DATE DESC " +
	        "  ) a WHERE ROWNUM <= ? " +
	        ") WHERE rnum >= ?";

	    List<RequestDTO> adminList = new ArrayList<>();

	    try (Connection conn = getConnection();
	         PreparedStatement pstmt = conn.prepareStatement(sql)) {
	        pstmt.setString(1, "%" + keyword + "%");
	        pstmt.setInt(2, endRow);
	        pstmt.setInt(3, startRow);

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





}