package Controller;

import java.io.IOException;
import javax.servlet.*;
import javax.servlet.annotation.WebFilter;
import javax.servlet.http.*;

@WebFilter("/*")
public class AuthFilter implements Filter {
    @Override
    public void init(FilterConfig filterConfig) throws ServletException {}

    @Override
    public void doFilter(ServletRequest req, ServletResponse res, FilterChain chain) throws IOException, ServletException {
        HttpServletRequest request = (HttpServletRequest) req;
        HttpServletResponse response = (HttpServletResponse) res;
        HttpSession session = request.getSession(false);

        String loginURI = request.getContextPath() + "/login.jsp";
        String loginServletURI = request.getContextPath() + "/LoginServlet";
        String requestURI = request.getRequestURI();

        boolean loggedIn = session != null && session.getAttribute("role") != null;
        boolean loginRequest = requestURI.equals(loginURI) || requestURI.equals(loginServletURI) || requestURI.endsWith(".css");

        if (loggedIn || loginRequest) {
            // Chặn EMPLOYEE không được vào trang quản lý
            if (loggedIn && "EMPLOYEE".equals(session.getAttribute("role")) && requestURI.contains("EmployeeManagementServlet")) {
                response.sendRedirect("EmployeeDetailServlet?id=" + session.getAttribute("nhanVienID"));
                return;
            }
            chain.doFilter(request, response);
        } else {
            response.sendRedirect(loginURI);
        }
    }
    @Override
    public void destroy() {}
}