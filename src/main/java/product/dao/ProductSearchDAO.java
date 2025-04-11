package product.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

import product.controller.ProductSearchHandler;
import product.dto.ProductDTO;

public class ProductSearchDAO {
	private Connection getConnection() throws Exception {
		Context initContext = new InitialContext();
		Context envContext = (Context) initContext.lookup("java:/comp/env");
		DataSource ds = (DataSource) envContext.lookup("jdbc/purchase");
		return ds.getConnection();
	}

	public List<ProductDTO> searchProduct(String keyword) {
		System.out.println("ProductSearchDAO 접근 성공");

		String sql = "SELECT * FROM PRODUCT WHERE PRODUCT_NAME LIKE ?";
		List<ProductDTO> productList = new ArrayList<>();

		try (Connection conn = getConnection(); PreparedStatement pstmt = conn.prepareStatement(sql)) {

			// 여기서 keyword 바인딩
			pstmt.setString(1, "%" + keyword + "%");

			try (ResultSet rs = pstmt.executeQuery()) {
				while (rs.next()) {
					ProductDTO product = new ProductDTO();
					product.setProductId(rs.getString("PRODUCT_ID"));
					product.setProductName(rs.getString("PRODUCT_NAME"));
					product.setProductDescription(rs.getString("PRODUCT_DESCRIPTION"));
					product.setProductPrice(rs.getString("PRODUCT_PRICE"));
					product.setProductQuantity(rs.getString("PRODUCT_QUANTITY"));
					productList.add(product);
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return productList;
	}
}
