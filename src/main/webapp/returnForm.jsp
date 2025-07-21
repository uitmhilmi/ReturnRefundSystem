<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Submit Return Request - Return & Refund System</title>
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
            max-width: 800px;
            margin: 0 auto;
        }
        .form-container {
            background: white;
            padding: 2rem;
            border-radius: 8px;
            box-shadow: 0 2px 4px rgba(0,0,0,0.1);
        }
        .form-header {
            margin-bottom: 2rem;
            text-align: center;
        }
        .form-header h2 {
            color: #333;
            margin-bottom: 0.5rem;
        }
        .form-header p {
            color: #6c757d;
        }
        .form-group {
            margin-bottom: 1.5rem;
        }
        label {
            display: block;
            margin-bottom: 0.5rem;
            font-weight: bold;
            color: #333;
        }
        .required {
            color: #dc3545;
        }
        select, textarea {
            width: 100%;
            padding: 12px;
            border: 1px solid #ddd;
            border-radius: 4px;
            font-size: 16px;
            font-family: inherit;
            box-sizing: border-box;
        }
        select:focus, textarea:focus {
            outline: none;
            border-color: #007bff;
            box-shadow: 0 0 0 2px rgba(0,123,255,0.25);
        }
        textarea {
            resize: vertical;
            min-height: 100px;
        }
        .btn {
            padding: 12px 24px;
            border: none;
            border-radius: 4px;
            font-size: 16px;
            cursor: pointer;
            text-decoration: none;
            display: inline-block;
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
            margin-left: 10px;
        }
        .btn-secondary:hover {
            background-color: #545b62;
        }
        .error-message {
            color: #dc3545;
            background-color: #f8d7da;
            border: 1px solid #f5c6cb;
            padding: 12px;
            border-radius: 4px;
            margin-bottom: 1rem;
        }
        .success-message {
            color: #155724;
            background-color: #d4edda;
            border: 1px solid #c3e6cb;
            padding: 12px;
            border-radius: 4px;
            margin-bottom: 1rem;
        }
        .form-actions {
            display: flex;
            justify-content: flex-end;
            margin-top: 2rem;
            padding-top: 1rem;
            border-top: 1px solid #eee;
        }
        .character-count {
            font-size: 0.8rem;
            color: #6c757d;
            text-align: right;
            margin-top: 0.25rem;
        }
        .form-note {
            background-color: #e7f3ff;
            border: 1px solid #b3d9ff;
            padding: 12px;
            border-radius: 4px;
            margin-bottom: 1.5rem;
            font-size: 0.9rem;
        }
        .form-note strong {
            color: #004085;
        }
    </style>
