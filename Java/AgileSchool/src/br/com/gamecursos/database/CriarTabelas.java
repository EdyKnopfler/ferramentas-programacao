package br.com.gamecursos.database;

import java.sql.Connection;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import br.com.gamecursos.db.core.DAO;
import br.com.gamecursos.aplicacao.ConexaoBD;
import br.com.gamecursos.createtable.*;
import br.com.gamecursos.modelo.*;


public class CriarTabelas {

   private Connection connection;
   private GeradorCreateTable gct;
   private List<String> comandos = new ArrayList<String>();

   public CriarTabelas(Connection connection) throws Exception {
      this.connection = connection;
      gct = new GeradorFirebird();
      gct.setConnection(connection);
      
      
      gerarAluno();
      gerarAulaCronograma();
      gerarAulaDada();
      gerarCurso();
      gerarMatricula();
      gerarMensalidade();
      gerarModulo();
      gerarPresenca();
      gerarTurma();
      
      executarComandos();
   }
   
   private void gerarAluno() {
      gct.setClazz(Aluno.class);
      gct.setTamanhoVarchar("nome", 70);
      gct.setTamanhoVarchar("responsavel", 70);
      gct.setTamanhoVarchar("telefone", 14);
      gct.setTamanhoVarchar("celular", 14);
      gct.setTamanhoVarchar("endereco", 100);
      gct.setTamanhoVarchar("complemento", 100);
      gct.setTamanhoVarchar("bairro", 50);
      gct.setTamanhoVarchar("cidade", 50);
      gct.setTamanhoVarchar("estado", 2);
      gct.setTamanhoVarchar("cep", 9);
      comandos.addAll(gct.gerar());
   }
   
   private void gerarAulaCronograma() {
      gct.setClazz(AulaCronograma.class);
      gct.setTamanhoVarchar("descricao", 255);
      gct.setTamanhoVarchar("conteudoPrevisto", 255);
      comandos.addAll(gct.gerar());
   }   
   
   private void gerarAulaDada() {
      gct.setClazz(AulaDada.class);
      gct.setTamanhoVarchar("conteudoMinistrado", 255);
      comandos.addAll(gct.gerar());
   }
   
   private void gerarCurso() {
      gct.setClazz(Curso.class);
      gct.setTamanhoVarchar("nome", 50);
      comandos.addAll(gct.gerar());
   }
   
   private void gerarMatricula() {
      gct.setClazz(Matricula.class);
      comandos.addAll(gct.gerar());
   }
   
   private void gerarMensalidade() {
      gct.setClazz(Mensalidade.class);
      comandos.addAll(gct.gerar());
   }
   
   private void gerarModulo() {
      gct.setClazz(Modulo.class);
      gct.setTamanhoVarchar("nome", 50);
      comandos.addAll(gct.gerar());
   }
   
   private void gerarPresenca() {
      gct.setClazz(Presenca.class);
      gct.setTamanhoVarchar("comportamento", 100);
      comandos.addAll(gct.gerar());
   }
   
   private void gerarTurma() {
      gct.setClazz(Turma.class);
      gct.setTamanhoVarchar("nome", 20);
      /*
      gct.setTamanhoVarchar("dias", 20);
      */
      comandos.addAll(gct.gerar());
   }
   
   private void executarComandos() throws Exception {
      Statement st = connection.createStatement();
      
      for (String c: comandos) {
         st.execute(c);
      }
      
      st.close();
   }
   
   public static void main(String[] args) throws Exception {
      ConexaoBD conexao = new ConexaoBD();
      new CriarTabelas(conexao.getConnection());
      conexao.finalizarTransacao();
      conexao.desconectar();
   }

}
