package ua.edu.nuos.lab2_servlets.calculator;

import lombok.Data;

import java.util.ArrayList;
import java.util.List;

@Data
public class Tabulation {
    private final double a;   // Початок
    private final double b;   // Кінець
    private final double h;   // Крок

    private final List<Point> points;
    private final Function func;

    public Tabulation(double a, double b, double h, Function func) {
        this.a = a;
        this.b = b;
        this.h = h;

        this.func = func;
        this.points = generatePoints();
    }

    // Розрахунок кількості кроків табуляції
    public int calcNumberTabulationSteps(){
        return (int) Math.round((b - a) / h) + 1;
    }

    // Генерації табульованого списку точок (x, y)
    private List<Point> generatePoints(){
        int n = calcNumberTabulationSteps();
        List<Point> p = new ArrayList<>();
        for(int i = 0; i < n; i++) {
            double x = a + i * h;
            double y = func.calculate(x);
            p.add(new Point(x, y));
        }
        return p;
    }
}
