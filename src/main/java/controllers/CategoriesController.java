package controllers;

import dao.CategoryDao;
import dao.CategoryDaoImpl;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.Category;

import java.io.IOException;
import java.util.List;

@WebServlet("/categories")
public class CategoriesController extends HttpServlet {
    private final CategoryDao categoryDao = new  CategoryDaoImpl();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String action = req.getParameter("action");

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
                req.setAttribute("error","Unable to add category");
                req.getRequestDispatcher("/WEB-INF/views/admin/categories.jsp").forward(req,resp);
            }

            resp.sendRedirect(req.getContextPath() + "/categories");

        }else if(action.equals("edit")){
            int id = Integer.parseInt(req.getParameter("id"));
            String name = req.getParameter("name");

            boolean success = categoryDao.updateCategory(new Category(name), id);

            if(!success){
                req.setAttribute("error","Unable to update category");
                req.getRequestDispatcher("/WEB-INF/views/admin/categories.jsp").forward(req,resp);
            }
            resp.sendRedirect(req.getContextPath() + "/categories");
        }else if(action.equals("delete")){
            int id = Integer.parseInt(req.getParameter("id"));

            boolean success = categoryDao.deleteCategory(id);

            if(!success){
                req.setAttribute("error","Unable to delete category");
//                req.getRequestDispatcher("/WEB-INF/views/categories.jsp").forward(req,resp);
            }
            resp.sendRedirect(req.getContextPath() + "/categories");
        }
    }
}
