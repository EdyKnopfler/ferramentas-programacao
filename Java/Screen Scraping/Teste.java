import java.util.Scanner;

public class Teste {

   public static void main(String[] args) {
      Scanner entrada = new Scanner(System.in);
      menu();
      int op;

      do {
         System.out.print("Digite sua opção: ");
         op = Integer.parseInt(entrada.nextLine());

         if (op < 5) {
            System.out.print("Digite um valor: ");
            double a = Double.parseDouble(entrada.nextLine());

            System.out.print("Digite mais um valor: ");
            double b = Double.parseDouble(entrada.nextLine());
 
            operacao(a, b, op);
         }
      } while (op != 5);
   }

   public static void menu() {
      System.out.println("1. Adição");
      System.out.println("2. Subtração");
      System.out.println("3. Multiplicação");
      System.out.println("4. Divisão");
      System.out.println("5. Sair");
   }

   public static void operacao(double a, double b, int op) {
      switch (op) {
         case 1:
            System.out.println("Resultado: " + (a + b));
            break;
         case 2:
            System.out.println("Resultado: " + (a - b));
            break;
         case 3:
            System.out.println("Resultado: " + (a * b));
            break;
         case 4:
            System.out.println("Resultado: " + (a / b));
            break;
      }
   }

}
