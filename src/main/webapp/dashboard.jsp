<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Admin Dashboard - Return & Refund System</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 0;
            background-color: #f8f9fa;
        }
        .header {
            background-color: #343a40;
            color: white;
            padding: 1rem 2rem;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }
        .header h1 {
            margin: 0;
        }
        .user-info {
            display: flex;
            align-items: center;
            gap: 15px;
        }
        .logout-btn {
            background-color: #dc3545;
            color: white;
            padding: 8px 16px;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            text-decoration: none;
        }
        .logout-btn:hover {
            background-color: #c82333;
        }
        .container {
            padding: 2rem;
            max-width: 1200px;
            margin: 0 auto;
        }
        .stats-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
            gap: 1.5rem;
            margin-bottom: 2rem;
        }
        .stat-card {
            background: white;
            padding: 1.5rem;
            border-radius: 8px;
            box-shadow: 0 2px 4px rgba(0,0,0,0.1);
            text-align: center;
        }
        .stat-number {
            font-size: 2rem;
            font-weight: bold;
            color: #007bff;
        }
        .stat-label {
            color: #6c757d;
            margin-top: 0.5rem;
        }
        .pending { color: #ffc107; }
        .approved { color: #28a745; }
        .rejected { color: #dc3545; }
        .total { color: #007bff; }
        
        .section {
            background: white;
            padding: 1.5rem;
            border-radius: 8px;
            box-shadow: 0 2px 4px rgba(0,0,0,0.1);
            margin-bottom: 2rem;
        }
        .section h2 {
            margin-top: 0;
            color: #333;
            border-bottom: 2px solid #007bff;
            padding-bottom: 0.5rem;
        }
        .table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 1rem;
        }
        .table th, .table td {
            padding: 12px;
            text-align: left;
            border-bottom: 1px solid #ddd;
        }
        .table th {
            background-color: #f8f9fa;
            font-weight: bold;
            color: #333;
        }
        .table tr:hover {
            background-color: #f8f9fa;
        }
        .status-badge {
            padding: 4px 8px;
            border-radius: 4px;
            font-size: 0.8rem;
            font-weight: bold;
            text-transform: uppercase;
        }
        .status-pending {
            background-color: #fff3cd;
            color: #856404;
        }
        .status-approved {
            background-color: #d4edda;
            color: #155724;
        }
        .status-rejected {
            background-color: #f8d7da;
            color: #721c24;
        }
        .action-btn {
            padding: 6px 12px;
            margin: 2px;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            font-size: 0.8rem;
        }
        .btn-approve {
            background-color: #28a745;
            color: white;
        }
        .btn-reject {
            background-color: #dc3545;
            color: white;
        }
        .btn-view {
            background-color: #007bff;
            color: white;
        }
        .quick-actions {
            display: flex;
            gap: 1rem;
            margin-bottom: 2rem;
        }
        .quick-action-btn {
            padding: 12px 24px;
            background-color: #007bff;
            color: white;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            text-decoration: none;
            font-size: 1rem;
        }
        .quick-action-btn:hover {
            background-color: #0056b3;
        }
    </style>
</head>
<body>
    <div class="header">
        <h1>Admin Dashboard</h1>
        <div class="user-info">
            <span>Welcome, <%= session.getAttribute("username") %></span>
            <a href="LogoutServlet" class="logout-btn">Logout</a>
        </div>
    </div>
    
    <div class="container">
        <!-- Statistics Cards -->
        <div class="stats-grid">
            <div class="stat-card">
                <div class="stat-number total">${totalRequests}</div>
                <div class="stat-label">Total Requests</div>
            </div>
            <div class="stat-card">
                <div class="stat-number pending">${pendingRequests}</div>
                <div class="stat-label">Pending</div>
            </div>
            <div class="stat-card">
                <div class="stat-number approved">${approvedRequests}</div>
                <div class="stat-label">Approved</div>
            </div>
            <div class="stat-card">
                <div class="stat-number rejected">${rejectedRequests}</div>
                <div class="stat-label">Rejected</div>
            </div>
        </div>
        
        <!-- Quick Actions -->
        <div class="quick-actions">
            <a href="returnForm.jsp" class="quick-action-btn">New Return Request</a>
            <a href="AllReturnsServlet" class="quick-action-btn">View All Returns</a>
            <a href="RefundServlet" class="quick-action-btn">Process Refunds</a>
        </div>
        
        <!-- Recent Return Requests -->
        <div class="section">
            <h2>Recent Return Requests</h2>
            <c:choose>
                <c:when test="${empty recentRequests}">
                    <p>No recent return requests found.</p>
                </c:when>
                <c:otherwise>
                    <table class="table">
                        <thead>
                            <tr>
                                <th>Request ID</th>
                                <th>Customer</th>
                                <th>Product</th>
                                <th>Reason</th>
                                <th>Status</th>
                                <th>Date</th>
                                <th>Actions</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="request" items="${recentRequests}">
                                <tr>
                                    <td>${request.requestId}</td>
                                    <td>${request.customerName}</td>
                                    <td>${request.productName}</td>
                                    <td>${request.reason}</td>
                                    <td>
                                        <span class="status-badge status-${request.status.toLowerCase()}">
                                            ${request.status}
                                        </span>
                                    </td>
                                    <td>${request.createdAt}</td>
                                    <td>
                                        <c:if test="${request.status == 'Pending'}">
                                            <form style="display: inline;" action="UpdateStatusServlet" method="post">
                                                <input type="hidden" name="requestId" value="${request.requestId}">
                                                <input type="hidden" name="status" value="Approved">
                                                <button type="submit" class="action-btn btn-approve">Approve</button>
                                            </form>
                                            <form style="display: inline;" action="UpdateStatusServlet" method="post">
                                                <input type="hidden" name="requestId" value="${request.requestId}">
                                                <input type="hidden" name="status" value="Rejected">
                                                <button type="submit" class="action-btn btn-reject">Reject</button>
                                            </form>
                                        </c:if>
                                        <button class="action-btn btn-view" onclick="viewDetails(${request.requestId})">View</button>
                                    </td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </c:otherwise>
            </c:choose>
        </div>
        
        <!-- Status Distribution Chart (Simple Table-based) -->
        <div class="section">
            <h2>Status Distribution</h2>
            <table class="table">
                <thead>
                    <tr>
                        <th>Status</th>
                        <th>Count</th>
                        <th>Percentage</th>
                        <th>Visual</th>
                    </tr>
                </thead>
                <tbody>
                    <tr>
                        <td>Pending</td>
                        <td>${pendingRequests}</td>
                        <td>${pendingPercentage}%</td>
                        <td>
                            <div style="background-color: #ffc107; width: ${pendingPercentage}%; height: 20px; border-radius: 10px;"></div>
                        </td>
                    </tr>
                    <tr>
                        <td>Approved</td>
                        <td>${approvedRequests}</td>
                        <td>${approvedPercentage}%</td>
                        <td>
                            <div style="background-color: #28a745; width: ${approvedPercentage}%; height: 20px; border-radius: 10px;"></div>
                        </td>
                    </tr>
                    <tr>
                        <td>Rejected</td>
                        <td>${rejectedRequests}</td>
                        <td>${rejectedPercentage}%</td>
                        <td>
                            <div style="background-color: #dc3545; width: ${rejectedPercentage}%; height: 20px; border-radius: 10px;"></div>
                        </td>
                    </tr>
                </tbody>
            </table>
        </div>
    </div>
    
    <script>
        function viewDetails(requestId) {
            window.location.href = 'ViewRequestServlet?requestId=' + requestId;
        }
        
        // Auto-refresh dashboard every 5 minutes
        setTimeout(function() {
            location.reload();
        }, 300000);
    </script>
</body>
</html>