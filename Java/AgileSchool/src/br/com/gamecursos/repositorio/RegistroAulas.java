package br.com.gamecursos.repositorio;

import br.com.gamecursos.aplicacao.ConexaoBD;
import br.com.gamecursos.db.core.DAO;
import br.com.gamecursos.modelo.AulaDada;
import br.com.gamecursos.modelo.Modulo;
import br.com.gamecursos.modelo.Turma;

import java.util.List;

public class RegistroAulas {

   private ConexaoBD conexao;
   
   public RegistroAulas(ConexaoBD conexao) {
      this.conexao = conexao;
   }
   
   /**
    * Lógica de negócio de registro de aula:
    * - registra a aula no registro de aulas (andamento da turma)
    * - registra as presenças no registro de frequência
    */
   public void salvar(AulaDada aula) throws Exception {
      conexao.getDao().save(aula);
      new RegistroFrequencia(conexao).registraFrequencia(aula);
   }

   public void excluir(AulaDada aula) throws Exception {
      conexao.getDao().delete(aula);
   }
   
   public List<AulaDada> consultarAulas(Turma turma, Modulo modulo) throws Exception {
      String criterio = 
            "turma = " + turma.getId() + 
            " AND EXISTS (" + 
            "   select id from aulaCronograma " +
            "   where aulaCronograma.modulo = " + modulo.getId() +
            "   and aulaCronograma.id = aulaDada.aulaCronograma" + 
            ")";
      return conexao.getDao().findBy(AulaDada.class, criterio);
   }

}