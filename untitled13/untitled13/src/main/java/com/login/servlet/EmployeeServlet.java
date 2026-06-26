package com.login.servlet;

import com.login.dao.EmployeeDAO;
import com.login.model.Employee;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet("/employee")
public class EmployeeServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private EmployeeDAO employeeDAO = new EmployeeDAO();

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        
        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }

        Object maRoleObj = session.getAttribute("maRole");
        String action = request.getParameter("action");

        if (maRoleObj == null || !maRoleObj.toString().equals("1")) {
            response.sendRedirect(request.getContextPath() + "/employee-dashboard.jsp?error=Từ chối truy cập");
            return;
        }

        if ("list".equals(action) || action == null) {
            request.setAttribute("employees", employeeDAO.getAllEmployees());
            request.getRequestDispatcher("/employee-list.jsp").forward(request, response);
        } else if ("edit".equals(action)) {
            String idParam = request.getParameter("id");
            if (idParam != null && !idParam.isEmpty()) {
                int id = Integer.parseInt(idParam);
                request.setAttribute("employee", employeeDAO.getEmployeeById(id));
            }
            request.getRequestDispatcher("/employee-form.jsp").forward(request, response);
        } else if ("view".equals(action)) {
            int id = Integer.parseInt(request.getParameter("id"));
            request.setAttribute("employee", employeeDAO.getEmployeeById(id));
            request.getRequestDispatcher("/employee-detail.jsp").forward(request, response);
        }
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        
        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }

        Object maRoleObj = session.getAttribute("maRole");
        if (maRoleObj == null || !maRoleObj.toString().equals("1")) {
            response.sendRedirect(request.getContextPath() + "/employee-dashboard.jsp?error=Từ chối truy cập");
            return;
        }

        String action = request.getParameter("action");

        try {
            if ("add".equals(action)) {
                Employee emp = new Employee();
                emp.setHoTen(request.getParameter("hoTen"));
                emp.setTuoi(Integer.parseInt(request.getParameter("tuoi")));
                emp.setMaRole(Integer.parseInt(request.getParameter("maRole")));
                emp.setMaTrangThai(Integer.parseInt(request.getParameter("maTrangThai")));

                if (employeeDAO.addEmployee(emp)) {
                    response.sendRedirect(request.getContextPath() + "/employee?action=list&success=Thêm nhân viên thành công");
                } else {
                    response.sendRedirect(request.getContextPath() + "/employee?action=list&error=Thêm nhân viên thất bại");
                }
            } else if ("update".equals(action)) {
                Employee emp = new Employee();
                emp.setMaNhanVien(Integer.parseInt(request.getParameter("maNhanVien")));
                emp.setHoTen(request.getParameter("hoTen"));
                emp.setTuoi(Integer.parseInt(request.getParameter("tuoi")));
                emp.setMaRole(Integer.parseInt(request.getParameter("maRole")));
                emp.setMaTrangThai(Integer.parseInt(request.getParameter("maTrangThai")));

                if (employeeDAO.updateEmployee(emp)) {
                    response.sendRedirect(request.getContextPath() + "/employee?action=list&success=Cập nhật nhân viên thành công");
                } else {
                    response.sendRedirect(request.getContextPath() + "/employee?action=list&error=Cập nhật nhân viên thất bại");
                }
            } else if ("delete".equals(action)) {
                int id = Integer.parseInt(request.getParameter("id"));
                if (employeeDAO.deleteEmployee(id)) {
                    response.sendRedirect(request.getContextPath() + "/employee?action=list&success=Xóa nhân viên thành công");
                } else {
                    response.sendRedirect(request.getContextPath() + "/employee?action=list&error=Xóa nhân viên thất bại");
                }
            }
        } catch (NumberFormatException e) {
            e.printStackTrace();
            response.sendRedirect(request.getContextPath() + "/employee?action=list&error=Định dạng dữ liệu không hợp lệ");
        }
    }
}
