package br.com.gamecursos.createtable;

import java.lang.reflect.Field;
import java.sql.Statement;

public class GeradorFirebird extends GeradorCreateTable {
   
   @Override
   protected String tipoCampo(Field campo, boolean id, boolean autoincremento) {
      
      if (autoincremento)
         criarGerador( campo.getName() );
      
      if (campo.getType().isAssignableFrom(Boolean.class) ||
          campo.getType().isAssignableFrom(Boolean.TYPE))
         return "VARCHAR(5)";
      else if (campo.getType().isAssignableFrom(String.class))
         return super.tipoCampo(campo, id, autoincremento) + 
                " CHARACTER SET WIN1252 COLLATE WIN_PTBR";
      else               
         return super.tipoCampo(campo, id, autoincremento);
   }
   
   private void criarGerador(String campo) {
      String tabela = getNomeTabela();
      novoComandoExtra("CREATE GENERATOR ger_" + tabela);
      novoComandoExtra( 
           "CREATE TRIGGER " + tabela + "_BI FOR " + tabela + " " + "\n" +
           "ACTIVE BEFORE INSERT POSITION 0 " + "\n" +
           "AS " + "\n" +
           "BEGIN " + "\n" +
           "  IF (NEW." + campo + " IS NULL) THEN " + "\n" +
           "    NEW." + campo + " = GEN_ID(GER_" + tabela + ",1); " + "\n" + 
           "END"
      );
   }
   
}
