package br.com.gamecursos.aplicacao;

import itexto.miocc.annotations.Named;
import itexto.miocc.annotations.Singleton;

import java.sql.Connection;
import java.io.FileInputStream;
import java.io.IOException;

import br.com.einformacao.db.util.Util;
import br.com.einformacao.db.core.ConnectionFactory;
import br.com.einformacao.db.core.Pagination;
import br.com.gamecursos.db.core.DAO;

@Named @Singleton
public class ConexaoBD {
   
   private Connection connection;
   private DAO        dao;
   
   public ConexaoBD() throws IOException {
      Util.getInstance().loadGlobalProperties(new FileInputStream("parallax.properties"), "");
      connection = ConnectionFactory.getInstance().getConnection();
      dao = new DAO(connection);
   }
   
   public Connection getConnection() {
      return connection;
   }
   
   public DAO getDao() {
      return dao;
   }
   
   public Pagination getPaginacao() {
      return dao.getPagination();
   }
   
   public void finalizarTransacao() {
      try {
         connection.commit();
      }
      catch (Exception e) {
         throw new RuntimeException("Erro no commit", e);
      }
   }
   
   public void cancelarTransacao() {
      try {
         connection.rollback();
      }
      catch (Exception e) {
         throw new RuntimeException("Erro no rollback", e);
      }
   }
   
   public void desconectar() {
      try {
         connection.close();
      }
      catch (Exception e) {
         throw new RuntimeException("Erro ao desconectar", e);
      }
   }
   
}
