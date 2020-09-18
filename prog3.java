
public class prog3 {

    public static void main(String[] args) {

        /*
         * Does my lexer ignore multiline comments?
         * 
         * Let's See
         */

        /* this comment /* // /** ends here: */

        /*
         * This program shows my lexer's ability to identify different representations
         * of literals!
         */

        int $hex = 0xAB123;
        long _bool = 0b011_01l;
        int rep = 0_172;
        double b = .12;
        double g = 6.022137e+23f;
        double h = 0.0;
        double i = 11e-9d;

        String x = "Sameed";
        char z = '\b';

        boolean y = true;
        if ($hex < b) {
            $hex += b;
        }

    }
}
