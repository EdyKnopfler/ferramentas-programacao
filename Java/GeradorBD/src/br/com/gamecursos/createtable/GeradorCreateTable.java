package br.com.gamecursos.createtable;

import br.com.gamecursos.db.annotations.*;
import br.com.gamecursos.db.core.Mapping;

import java.math.BigDecimal;
import java.math.BigInteger;
import java.util.Date;
import java.util.GregorianCalendar;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.ResultSetMetaData;
import java.sql.SQLException;
import java.sql.Statement;
import java.sql.Timestamp;
import java.util.HashMap;
import java.util.List;
import java.util.ArrayList;
import java.lang.reflect.*;
import java.sql.*;

public abstract class GeradorCreateTable {
   
   private Class<?>   clazz;
   private HashMap<String, Integer> tamanhosVarchar = new HashMap<>();
   private List<String> comandosExtras = new ArrayList<>();
   private String nomeTabela;
   private Connection connection;

   public void setTamanhoVarchar(String campo, int tamanho) {
      tamanhosVarchar.put(campo, tamanho);
   }
   
   public void setClazz(Class<?> clazz) {
      this.clazz = clazz;
   }
   
   public Class<?> getClazz() {
      return this.clazz;
   }
   
   public void setConnection(Connection connection) {
      this.connection = connection;
   }
   
   public Connection getConnection() {
      return connection;
   }
   
   public List<String> gerar() {
      comandosExtras.clear();
      List<String> comandos;
      
      if (connection != null) {
         try {
            comandos = alteraTabela();
         }
         catch (Exception e) {
            comandos = criaTabela();
         }
      }
      else {
         comandos = criaTabela();
      }
      
      for (String c: comandosExtras) {
         comandos.add(c);
      }
      
      return comandos;
   }
   
   private List<String> alteraTabela() throws SQLException {
      // Inspecionar a classe
      Mapping mapp = new Mapping(clazz, null);
      List<String> camposNaClasse = mapp.updateFields();
      camposNaClasse.add(mapp.getIdField());
      nomeTabela = mapp.getTable();
      
      // Comparar
      List<String> camposAlterar = obterCamposAlterar(camposNaClasse);
      
      // Gerar os comandos
      List<String> comandos = new ArrayList<>();
      
      if (camposAlterar.size() > 0)
         comandos.add(gerarAlterTable(mapp, camposAlterar));
      
      return comandos;
   }
   
   private List<String> obterCamposAlterar(List<String> camposNaClasse) 
         throws SQLException {
      
      Statement st = connection.createStatement();
      ResultSet consulta = st.executeQuery("SELECT * FROM " + nomeTabela);
      ResultSetMetaData metadata = consulta.getMetaData();      List<String> camposAlterar = new ArrayList<>();
      
      for (String campo: camposNaClasse) {
         if ( ! existeNaTabela(campo, metadata) )
            camposAlterar.add(campo);
      }
      
      consulta.close();
      st.close();
      
      return camposAlterar;
   }
   
   private boolean existeNaTabela(String campo, ResultSetMetaData metadata)
         throws SQLException {
      
      for (int i = 1; i <= metadata.getColumnCount(); i++) {
         if (campo.equalsIgnoreCase(metadata.getColumnName(i)))
            return true;
      }
      
      return false;
   }

   private String gerarAlterTable(Mapping mapp, List<String> camposAlterar) {
      StringBuilder alterTable = new StringBuilder("ALTER TABLE " + nomeTabela);
      
      for (int i = 0; i < camposAlterar.size(); i++) {
         String novoCampo = camposAlterar.get(i);
         String add = "\n   " + (i == 0  ?  ""  : ", ") + " ADD ";
         if (novoCampo.equals(mapp.getIdField()))
            alterTable.append(add + campoId(novoCampo));
         else
            alterTable.append(add + campoNormal(novoCampo));
      }
      
      return alterTable.toString();
   }

