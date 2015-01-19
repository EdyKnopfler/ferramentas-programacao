package br.com.gamecursos.modelo;

import java.util.Date;

import br.com.gamecursos.db.annotations.*;

public class Matricula {

   @Id
   @GeneratedValue
   private Long id;
   
   @Active
   private int ativo;

   @ManyToOne
   private Aluno aluno;

   @ManyToOne
   private Turma turma;

   private Date data;
   
   public Matricula() {
   }
   
   public Matricula (Aluno aluno, Turma turma, Date data) {
      this.aluno = aluno;
      this.turma = turma;
      this.data = data;
   }
   
   public Long getId() {
      return id;
   }

   public Turma getTurma() {
      return turma;
   }

   public Aluno getAluno() {
      return aluno;
   }

   public Date getData() {
      return data;
   }

   public void setAluno(Aluno aluno) {
      this.aluno = aluno;
   }

   public void setTurma(Turma turma) {
      this.turma = turma;
   }

   public void setData(Date data) {
      this.data = data;
   }

}
