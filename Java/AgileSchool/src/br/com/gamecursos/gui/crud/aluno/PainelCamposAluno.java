package br.com.gamecursos.gui.crud.aluno;

import javax.swing.JTextField;

import java.awt.*;
import java.text.DateFormat;
import java.text.ParseException;
import java.util.Date;

import javax.swing.*;

import br.com.gamecursos.modelo.Aluno;
import br.com.gamecursos.swingcrud.*;

public class PainelCamposAluno extends PainelCampos<Aluno> {

   private Aluno atual;

   private JTextField nome = new JTextField(30);
   private JTextField responsavel = new JTextField(30);
   private JTextField nascimento = new JTextField(10);
   private JTextField telefone = new JTextField(10);
   private JTextField celular = new JTextField(10);
   private JTextField endereco = new JTextField(30);
   private JTextField complemento = new JTextField(30);
   private JTextField bairro = new JTextField(20);
   private JTextField cidade = new JTextField(20);
   private JTextField estado = new JTextField(10);
   private JTextField cep = new JTextField(10);
   
   public PainelCamposAluno() {
      setLayout(new GridBagLayout());
      GridBagConstraints gbc = new GridBagConstraints();
      gbc.insets = new Insets(5, 5, 5, 5);
      gbc.anchor = gbc.WEST;
      gbc.gridx = 0;
      gbc.gridy = 0;
      
      add(new JLabel("Nome"), gbc);
      gbc.gridy++;
      add(new JLabel("Responsável"), gbc);
      gbc.gridy++;
      add(new JLabel("Data nasc."), gbc);
      gbc.gridy++;
      add(new JLabel("Telefone"), gbc);
      gbc.gridy++;
      add(new JLabel("Celular"), gbc);
      gbc.gridy++;
      add(new JLabel("Endereço"), gbc);
      gbc.gridy++;
      add(new JLabel("Complemento"), gbc);
      gbc.gridy++;
      add(new JLabel("Bairro"), gbc);
      gbc.gridy++;
      add(new JLabel("Cidade"), gbc);
      gbc.gridy++;
      add(new JLabel("Estado"), gbc);
      gbc.gridy++;
      add(new JLabel("CEP"), gbc);
      
      gbc.gridx = 1;
      gbc.gridy = 0;
      
      add(nome, gbc);
      gbc.gridy++;
      add(responsavel, gbc);
      gbc.gridy++;
      add(nascimento, gbc);
      gbc.gridy++;
      add(telefone, gbc);
      gbc.gridy++;
      add(celular, gbc);
      gbc.gridy++;
      add(endereco, gbc);
      gbc.gridy++;
      add(complemento, gbc);
      gbc.gridy++;
      add(bairro, gbc);
      gbc.gridy++;
      add(cidade, gbc);
      gbc.gridy++;
      add(estado, gbc);
      gbc.gridy++;
      add(cep, gbc);
   }
   
   @Override
   public void exibir(Aluno aluno) {
      atual = aluno;
      
      String nascFormatado = 
            DateFormat.getDateInstance().format(aluno.getNascimento());
      
      nome.setText(aluno.getNome());
      responsavel.setText(aluno.getResponsavel());
      nascimento.setText(nascFormatado);
      telefone.setText(aluno.getTelefone());
      celular.setText(aluno.getCelular());
      endereco.setText(aluno.getEndereco());
      complemento.setText(aluno.getComplemento());
      bairro.setText(aluno.getBairro());
      cidade.setText(aluno.getCidade());
      estado.setText(aluno.getEstado());
      cep.setText(aluno.getCep());
   }

   @Override
   public Aluno novoObjeto() throws CRUDException {
      Aluno a = new Aluno();
      popula(a);
      atual = a;
      return a;
   }

   @Override
   public Aluno objetoSendoAlterado() throws CRUDException {
      popula(atual);
      return atual;
   }
   
   private void popula(Aluno a) throws CRUDException {
      try {
         obrigatorio(nome, "nome");
         obrigatorio(nascimento, "Data de Nascimento");
         obrigatorio(endereco, "Endereço");
         obrigatorio(bairro, "Bairro");
         obrigatorio(cidade, "Cidade");
         obrigatorio(estado, "Estado");
         obrigatorio(cep, "CEP");
         
         Date dataNascimento =
               DateFormat.getDateInstance().parse(nascimento.getText().trim());
      
         a.setNome(nome.getText().trim());
         a.setResponsavel(responsavel.getText().trim());
         a.setNascimento(dataNascimento);
         a.setTelefone(telefone.getText().trim());
         a.setCelular(celular.getText().trim());
         a.setEndereco(endereco.getText().trim());
         a.setComplemento(complemento.getText().trim());
         a.setBairro(bairro.getText().trim());
         a.setCidade(cidade.getText().trim());
         a.setEstado(estado.getText().trim());
         a.setCep(cep.getText().trim());
      } 
      catch (ParseException e) {
         throw new CRUDException("Data inválida: " + nascimento.getText());
      }
   }
   
   private void obrigatorio(JTextField campo, String msg) throws CRUDException {
      if (campo.getText().trim().equals("")) {
         campo.requestFocus();
         throw new CRUDException("Favor preencher o campo " + msg);
      }
   }

   @Override
   public void limpar() {
      nome.setText("");
      responsavel.setText("");
      nascimento.setText("");
      telefone.setText("");
      celular.setText("");
      endereco.setText("");
      complemento.setText("");
      bairro.setText("");
      cidade.setText("");
      estado.setText("");
      cep.setText("");
   }

   @Override
   public void habilitarCampos(boolean habilitar) {
      nome.setEditable(habilitar);
      responsavel.setEditable(habilitar);
      nascimento.setEditable(habilitar);
      telefone.setEditable(habilitar);
      celular.setEditable(habilitar);
      endereco.setEditable(habilitar);
      complemento.setEditable(habilitar);
      bairro.setEditable(habilitar);
      cidade.setEditable(habilitar);
      estado.setEditable(habilitar);
      cep.setEditable(habilitar);
   }

   public void focoEmNome() {
      nome.requestFocus();
   }

}
