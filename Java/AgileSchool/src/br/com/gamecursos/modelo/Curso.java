package br.com.gamecursos.modelo;

import br.com.gamecursos.db.annotations.*;

import java.util.List;

public class Curso {
   
   @Id @GeneratedValue
   private Long id;
   
   @Active
   private int ativo;
   
   @OneToMany(fkField = "curso", targetEntity = Modulo.class)
   private List<Modulo> modulos;
   
   private String nome;
   private int meses;
   private double valorMensalidade;
   
   public Long getId() {
      return this.id;
   }
   
   public void setNome(String nome) {
      this.nome = nome;
   }
   
   public String getNome() {
      return this.nome;
   }
   
   public List<Modulo> getModulos() {
      return this.modulos;
   }

   public int getMeses() {
      return meses;
   }

   public void setMeses(int meses) {
      this.meses = meses;
   }

   public double getValorMensalidade() {
      return valorMensalidade;
   }

   public void setValorMensalidade(double valorMensalidade) {
      this.valorMensalidade = valorMensalidade;
   }
   
   @Override
   public String toString() {
      return nome;
   }

}