   private List<String> criaTabela() {
      List<String> comandos = new ArrayList<>();
      Mapping       mapp = new Mapping(clazz, null);
      StringBuilder sql  = new StringBuilder();
      nomeTabela = mapp.getTable();
      
      sql.append("CREATE TABLE " + nomeTabela + " ( \n");
      sql.append( "   " + campoId(mapp.getIdField()) );
      
      List<String> outrosCampos = mapp.updateFields();
      
      for (String c: outrosCampos) {
         sql.append(", \n");
         sql.append( "   " + campoNormal(c) );
      }
      
      sql.append("\n)");
      comandos.add(sql.toString());
      
      return comandos;
   }
   
   protected void novoComandoExtra(String sql) {
      comandosExtras.add(sql);
   }
   
   protected String getNomeTabela() {
      return nomeTabela;
   }
   
   private String campoId(String atributo) {
      String  tipo  = determinarTipoCampo(atributo, true, true);
      String  sql   = atributo + " " + tipo;
      return sql;
   }
   
   private String campoNormal(String atributo) {
      String  tipo = determinarTipoCampo(atributo, false, false);
      String  sql  = atributo + " " + tipo;
      return sql;
   }
   
   private String determinarTipoCampo(String atributo, boolean id, 
         boolean autoincremento) {
      
      try {
         Field    campo = clazz.getDeclaredField(atributo);
         Class<?> myType  = campo.getType();
         
         if ( campo.isAnnotationPresent(ManyToOne.class) ) {
            Mapping mapp    = new Mapping(myType, null);
            Field   campoId = myType.getDeclaredField( mapp.getIdField() );
            return tipoCampo( campoId, id, autoincremento);
         }
         else
            return tipoCampo(campo, id, autoincremento);
      } 
      catch (Exception e) {
         throw new RuntimeException("Erro ao determinar tipo do campo " +
               atributo, e);
      }
   }
   
   protected String tipoCampo(Field campo, boolean id, boolean autoincremento) 
         {
      
      Class<?> myType = campo.getType();
      String   tipo   = "";
      
      if ( myType.isAssignableFrom(GregorianCalendar.class) )
         tipo = "TIMESTAMP";
      
      else if ( myType.isAssignableFrom(Date.class) )
         tipo = "DATE";
      
      else if ( myType.isAssignableFrom(Timestamp.class) )
         tipo = "TIME";
      
      else if ( myType.isAssignableFrom(BigDecimal.class) ||
                myType.isAssignableFrom(Float.class) || 
                myType.isAssignableFrom(Float.TYPE) ||
                myType.isAssignableFrom(Double.class) || 
                myType.isAssignableFrom(Double.TYPE) )
         tipo = "DECIMAL(10,2)";
      
      else if ( myType.isAssignableFrom(String.class) )
         tipo = "VARCHAR(" + tamanho( campo.getName() ) + ")";
      
      else if ( myType.isAssignableFrom(BigInteger.class) ||
                myType.isAssignableFrom(Byte.class) || 
                myType.isAssignableFrom(Byte.TYPE) ||
                myType.isAssignableFrom(Short.class) || 
                myType.isAssignableFrom(Short.TYPE) ||
                myType.isAssignableFrom(Integer.class) || 
                myType.isAssignableFrom(Integer.TYPE) ||
                myType.isAssignableFrom(Long.class) || 
                myType.isAssignableFrom(Long.TYPE) )
         tipo = "INTEGER";
      
      else if ( myType.isAssignableFrom(Boolean.class) || 
            myType.isAssignableFrom(Boolean.TYPE) )
         tipo = "BOOLEAN";
      
      else
         throw new RuntimeException("Tipo do objeto no banco de dados não suportado!");
      
      if (id)
         tipo += " NOT NULL PRIMARY KEY ";
      
      return tipo;
   }
   
   private int tamanho(String atributo) {
      Integer tam = tamanhosVarchar.get(atributo); 
      return ( tam != null  ?  tam  :  50 ); 
   }
   
}
