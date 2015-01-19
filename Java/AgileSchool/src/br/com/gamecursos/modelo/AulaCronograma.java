package br.com.gamecursos.modelo;

import br.com.gamecursos.db.annotations.*;

public class AulaCronograma {

   @Id @GeneratedValue
   private Long id;
   
   @Active
   private int ativo;
   
   @ManyToOne
   private Modulo modulo;
   
   private int    numeroAula;
   private String descricao;
   private String conteudoPrevisto;
   
   public AulaCronograma(Modulo modulo, int numeroAula, String descricao) {
      this.modulo     = modulo;
      this.numeroAula = numeroAula;
      this.descricao  = descricao;
   }
   
   public AulaCronograma() {}
   
   public Long getId() {
      return this.id;
   }
   
   public Modulo getModulo() {
      return this.modulo;
   }
   
   public void setModulo(Modulo modulo) {
      this.modulo = modulo;
   }
   
   public int getNumeroAula() {
      return this.numeroAula;
   }
   
   public void setNumeroAula(int numeroAula) {
      this.numeroAula = numeroAula;
   }
   
   public String getDescricao() {
      return this.descricao;
   }
   
   public void setDescricao(String descricao) {
      this.descricao = descricao;
   }
   
   public String getConteudoPrevisto() {
      return this.conteudoPrevisto;
   }
   
   public void setConteudoPrevisto(String conteudoPrevisto) {
      this.conteudoPrevisto = conteudoPrevisto;
   }
   
   public String toString() {
      return numeroAula + " - " + descricao;
   }

}