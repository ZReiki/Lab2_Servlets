package ua.edu.nuos.lab2_servlets.calculator;

public class Function {
    public double calculate(double x){
        return Math.exp(Math.log(x) - 1) + Math.sin(x);
    }
}
