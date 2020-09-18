/*
         * This program shows my lexer's ability to tokenize a Compound interest code!
         */

public class prog2 {

    public void calculate(int p, int t, double r, int n) {
        double amount = p * Math.pow(1 + (r / n), n * t);

        double cinterest = amount - p;
        System.out.println("Compound Interest after " + t + " years: " + cinterest);
        System.out.println("Amount \"after\" " + t + " years: " + amount);
        // Testing my lexer using escape sequences
    }

    public static void main(String args[]) {
        prog2 obj = null;
        obj = new prog2();
        obj.calculate(2000, 5, .08, 12);
    }
}