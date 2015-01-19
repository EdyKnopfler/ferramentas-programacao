package br.com.gamecursos.gui.telaprincipal;

import java.awt.*;
import java.awt.event.*;
import java.util.List;

import javax.swing.*;

import br.com.gamecursos.aplicacao.*;

import javax.swing.UIManager.LookAndFeelInfo;

public class JanelaPrincipal extends JFrame implements ActionListener {  
   
   private ControladorAplicacao controlador;
   
   private JDesktopPane desktop;  
   private JMenuBar menu;  
   private JMenu menuDiaADia, menuRegistroAula, menuMatriculas, menuCadastros,
                 menuLookAndFeel;
   private JMenuItem itemNovaAula, itemConsultarAulas, itemSair;
   private JMenuItem itemNovaMatricula;
   private JMenuItem itemAlunos;
   private JMenuItem itemLookAndFeel[]; 
   private LookAndFeelInfo looks[];
   
   public void actionPerformed(ActionEvent e) {  
      if (e.getSource() == itemSair) {  
         fecharJanela(); 
         controlador.desconectar();
      }  
      else if (e.getSource() == itemNovaAula) {
         novaJanela("Registro de Aula", (PainelInterno) controlador.pegarBean("painelRegistroAula"));
      } 
      else if (e.getSource() == itemConsultarAulas) {
         novaJanela("Consulta de Aulas",
               (PainelInterno) controlador.pegarBean("painelConsultaAulas"));
      } 
      else if (e.getSource() == itemNovaMatricula) {
         novaJanela("Nova Matrícula",
               (PainelInterno) controlador.pegarBean("painelMatricula"));
      }
      else if (e.getSource() == itemAlunos) {
         novaJanela("Cadastro de Alunos", 
               (PainelInterno) controlador.pegarBean("painelCadastroAlunos")); 
      }
   }
      
   /**
    * Cria uma nova janela interna com o painel desejado
    */
   public void novaJanela(String titulo, PainelInterno painel) {
      FrameInterno frame = new FrameInterno(titulo, painel);
      
      painel.setJanelaPrincipal(this);
      painel.setControladorAplicacao(controlador);
      
      frame.getContentPane().add(painel);
      frame.setDefaultCloseOperation(JInternalFrame.DO_NOTHING_ON_CLOSE);
      frame.pack();
      desktop.add(frame);
      frame.setVisible(true);
   }
   
   public JanelaPrincipal(ControladorAplicacao controlador){  
      this.controlador = controlador;
      
      setSize(980, 700);  
      setTitle("Agile School 0.1");  
      setLocationRelativeTo(null);  // Abrir aplicação no centro da tela  
      setDefaultCloseOperation(DO_NOTHING_ON_CLOSE);  
       
      menu = new JMenuBar();  
       
      menuDiaADia = new JMenu("Dia-a-dia");  
      
      menuRegistroAula = new JMenu("Registro de Aulas");
      menuDiaADia.add(menuRegistroAula);
      
      itemNovaAula = new JMenuItem("Nova Aula");  
      itemNovaAula.addActionListener(this);  
      menuRegistroAula.add(itemNovaAula);
      
      itemConsultarAulas = new JMenuItem("Consultar");
      itemConsultarAulas.addActionListener(this);  
      menuRegistroAula.add(itemConsultarAulas);
      
      menuMatriculas = new JMenu("Matrículas");
      menuDiaADia.add(menuMatriculas);
      
      itemNovaMatricula = new JMenuItem("Nova Matrícula");
      itemNovaMatricula.addActionListener(this);
      menuMatriculas.add(itemNovaMatricula);
      
      // ..................
      
      menuCadastros = new JMenu("Cadastros");
      
      itemAlunos = new JMenuItem("Alunos");
      itemAlunos.addActionListener(this);
      menuCadastros.add(itemAlunos);
      
      // ..................
      
      menuDiaADia.addSeparator();  
      itemSair = new JMenuItem("Sair");  
      itemSair.addActionListener(this);  
      menuDiaADia.add(itemSair);  
       
      menuLookAndFeel = new JMenu("L&F");
      menuLFNativos();
      menuLFJTattoo(controlador);
      
      setJMenuBar(menu);  
      menu.add(menuDiaADia);  
      menu.add(menuCadastros);
      menu.add(menuLookAndFeel);
      
      desktop = new JDesktopPane();  
      getContentPane().add(desktop);      
      configurarFechamento();
   }

   private void menuLFNativos() {
      looks = UIManager.getInstalledLookAndFeels();
      itemLookAndFeel = new JMenuItem[looks.length];
      ButtonGroup grupo = new ButtonGroup();
       
      for (int i = 0; i < looks.length; i++) {
         itemLookAndFeel[i] = new JRadioButtonMenuItem( looks[i].getName() );
         menuLookAndFeel.add(itemLookAndFeel[i]);
         itemLookAndFeel[i].addActionListener(this);
         grupo.add(itemLookAndFeel[i]);
         
         String selecionado = UIManager.getLookAndFeel().getClass().getName();
         final String classe = looks[i].getClassName();
         
         itemLookAndFeel[i].setSelected( classe.equals(selecionado) );
         itemLookAndFeel[i].addActionListener(new ActionListener() {
            @Override
            public void actionPerformed(ActionEvent e) {
               try {
                  controlador.salvarLookAndFeel(classe, "Default");
                  trocaLookAndFeel();
               }
               catch (Exception ex) {
                  // Teoricamente não é para acontecer, porque carregou todos no construtor.
                  ex.printStackTrace();
               }
            }
         });
      }
   }
   
   private void menuLFJTattoo(ControladorAplicacao controlador) {
      menuLookAndFeel.addSeparator();
      List<JMenu> jtattoo = new MenuJTattoo(controlador, this).criarMenus();
      
      for (JMenu item: jtattoo) {
         menuLookAndFeel.add(item);
      }
   }
   
   private void configurarFechamento() {
      addWindowListener(new WindowAdapter() {
         @Override
         public void windowClosing(WindowEvent e) {
            // Tentar fechar todos os frames internos 
            Component[] janelas = desktop.getComponents();
            
            for (Component j: janelas) {
               FrameInterno frame = (FrameInterno) j;
               
               if (j instanceof FrameInterno)
                  frame.janelaPrincipalFechando();
            };
            
            // Sobrou algum?
            if (desktop.getComponents().length == 0)
               JanelaPrincipal.this.dispose();
         }
      });
   }

   public void trocaLookAndFeel() {
      fecharJanela();
      
      if (desktop.getComponents().length == 0) {
         controlador.carregarLookAndFeel();
         new JanelaPrincipal(JanelaPrincipal.this.controlador).setVisible(true);
      }
   }
   
   private void fecharJanela() {
      getWindowListeners()[0].windowClosing(null);
   }
   
}  