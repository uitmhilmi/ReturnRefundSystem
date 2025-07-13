/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package filter;

import java.io.IOException;
import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 *
 * @author ahmad
 */
public class AuthenticationFilter implements Filter {
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {
        
        HttpServletRequest req = (HttpServletRequest) request;
        HttpServletResponse res = (HttpServletResponse) response;

        HttpSession session = req.getSession(false);
        String userRole = (session != null) ? (String) session.getAttribute("userRole") : null;

        String uri = req.getRequestURI();

        boolean isAdminPage = uri.contains("/dashboard") || uri.contains("/updateStatus") || uri.contains("/delete") || uri.contains("/processRefund");
        boolean isCustomerPage = uri.contains("/return") || uri.contains("/customerReturns");

        if ((isAdminPage && !"admin".equals(userRole)) || (isCustomerPage && userRole == null)) {
            res.sendRedirect(req.getContextPath() + "/login.jsp?error=unauthorized");
            return;
        }

        chain.doFilter(request, response);
    }
}
