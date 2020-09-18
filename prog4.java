import java.util.*;
import java.io.*;

/*
         * This program shows my lexer's ability to tokenize a complex program
         */

class prog4 {

    static int find(String array[], String s, int size) {
        // System.out.println(s);
        for (int i = 0; i < size; i++) {
            if (array[i].equals(s)) {
                return i;
            }
        }
        return -1;
    }

    public static void main(String[] args) {
        Scanner scan = new Scanner(System.in);
        int t = scan.nextInt();
        for (int test = 0; test < t; test++) {
            int n = scan.nextInt();
            // ArrayList<String> strings = new ArrayList<String>();
            String[] strings = new String[n];
            // ArrayList<Integer> ones = new ArrayList<Integer>();
            int[] ones = new int[n];
            // ArrayList<Integer> zeros = new ArrayList<Integer>();
            int[] zeros = new int[n];
            int size = 0;

            String oldString = "";
            int index = -1;
            int oldIndex = -1;
            for (int i = 0; i < n; i++) {
                String s = scan.next();
                int bool = scan.nextInt();

                if (s != oldString) {
                    index = find(strings, s, size);
                    if (index == -1) {
                        strings[size] = s;

                        if (bool == 0) {
                            zeros[size] = 1;
                            ones[size] = 0;
                        } else {
                            zeros[size] = 0;
                            ones[size] = 1;
                        }
                        size++;
                    } else {

                        if (bool == 0) {
                            int x = zeros[index] + 1;
                            zeros[index] = x;
                        } else {
                            int x = ones[index] + 1;
                            ones[index] = x;
                        }
                    }
                    s = oldString;
                    oldIndex = index;
                } else {
                    index = oldIndex;

                    if (bool == 0) {
                        int x = zeros[index] + 1;
                        zeros[index] = x;
                    } else {
                        int x = ones[index] + 1;
                        ones[index] = x;
                    }
                }

            }

            int answer = 0;

            for (int i = 0; i < size; i++) {
                // System.out.println(ones.get(i)+" "+zeros.get(i));
                if (ones[i] > zeros[i]) {

                    answer = answer + ones[i];

                } else {
                    answer = answer + zeros[i];
                }
            }
            System.out.println(answer);

        }

    }

}
