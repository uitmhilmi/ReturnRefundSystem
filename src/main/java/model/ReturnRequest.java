/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

import java.sql.Timestamp;

public class ReturnRequest {
    private int requestId;
    private int userId;
    private int productId;
    private String reason;
    private String status;
    private Timestamp createdAt;
    
    // Additional fields for display
    private String userName;
    private String productName;
    
    // Default constructor
    public ReturnRequest() {}
    
    // Constructor with parameters
    public ReturnRequest(int userId, int productId, String reason) {
        this.userId = userId;
        this.productId = productId;
        this.reason = reason;
        this.status = "Pending";
    }
    
    // Getters and Setters
    public int getRequestId() { return requestId; }
    public void setRequestId(int requestId) { this.requestId = requestId; }
    
    public int getUserId() { return userId; }
    public void setUserId(int userId) { this.userId = userId; }
    
    public int getProductId() { return productId; }
    public void setProductId(int productId) { this.productId = productId; }
    
    public String getReason() { return reason; }
    public void setReason(String reason) { this.reason = reason; }
    
    public String getStatus() { return status; }
    public void setStatus(String status) { this.status = status; }
    
    public Timestamp getCreatedAt() { return createdAt; }
    public void setCreatedAt(Timestamp createdAt) { this.createdAt = createdAt; }
    
    public String getUserName() { return userName; }
    public void setUserName(String userName) { this.userName = userName; }
    
    public String getProductName() { return productName; }
    public void setProductName(String productName) { this.productName = productName; }
}