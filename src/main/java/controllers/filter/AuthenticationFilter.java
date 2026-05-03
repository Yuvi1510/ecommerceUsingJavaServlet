//package controllers.filter;
//
//
//import jakarta.servlet.*;
//import jakarta.servlet.http.HttpServletRequest;
//import jakarta.servlet.http.HttpServletResponse;
//import util.SessionUtil;
//
//import java.io.IOException;
//
//public class AuthenticationFilter implements Filter {
//    @Override
//    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain) throws IOException, ServletException {
//        HttpServletRequest req = (HttpServletRequest) request;
//        HttpServletResponse res = (HttpServletResponse) response;
//
//
//        String uri = req.getRequestURI();
//        System.out.println(uri);
//
//        String contextPath = req.getContextPath();
//        System.out.println(contextPath);
//
//        String path = uri.substring(contextPath.length());
//        System.out.println(path);
//
//
//        if(path.startsWith("/static/")){
//            chain.doFilter(req, res);
//            return;
//        }
//
//        boolean isLoggedIn = SessionUtil.getAttribute(req, "user") != null;
//        boolean isAuthPage = "/login".equals(path) || "/register".equals(path);
//
//        // not logged in and trying to access other pages
//        if(!isLoggedIn && !isAuthPage){
//            res.sendRedirect(contextPath + "/login");
//            return;
//        }
//    }
//}
