package controllers;

import dao.UserDaoImpl;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import util.ModelUtils;
import java.io.IOException;

@WebServlet("/users")
public class UserController extends HttpServlet {
    private final UserDaoImpl userDao = new UserDaoImpl();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        super.doGet(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        super.doPost(req, resp);
        String action = req.getParameter("action");

        if(action.equals("add")){
            userDao.addUser(ModelUtils.getUserFromRequest(req));
        }
    }


}
