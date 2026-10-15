package ua.edu.nuos.lab2_servlets;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import ua.edu.nuos.lab2_servlets.calculator.NumericalSequence;
import ua.edu.nuos.lab2_servlets.calculator.SequenceResult;

import java.io.IOException;

@WebServlet(name = "NumericalSequenceServlet", value = "/numerical-sequence")
public class NumericalSequenceServlet extends HttpServlet {
    @Override
    public void doPost(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
        double x = Double.parseDouble(req.getParameter("value_x"));
        int n = Integer.parseInt(req.getParameter("value_n"));
        double eps1 =  Double.parseDouble(req.getParameter("value_e1"));
        double eps2 = Double.parseDouble(req.getParameter("value_e2"));

        if (n <= 0 || !Double.isFinite(x) || !Double.isFinite(eps1) || !Double.isFinite(eps2) || eps1 <= 0 || eps2 <= 0 || eps1 == eps2) {
            throw new IllegalArgumentException("Некоректні значення параметрів.");
        }

        NumericalSequence sequence = new NumericalSequence(x, n);
        SequenceResult result = new SequenceResult(sequence.sumN(), sequence.sumEPS(eps1), sequence.sumEPS(eps2), sequence.exactValue());

        HttpSession session = req.getSession();

        session.setAttribute("value_x", x);
        session.setAttribute("value_n", n);
        session.setAttribute("value_e1", eps1);
        session.setAttribute("value_e2", eps2);
        session.setAttribute("sequenceResult", result);
        req.getRequestDispatcher("/index.jsp").forward(req, res);
    }
}
