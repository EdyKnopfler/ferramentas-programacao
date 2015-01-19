package br.com.gamecursos.modelo;

import br.com.gamecursos.db.annotations.*;

import java.util.Calendar;

public class Turma {

   @Id @GeneratedValue
   private Long id;
   
   @Active
   private int ativo;
   
   @ManyToOne
   private Curso curso;
   
   private String nome;
   private Calendar horaEntrada;
   private Calendar horaSaida;
   
   public Long getId() {
      return this.id;
   }
   
   public String getNome() {
      return this.nome;
   }
   
   public void setNome(String nome) {
      this.nome = nome;
   }
   
   public Calendar getHoraEntrada() {
      return this.horaEntrada;
   }
   
   public void setHoraEntrada(Calendar horaEntrada) {
      this.horaEntrada = horaEntrada;
   }
   
   public Calendar getHoraSaida() {
      return this.horaSaida;
   }
   
   public void setHoraSaida(Calendar horaSaida) {
      this.horaSaida = horaSaida;
   }
   
   public Curso getCurso() {
      return curso;
   }

   public void setCurso(Curso curso) {
      this.curso = curso;
   }

   public String toString() {
      return nome;
   }
   
}