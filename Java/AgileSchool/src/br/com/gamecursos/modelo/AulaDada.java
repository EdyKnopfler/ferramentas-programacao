package br.com.gamecursos.modelo;

import java.util.List;
import java.util.Date;
import br.com.gamecursos.db.annotations.*;

public class AulaDada {
   
   @Id @GeneratedValue
   private Long id;
   
   @Active
   private int ativo;

   @ManyToOne
   private Turma turma;
   
   @ManyToOne
   private AulaCronograma aulaCronograma;
   
   private List<Presenca> presencas;
   
   // Dados
   private Date data = new Date();
   private String conteudoMinistrado;
   
   // Getters e setters
   public Long getId() {
      return this.id;
   }
   
   public Date getData() {
      return this.data;
   }
   
   public void setData(Date data) {
      this.data = data;
   }
   
   public Turma getTurma() {
      return this.turma;
   }
   
   public void setTurma(Turma turma) {
      this.turma = turma;
   }
   
   public String getConteudoMinistrado() {
      return this.conteudoMinistrado;
   }
   
   public void setConteudoMinistrado(String conteudoMinistrado) {
      this.conteudoMinistrado = conteudoMinistrado;
   }
   
   public AulaCronograma getAulaCronograma() {
      return this.aulaCronograma;
   }
   
   public void setAulaCronograma(AulaCronograma aulaCronograma) {
      this.aulaCronograma = aulaCronograma;
   }

   public List<Presenca> getPresencas() {
      return presencas;
   }

   public void setPresencas(List<Presenca> presencas) {
      this.presencas = presencas;
   }
   
}