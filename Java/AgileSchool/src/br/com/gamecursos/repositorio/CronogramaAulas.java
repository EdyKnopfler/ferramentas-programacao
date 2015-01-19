package br.com.gamecursos.repositorio;

import br.com.gamecursos.aplicacao.ConexaoBD;
import br.com.gamecursos.modelo.AulaCronograma;
import br.com.gamecursos.modelo.Modulo;

import java.util.List;

public class CronogramaAulas {

   private ConexaoBD conexao;
   
   public CronogramaAulas(ConexaoBD conexao) {
      this.conexao = conexao;
   }
   
   public void salvar(AulaCronograma a) throws Exception {
      conexao.getDao().save(a);
   }

   public void excluir(AulaCronograma a) throws Exception {
      conexao.getDao().delete(a);
   }
   
   public List<AulaCronograma> consultarPorModulo(Modulo m) throws Exception {
      return conexao.getDao().findBy( AulaCronograma.class, "modulo = " + m.getId() );
   }
   
}
