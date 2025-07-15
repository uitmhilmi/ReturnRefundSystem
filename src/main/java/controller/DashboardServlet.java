package controller;

import dao.ReturnDAO;
import model.ReturnRequest;
import model.User;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.RequestDispatcher;
import java.io.IOException;
import java.util.List;

public class DashboardServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private ReturnDAO returnDAO;
    
    @Override
    public void init() throws ServletException {
        super.init();
        returnDAO = new ReturnDAO();
    }
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");
        
        if (user == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        ReturnDAO dao = new ReturnDAO();
        List<ReturnRequest> allRequests = dao.getLatestReturnRequests(10);
        
        int total = allRequests.size();
        int pending = returnDAO.getReturnCountByStatus("Pending");
        int approved = returnDAO.getReturnCountByStatus("Approved");
        int rejected = returnDAO.getReturnCountByStatus("Rejected");

        request.setAttribute("recentRequests", allRequests);
        request.setAttribute("user", user);
        request.setAttribute("totalRequests", total);
        request.setAttribute("pendingRequests", pending);
        request.setAttribute("approvedRequests", approved);
        request.setAttribute("rejectedRequests", rejected);
        
        request.setAttribute("pendingPercentage", total > 0 ? pending * 100 / total : 0);
        request.setAttribute("approvedPercentage", total > 0 ? approved * 100 / total : 0);
        request.setAttribute("rejectedPercentage", total > 0 ? rejected * 100 / total : 0);

        RequestDispatcher dispatcher = request.getRequestDispatcher("dashboard.jsp");
        dispatcher.forward(request, response);
    }

    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String action = request.getParameter("action");
        
        if ("delete".equals(action)) {
            handleDeleteRequest(request, response);
        } else {
            // Default behavior - redirect to GET
            doGet(request, response);
        }
    }
    
    private void handleDeleteRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");
        
        if (user == null) {
            response.sendRedirect("login.jsp");
            return;
        }
        
        try {
            int requestId = Integer.parseInt(request.getParameter("requestId"));
            
            // Verify that the return request belongs to the logged-in user
            ReturnRequest returnRequest = returnDAO.getReturnRequestById(requestId);
            
            if (returnRequest != null && returnRequest.getUserId() == user.getUserId()) {
                boolean deleted = returnDAO.deleteReturnRequest(requestId);
                
                if (deleted) {
                    request.setAttribute("successMessage", "Return request deleted successfully.");
                } else {
                    request.setAttribute("errorMessage", "Failed to delete return request.");
                }
            } else {
                request.setAttribute("errorMessage", "You are not authorized to delete this request.");
            }
            
        } catch (NumberFormatException e) {
            request.setAttribute("errorMessage", "Invalid request ID.");
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "Error deleting return request: " + e.getMessage());
        }
        
        // Redirect back to the customer returns page
        doGet(request, response);
    }
}