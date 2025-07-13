/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dao;

import model.ReturnRequest;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class ReturnDAO {
    
    public boolean insertReturnRequest(ReturnRequest returnRequest) {
        String sql = "INSERT INTO ReturnRequests (user_id, product_id, reason, status) VALUES (?, ?, ?, ?)";
        
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setInt(1, returnRequest.getUserId());
            stmt.setInt(2, returnRequest.getProductId());
            stmt.setString(3, returnRequest.getReason());
            stmt.setString(4, returnRequest.getStatus());
            
            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
    
    public List<ReturnRequest> getReturnRequestsByUserId(int userId) {
        List<ReturnRequest> requests = new ArrayList<>();
        String sql = "SELECT rr.*, p.name as product_name FROM ReturnRequests rr " +
                    "JOIN Products p ON rr.product_id = p.product_id " +
                    "WHERE rr.user_id = ? ORDER BY rr.created_at DESC";
        
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setInt(1, userId);
            ResultSet rs = stmt.executeQuery();
            
            while (rs.next()) {
                ReturnRequest request = new ReturnRequest();
                request.setRequestId(rs.getInt("request_id"));
                request.setUserId(rs.getInt("user_id"));
                request.setProductId(rs.getInt("product_id"));
                request.setReason(rs.getString("reason"));
                request.setStatus(rs.getString("status"));
                request.setCreatedAt(rs.getTimestamp("created_at"));
                request.setProductName(rs.getString("product_name"));
                requests.add(request);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return requests;
    }
    
    public List<ReturnRequest> getAllReturnRequests() {
        List<ReturnRequest> requests = new ArrayList<>();
        String sql = "SELECT rr.*, u.full_name as user_name, p.name as product_name " +
                    "FROM ReturnRequests rr " +
                    "JOIN Users u ON rr.user_id = u.user_id " +
                    "JOIN Products p ON rr.product_id = p.product_id " +
                    "ORDER BY rr.created_at DESC";
        
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {
            
            while (rs.next()) {
                ReturnRequest request = new ReturnRequest();
                request.setRequestId(rs.getInt("request_id"));
                request.setUserId(rs.getInt("user_id"));
                request.setProductId(rs.getInt("product_id"));
                request.setReason(rs.getString("reason"));
                request.setStatus(rs.getString("status"));
                request.setCreatedAt(rs.getTimestamp("created_at"));
                request.setUserName(rs.getString("user_name"));
                request.setProductName(rs.getString("product_name"));
                requests.add(request);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return requests;
    }
    
    public boolean updateReturnRequestStatus(int requestId, String status) {
        String sql = "UPDATE ReturnRequests SET status = ? WHERE request_id = ?";
        
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setString(1, status);
            stmt.setInt(2, requestId);
            
            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
    
    public ReturnRequest getReturnRequestById(int requestId) {
        String sql = "SELECT rr.*, u.full_name as user_name, p.name as product_name, p.price " +
                    "FROM ReturnRequests rr " +
                    "JOIN Users u ON rr.user_id = u.user_id " +
                    "JOIN Products p ON rr.product_id = p.product_id " +
                    "WHERE rr.request_id = ?";
        
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setInt(1, requestId);
            ResultSet rs = stmt.executeQuery();
            
            if (rs.next()) {
                ReturnRequest request = new ReturnRequest();
                request.setRequestId(rs.getInt("request_id"));
                request.setUserId(rs.getInt("user_id"));
                request.setProductId(rs.getInt("product_id"));
                request.setReason(rs.getString("reason"));
                request.setStatus(rs.getString("status"));
                request.setCreatedAt(rs.getTimestamp("created_at"));
                request.setUserName(rs.getString("user_name"));
                request.setProductName(rs.getString("product_name"));
                return request;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }
    
    public int[] getReturnStatistics() {
        int[] stats = new int[4]; // [total, pending, approved, rejected]
        String sql = "SELECT " +
                    "COUNT(*) as total, " +
                    "SUM(CASE WHEN status = 'Pending' THEN 1 ELSE 0 END) as pending, " +
                    "SUM(CASE WHEN status = 'Approved' THEN 1 ELSE 0 END) as approved, " +
                    "SUM(CASE WHEN status = 'Rejected' THEN 1 ELSE 0 END) as rejected " +
                    "FROM ReturnRequests";
        
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {
            
            if (rs.next()) {
                stats[0] = rs.getInt("total");
                stats[1] = rs.getInt("pending");
                stats[2] = rs.getInt("approved");
                stats[3] = rs.getInt("rejected");
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return stats;
    }
}
