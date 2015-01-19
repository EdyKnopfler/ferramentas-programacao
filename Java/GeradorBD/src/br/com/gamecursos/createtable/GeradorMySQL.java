package br.com.gamecursos.createtable;

import java.lang.reflect.Field;
import java.sql.Connection;

public class GeradorMySQL extends GeradorCreateTable {

   @Override
   protected String tipoCampo(Field campo, boolean id, boolean autoincremento) {
      
      String tipo = super.tipoCampo(campo, id, autoincremento);
      
      if (autoincremento)
         tipo += " AUTO_INCREMENT";
      
      return tipo;
   }
   
}
