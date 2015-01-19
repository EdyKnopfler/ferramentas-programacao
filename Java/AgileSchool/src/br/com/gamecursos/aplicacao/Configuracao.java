package br.com.gamecursos.aplicacao;

import java.util.Properties;
import java.io.*;

public class Configuracao {
   
   private String arquivo;
   private Properties properties;
   
   public Configuracao(String arquivo) {
      this.arquivo = arquivo;
      this.properties = new Properties();
      
      try {
         FileInputStream fis = new FileInputStream(arquivo);
         properties.load(fis);
         fis.close();
      }
      catch (Exception e) {
         throw new RuntimeException("Erro ao ler do arquivo de configura��o: ", e);
      }
   }
   
   public String lerPropriedade(String prop) {
      return properties.getProperty(prop);
   }
   
   public void setarPropriedade(String prop, String valor) {
      properties.setProperty(prop, valor);
   }
   
   public void gravar() {
      try {
         FileOutputStream fos = new FileOutputStream(arquivo);
         properties.store(fos, "Configura��es de Inicializa��o");
         fos.close();
      }
      catch (Exception e) {
         throw new RuntimeException( "Erro ao gravar no arquivo de configura��o: ", e); 
      }
   }
   
}