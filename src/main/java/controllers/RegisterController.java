package controllers;

import com.mysql.cj.Session;
import dao.UserDao;
import dao.UserDaoImpl;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.User;
import util.ModelUtils;
import util.SessionUtil;

import java.io.IOException;

@WebServlet("/register")
public class RegisterController extends HttpServlet {
    UserDao userDao = new UserDaoImpl();

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        System.out.println("register called");
        User user = ModelUtils.getUserFromRequest(req);
        boolean success = userDao.addUser(user);

        if(success){
            SessionUtil.setAttribute(req, "success", "Registration successful! Please login");
            resp.sendRedirect(req.getContextPath() + "/login");
        }else {
            SessionUtil.setAttribute(req,"error", "Unable to register!");
            req.getRequestDispatcher("/WEB-INF/views/auth.jsp").forward(req, resp);
        }
    }
}
