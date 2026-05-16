package controllers;

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
import java.util.List;

@WebServlet("/dashboard")
public class UserController extends HttpServlet {
    private final UserDao userDao = new UserDaoImpl();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String action = req.getParameter("action");

        User user = (User) SessionUtil.getAttribute(req, "user");

        // if np user in session then redirect to login
        if(user == null){
            SessionUtil.setAttribute(req, "error", "Please login first!");
            resp.sendRedirect(req.getContextPath() + "/login");
            return;
        }


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

        // if action is null find all users and forward to dashboard
        if(action == null){
            List<User> users = userDao.findAllUsers();
            req.setAttribute("users", users);
            req.getRequestDispatcher("/WEB-INF/views/admin/dashboard.jsp").forward(req, resp);
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String action = req.getParameter("action");

        if(action.equals("add")){
            userDao.addUser(ModelUtils.getUserFromRequest(req));
            List<User> users = userDao.findAllUsers();
            req.setAttribute("users", users);
            resp.sendRedirect(req.getContextPath() + "/dashboard");
        }else if(action.equals("findById")){
            int id = Integer.parseInt( req.getParameter("userId"));
            User user = userDao.findUserById(id);
            System.out.println(user.getUserId());
            req.setAttribute("users", List.of(user));
            req.getRequestDispatcher("/WEB-INF/views/admin/dashboard.jsp").forward(req,resp);
        }else if(action.equals("findByEmail")){
            String email = req.getParameter("email");
            System.out.println(email);
            User user = userDao.findUserByEmail(email);
            System.out.println(user.getEmail());
            req.setAttribute("users", List.of(user));
            req.getRequestDispatcher("/WEB-INF/views/admin/dashboard.jsp").forward(req,resp);
        }else if(action.equals("edit")){
            int id = Integer.parseInt(req.getParameter("userId"));
            User user = ModelUtils.getUserFromRequest(req);
            boolean success = userDao.updateUser(user, id);

            if(success){
                resp.sendRedirect(req.getContextPath() + "/dashboard");
            }
            req.setAttribute("error", "Unable to update user.");
        }else if(action.equals("delete")){
            System.out.println(req.getParameter("userId"));
            int id = Integer.parseInt(req.getParameter("userId"));
            boolean success = userDao.deleteUser(id);
            if(success){
                resp.sendRedirect(req.getContextPath() + "/dashboard");
            }
            req.setAttribute("error", "Unable to delete user.");
        }
    }
}
