package dao;

import aplicacao.*;
import jdbc.ConexaoMySQL;
import org.h2.command.query.Select;
import org.springframework.jdbc.core.BeanPropertyRowMapper;
import org.springframework.jdbc.core.JdbcTemplate;
import usuario.Funcionario;
import java.util.List;

public class DaoMySQL {
    ConexaoMySQL conexao = new ConexaoMySQL();
    JdbcTemplate con = conexao.getConexaoDoBanco();

    public DaoMySQL() {
        this.conexao = conexao;
        this.con = con;
    }

    // FUNÇÕES DE ADICIONAR REGISTROS (INSERT)

    public void adicionarComputador(Computador computador) {
        con.update("INSERT INTO computador (nome, fkEmpresa, fkModeloComputador, fkEmpresaLocataria, fkStatus) VALUES (?, ?, ?, ?, ?)", computador.getNome(), computador.getFkEmpresa(), computador.getFkModeloComputador(), computador.getFkEmpresaLocataria(), computador.getFkStatus());
    }

    public void adicionarCaptura(Double valor, Integer tipoHardware) {
        con.update("INSERT INTO captura (valor, fkComputador, fkHardware, fkComponente) VALUES (?, 1, ?, ?)", valor, tipoHardware, tipoHardware);
    }

    public void adicionarHardwareSemEspecificidade(Hardware hardware, Integer numero) {
        con.update("INSERT INTO hardware (nome, capacidade, fkTipoHardware) VALUES (?, ?, ?)", hardware.getNome(), hardware.getCapacidade(), numero);
    }

    public void adicionarComponente(Integer fkHardware) {
        con.update("INSERT INTO componente (fkComputador, fkHardware) VALUES (1, ?)", fkHardware);
    }

    // FUNCÕES DE EXIBIR REGISTROS (SELECT)
    public List<Hardware> exibirHardware(Hardware hardware) {
        // SEMPRE FAZER ESSE BLOCO DE CODIGO PARA PRINTAR NA TELA E GUARDAR NO VETOR "personagensDoBanco"
        List<Hardware> hardwareDoBanco = con.query("SELECT nome, capacidade FROM hardware WHERE nome = ? AND capacidade = ?", new BeanPropertyRowMapper<>(Hardware.class), hardware.getNome(), hardware.getCapacidade());
        return hardwareDoBanco;
    }

    public List<Computador> exibirComputador(Computador computador) {
        // SEMPRE FAZER ESSE BLOCO DE CODIGO PARA PRINTAR NA TELA E GUARDAR NO VETOR "personagensDoBanco"
        List<Computador> hardwareDoBanco = con.query("SELECT nome FROM computador WHERE nome = ?", new BeanPropertyRowMapper<>(Computador.class), computador.getNome());
        return hardwareDoBanco;
    }

    public List<Componente> exibirComponente() {
        // SEMPRE FAZER ESSE BLOCO DE CODIGO PARA PRINTAR NA TELA E GUARDAR NO VETOR "personagensDoBanco"
        List<Componente> componenteDoBanco = con.query("SELECT idComponente FROM componente", new BeanPropertyRowMapper<>(Componente.class));
        return componenteDoBanco;
    }


}
