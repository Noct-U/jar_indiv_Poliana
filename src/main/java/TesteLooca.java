import com.github.britooo.looca.api.core.Looca;
import com.github.britooo.looca.api.group.janelas.Janela;
import com.github.britooo.looca.api.group.janelas.JanelaGrupo;
import jdbc.ConexaoMySQL;
import org.springframework.jdbc.core.BeanPropertyRowMapper;
import org.springframework.jdbc.core.JdbcTemplate;
import oshi.SystemInfo;
import usuario.Funcionario;

import javax.swing.*;
import java.util.List;
import java.util.Scanner;

import java.util.Random;

import static javax.swing.JOptionPane.showInputDialog;

public class TesteLooca {
    public static void main(String[] args) {
        Looca looca = new Looca();
        Random random = new Random();


        ConexaoMySQL conexao = new ConexaoMySQL();
        JdbcTemplate con = conexao.getConexaoDoBanco();


        JanelaGrupo windows = new JanelaGrupo(new SystemInfo());
        SystemInfo sistema  = new SystemInfo();

        List<Janela> janelas = windows.getJanelas();

        Scanner leitor = new Scanner(System.in);

        String email = String.valueOf(new Scanner(System.in));
        String senha = String.valueOf(new Scanner(System.in));
        String inserido = String.valueOf(new Scanner(System.in));
        Integer numeroAleatorio = random.nextInt(100000);

        JOptionPane.showInputDialog(null, "Área de Login");

        email = showInputDialog("Digite seu email: ");

        senha = showInputDialog("Digite sua senha: ");

        inserido = showInputDialog("Digite o número: " + numeroAleatorio);

        List<Funcionario> usuariosBanco = con.query("SELECT email, senha FROM usuario " +
                        "WHERE email = '%s' AND senha = '%s'".formatted(email, senha),
                new BeanPropertyRowMapper<>(Funcionario.class));

        if (!numeroAleatorio.toString().equals(inserido) || usuariosBanco.isEmpty()) {
            JOptionPane.showInputDialog(null, "Email e/ou senha inválidos. Inicie novamente o programa.", "ERRO", JOptionPane.ERROR_MESSAGE);

        } else {
            Integer escolha;
            do {

                        showInputDialog("""
                        *---------------------------------------------------------------*
                        |      Monitoramento de Janelas da NOCT.U     |   
                        *---------------------------------------------------------------*
                        | 1 - Visualizar quantidade de janelas visiveis |
                        | 2 - Verificar Sistema Operacional                    |
                        | 0 - Sair                                                                 |
                        *---------------------------------------------------------------*
                        Insira também no sistema para validação da opção            
                        """);

                escolha = leitor.nextInt();

                switch (escolha){
                    case 1:
                        String nome= "Janelas";
                    System.out.println("Total das janelas: " + windows.getTotalJanelas());
                        con.update("INSERT INTO insercao (nome, descricao) VALUES (?,?)", nome, windows.getTotalJanelas());

                    break;

                    case 2:
                        String nome2= "Janelas";
                    System.out.println("Sobre o sistema: " + sistema.getOperatingSystem());
                    String so = String.valueOf(sistema.getOperatingSystem());
                        con.update("INSERT INTO insercao (nome, descricao) VALUES (?,?)", nome2, so);
                    break;
                }

            } while (escolha != 0);


        }
    }

}
