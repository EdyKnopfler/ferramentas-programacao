package br.com.gamecursos.aplicacao;

import java.lang.reflect.Method;

import javax.swing.UIManager;

import itexto.miocc.Context;
import itexto.miocc.parser.AnnotationParser;
import br.com.gamecursos.gui.telaprincipal.JanelaPrincipal;

public class ControladorAplicacao {
   
   private Context      container;
   private Configuracao configuracao;

   /**
    * O aplicativo nasce aqui ;)
    */
   public static void main(String[] args) {
      try {
         ControladorAplicacao c = new ControladorAplicacao();
         c.abrirMenu();
      }
      catch (Exception e) {
         throw new RuntimeException("Erro ao ler agileschool.properties", e);
      }
   }
   
   public ControladorAplicacao() throws Exception {
      container    = new Context( new AnnotationParser("br.com.gamecursos") );
      configuracao = new Configuracao("agileschool.properties");
      carregarLookAndFeel();
   }
   
   public void salvarLookAndFeel(String classe, String tema) {
      configuracao.setarPropriedade("L&F", classe);
      configuracao.setarPropriedade("Tema", tema);
      configuracao.gravar();
   }
   
   public void carregarLookAndFeel() {
      try {
         String classe = configuracao.lerPropriedade("L&F");
         String tema = configuracao.lerPropriedade("Tema");
         Class<?> look = Class.forName(classe);
         try {
            Method setTheme = look.getMethod("setTheme", String.class);
            setTheme.invoke(look, tema);
         }
         catch (NoSuchMethodException n) {}
         
         UIManager.setLookAndFeel(classe);
      }
      catch (Exception ex) {
         // Inesperado se a biblioteca estiver disponível!
         ex.printStackTrace();
      }
   }
   
   public void abrirMenu() {
      new JanelaPrincipal(this).setVisible(true);
   }
   
   public Configuracao getConfiguracao() {
      return configuracao;
   }
   
   public Object pegarBean(String beanId) {
      try {
         return container.getBean(beanId);
      } 
      catch (Exception e) {
         throw new RuntimeException("Erro na instanciação do bean:", e); 
      }
   }
   
   public void desconectar() {
      // É um @Singleton ;)
      ConexaoBD conexao = (ConexaoBD) pegarBean("conexaoBD");
      conexao.desconectar();
   }
   
}