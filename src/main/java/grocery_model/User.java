package grocery_model;

public class User {

    private Integer userId;
    private String fullName;
    private String email;
    private String password;
    private String phone;
    private String address;
    private String role;
    private String status;

    
    public User() {
    }

    
    public Integer getUserId() {
        return userId;
    }
    public void setUserId(Integer userId) {
        this.userId = userId;
    }

    
    public String getFullName() {
        return fullName;
    }
    public void setFullName(String fullName) {
        this.fullName = fullName;
    }

   
    public String getEmail() {
        return email;
    }
    public void setEmail(String email) {
        this.email = email;
    }

    
    public String getPassword() {
        return password;
    }
    public void setPassword(String password) {
        this.password = password;
    }

    
    public String getPhone() {
        return phone;
    }
    public void setPhone(String phone) {
        this.phone = phone;
    }

    
    public String getAddress() {
        return address;
    }
    public void setAddress(String address) {
        this.address = address;
    }

   
    public String getRole() {
        return role;
    }
    public void setRole(String role) {
        this.role = role;
    }

    
    public String getStatus() {
        return status;
    }
    public void setStatus(String status) {
        this.status = status;
    }
}