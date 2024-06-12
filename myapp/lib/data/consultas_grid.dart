import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:mysql_client/mysql_client.dart';

class Sugestoes {
  final resumo;
  final idEstande;
  final idTrabalho;
  final idAluno;
  final titulo;
  Sugestoes({
    required this.resumo,
    required this.idEstande,
    required this.idTrabalho,
    required this.idAluno,
    required this.titulo,
  });
}

Future<List<Sugestoes>> buscaTrabalhoNoBanco(String inputUsuario) async {
  List<Sugestoes>  sugestoes = [];

  await dotenv.load(fileName: "lib/assets/.env");
  try {
    final conn = await MySQLConnection.createConnection(
      host: dotenv.get("HOST_BD"),
      port: int.parse(dotenv.get("PORT_BD")),
      userName: dotenv.get("USUARIO_BD"),
      password: dotenv.get("SENHA_BD"),
      databaseName: "bdeurekamap",
    );

  await conn.connect();

  var res = await conn.execute(
      'SELECT t.resumo, t.idestande, t.idtrabalho, a.idAluno, t.titulo FROM trabalhos t JOIN trabalhos_aluno ta ON t.idtrabalho = ta.idtrabalho JOIN aluno a ON a.idAluno = ta.idAluno WHERE a.nome like "%" "$inputUsuario" "%" or t.titulo like "%" "$inputUsuario" "%" or t.resumo like "%" "$inputUsuario" "%";', {});

  for (var row in res.rows) {
    sugestoes.add(Sugestoes(
    resumo: row.colAt(0), // resumo
    idEstande: row.colAt(1), // idestande
    idTrabalho: row.colAt(2) , // idtrabalho
    idAluno: row.colAt(3), // idaluno
    titulo: row.colAt(4) , // titulo (trabalhos)
    )); 
  }
  
  await conn.close();

  } catch (e) {
    print("Erro: $e");
  }
  return sugestoes;
}
