package br.com.gamecursos.repositorio;

import java.util.Calendar;

import br.com.gamecursos.aplicacao.ConexaoBD;
import br.com.gamecursos.modelo.*;

public class RegistroMensalidades {

   private ConexaoBD conexao;

   public RegistroMensalidades(ConexaoBD conexao) {
      this.conexao = conexao;
   }
   
   public void gerarMensalidades(Matricula matricula) throws Exception {
      Calendar data = Calendar.getInstance(); 
      data.setTime(matricula.getData());
      Curso curso = matricula.getTurma().getCurso();
      int mesesCurso = curso.getMeses();
      double valorCurso = curso.getValorMensalidade();
      
      for (int i = 0; i < mesesCurso; i++) {
         Calendar vencimento = (Calendar) data.clone();
         vencimento.add(Calendar.MONTH, i);
         Mensalidade m = new Mensalidade(matricula, valorCurso, 
               vencimento.getTime());
         conexao.getDao().save(m);
      }
   }

}
