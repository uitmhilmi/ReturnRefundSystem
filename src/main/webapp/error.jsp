<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page isErrorPage="true" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Error - Return & Refund System</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 0;
            background-color: #f8f9fa;
            display: flex;
            justify-content: center;
            align-items: center;
            min-height: 100vh;
        }
        .error-container {
            background: white;
            padding: 3rem;
            border-radius: 12px;
            box-shadow: 0 4px 6px rgba(0,0,0,0.1);
            text-align: center;
            max-width: 600px;
            width: 90%;
        }
        .error-icon {
            font-size: 4rem;
            color: #dc3545;
            margin-bottom: 1rem;
        }
        .error-title {
            color: #dc3545;
            font-size: 2rem;
            margin-bottom: 1rem;
            font-weight: bold;
        }
        .error-message {
            color: #6c757d;
            font-size: 1.1rem;
            margin-bottom: 2rem;
            line-height: 1.5;
        }
        .error-details {
            background-color: #f8f9fa;
            padding: 1.5rem;
            border-radius: 8px;
            margin-bottom: 2rem;
            text-align: left;
        }
        .error-details h4 {
            margin-top: 0;
            color: #333;
        }
        .error-details pre {
            background-color: #e9ecef;
            padding: 1rem;
            border-radius: 4px;
            overflow-x: auto;
            font-size: 0.9rem;
            color: #495057;
        }
        .error-actions {
            display: flex;
            gap: 1rem;
            justify-content: center;
            flex-wrap: wrap;
        }
        .btn {
            padding: 12px 24px;
            border: none;
            border-radius: 6px;
            font-size: 1rem;
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
        }
        .btn-secondary:hover {
            background-color: #545b62;
        }
        .btn-outline {
            background-color: transparent;
            color: #007bff;
            border: 2px solid #007bff;
        }
        .btn-outline:hover {
            background-color: #007bff;
            color: white;
        }
        .error-code {
            font-size: 0.9rem;
            color: #adb5bd;
            margin-top: 2rem;
        }
        .help-section {
            margin-top: 2rem;
            padding-top: 2rem;
            border-top: 1px solid #dee2e6;
        }
        .help-section h4 {
            color: #333;
            margin-bottom: 1rem;
        }
        .help-links {
            display: flex;
            gap: 1rem;
            justify-content: center;
            flex-wrap: wrap;
        }
        .help-links a {
            color: #007bff;
            text-decoration: none;
            font-size: 0.9rem;
        }
        .help-links a:hover {
            text-decoration: underline;
        }
        .countdown {
            font-size: 0.9rem;
            color: #6c757d;
            margin-top: 1rem;
        }
        .progress-bar {
            width: 100%;
            height: 4px;
            background-color: #e9ecef;
            border-radius: 2px;
            margin-top: 1rem;
            overflow: hidden;
        }
        .progress-fill {
            height: 100%;
            background-color: #007bff;
            width: 0%;
            transition: width 0.1s ease;
        }
        @media (max-width: 768px) {
            .error-container {
                padding: 2rem;
            }
            .error-title {
                font-size: 1.5rem;
            }
            .error-actions {
                flex-direction: column;
            }
        }
    </style>
