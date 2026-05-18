package controllers;

import dao.UserDao;
import dao.UserDaoImpl;
import enums.Role;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.User;
import org.mindrot.jbcrypt.BCrypt;
import util.SessionUtil;

import java.io.IOException;

@WebServlet({"/login","/logout"})
public class AuthController extends HttpServlet {

    UserDao userDao = new UserDaoImpl();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String action = req.getParameter("action");

        // remove the msg from session
        String success = (String) SessionUtil.getAttribute(req, "success");
        if (success != null) {
            req.setAttribute("success", success);
            SessionUtil.removeAttribute(req, "success");
        }
        String error = (String) SessionUtil.getAttribute(req, "error");
        if (error != null) {
            req.setAttribute("error", error);
            SessionUtil.removeAttribute(req, "error");
        }

        String uri = req.getRequestURI();
        String contextPath = req.getContextPath();
        String path = uri.substring(contextPath.length());

        if (path.contains("/logout")){
            SessionUtil.invalidateSession(req);
            resp.sendRedirect(req.getContextPath() + "/login");
            return;
        }


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
           SessionUtil.setAttribute(req, "success", "Login successful");

           if(user.hasRole(Role.ROLE_ADMIN)){
               resp.sendRedirect(req.getContextPath() + "/dashboard/users");
           }else {
               resp.sendRedirect(req.getContextPath() + "/home");
           }
       }
    }


}
