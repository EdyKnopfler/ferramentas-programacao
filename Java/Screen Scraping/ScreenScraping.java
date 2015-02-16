import java.io.*;

public class ScreenScraping {

   public void rodar(double a, double b) {
      try {
         PrintWriter pw = new PrintWriter(new File("input.txt"));
         pw.println("1");  // Adição
         pw.println(a);
         pw.println(b);
         pw.println("2");  // Subtração
         pw.println(a);
         pw.println(b);
         pw.println("3");  // Multiplicação
         pw.println(a);
         pw.println(b);
         pw.println("4");  // Divisão
         pw.println(a);
         pw.println(b);
         pw.println("5");  // Sair
         pw.close();

         Process p = new ProcessBuilder("java", "Teste")
            .redirectInput(ProcessBuilder.Redirect.from(new File("input.txt")))
            .redirectOutput(ProcessBuilder.Redirect.to(new File("output.txt")))
            .start();
         p.waitFor();
      }
      catch (Exception e) {
         e.printStackTrace();
      }
   }

   public double[] parsear() {
      double[] resultados = new double[4];

      try {
         FileReader arquivo = new FileReader("output.txt");
         BufferedReader saida = new BufferedReader(arquivo);

         for (int i = 1; i <=5; i++)
            saida.readLine();  // Salta as 5 linhas do menu

         for (int i = 0; i <= 3; i++) {
            String linha = saida.readLine();
            String tiraTexto = linha.replace("Digite sua opção: Digite um valor: Digite mais um valor: Resultado: ", "");
            resultados[i] = Double.parseDouble(tiraTexto);
         }

         arquivo.close();
         saida.close();
      }
      catch (Exception e) {
         e.printStackTrace();
      }
  
      return resultados;
    }

}
