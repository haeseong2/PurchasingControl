package view.model.dto;

public class UserDTO {
    private String id;
    private String userName;
    private String userEmail;
    private String userStatus;  // status -> userStatus로 변경
    private String departmentId;
    private String password;  // pw -> password로 변경

    public String getId() { return id; }
    public void setId(String id) { this.id = id; }

    public String getUserName() { return userName; }
    public void setUserName(String userName) { this.userName = userName; }

    public String getUserEmail() { return userEmail; }
    public void setUserEmail(String userEmail) { this.userEmail = userEmail; }

    public String getUserStatus() { return userStatus; }  // getStatus() -> getUserStatus()로 변경
    public void setUserStatus(String userStatus) { this.userStatus = userStatus; }  // setStatus() -> setUserStatus()로 변경

    public String getDepartmentId() { return departmentId; }
    public void setDepartmentId(String departmentId) { this.departmentId = departmentId; }

    public String getPassword() { return password; }  // getPw() -> getPassword()로 변경
    public void setPassword(String password) { this.password = password; }  // setPw() -> setPassword()로 변경
}
