package br.com.gamecursos.repositorio;

import br.com.gamecursos.aplicacao.ConexaoBD;
import br.com.gamecursos.db.core.DAO;
import br.com.gamecursos.modelo.AulaDada;
import br.com.gamecursos.modelo.Presenca;

import java.util.List;

public class RegistroFrequencia {

   private ConexaoBD conexao;
   
   public RegistroFrequencia(ConexaoBD conexao) {
      this.conexao = conexao;
   }
   
   public void salvar(Presenca p) throws Exception {
      conexao.getDao().save(p);
   }

   public void excluir(Presenca p) throws Exception {
      conexao.getDao().delete(p);
   }

   public void registraFrequencia(AulaDada aula) throws Exception {
      for ( Presenca p: aula.getPresencas() ) {
         p.setAulaDada(aula);
         conexao.getDao().save(p);
      }
   }
   
   public List<Presenca> consultarPorAula(AulaDada a) throws Exception {
      return conexao.getDao().findBy( Presenca.class, "aulaDada = " + a.getId() );
   }

}