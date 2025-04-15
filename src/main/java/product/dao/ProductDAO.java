package product.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

import product.dto.ProductDTO;

public class ProductDAO {
	
	    private Connection getConnection() throws Exception {
	        Context initContext = new InitialContext();
	        Context envContext  = (Context)initContext.lookup("java:/comp/env");
	        DataSource ds = (DataSource)envContext.lookup("jdbc/purchase");
	        return ds.getConnection();
	    }

	    public int insertProduct(ProductDTO product) {
	    	System.out.println("ProductDAO 접근 성공");
	        int result = 0;
	        String sql = "INSERT INTO PRODUCT (PRODUCT_ID, PRODUCT_NAME, PRODUCT_DESCRIPTION, PRODUCT_PRICE, PRODUCT_QUANTITY) " +
	                     "VALUES (product_seq.nextVal, ?, ?, ?, ?)";
	        try (Connection conn = getConnection();
	             PreparedStatement pstmt = conn.prepareStatement(sql)) {
	            pstmt.setString(1, product.getProductName());
	            pstmt.setString(2, product.getProductDescription());
	            pstmt.setString(3, product.getProductPrice());
	            pstmt.setString(4, product.getProductQuantity());


	            result = pstmt.executeUpdate();
	        } catch (Exception e) {
	            e.printStackTrace();
	        }
	        return result;
	    }
	    
	    //전체 상품 조회
	    public List<ProductDTO> selectProduct() {
	    	System.out.println("ProductDAO 접근 성공");
	        String sql = "SELECT * FROM PRODUCT";
	        List<ProductDTO> productList = new ArrayList<>();
	        
	        try (Connection conn = getConnection();
	             PreparedStatement pstmt = conn.prepareStatement(sql); 
	            ResultSet rs = pstmt.executeQuery()){
	        	while (rs.next()) {
					ProductDTO product = new ProductDTO();
					product.setProductId(rs.getString("PRODUCT_ID"));
					product.setProductName(rs.getString("PRODUCT_NAME"));
					product.setProductDescription(rs.getString("PRODUCT_DESCRIPTION"));
					product.setProductPrice(rs.getString("PRODUCT_PRICE"));
					product.setProductQuantity(rs.getString("PRODUCT_QUANTITY"));
					productList.add(product);
				}
	        } catch (Exception e) {
	            e.printStackTrace();
	        }
	        return productList;
	    }
	    
	    //상품 수량 감소
	    public int decreaseQuantity(String productId, String quantity) throws Exception{
	        String sql = "UPDATE product SET product_quantity = product_quantity - ? WHERE product_id = ?";
	        
	        try (Connection conn = getConnection();
	        		PreparedStatement pstmt = conn.prepareStatement(sql)) {
	            pstmt.setInt(1, Integer.parseInt(quantity));   // 문자열을 int로 변환
	            pstmt.setString(2, productId);                 // productId는 그대로 문자열
	            return pstmt.executeUpdate();
	        }
	    }

	   
}
