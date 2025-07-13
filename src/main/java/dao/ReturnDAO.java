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
    
    public boolean createReturnRequest(ReturnRequest request) {
        String query = "INSERT INTO returnrequests (user_id, product_id, reason, status) VALUES (?, ?, ?, ?)";
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(query)) {
            
            stmt.setInt(1, request.getUserId());
            stmt.setInt(2, request.getProductId());
            stmt.setString(3, request.getReason());
            stmt.setString(4, request.getStatus());
            
            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }
    
    public List<ReturnRequest> getReturnRequestsByUserId(int userId) {
        List<ReturnRequest> requests = new ArrayList<>();
        String query = "SELECT r.*, u.full_name as user_name, p.name as product_name " +
                      "FROM returnrequests r " +
                      "JOIN users u ON r.user_id = u.user_id " +
                      "JOIN products p ON r.product_id = p.product_id " +
                      "WHERE r.user_id = ? ORDER BY r.created_at DESC";
        
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(query)) {
            
            stmt.setInt(1, userId);
            ResultSet rs = stmt.executeQuery();
            
            while (rs.next()) {
                ReturnRequest request = new ReturnRequest(
                    rs.getInt("user_id"),
                    rs.getInt("product_id"),
                    rs.getString("reason")
                );
                request.setUserName(rs.getString("user_name"));
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
        String query = "SELECT r.*, u.full_name as user_name, p.name as product_name " +
                      "FROM returnrequests r " +
                      "JOIN users u ON r.user_id = u.user_id " +
                      "JOIN products p ON r.product_id = p.product_id " +
                      "ORDER BY r.created_at DESC";
        
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(query)) {
            
            ResultSet rs = stmt.executeQuery();
            
            while (rs.next()) {
                ReturnRequest request = new ReturnRequest(
                    rs.getInt("user_id"),
                    rs.getInt("product_id"),
                    rs.getString("reason")
                );
                request.setUserName(rs.getString("user_name"));
                request.setProductName(rs.getString("product_name"));
                requests.add(request);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return requests;
    }
    
    public boolean updateReturnStatus(int requestId, String status) {
        String query = "UPDATE returnrequests SET status = ? WHERE request_id = ?";
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(query)) {
            
            stmt.setString(1, status);
            stmt.setInt(2, requestId);
            
            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }
    
    public ReturnRequest getReturnRequestById(int requestId) {
        String query = "SELECT r.*, u.full_name as user_name, p.name as product_name " +
                      "FROM returnrequests r " +
                      "JOIN users u ON r.user_id = u.user_id " +
                      "JOIN products p ON r.product_id = p.product_id " +
                      "WHERE r.request_id = ?";
        
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(query)) {
            
            stmt.setInt(1, requestId);
            ResultSet rs = stmt.executeQuery();
            
            if (rs.next()) {
                ReturnRequest request = new ReturnRequest(
                    rs.getInt("user_id"),
                    rs.getInt("product_id"),
                    rs.getString("reason")
                );
                request.setUserName(rs.getString("user_name"));
                request.setProductName(rs.getString("product_name"));
                return request;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }
    
    public int getReturnCountByStatus(String status) {
        String query = "SELECT COUNT(*) FROM returnrequests WHERE status = ?";
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(query)) {
            
            stmt.setString(1, status);
            ResultSet rs = stmt.executeQuery();
            
            if (rs.next()) {
                return rs.getInt(1);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return 0;
    }
    
    public int getTotalReturnRequests() {
        String query = "SELECT COUNT(*) FROM returnrequests";
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(query)) {
            
            ResultSet rs = stmt.executeQuery();
            
            if (rs.next()) {
                return rs.getInt(1);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return 0;
    }
    
    public List<ReturnRequest> getLatestReturnRequests(int limit) {
        List<ReturnRequest> requests = new ArrayList<>();
        String query = "SELECT r.*, u.full_name as user_name, p.name as product_name " +
                      "FROM returnrequests r " +
                      "JOIN users u ON r.user_id = u.user_id " +
                      "JOIN products p ON r.product_id = p.product_id " +
                      "ORDER BY r.created_at DESC LIMIT ?";
        
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(query)) {
            
            stmt.setInt(1, limit);
            ResultSet rs = stmt.executeQuery();
            
            while (rs.next()) {
                ReturnRequest request = new ReturnRequest(
                    rs.getInt("user_id"),
                    rs.getInt("product_id"),
                    rs.getString("reason")
                );
                request.setUserName(rs.getString("user_name"));
                request.setProductName(rs.getString("product_name"));
                requests.add(request);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return requests;
    }
    
    public boolean deleteReturnRequest(int requestId) {
        String query = "DELETE FROM returnrequests WHERE request_id = ?";
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(query)) {
            
            stmt.setInt(1, requestId);
            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }
}