</head>
<body>
    <div class="header">
        <h1>Return Request Form</h1>
        <div class="nav-links">
            <c:choose>
                <c:when test="${sessionScope.role == 'admin'}">
                    <a href="dashboard.jsp">Dashboard</a>
                </c:when>
                <c:otherwise>
                    <a href="customerReturns">My Returns</a>
                </c:otherwise>
            </c:choose>
            <a href="LogoutServlet">Logout</a>
        </div>
    </div>
    
    <div class="container">
        <div class="form-container">
            <div class="form-header">
                <h2>Submit Return Request</h2>
                <p>Please fill out the form below to submit your return request. All fields marked with <span class="required">*</span> are required.</p>
            </div>
            
            <div class="form-note">
                <strong>Note:</strong> Please ensure all information is accurate before submitting. 
                Return requests are typically processed within 2-3 business days.
            </div>
            
            <% String errorMessage = (String) request.getAttribute("errorMessage"); %>
            <% if (errorMessage != null) { %>
                <div class="error-message">
                    <%= errorMessage %>
                </div>
            <% } %>
            
            <% String successMessage = (String) request.getAttribute("successMessage"); %>
            <% if (successMessage != null) { %>
                <div class="success-message">
                    <%= successMessage %>
                </div>
            <% } %>
            
            <form action="returnForm" method="post" onsubmit="return validateForm()">
                <div class="form-group">
                    <label for="product">Product <span class="required">*</span></label>
                    <select id="product" name="productId" required>
                        <option value="">-- Select a Product --</option>
                        <c:forEach var="product" items="${products}">
                            <option value="${product.productId}">
                                ${product.name} - $${product.price}
                            </option>
                        </c:forEach>
                        <!-- Fallback options if products are not loaded from database -->
                        <c:if test="${empty products}">
                            <option value="1">Laptop - $999.99</option>
                            <option value="2">Smartphone - $699.99</option>
                            <option value="3">Headphones - $199.99</option>
                            <option value="4">Tablet - $399.99</option>
                            <option value="5">Watch - $299.99</option>
                        </c:if>
                    </select>
                </div>
                
                <div class="form-group">
                    <label for="reason">Reason for Return <span class="required">*</span></label>
                    <textarea id="reason" name="reason" required placeholder="Please provide a detailed reason for your return request..." maxlength="500" onkeyup="updateCharacterCount()"></textarea>
                    <div class="character-count">
                        <span id="charCount">0</span>/500 characters
                    </div>
                </div>
                
                <div class="form-group">
                    <label for="returnType">Return Type <span class="required">*</span></label>
                    <select id="returnType" name="returnType" required>
                        <option value="">-- Select Return Type --</option>
                        <option value="Defective Product">Defective Product</option>
                        <option value="Wrong Item Received">Wrong Item Received</option>
                        <option value="Damaged During Shipping">Damaged During Shipping</option>
                        <option value="Not as Described">Not as Described</option>
                        <option value="Changed Mind">Changed Mind</option>
                        <option value="Size/Fit Issue">Size/Fit Issue</option>
                        <option value="Other">Other</option>
                    </select>
                </div>
                
                <div class="form-group">
                    <label for="condition">Product Condition <span class="required">*</span></label>
                    <select id="condition" name="condition" required>
                        <option value="">-- Select Condition --</option>
                        <option value="New/Unused">New/Unused</option>
                        <option value="Like New">Like New</option>
                        <option value="Good">Good</option>
                        <option value="Fair">Fair</option>
                        <option value="Poor/Damaged">Poor/Damaged</option>
                    </select>
                </div>
                
                <div class="form-group">
                    <label for="refundPreference">Refund Preference</label>
                    <select id="refundPreference" name="refundPreference">
                        <option value="Original Payment Method">Original Payment Method</option>
                        <option value="Store Credit">Store Credit</option>
                        <option value="Exchange">Exchange for Different Product</option>
                        <option value="Bank Transfer">Bank Transfer</option>
                    </select>
                </div>
                
                <div class="form-actions">
                    <a href="javascript:history.back()" class="btn btn-secondary">Cancel</a>
                    <button type="submit" class="btn btn-primary">Submit Return Request</button>
                </div>
            </form>
        </div>
    </div>
    
    <script>
        function updateCharacterCount() {
            const textarea = document.getElementById('reason');
            const charCount = document.getElementById('charCount');
            charCount.textContent = textarea.value.length;
            
            // Change color based on character count
            if (textarea.value.length > 450) {
                charCount.style.color = '#dc3545';
            } else if (textarea.value.length > 400) {
                charCount.style.color = '#ffc107';
            } else {
                charCount.style.color = '#6c757d';
            }
        }
        
        function validateForm() {
            const product = document.getElementById('product').value;
            const reason = document.getElementById('reason').value;
            const returnType = document.getElementById('returnType').value;
            const condition = document.getElementById('condition').value;
            
            if (!product) {
                alert('Please select a product');
                return false;
            }
            
            if (!reason || reason.trim().length < 10) {
                alert('Please provide a detailed reason (at least 10 characters)');
                return false;
            }
            
            if (!returnType) {
                alert('Please select a return type');
                return false;
            }
            
            if (!condition) {
                alert('Please select the product condition');
                return false;
            }
            
            return confirm('Are you sure you want to submit this return request?');
        }
        
        // Initialize character count on page load
        document.addEventListener('DOMContentLoaded', function() {
            updateCharacterCount();
        });
    </script>
</body>
</html>