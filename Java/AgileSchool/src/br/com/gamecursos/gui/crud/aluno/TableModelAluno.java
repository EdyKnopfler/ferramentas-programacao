package br.com.gamecursos.gui.crud.aluno;

import br.com.gamecursos.modelo.Aluno;
import br.com.gamecursos.swingcrud.TableModelEntidade;

public class TableModelAluno extends TableModelEntidade<Aluno> {

   @Override
   public String[] getColunas() {
      return new String[] {"Nome", "Responsável", "Telefone", "Celular"};
   }

   @Override
   public Object getDadoColuna(int coluna, Aluno aluno) {
      switch (coluna) {
         case 0:  return aluno.getNome();
         case 1:  return aluno.getResponsavel();
         case 2:  return aluno.getTelefone();
         case 3:  return aluno.getCelular();
         default: return null;
      }
   }

}
