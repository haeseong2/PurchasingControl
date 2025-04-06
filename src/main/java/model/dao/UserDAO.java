package model.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import jdbc.connection.ConnectionProvider;
import model.dto.UserDTO;

public class UserDAO {

	public boolean validateUser(String username, String password) {
		String sql = "SELECT * FROM users WHERE username = ? AND password = ?";
		try (Connection conn = ConnectionProvider.getConnection();
				PreparedStatement pstmt = conn.prepareStatement(sql)) {

			pstmt.setString(1, username);
			pstmt.setString(2, password);
			ResultSet rs = pstmt.executeQuery();

			return rs.next();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return false;
	}

	public boolean registerUser(UserDTO user) {
        String sql = "INSERT INTO users (username, password) VALUES (?, ?)";
        try (Connection conn = ConnectionProvider.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setString(1, user.getUsername());
            pstmt.setString(2, user.getPassword());

            return pstmt.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace(); // 🔥 콘솔에 진짜 이유 찍힘!
        }
        return false;
    }
}
