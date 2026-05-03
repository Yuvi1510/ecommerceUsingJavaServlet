package controllers;

import dao.UserDao;
import dao.UserDaoImpl;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.User;
import org.mindrot.jbcrypt.BCrypt;
import util.SessionUtil;

import java.io.IOException;

@WebServlet("/login")
public class AuthController extends HttpServlet {

    UserDao userDao = new UserDaoImpl();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.getRequestDispatcher("/WEB-INF/views/auth.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String email = req.getParameter("email");
        String password = req.getParameter("password");

        User user = userDao.findUserByEmail(email);

       if( user == null || !BCrypt.checkpw(password, user.getPassword())){
           req.setAttribute("error", "Invalid credentials!");
           req.getRequestDispatcher("/WEB-INF/views/auth.jsp").forward(req, resp);
       }else {
           SessionUtil.setAttribute(req, "user", user);

//           CookieUtil.addCookie(response, "username", user.getUsername(), 24 * 60 * 60);

           resp.sendRedirect(req.getContextPath() + "/home");
       }
    }


}
