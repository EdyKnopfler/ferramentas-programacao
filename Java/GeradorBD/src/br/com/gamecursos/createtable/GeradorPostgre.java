package br.com.gamecursos.createtable;

import java.lang.reflect.Field;
import java.sql.Statement;

public class GeradorPostgre extends GeradorCreateTable {
   
   @Override
   protected String tipoCampo(Field campo, boolean id, boolean autoincremento) {
      
      String tipo = super.tipoCampo(campo, id, autoincremento);
      
      if (autoincremento) {
         String sequencia = "seq_" + campo.getName();
         novoComandoExtra("CREATE SEQUENCE " + sequencia);
         tipo += " DEFAULT NEXTVAL('" + sequencia + "')";
      }
      
      return tipo;
   }
   
}
