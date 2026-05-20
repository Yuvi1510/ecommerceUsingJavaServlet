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

@WebServlet("/dashboard/users")
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
            boolean success = userDao.addUser(ModelUtils.getUserFromRequest(req));
            if(success){
                SessionUtil.setAttribute(req, "success", "User added successfully");
            }else {
                SessionUtil.setAttribute(req, "error", "Failed to add user");

            }
            resp.sendRedirect(req.getContextPath() + "/dashboard/users");
        }else if(action.equals("findById")){
            int id = Integer.parseInt( req.getParameter("userId"));
            User user = userDao.findUserById(id);
            req.setAttribute("users", List.of(user));
            req.getRequestDispatcher("/WEB-INF/views/admin/dashboard.jsp").forward(req,resp);
        }else if(action.equals("findByEmail")){
            String email = req.getParameter("email");
            User user = userDao.findUserByEmail(email);
            req.setAttribute("users", List.of(user));
            req.getRequestDispatcher("/WEB-INF/views/admin/dashboard.jsp").forward(req,resp);
        }else if(action.equals("edit")){
            int id = Integer.parseInt(req.getParameter("userId"));
            User user = ModelUtils.getUserFromRequest(req);
            boolean success = userDao.updateUser(user, id);

            if(success){
                SessionUtil.setAttribute(req, "success", "User successfully updated");
            }else {
                SessionUtil.setAttribute(req, "error", "Failed to update user");
            }
                resp.sendRedirect(req.getContextPath() + "/dashboard/users");
        }else if(action.equals("delete")){
            int id = Integer.parseInt(req.getParameter("userId"));
            boolean success = userDao.deleteUser(id);
            if(success){
            SessionUtil.setAttribute(req, "success", "Unable to delete user.");
            }else {
            SessionUtil.setAttribute(req, "error", "Unable to delete user.");
            }
                resp.sendRedirect(req.getContextPath() + "/dashboard/users");
        }
    }
}
