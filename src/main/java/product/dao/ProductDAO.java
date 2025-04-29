package product.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

import product.dto.ProductDTO;
import product.dto.ProductPageDTO;

public class ProductDAO {

	private Connection getConnection() throws Exception {
		Context initContext = new InitialContext();
		Context envContext = (Context) initContext.lookup("java:/comp/env");
		DataSource ds = (DataSource) envContext.lookup("jdbc/purchase");
		return ds.getConnection();
	}

	public int insertProduct(ProductDTO product) {
		System.out.println("ProductDAO 접근 성공");
		int result = 0;
		String sql = "INSERT INTO PRODUCT (PRODUCT_ID, PRODUCT_NAME, PRODUCT_DESCRIPTION, PRODUCT_PRICE, PRODUCT_QUANTITY) "
				+ "VALUES (product_seq.nextVal, ?, ?, ?, ?)";
		try (Connection conn = getConnection(); PreparedStatement pstmt = conn.prepareStatement(sql)) {
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

	/*
	 * public List<ProductDTO> select() { System.out.println("ProductDAO 접근 성공");
	 * String sql = "SELECT * FROM PRODUCT"; List<ProductDTO> productList = new
	 * ArrayList<>();
	 * 
	 * try (Connection conn = getConnection(); PreparedStatement pstmt =
	 * conn.prepareStatement(sql); ResultSet rs = pstmt.executeQuery()){ while
	 * (rs.next()) { ProductDTO product = new ProductDTO();
	 * product.setProductId(rs.getString("PRODUCT_ID"));
	 * product.setProductName(rs.getString("PRODUCT_NAME"));
	 * product.setProductDescription(rs.getString("PRODUCT_DESCRIPTION"));
	 * product.setProductPrice(rs.getString("PRODUCT_PRICE"));
	 * product.setProductQuantity(rs.getString("PRODUCT_QUANTITY"));
	 * productList.add(product); } } catch (Exception e) { e.printStackTrace(); }
	 * return productList; }
	 */

	public int decreaseQuantity(String productId, String quantity) throws Exception {
		String sql = "UPDATE product SET product_quantity = product_quantity - ? WHERE product_id = ?";

		try (Connection conn = getConnection(); PreparedStatement pstmt = conn.prepareStatement(sql)) {

			pstmt.setInt(1, Integer.parseInt(quantity)); // 문자열을 int로 변환
			pstmt.setString(2, productId);

			return pstmt.executeUpdate();
		}
	}

	public int selectCount() {
		String sql = "SELECT COUNT(*) FROM PRODUCT";
		try (Connection conn = getConnection();
				PreparedStatement pstmt = conn.prepareStatement(sql);
				ResultSet rs = pstmt.executeQuery()) {
			return rs.next() ? rs.getInt(1) : 0;
		} catch (Exception e) {
			e.printStackTrace();
			return 0;
		}
	}

	public List<ProductDTO> selectProduct(int firstRow, int endRow) {

		String sql = "SELECT * FROM (SELECT ROWNUM AS rnum, b.* FROM ("
				+ "SELECT * FROM PRODUCT ORDER BY PRODUCT_ID DESC) b " + "WHERE ROWNUM <= ?) "
				+ "WHERE rnum >= ? AND rnum <= ?";

		try (Connection conn = getConnection(); PreparedStatement pstmt = conn.prepareStatement(sql);) {

			pstmt.setInt(1, endRow);
			pstmt.setInt(2, firstRow);
			pstmt.setInt(3, endRow);
			ResultSet rs = pstmt.executeQuery();
			List<ProductDTO> result = new ArrayList<>();

			while (rs.next()) {
				ProductDTO product = new ProductDTO();
				product.setProductId(rs.getString("PRODUCT_ID"));
				product.setProductName(rs.getString("PRODUCT_NAME"));
				product.setProductDescription(rs.getString("PRODUCT_DESCRIPTION"));
				product.setProductPrice(rs.getString("PRODUCT_PRICE"));
				product.setProductQuantity(rs.getString("PRODUCT_QUANTITY"));
				result.add(product);
			}

			return result;
		} catch (Exception e) {
			e.printStackTrace();
			return null;
		}
	}

}
