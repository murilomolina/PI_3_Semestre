import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:mysql1/mysql1.dart';

class Habilitacao {
  final int? idHabilitacao;
  final String codigoHabilitacao;
  final String descricao;
  final String textoWeb;

  Habilitacao({
    this.idHabilitacao,
    required this.codigoHabilitacao,
    required this.descricao,
    required this.textoWeb,
  });
}

Future<void> insereHabilitacao(Habilitacao habilitacao) async {
  await dotenv.load(fileName: "lib/assets/.env");

  final conn = await MySqlConnection.connect(ConnectionSettings(
    host: dotenv.get("HOST_BD"),
    port: int.parse(dotenv.get("PORT_BD")),
    user: dotenv.get("USUARIO_BD"),
    password: dotenv.get("SENHA_BD"),
    db: 'bdeurekamap',
  ));

  try {
    await conn.query(
      'INSERT INTO habilitacoes (codigoHabilitacao, descricao, texto_web) VALUES (?, ?, ?)',
      [habilitacao.codigoHabilitacao, habilitacao.descricao, habilitacao.textoWeb],
    );
  } catch (e) {
    print('Erro ao inserir habilitação: $e');
  } finally {
    await conn.close();
  }
}
