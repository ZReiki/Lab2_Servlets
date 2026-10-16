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

    double element(int i){
        return -(x * x) / ((2 * i) * (2 * i + 1));
    }

    public double sumN(){
        if(n == 0) return 0;

        double cur = x;
        double sum = cur;

        for(int i = 1; i < n; i++){
            cur *= element(i);
            sum += cur;
        }
        return sum;
    }

    public SumResult sumEPS(double EPS){
        double cur = x;
        double sum = cur;
        int count = 0;
        int i = 0;

        while(true) {
            cur *= element(i);

            if(Math.abs(cur) > EPS) {
                sum += cur;
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
