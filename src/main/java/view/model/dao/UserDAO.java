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
		Context envContext = (Context) initContext.lookup("java:/comp/env");
		DataSource ds = (DataSource) envContext.lookup("jdbc/purchase");
		return ds.getConnection();
	}

	/**
	 * メソッド名: insertUser 役割: ユーザー情報を USER_INFO テーブルに新規登録する。 作成者: [イ・グァンフン] 作成日:
	 * [2025年０４月０３日]
	 */
	public int insertUser(UserDTO user) {
		int result = 0;
		String sql = "INSERT INTO USER_INFO (USER_ID, USER_NAME, USER_EMAIL, USER_STATUS, USER_CREATED, USER_PW) "
				+ "VALUES (?, ?, ?, ?, SYSDATE, ?)";
		try (Connection conn = getConnection(); PreparedStatement pstmt = conn.prepareStatement(sql)) {
			pstmt.setString(1, user.getId());
			pstmt.setString(2, user.getUserName());
			pstmt.setString(3, user.getUserEmail());
			pstmt.setString(4, user.getUserStatus());
			pstmt.setString(5, user.getPassword());

			result = pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return result;
	}

	/**
	 * メソッド名: login 役割: ユーザーIDとパスワードを用いてログイン認証を行う。 USER_INFO
	 * テーブルに該当するレコードが存在するかを確認する。 作成者: [イ・グァンフン] 作成日: [2025年０４月０３日]
	 */
	public boolean login(String id, String password) {
		boolean isValid = false;
		String sql = "SELECT * FROM USER_INFO WHERE USER_ID = ? AND USER_PW = ?";
		try (Connection conn = getConnection(); PreparedStatement pstmt = conn.prepareStatement(sql)) {
			pstmt.setString(1, id);
			pstmt.setString(2, password);
			ResultSet rs = pstmt.executeQuery();
			isValid = rs.next();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return isValid;
	}

	/**
	 * メソッド名: getUserByIdAndPw 役割:
	 * 指定されたユーザーIDとパスワードに一致するユーザーのステータス（USER_STATUS）を取得する。 ユーザー情報が一致すれば、UserDTO
	 * オブジェクトにステータスを設定して返す。 作成者: [イ・グァンフン] 作成日: [2025年０４月０３日]
	 */
	public UserDTO getUserByIdAndPw(String id, String password) {
		UserDTO user = null;
		String sql = "SELECT USER_STATUS FROM USER_INFO WHERE USER_ID = ? AND USER_PW = ?";
		try (Connection conn = getConnection(); PreparedStatement pstmt = conn.prepareStatement(sql)) {

			pstmt.setString(1, id);
			pstmt.setString(2, password);

			try (ResultSet rs = pstmt.executeQuery()) {
				if (rs.next()) {
					user = new UserDTO();
					user.setUserStatus(rs.getString("USER_STATUS")); // "0" or "1"
					String a = rs.getString("USER_STATUS");
					System.out.println("a アクセス成功" + a);
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return user;
	}

	/**
	 * メソッド名: isIdDuplicate 役割:
	 * IDの重複確認のための機能。 ユーザー情報が一致すれば、UserDTO
	 * オブジェクトにステータスを設定して返す。 作成者: [イ・グァンフン] 作成日: [2025年０４月30日]
	 */
	public boolean isIdDuplicate(String id) {
		String sql = "SELECT COUNT(*) FROM USER_INFO WHERE USER_ID = ?";
		try (Connection conn = getConnection(); PreparedStatement pstmt = conn.prepareStatement(sql)) {
			pstmt.setString(1, id);
			ResultSet rs = pstmt.executeQuery();
			if (rs.next()) {
				return rs.getInt(1) > 0;
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return false;
	}
}
