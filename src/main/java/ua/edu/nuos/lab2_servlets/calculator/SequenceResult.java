package ua.edu.nuos.lab2_servlets.calculator;

public record SequenceResult(double sumN, SumResult sumE1, SumResult sumE2, double exact) {
    public double errorN() {
        return Math.abs(sumN - exact);
    }

    public double errorE1() {
        return Math.abs(sumE1.sum() - exact);
    }

    public double errorE2() {
        return Math.abs(sumE2.sum() - exact);
    }
}
