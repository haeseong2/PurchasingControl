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
		Context envContext = (Context) initContext.lookup("java:/comp/env");
		DataSource ds = (DataSource) envContext.lookup("jdbc/purchase");
		return ds.getConnection();
	}
	
	/**
	 * メソッド名: selectCount
	 * 役割: 決済が完了（settlement_status = '1'）し、かつユーザーが有効（user_status = '1'）なすべての購入リクエストの件数を取得する。
	 * 作成者: [ジョン·ジユン]
	 * 作成日: [2025年０４月24日]
	 */
	public int selectCount() {
		String sql = ""
			      + "SELECT COUNT(*) "
			      + "FROM Purchase_Settlement S "
			      + "INNER JOIN Purchase_Request  r ON r.request_id = S.request_id "
			      + "INNER JOIN User_info         u ON r.user_id      = u.user_id "
			      + "WHERE S.settlement_status = '1' "
			      + "  AND u.user_status       = '1'";
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
	 * メソッド名: requestResult
	 * 役割: 決済が完了しており、かつ有効なユーザーによる購入リクエストの一覧を取得する。
	 *       各リクエストについて、リクエストユーザー名、製品名、製品価格、決済完了日を取得する。
	 * 作成者: [ジョン·ジユン]
	 * 作成日: [2025年０４月24日]
	 */
	public List<IndexDTO> requestResult() {
		System.out.println("Index DAO requestResult アクセス成功");
		String sql = "SELECT \r\n" + "    u.user_name         AS 요청자,\r\n" + "    p.product_name      AS 제품명,\r\n"
				+ "    p.product_price     AS 제품가격,\r\n" + "    s.settlement_date   AS 정산완료일자\r\n" + "FROM \r\n"
				+ "    Purchase_Settlement S\r\n" + "INNER JOIN \r\n"
				+ "    Purchase_Request r ON r.request_id = s.request_id\r\n" + "INNER JOIN \r\n"
				+ "    User_info u ON r.user_id = s.user_id\r\n" + "INNER JOIN \r\n"
				+ "    Product p ON r.product_id = p.product_id\r\n" + "WHERE \r\n"
				+ "    s.settlement_status = '1' and u.user_status = '1'\r\n" + "ORDER BY \r\n"
				+ "    s.settlement_date DESC";
		List<IndexDTO> IndexList = new ArrayList<>();

		try (Connection conn = getConnection();
				PreparedStatement pstmt = conn.prepareStatement(sql);
				ResultSet rs = pstmt.executeQuery()) {
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

	/**
	 * メソッド名: selectIndex
	 * 役割: 決済完了かつ有効なユーザーのリクエスト情報を、指定された行番号の範囲でページネーションして取得する。
	 *       返される情報には、ユーザー名、製品名、価格、決済完了日が含まれる。
	 * パラメータ:
	 *   - firstRow: 開始行番号（1以上）
	 *   - endRow: 終了行番号
	 * 作成者: [ジョン·ジユン]
	 * 作成日: [2025年０４月24日]
	 */
	public List<IndexDTO> selectIndex(int firstRow, int endRow) {
		System.out.println("Index DAO selectIndex アクセス成功");
		String sql = "SELECT 요청자, 제품명, 제품가격, 정산완료일자 " + "FROM ( " + "    SELECT ROWNUM AS rnum, b.* " + "    FROM ( "
				+ "        SELECT " + "            u.user_name     AS 요청자, " + "            p.product_name  AS 제품명, "
				+ "            p.product_price AS 제품가격, " + "            s.settlement_date AS 정산완료일자 "
				+ "        FROM Purchase_Settlement S "
				+ "        INNER JOIN Purchase_Request r ON r.request_id = s.request_id "
				+ "        INNER JOIN User_info u      ON r.user_id     = s.user_id "
				+ "        INNER JOIN Product p        ON r.product_id  = p.product_id "
				+ "        WHERE s.settlement_status = '1' " + "          AND u.user_status       = '1' "
				+ "        ORDER BY s.settlement_date DESC " + "    ) b " + "    WHERE ROWNUM <= ? " + // バインド1: 取得する最大
																										// 行番号（endRow）
				") " + "WHERE rnum >= ? " + // バインド2: 開始行番号（startRow）
				"  AND rnum <= ?"; // バインド3: 終了行番号（endRow）

		List<IndexDTO> IndexList = new ArrayList<>();
		
		try (Connection conn = getConnection(); PreparedStatement pstmt = conn.prepareStatement(sql)) {

			pstmt.setInt(1, endRow);
			pstmt.setInt(2, firstRow);
			pstmt.setInt(3, endRow);
			ResultSet rs = pstmt.executeQuery();
			

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
