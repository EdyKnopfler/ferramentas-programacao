package br.com.gamecursos.modelo;

import br.com.gamecursos.db.annotations.*;
import java.util.List;

public class Modulo {
   
   @Id @GeneratedValue
   private Long id;
   
   @Active
   private int ativo;
   
   @ManyToOne
   private Curso curso;
   
   private String nome;
   private int cargaHoraria;
   
   public Long getId() {
      return this.id;
   }
   
   public void setCurso(Curso curso) {
      this.curso = curso;
   }
   
   public Curso getCurso(Curso curso) {
      return this.curso;
   }
   
   public void setNome(String nome) {
      this.nome = nome;
   }
   
   public String getNome() {
      return this.nome;
   }

   public int getCargaHoraria() {
      return cargaHoraria;
   }

   public void setCargaHoraria(int cargaHoraria) {
      this.cargaHoraria = cargaHoraria;
   }

   public String toString() {
      return this.nome;
   }
   
}