package ua.edu.nuos.lab2_servlets.calculator;

import lombok.Data;

@Data
public class NumericalSequence {
    private final double x;
    private final int n;

    public NumericalSequence(double x, int n){
        this.x = x;
        this.n = n;
    }

    private double factorial(int n) {
        if (n <= 1) return 1.0;
        return n * factorial(n - 1);
    }

    private double element(int i) {
        int power = i * 2 + 1;
        return Math.pow(-1, i) * (Math.pow(x, power) / (factorial(power)));
    }

    public double sumN(){
        double sum = 0.0;
        for(int i = 0; i < n; i++){
            sum += element(i);
        }
        return sum;
    }

    public SumResult sumEPS(double EPS){
        double sum = 0.0;
        int count = 0;
        int i = 0;

        while(true) {
            double current = element(i);

            if(Math.abs(current) > EPS) {
                sum += current;
                count++;
            } else break;
            i++;
        }

        return new SumResult(sum, count);
    }

    public double exactValue() {
        return Math.sin(x);
    }
}
