package controllers.filter;


import enums.Role;
import jakarta.servlet.*;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.User;
import util.SessionUtil;

import java.io.IOException;

@WebFilter("/*")
public class AuthenticationFilter implements Filter {
    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain) throws IOException, ServletException {
        HttpServletRequest req = (HttpServletRequest) request;
        HttpServletResponse res = (HttpServletResponse) response;


        String uri = req.getRequestURI();
        System.out.println(uri);

        String contextPath = req.getContextPath();
        System.out.println(contextPath);

        String path = uri.substring(contextPath.length());
        System.out.println(path);


        if(path.startsWith("/static/")){
            chain.doFilter(req, res);
            return;
        }

        // allow everyone to access login and register page
        if(path.equals("/") || path.contains("/singleProduct") || path.contains("/login") || path.contains("/images") || path.contains("/register") || path.contains("/about") || path.contains("/home") || path.contains("/shop") || path.contains("/service") || path.contains("/logout")){
            chain.doFilter(req, res);
            return;
        }

        // check if user is logged in
        User user = (User) SessionUtil.getAttribute(req, "user");

        // if np user in session then redirect to login
//        if((path.contains("/my-orders") || path.contains("/carts"))){
//            if(user == null) {
//                SessionUtil.setAttribute(req, "error", "Please login first!");
//                res.sendRedirect(req.getContextPath() + "/login");
//                return;
//            }else {
//                chain.doFilter(req, res);
//                return;
//            }
//        }

        boolean isLoggedIn = user != null;
        boolean isAuthPage = "/login".equals(path) || "/register".equals(path);

        // not logged in and trying to access other pages
        if(!isLoggedIn && !isAuthPage){
            req.setAttribute("error", "Please login first!");
            req.getRequestDispatcher("/WEB-INF/views/auth.jsp").forward(req, res);
        }else {
            if(path.equals("/dashboard")){
                req.getRequestDispatcher("/WEB-INF/error404.jsp").forward(req, res);
                return;
            }

            // if path has dashboard check role and allow only admin
            if(path.contains("/dashboard/") && !user.hasRole(Role.ROLE_ADMIN)){
                    req.getRequestDispatcher("/WEB-INF/views/accessDenied.jsp").forward(req, res);
                    return;
            }

            chain.doFilter(req, res);
        }
    }
}