</head>
<body>
    <div class="error-container">
        <div class="error-icon">⚠️</div>
        
        <% 
            String errorCode = request.getParameter("code");
            String errorMessage = (String) request.getAttribute("errorMessage");
            String errorDetails = (String) request.getAttribute("errorDetails");
            Exception exception = (Exception) request.getAttribute("exception");
            
            // Default error handling
            if (errorCode == null) errorCode = "500";
            if (errorMessage == null) {
                switch (errorCode) {
                    case "400":
                        errorMessage = "Bad Request - The request could not be understood by the server.";
                        break;
                    case "401":
                        errorMessage = "Unauthorized - You need to log in to access this resource.";
                        break;
                    case "403":
                        errorMessage = "Forbidden - You don't have permission to access this resource.";
                        break;
                    case "404":
                        errorMessage = "Page Not Found - The requested page could not be found.";
                        break;
                    case "500":
                        errorMessage = "Internal Server Error - Something went wrong on our end.";
                        break;
                    default:
                        errorMessage = "An unexpected error occurred.";
                }
            }
        %>
        
        <div class="error-title">
            <% if ("404".equals(errorCode)) { %>
                Page Not Found
            <% } else if ("401".equals(errorCode)) { %>
                Access Denied
            <% } else if ("403".equals(errorCode)) { %>
                Forbidden
            <% } else { %>
                Oops! Something went wrong
            <% } %>
        </div>
        
        <div class="error-message">
            <%= errorMessage %>
        </div>
        
        <% if (errorDetails != null || exception != null) { %>
            <div class="error-details">
                <h4>Error Details</h4>
                <% if (errorDetails != null) { %>
                    <p><%= errorDetails %></p>
                <% } %>
                <% if (exception != null) { %>
                    <pre><%= exception.getMessage() %></pre>
                <% } %>
            </div>
        <% } %>
        
        <div class="error-actions">
            <% if ("404".equals(errorCode)) { %>
                <a href="login.jsp" class="btn btn-primary">Go to Login</a>
                <button onclick="history.back()" class="btn btn-secondary">Go Back</button>
            <% } else if ("401".equals(errorCode)) { %>
                <a href="login.jsp" class="btn btn-primary">Login</a>
                <a href="register.jsp" class="btn btn-outline">Register</a>
            <% } else { %>
                <button onclick="location.reload()" class="btn btn-primary">Try Again</button>
                <button onclick="history.back()" class="btn btn-secondary">Go Back</button>
                <a href="login.jsp" class="btn btn-outline">Go to Login</a>
            <% } %>
        </div>
        
        <!-- Countdown and progress bar for auto-redirect -->
        <% if ("401".equals(errorCode)) { %>
            <div class="countdown" id="countdown">
                Redirecting to login page in <span id="timer">10</span> seconds...
            </div>
            <div class="progress-bar">
                <div class="progress-fill" id="progressFill"></div>
            </div>
        <% } %>
        
        <div class="help-section">
            <h4>Need Help?</h4>
            <div class="help-links">
                <a href="mailto:support@returnrefund.com">Contact Support</a>
                <a href="login.jsp">Login Page</a>
                <a href="register.jsp">Register</a>
                <a href="faq.jsp">FAQ</a>
            </div>
        </div>
        
        <div class="error-code">
            Error Code: <%= errorCode %> | 
            Time: <%= new java.util.Date() %> |
            Session ID: <%= session.getId() %>
        </div>
    </div>
    
    <script>
        // Auto-redirect for certain error types after a delay
        <% if ("401".equals(errorCode)) { %>
            let timeLeft = 10;
            let redirectCancelled = false;
            
            function updateCountdown() {
                const timerElement = document.getElementById('timer');
                const progressFill = document.getElementById('progressFill');
                
                if (timerElement && progressFill) {
                    timerElement.textContent = timeLeft;
                    progressFill.style.width = ((10 - timeLeft) / 10 * 100) + '%';
                }
                
                if (timeLeft <= 0 && !redirectCancelled) {
                    window.location.href = 'login.jsp';
                } else if (timeLeft > 0) {
                    timeLeft--;
                    setTimeout(updateCountdown, 1000);
                }
            }
            
            // Start countdown
            updateCountdown();
            
            // Allow users to cancel redirect by clicking anywhere
            document.addEventListener('click', function(e) {
                if (e.target.tagName !== 'A' && e.target.tagName !== 'BUTTON') {
                    redirectCancelled = true;
                    const countdownElement = document.getElementById('countdown');
                    const progressBar = document.querySelector('.progress-bar');
                    if (countdownElement) {
                        countdownElement.innerHTML = 'Auto-redirect cancelled. Click Login to continue.';
                    }
                    if (progressBar) {
                        progressBar.style.display = 'none';
                    }
                }
            });
        <% } %>
        
        // Enhanced error reporting
        function reportError() {
            const errorData = {
                errorCode: '<%= errorCode %>',
                errorMessage: '<%= errorMessage != null ? errorMessage.replace("'", "\\'") : "" %>',
                userAgent: navigator.userAgent,
                url: window.location.href,
                timestamp: new Date().toISOString(),
                sessionId: '<%= session.getId() %>'
            };
            
            // Send error report to server (implement your error reporting endpoint)
            // fetch('/api/error-report', {
            //     method: 'POST',
            //     headers: { 'Content-Type': 'application/json' },
            //     body: JSON.stringify(errorData)
            // });
            
            console.log('Error Report:', errorData);
        }
        
        // Report error on page load
        window.addEventListener('load', reportError);
        
        // Keyboard navigation
        document.addEventListener('keydown', function(e) {
            switch(e.key) {
                case 'Enter':
                case ' ':
                    // Press Enter or Space to try again
                    if (document.querySelector('.btn-primary')) {
                        document.querySelector('.btn-primary').click();
                    }
                    break;
                case 'Escape':
                    // Press Escape to go back
                    if (document.querySelector('.btn-secondary')) {
                        document.querySelector('.btn-secondary').click();
                    }
                    break;
                case 'l':
                case 'L':
                    // Press L to go to login
                    if (e.ctrlKey || e.metaKey) {
                        e.preventDefault();
                        window.location.href = 'login.jsp';
                    }
                    break;
            }
        });
        
        // Handle offline/online status
        window.addEventListener('online', function() {
            const errorMessage = document.querySelector('.error-message');
            if (errorMessage && errorMessage.textContent.includes('network')) {
                location.reload();
            }
        });
        
        window.addEventListener('offline', function() {
            const errorMessage = document.querySelector('.error-message');
            if (errorMessage) {
                errorMessage.innerHTML += '<br><small style="color: #dc3545;">You are currently offline. Please check your internet connection.</small>';
            }
        });
        
        // Console message for developers
        console.log('%cReturn & Refund System - Error Page', 'color: #007bff; font-size: 16px; font-weight: bold;');
        console.log('Error Code: <%= errorCode %>');
        console.log('If you are a developer, check the network tab for more details.');
        
        // Add some animation to the error icon
        const errorIcon = document.querySelector('.error-icon');
        if (errorIcon) {
            errorIcon.style.animation = 'pulse 2s infinite';
        }
        
        // CSS animation for error icon
        const style = document.createElement('style');
        style.textContent = `
            @keyframes pulse {
                0% { transform: scale(1); }
                50% { transform: scale(1.1); }
                100% { transform: scale(1); }
            }
        `;
        document.head.appendChild(style);
    </script>
</body>
</html>