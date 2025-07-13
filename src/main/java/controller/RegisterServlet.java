/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package controller;

import dao.UserDAO;
import model.User;
import util.PasswordUtil;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

public class RegisterServlet extends HttpServlet {
      private UserDAO userDAO = new UserDAO();
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String fullName = request.getParameter("fullName");
        String username = request.getParameter("username");
        String contact = request.getParameter("contact");
        String email = request.getParameter("email");
        String password = request.getParameter("password");

        if (fullName == null || username == null || email == null || password == null
                || fullName.trim().isEmpty() || username.trim().isEmpty()
                || email.trim().isEmpty() || password.trim().isEmpty()) {
            request.setAttribute("error", "All fields are required");
            request.getRequestDispatcher("register.jsp").forward(request, response);
            return;
        }

        if (!PasswordUtil.isValidPassword(password)) {
            request.setAttribute("error", "Password must be at least 8 characters long and contain at least 1 letter and 1 number");
            request.getRequestDispatcher("register.jsp").forward(request, response);
            return;
        }

        if (userDAO.isUsernameExists(username.trim())) {
            request.setAttribute("error", "Username already exists");
            request.getRequestDispatcher("register.jsp").forward(request, response);
            return;
        }
        
        password = PasswordUtil.hashPassword(password);

        // All validations passed — proceed with registration
        User newUser = new User(fullName, username, contact, email, password, "customer");
        userDAO.insertUser(newUser); // Make sure this works

        // Redirect to login page after successful registration
        response.sendRedirect("login.jsp");
    }

}
