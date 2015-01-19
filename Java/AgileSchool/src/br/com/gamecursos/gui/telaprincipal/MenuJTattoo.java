package br.com.gamecursos.gui.telaprincipal;

import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import java.util.ArrayList;
import java.util.Collections;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Set;
import java.util.StringTokenizer;

import javax.swing.JMenu;
import javax.swing.JMenuItem;

import br.com.gamecursos.aplicacao.ControladorAplicacao;

public class MenuJTattoo {
   
   private Map<String, String[]> disponiveis;
   private ControladorAplicacao controlador;
   private JanelaPrincipal janela;

   public MenuJTattoo(ControladorAplicacao controlador, JanelaPrincipal janela) {
      this.controlador = controlador;
      this.janela = janela;
      this.disponiveis = new HashMap<>();
      
      disponiveis.put("com.jtattoo.plaf.acryl.AcrylLookAndFeel",
            new String[] {"Default", "Green", "Lemmon", "Red"});

      disponiveis.put("com.jtattoo.plaf.aero.AeroLookAndFeel",
            new String[] {"Default", "Gold", "Green"});

      disponiveis.put("com.jtattoo.plaf.aluminium.AluminiumLookAndFeel",
            new String[] {"Default"});

      disponiveis.put("com.jtattoo.plaf.bernstein.BernsteinLookAndFeel",
            new String[] {"Default"});

      disponiveis.put("com.jtattoo.plaf.fast.FastLookAndFeel",
            new String[] {"Default", "Blue", "Green"});

      disponiveis.put("com.jtattoo.plaf.graphite.GraphiteLookAndFeel",
            new String[] {"Default", "Green", "Blue"});

      disponiveis.put("com.jtattoo.plaf.hifi.HiFiLookAndFeel",
            new String[] {"Default"});

      disponiveis.put("com.jtattoo.plaf.luna.LunaLookAndFeel",
            new String[] {"Default"});

      disponiveis.put("com.jtattoo.plaf.mcwin.McWinLookAndFeel",
            new String[] {"Default", "Modern", "Pink"});

      disponiveis.put("com.jtattoo.plaf.mint.MintLookAndFeel",
            new String[] {"Default"});

      disponiveis.put("com.jtattoo.plaf.noire.NoireLookAndFeel",
            new String[] {"Default"});

      disponiveis.put("com.jtattoo.plaf.smart.SmartLookAndFeel",
            new String[] {"Default", "Gold", "Green", "Brown", "Lemmon", "Gray"});

      disponiveis.put("com.jtattoo.plaf.pampa.PampaLookAndFeel",
            new String[] {"Default"});
   }
   
   public List<JMenu> criarMenus() {
      List<JMenu> menus = new ArrayList<>();
      Set<String> pacotes= disponiveis.keySet();
      
      for (final String classe: pacotes) {
         StringTokenizer tokens = new StringTokenizer(classe, ".");
         String nome = null;
         
         while (tokens.hasMoreTokens())
            nome = tokens.nextToken();
         
         JMenu menu = new JMenu(nome.replace("LookAndFeel", ""));
         
         String[] itens = disponiveis.get(classe);
         
         for (final String tema: itens) {
            JMenuItem itemMenu = new JMenuItem(tema);
            menu.add(itemMenu);
            
            itemMenu.addActionListener(new ActionListener() {
               @Override
               public void actionPerformed(ActionEvent e) {
                  controlador.salvarLookAndFeel(classe, tema);
                  janela.trocaLookAndFeel();
               }
            });
         }
         
         menus.add(menu);
      }
      
      return menus;
   }
   
}
