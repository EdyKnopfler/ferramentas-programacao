package br.com.gamecursos.modelo;

import java.util.Date;

import br.com.gamecursos.db.annotations.*;

public class Aluno {

   @Id @GeneratedValue
   private Long id;
   
   @Active
   private int ativo;
   
   private String nome;
   private String responsavel;
   private Date nascimento;
   private String telefone;
   private String celular;
   private String endereco;
   private String complemento;
   private String bairro;
   private String cidade;
   private String estado;
   private String cep;
   
   public Long getId() {
      return this.id;
   }
   
   public String getNome() {
      return this.nome;
   }
   
   public void setNome(String nome) {
      this.nome = nome;
   }
   
   public String getResponsavel() {
      return responsavel;
   }

   public void setResponsavel(String responsavel) {
      this.responsavel = responsavel;
   }

   public Date getNascimento() {
      return nascimento;
   }

   public void setNascimento(Date nascimento) {
      this.nascimento = nascimento;
   }

   public String getTelefone() {
      return telefone;
   }

   public void setTelefone(String telefone) {
      this.telefone = telefone;
   }

   public String getCelular() {
      return celular;
   }

   public void setCelular(String celular) {
      this.celular = celular;
   }

   public String getEndereco() {
      return endereco;
   }

   public void setEndereco(String endereco) {
      this.endereco = endereco;
   }

   public String getComplemento() {
      return complemento;
   }

   public void setComplemento(String complemento) {
      this.complemento = complemento;
   }

   public String getBairro() {
      return bairro;
   }

   public void setBairro(String bairro) {
      this.bairro = bairro;
   }

   public String getCidade() {
      return cidade;
   }

   public void setCidade(String cidade) {
      this.cidade = cidade;
   }

   public String getEstado() {
      return estado;
   }

   public void setEstado(String estado) {
      this.estado = estado;
   }

   public String getCep() {
      return cep;
   }

   public void setCep(String cep) {
      this.cep = cep;
   }

   public String toString() {
      return nome;
   }
   
}