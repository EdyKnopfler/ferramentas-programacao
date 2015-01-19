package br.com.gamecursos.modelo;

import java.util.Date;

import br.com.gamecursos.db.annotations.*;

@Entity
public class Mensalidade {

   @Id @GeneratedValue
   private Long id;
   
   @Active
   private int ativo;
   
   @ManyToOne
   private Matricula matricula;
   
   private double valor;
   private Date vencimento;
   private boolean pago;
   private double juros;
   
   public Mensalidade() {
   }
   
   public Mensalidade(Matricula matricula, double valor, Date vencimento) {
      this.matricula = matricula;
      this.valor = valor;
      this.vencimento = vencimento;
   }
   
   public double getValorPago() {
      return valor * (1 + juros/100);
   }
   
   public Long getId() {
      return id;
   }
   public Matricula getMatricula() {
      return matricula;
   }
   public void setMatricula(Matricula matricula) {
      this.matricula = matricula;
   }
   public double getValor() {
      return valor;
   }
   public void setValor(double valor) {
      this.valor = valor;
   }
   public Date getVencimento() {
      return vencimento;
   }
   public void setVencimento(Date vencimento) {
      this.vencimento = vencimento;
   }
   public boolean isPago() {
      return pago;
   }
   public void setPago(boolean pago) {
      this.pago = pago;
   }
   public double getJuros() {
      return juros;
   }
   public void setJuros(double juros) {
      this.juros = juros;
   }
   
}
