import 'package:mysql1/mysql1.dart';

main() async {
  try {
    print('Conectando ao banco de dados...');
    final conn = await MySqlConnection.connect(ConnectionSettings(
        host: '10.0.2.2', // recomenda-se usar esse host porem é valido testar com o "localhost"
        port: 3306,
        user: 'root',
        db: '', // preencher com o nome do banco local (usei o nome "bdeurekamap")
        password: '')); // senha pessoal

    print('Conexão estabelecida. Executando consulta...');
    var results = await conn.query(
        'select email from usuariosapp'); // essa tabela serve unicamente para guardar os usuarios logados NO APP. contem colunas: idUsuario, email, senha, admin(default está para 0 que significa não é adm), data_criacao.
    for (var row in results) {
      print(row);
    }

    print('Consulta executada com sucesso. Fechando conexão...');
    await conn.close();
    print('Conexão fechada.');
  } catch (e) {
    print('Erro durante a conexão ou execução da consulta: $e');
  }
}