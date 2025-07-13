<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>My Returns - Return & Refund System</title>
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
        .nav-links {
            display: flex;
            gap: 1rem;
        }
        .nav-links a {
            color: white;
            text-decoration: none;
            padding: 8px 16px;
            border-radius: 4px;
            transition: background-color 0.3s;
        }
        .nav-links a:hover {
            background-color: rgba(255,255,255,0.1);
        }
        .container {
            padding: 2rem;
            max-width: 1200px;
            margin: 0 auto;
        }
        .page-header {
            background: white;
            padding: 1.5rem;
            border-radius: 8px;
            box-shadow: 0 2px 4px rgba(0,0,0,0.1);
            margin-bottom: 2rem;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }
        .page-header h2 {
            margin: 0;
            color: #333;
        }
        .btn {
            padding: 10px 20px;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            text-decoration: none;
            font-size: 14px;
            transition: all 0.3s;
        }
        .btn-primary {
            background-color: #007bff;
            color: white;
        }
        .btn-primary:hover {
            background-color: #0056b3;
        }
        .btn-secondary {
            background-color: #6c757d;
            color: white;
        }
        .btn-secondary:hover {
            background-color: #545b62;
        }
        .btn-sm {
            padding: 6px 12px;
            font-size: 12px;
        }
        .filter-section {
            background: white;
            padding: 1.5rem;
            border-radius: 8px;
            box-shadow: 0 2px 4px rgba(0,0,0,0.1);
            margin-bottom: 2rem;
        }
        .filter-row {
            display: flex;
            gap: 1rem;
            align-items: end;
        }
        .filter-group {
            flex: 1;
        }
        .filter-group label {
            display: block;
            margin-bottom: 0.5rem;
            font-weight: bold;
            color: #333;
        }
        .filter-group select,
        .filter-group input {
            width: 100%;
            padding: 8px;
            border: 1px solid #ddd;
            border-radius: 4px;
            font-size: 14px;
        }
        .returns-section {
            background: white;
            padding: 1.5rem;
            border-radius: 8px;
            box-shadow: 0 2px 4px rgba(0,0,0,0.1);
        }
        .returns-section h3 {
            margin-top: 0;
            color: #333;
            border-bottom: 2px solid #007bff;
            padding-bottom: 0.5rem;
        }
        .returns-grid {
            display: grid;
            gap: 1rem;
            margin-top: 1rem;
        }
        .return-card {
            border: 1px solid #ddd;
            border-radius: 8px;
            padding: 1.5rem;
            background: #f8f9fa;
            transition: all 0.3s;
        }
        .return-card:hover {
            box-shadow: 0 4px 8px rgba(0,0,0,0.1);
        }
        .return-header {
            display: flex;
            justify-content: space-between;
            align-items: start;
            margin-bottom: 1rem;
        }
        .return-id {
            font-weight: bold;
            color: #007bff;
            font-size: 1.1rem;
        }
        .return-date {
            color: #6c757d;
            font-size: 0.9rem;
        }
        .return-details {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 1rem;
            margin-bottom: 1rem;
        }
        .detail-item {
            display: flex;
            flex-direction: column;
        }
        .detail-label {
            font-weight: bold;
            color: #333;
            margin-bottom: 0.25rem;
        }
        .detail-value {
            color: #555;
        }
        .status-badge {
            padding: 4px 12px;
            border-radius: 20px;
            font-size: 0.8rem;
            font-weight: bold;
            text-transform: uppercase;
            display: inline-block;
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
        .return-reason {
            background: white;
            padding: 1rem;
            border-radius: 4px;
            margin-top: 1rem;
            border-left: 4px solid #007bff;
        }
        .return-reason h4 {
            margin: 0 0 0.5rem 0;
            color: #333;
        }
        .return-actions {
            display: flex;
            gap: 0.5rem;
            margin-top: 1rem;
            padding-top: 1rem;
            border-top: 1px solid #ddd;
        }
        .empty-state {
            text-align: center;
            padding: 3rem;
            color: #6c757d;
        }
        .empty-state h3 {
            margin-bottom: 1rem;
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
        .view-toggle {
            display: flex;
            gap: 0.5rem;
            margin-bottom: 1rem;
        }
        .view-toggle button {
            padding: 8px 16px;
            border: 1px solid #ddd;
            background: white;
            cursor: pointer;
            border-radius: 4px;
        }
        .view-toggle button.active {
            background-color: #007bff;
            color: white;
            border-color: #007bff;
        }
        @media (max-width: 768px) {
            .filter-row {
                flex-direction: column;
            }
            .return-details {
                grid-template-columns: 1fr;
            }
            .return-actions {
                flex-direction: column;
            }
        }
    </style>
</head>
<body>
    <div class="header">
        <h1>My Return Requests</h1>
        <div class="nav-links">
            <a href="returnForm.jsp">New Return</a>
            <a href="LogoutServlet">Logout</a>
        </div>
    </div>

    <div class="container">
        <div class="page-header">
            <h2>My Return History</h2>
            <a href="returnForm.jsp" class="btn btn-primary">Submit New Return</a>
        </div>

        <!-- Filter Section -->
        <div class="filter-section">
            <form method="get" action="customerReturns.jsp">
                <div class="filter-row">
                    <div class="filter-group">
                        <label for="statusFilter">Status</label>
                        <select id="statusFilter" name="status">
                            <option value="">All Statuses</option>
                            <option value="Pending" ${param.status == 'Pending' ? 'selected' : ''}>Pending</option>
                            <option value="Approved" ${param.status == 'Approved' ? 'selected' : ''}>Approved</option>
                            <option value="Rejected" ${param.status == 'Rejected' ? 'selected' : ''}>Rejected</option>
                        </select>
                    </div>
                    <div class="filter-group">
                        <label for="dateFrom">From Date</label>
                        <input type="date" id="dateFrom" name="dateFrom" value="${param.dateFrom}">
                    </div>
                    <div class="filter-group">
                        <label for="dateTo">To Date</label>
                        <input type="date" id="dateTo" name="dateTo" value="${param.dateTo}">
                    </div>
                    <div class="filter-group">
                        <label>&nbsp;</label>
                        <button type="submit" class="btn btn-primary">Filter</button>
                    </div>
                </div>
            </form>
        </div>

        <!-- Returns Section -->
        <div class="returns-section">
            <div style="display: flex; justify-content: space-between; align-items: center;">
                <h3>Return Requests</h3>
                <div class="view-toggle">
                    <button onclick="toggleView('cards')" id="cardsBtn" class="active">Cards</button>
                    <button onclick="toggleView('table')" id="tableBtn">Table</button>
                </div>
            </div>

            <c:choose>
                <c:when test="${empty returnRequests}">
                    <div class="empty-state">
                        <h3>No Return Requests Found</h3>
                        <p>You haven't submitted any return requests yet.</p>
                        <a href="returnForm.jsp" class="btn btn-primary">Submit Your First Return</a>
                    </div>
                </c:when>
                <c:otherwise>
                    <!-- Cards View -->
                    <div id="cardsView" class="returns-grid">
                        <c:forEach var="request" items="${returnRequests}">
                            <div class="return-card">
                                <div class="return-header">
                                    <div class="return-id">Request #${request.requestId}</div>
                                    <div class="return-date">
                                        <fmt:formatDate value="${request.createdAt}" pattern="MMM dd, yyyy" />
                                    </div>
                                </div>

                                <div class="return-details">
                                    <div class="detail-item">
                                        <div class="detail-label">Product</div>
                                        <div class="detail-value">${request.productName}</div>
                                    </div>
                                    <div class="detail-item">
                                        <div class="detail-label">Status</div>
                                        <div class="detail-value">
                                            <span class="status-badge status-${request.status.toLowerCase()}">
                                                ${request.status}
                                            </span>
                                        </div>
                                    </div>
                                </div>

                                <div class="return-reason">
                                    <h4>Reason for Return</h4>
                                    <p>${request.reason}</p>
                                </div>

                                <div class="return-actions">
                                    <button class="btn btn-secondary btn-sm" onclick="viewDetails(${request.requestId})">View Details</button>
                                    <c:if test="${request.status == 'Pending'}">
                                        <button class="btn btn-secondary btn-sm" onclick="cancelRequest(${request.requestId})">Cancel Request</button>
                                    </c:if>
                                    <c:if test="${request.status == 'Approved'}">
                                        <button class="btn btn-primary btn-sm" onclick="trackRefund(${request.requestId})">Track Refund</button>
                                    </c:if>
                                </div>
                            </div>
                        </c:forEach>
                    </div>

                    <!-- Table View -->
                    <div id="tableView" style="display: none;">
                        <table class="table">
                            <thead>
                                <tr>
                                    <th>Request ID</th>
                                    <th>Product</th>
                                    <th>Status</th>
                                    <th>Date</th>
                                    <th>Actions</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach var="request" items="${returnRequests}">
                                    <tr>
                                        <td>#${request.requestId}</td>
                                        <td>${request.productName}</td>
                                        <td>
                                            <span class="status-badge status-${request.status.toLowerCase()}">
                                                ${request.status}
                                            </span>
                                        </td>
                                        <td>
                                            <fmt:formatDate value="${request.createdAt}" pattern="MMM dd, yyyy" />
                                        </td>
                                        <td>
                                            <button class="btn btn-secondary btn-sm" onclick="viewDetails(${request.requestId})">View</button>
                                            <c:if test="${request.status == 'Pending'}">
                                                <button class="btn btn-secondary btn-sm" onclick="cancelRequest(${request.requestId})">Cancel</button>
                                            </c:if>
                                        </td>
                                    </tr>
                                </c:forEach>
                            </tbody>
                        </table>
                    </div>
                </c:otherwise>
            </c:choose>
        </div>
    </div>

    <script>
        function toggleView(view) {
            const cardsView = document.getElementById('cardsView');
            const tableView = document.getElementById('tableView');
            const cardsBtn = document.getElementById('cardsBtn');
            const tableBtn = document.getElementById('tableBtn');

            if (view === 'cards') {
                cardsView.style.display = 'grid';
                tableView.style.display = 'none';
                cardsBtn.classList.add('active');
                tableBtn.classList.remove('active');
            } else {
                cardsView.style.display = 'none';
                tableView.style.display = 'block';
                cardsBtn.classList.remove('active');
                tableBtn.classList.add('active');
            }
        }

        function viewDetails(requestId) {
            window.location.href = 'ViewRequestServlet?requestId=' + requestId;
        }

        function cancelRequest(requestId) {
            if (confirm('Are you sure you want to cancel this return request?')) {
                window.location.href = 'CancelRequestServlet?requestId=' + requestId;
            }
        }

        function trackRefund(requestId) {
            window.location.href = 'TrackRefundServlet?requestId=' + requestId;
        }
    </script>
</body>
</html>
