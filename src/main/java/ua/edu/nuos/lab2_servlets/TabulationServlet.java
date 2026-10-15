package ua.edu.nuos.lab2_servlets;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import ua.edu.nuos.lab2_servlets.calculator.Function;
import ua.edu.nuos.lab2_servlets.calculator.Tabulation;

import java.io.IOException;

@WebServlet(name = "TabulationServlet", value = "/tabulation")
public class TabulationServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
        double a = Double.parseDouble(req.getParameter("value_a"));
        double b = Double.parseDouble(req.getParameter("value_b"));
        double h = Double.parseDouble(req.getParameter("value_h"));

        if (!Double.isFinite(a) || !Double.isFinite(b) || !Double.isFinite(h) || a <= 0 || b < a || h <= 0) {
            throw new IllegalArgumentException("Некоректні значення параметрів.");
        }

        // Обмеження запобігає надмірній кількості точок
        if ((b - a) / h > 10000) {
            throw new IllegalArgumentException();
        }

        Tabulation tabulation = new Tabulation(a, b, h, new Function());

        HttpSession session = req.getSession();

        session.setAttribute("value_a", a);
        session.setAttribute("value_b", b);
        session.setAttribute("value_h", h);
        session.setAttribute("points", tabulation.getPoints());
        req.getRequestDispatcher("/index.jsp").forward(req, res);
    }
}
