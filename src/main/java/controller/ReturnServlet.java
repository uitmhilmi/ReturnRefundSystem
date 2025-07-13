package controller;

import java.io.IOException;
import java.sql.Timestamp;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import dao.ReturnDAO;
import dao.ProductDAO;
import model.ReturnRequest;
import model.User;

@WebServlet("/ReturnServlet")
public class ReturnServlet extends HttpServlet {
    private ReturnDAO returnDAO;
    private ProductDAO productDAO;
    
    @Override
    public void init() throws ServletException {
        returnDAO = new ReturnDAO();
        productDAO = new ProductDAO();
    }
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        // Check if user is logged in
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect("login.jsp");
            return;
        }
        
        try {
            // Load products for dropdown
            request.setAttribute("products", productDAO.getAllProducts());
            request.getRequestDispatcher("returnForm.jsp").forward(request, response);
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "Failed to load return form");
            request.getRequestDispatcher("error.jsp").forward(request, response);
        }
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        // Check if user is logged in
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect("login.jsp");
            return;
        }
        
        User user = (User) session.getAttribute("user");
        String productIdStr = request.getParameter("productId");
        String reason = request.getParameter("reason");
        
        // Input validation
        if (productIdStr == null || productIdStr.trim().isEmpty() ||
            reason == null || reason.trim().isEmpty()) {
            request.setAttribute("errorMessage", "Product and reason are required");
            try {
                request.setAttribute("products", productDAO.getAllProducts());
            } catch (Exception e) {
                e.printStackTrace();
            }
            request.getRequestDispatcher("returnForm.jsp").forward(request, response);
            return;
        }
        
        try {
            int productId = Integer.parseInt(productIdStr);
            
            // Create return request
            ReturnRequest returnRequest = new ReturnRequest();
            returnRequest.setUserId(user.getUserId());
            returnRequest.setProductId(productId);
            returnRequest.setReason(reason.trim());
            returnRequest.setStatus("Pending");
            returnRequest.setCreatedAt(new Timestamp(System.currentTimeMillis()));
            
            boolean submitted = returnDAO.createReturnRequest(returnRequest);
            
            if (submitted) {
                request.setAttribute("successMessage", "Return request submitted successfully!");
                response.sendRedirect("customerReturns.jsp");
            } else {
                request.setAttribute("errorMessage", "Failed to submit return request");
                request.setAttribute("products", productDAO.getAllProducts());
                request.getRequestDispatcher("returnForm.jsp").forward(request, response);
            }
            
        } catch (NumberFormatException e) {
            request.setAttribute("errorMessage", "Invalid product selection");
            try {
                request.setAttribute("products", productDAO.getAllProducts());
            } catch (Exception ex) {
                ex.printStackTrace();
            }
            request.getRequestDispatcher("returnForm.jsp").forward(request, response);
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "System error occurred");
            request.getRequestDispatcher("error.jsp").forward(request, response);
        }
    }
}