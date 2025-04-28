package view.model.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

import product.dto.ProductDTO;
import view.model.dto.IndexDTO;

public class IndexDAO {
	
    private Connection getConnection() throws Exception {
        Context initContext = new InitialContext();
        Context envContext  = (Context)initContext.lookup("java:/comp/env");
        DataSource ds = (DataSource)envContext.lookup("jdbc/purchase");
        return ds.getConnection();
    }

	public List<IndexDTO> requestResult() {
		System.out.println("Index DAO requestResult 접근 성공");
        String sql = "SELECT \r\n"
        		+ "    u.user_name         AS 요청자,\r\n"
        		+ "    p.product_name      AS 제품명,\r\n"
        		+ "    p.product_price     AS 제품가격,\r\n"
        		+ "    s.settlement_date   AS 정산완료일자\r\n"
        		+ "FROM \r\n"
        		+ "    Purchase_Settlement S\r\n"
        		+ "INNER JOIN \r\n"
        		+ "    Purchase_Request r ON r.request_id = s.request_id\r\n"
        		+ "INNER JOIN \r\n"
        		+ "    User_info u ON r.user_id = s.user_id\r\n"
        		+ "INNER JOIN \r\n"
        		+ "    Product p ON r.product_id = p.product_id\r\n"
        		+ "WHERE \r\n"
        		+ "    s.settlement_status = '1' and u.user_status = '1'\r\n"
        		+ "ORDER BY \r\n"
        		+ "    s.settlement_date DESC";
        List<IndexDTO> IndexList = new ArrayList<>();
        
        try (Connection conn = getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql); 
            ResultSet rs = pstmt.executeQuery()){
        	while (rs.next()) {
        		IndexDTO Index = new IndexDTO();
				Index.setUserName(rs.getString("요청자"));
				Index.setProductName(rs.getString("제품명"));
				Index.setProductPrice(rs.getString("제품가격"));
				Index.setSettlementDate(rs.getString("정산완료일자"));
				
				IndexList.add(Index); 
			}
        } catch (Exception e) {
            e.printStackTrace();
        }
        return IndexList;
    }
    
    
}
