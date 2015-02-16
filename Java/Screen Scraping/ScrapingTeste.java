import static javax.swing.JOptionPane.*;

public class ScrapingTeste {

   public static void main(String[] args) {
      double a = Double.parseDouble(showInputDialog(null, "Digite um valor:"));
      double b = Double.parseDouble(showInputDialog(null, "Digite outro!"));

      ScreenScraping s = new ScreenScraping();
      s.rodar(a, b);
      double[] resultados = s.parsear();

      String mensagem = "Adição = " + resultados[0] +
                        "\nSubtração = " + resultados[1] +
                        "\nMultiplicação = " + resultados[2] +
                        "\nDivisão = " + resultados[3];
      showMessageDialog(null, mensagem);
   }

}
