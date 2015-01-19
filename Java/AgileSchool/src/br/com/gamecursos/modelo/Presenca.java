package br.com.gamecursos.modelo;

import br.com.gamecursos.db.annotations.*;

public class Presenca {

   @Id @GeneratedValue
   private Long id;
   
   @Active
   private int ativo;
   
   @ManyToOne
   private AulaDada aulaDada;
   
   @ManyToOne
   private Aluno aluno;
   
   private boolean compareceu;
   
   public Presenca(Aluno aluno, boolean compareceu) {
      this.aluno      = aluno;
      this.compareceu = compareceu;
   }
   
   public Presenca() {}
   
   // Getters e setters
   public Long getId() {
      return this.id;
   }
   
   public Aluno getAluno() {
      return this.aluno;
   }
   
   public void setAluno(Aluno aluno) {
      this.aluno = aluno;
   }
   
   public boolean getCompareceu() {
      return this.compareceu;
   }
   
   public void setCompareceu(boolean compareceu) {
      this.compareceu = compareceu;
   }
   
   public AulaDada getAulaDada() {
      return aulaDada;
   }

   public void setAulaDada(AulaDada aulaDada) {
      this.aulaDada = aulaDada;
   }

   public String toString() {
      return aluno.getNome();
   }

}