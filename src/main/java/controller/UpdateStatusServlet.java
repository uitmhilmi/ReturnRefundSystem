package controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import dao.ReturnDAO;
import model.User;

@WebServlet("/UpdateStatusServlet")
public class UpdateStatusServlet extends HttpServlet {
    private ReturnDAO returnDAO;
    
    @Override
    public void init() throws ServletException {
        returnDAO = new ReturnDAO();
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        // Check if user is logged in and is admin
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect("login.jsp");
            return;
        }
        
        User user = (User) session.getAttribute("user");
        if (!"admin".equals(user.getRole())) {
            request.setAttribute("errorMessage", "Access denied. Admin privileges required.");
            request.getRequestDispatcher("error.jsp").forward(request, response);
            return;
        }
        
        String requestIdStr = request.getParameter("requestId");
        String newStatus = request.getParameter("status");
        
        // Input validation
        if (requestIdStr == null || requestIdStr.trim().isEmpty() ||
            newStatus == null || newStatus.trim().isEmpty()) {
            request.setAttribute("errorMessage", "Request ID and status are required");
            request.getRequestDispatcher("dashboard.jsp").forward(request, response);
            return;
        }
        
        // Validate status values
        if (!newStatus.equals("Pending") && !newStatus.equals("Approved") && !newStatus.equals("Rejected")) {
            request.setAttribute("errorMessage", "Invalid status value");
            request.getRequestDispatcher("dashboard.jsp").forward(request, response);
            return;
        }
        
        try {
            int requestId = Integer.parseInt(requestIdStr);
            
            boolean updated = returnDAO.updateReturnRequestStatus(requestId, newStatus);
            
            if (updated) {
                request.setAttribute("successMessage", "Return request status updated successfully!");
            } else {
                request.setAttribute("errorMessage", "Failed to update return request status");
            }
            
            response.sendRedirect("dashboard.jsp");
            
        } catch (NumberFormatException e) {
            request.setAttribute("errorMessage", "Invalid request ID");
            request.getRequestDispatcher("dashboard.jsp").forward(request, response);
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "System error occurred");
            request.getRequestDispatcher("error.jsp").forward(request, response);
        }
    }
}