package controllers;

import dao.CategoryDao;
import dao.CategoryDaoImpl;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.Category;
import model.User;
import util.SessionUtil;

import java.io.IOException;
import java.util.List;

@WebServlet("/dashboard/categories")
public class CategoriesController extends HttpServlet {
    private final CategoryDao categoryDao = new  CategoryDaoImpl();

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


        if(action == null){
            List<Category> categories = categoryDao.getAllCategories();
            req.setAttribute("categories", categories);
            req.getRequestDispatcher("/WEB-INF/views/admin/categories.jsp").forward(req,resp);
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String action = req.getParameter("action");

        if(action.equals("add")){
            String name = req.getParameter("name").trim();
            boolean success = categoryDao.addCategory(new Category(name));
            if(!success || name.equals("test")){
                SessionUtil.setAttribute(req, "error","Unable to add category");
            }
                SessionUtil.setAttribute(req, "success","Category successfully added");

            resp.sendRedirect(req.getContextPath() + "/categories");

        }else if(action.equals("edit")){
            int id = Integer.parseInt(req.getParameter("id"));
            String name = req.getParameter("name");

            boolean success = categoryDao.updateCategory(new Category(name), id);

            if(!success){
                SessionUtil.setAttribute(req, "error","Unable to update category");
            }
                SessionUtil.setAttribute(req, "success","Category successfully updated");
            resp.sendRedirect(req.getContextPath() + "/categories");
        }else if(action.equals("delete")){
            int id = Integer.parseInt(req.getParameter("id"));

            boolean success = categoryDao.deleteCategory(id);

            if(!success){

                SessionUtil.setAttribute(req, "error","Unable to delete category");
//                req.getRequestDispatcher("/WEB-INF/views/categories.jsp").forward(req,resp);
            }
                SessionUtil.setAttribute(req, "error","Category successfully deleted");
            resp.sendRedirect(req.getContextPath() + "/categories");
        }
    }
}
