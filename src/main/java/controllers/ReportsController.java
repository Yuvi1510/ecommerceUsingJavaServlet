package controllers;

import dao.ReportsDao;
import dao.ReportsDaoImpl;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebServlet("/dashboard/reports")
public class ReportsController extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        ReportsDao dao = new ReportsDaoImpl();

        request.setAttribute("users", dao.getTotalUsers());
        request.setAttribute("products", dao.getTotalProducts());
        request.setAttribute("orders", dao.getTotalOrders());
        request.setAttribute("revenue", dao.getTotalRevenue());

        request.setAttribute("monthlyRevenue", dao.getMonthlyRevenue());
        request.setAttribute("orderStatus", dao.getOrderStatusCount());
        request.setAttribute("topProducts", dao.getTopProducts());

        request.getRequestDispatcher("/WEB-INF/views/admin/reports.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        super.doPost(req, resp);
    }
}
